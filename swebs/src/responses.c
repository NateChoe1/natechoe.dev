/*
   swebs - a simple web server
   Copyright (C) 2022  Nate Choe
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include <stdlib.h>
#include <string.h>

#include <errno.h>
#include <fcntl.h>
#include <limits.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/wait.h>

#include <swebs/responses.h>
#include <swebs/responseutil.h>

char *realpath(char *, char *);

static int readResponse(Connection *conn, char *path) {
	int fd = -1;
	struct stat statbuf;
	if (stat(path, &statbuf)) {
		sendErrorResponse(conn->stream, ERROR_404);
		return 1;
	}
	if (S_ISDIR(statbuf.st_mode)) {
		size_t reqPathLen = conn->path.len;
		size_t pathLen = strlen(path);
		char *assembledPath = malloc(reqPathLen + pathLen + 1);
		char requestPath[PATH_MAX], responsePath[PATH_MAX];
		size_t responsePathLen;
		struct stat requestBuff;
		if (assembledPath == NULL)
			goto error;
		memcpy(assembledPath, path, pathLen);
		memcpy(assembledPath + pathLen,
				conn->path.data, reqPathLen + 1);

		if (realpath(assembledPath, requestPath) == NULL) {
			if (errno == ENOENT) {
				free(assembledPath);
				sendErrorResponse(conn->stream, ERROR_404);
				return 1;
			}
			free(assembledPath);
			goto error;
		}

		if (realpath(path, responsePath) == NULL) {
			free(assembledPath);
			goto error;
		}
		responsePathLen = strlen(responsePath);
		if (memcmp(requestPath, responsePath, responsePathLen)) {
			free(assembledPath);
			goto forbidden;
		}
		/*
		 * in theory an attacker could just request
		 *  /blog/../../../../site/privatekey.pem
		 * so we make sure that the filepath is actually within the path
		 * specified by the page.
		 * */

		if (stat(requestPath, &requestBuff)) {
			free(assembledPath);
			sendErrorResponse(conn->stream, ERROR_404);
			return 1;
		}
		if (S_ISDIR(requestBuff.st_mode)) {
			free(assembledPath);
			sendErrorResponse(conn->stream, ERROR_400);
			return 1;
		}

		fd = open(requestPath, O_RDONLY);
		free(assembledPath);
	}
	else
		fd = open(path, O_RDONLY);
	if (fd < 0)
		goto forbidden;
	return sendSeekableFile(conn->stream, CODE_200, fd);
error:
	sendErrorResponse(conn->stream, ERROR_500);
	return 1;
forbidden:
	sendErrorResponse(conn->stream, ERROR_403);
	return 1;
}

static int linkedResponse(Connection *conn,
		int (*getResponse)(Request *request, Response *response)) {
	Request request;
	Response response;
	int code;
	int ret;

	request.fieldCount = conn->fieldCount;
	request.fields = conn->fields;
	request.path.path = conn->path;
	request.path.fieldCount = conn->pathFieldCount;
	request.path.fields = conn->pathFields;
	request.type = conn->type;
	request.body = conn->body;
	request.bodylen = conn->bodylen;

	code = getResponse(&request, &response);

	switch (response.type) {
		case FILE_KNOWN_LENGTH:
			return sendKnownPipe(conn->stream, getCode(code),
					response.response.file.fd,
					response.response.file.len);
		case FILE_UNKNOWN_LENGTH:
			return sendPipe(conn->stream, getCode(code),
					response.response.file.fd);
		case BUFFER:
			ret = sendBinaryResponse(conn->stream, getCode(code),
					response.response.buffer.data,
					response.response.buffer.len);
			free(response.response.buffer.data);
			return ret;
		case DEFAULT:
			return sendErrorResponse(conn->stream, getCode(code));
	}
	return 1;
}

static int fullmatch(regex_t *regex, char *str) {
	regmatch_t match;
	if (regexec(regex, str, 1, &match, 0))
		return 1;
	return match.rm_so != 0 || match.rm_eo != strlen(str);
}

int sendResponse(Connection *conn, Sitefile *site) {
	char *host = NULL;
	int i;
	for (i = 0; i < conn->fieldCount; i++) {
		if (strcmp(conn->fields[i].field, "Host") == 0) {
			host = conn->fields[i].value;
			break;
		}
	}
	if (host == NULL) {
		sendErrorResponse(conn->stream, ERROR_400);
		return 1;
	}
	for (i = 0; i < site->size; i++) {
		if (site->content[i].respondto != conn->type)
			continue;
		if (fullmatch(&site->content[i].host, host))
			continue;
		if (fullmatch(&site->content[i].path, conn->path.data) == 0) {
			switch (site->content[i].command) {
				case READ:
					readResponse(conn,
							site->content[i].arg);
					break;
				case THROW:
					sendErrorResponse(conn->stream,
							site->content[i].arg);
					break;
				case LINKED:
#if DYNAMIC_LINKED_PAGES
					if (!site->getResponse)
						sendErrorResponse(conn->stream,
								ERROR_500);
					else
						linkedResponse(conn,
							site->getResponse);
#else
					/* Unreachable state */
					sendErrorResponse(conn->stream,
							ERROR_500);
#endif
					break;
				default:
					sendErrorResponse(conn->stream,
							ERROR_500);
					return 1;
			}
			resetConnection(conn);
			return 0;
		}
	}
	sendErrorResponse(conn->stream, ERROR_404);
	return 1;
}
