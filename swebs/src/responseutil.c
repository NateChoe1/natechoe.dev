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
#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <string.h>

#include <unistd.h>

#include <swebs/responseutil.h>

#define CONST_FIELDS "Server: swebs/0.1\r\n"

static int resilientSend(Stream *stream, void *data, size_t len) {
	char *buffer = (char *) data;
	size_t left = len;
	while (left) {
		ssize_t sent = sendStream(stream, buffer, left);
		if (sent < 0)
			return 1;
		if (sent == 0)
			break;
		buffer += sent;
		left -= sent;
	}
	return left != 0;
}

static int sendStreamValist(Stream *stream, char *format, ...) {
	va_list ap;
	int len;
	char *data;
	va_start(ap, format);
	len = vsnprintf(NULL, 0, format, ap);
	data = malloc(len + 1);
	if (data == NULL)
		return 1;

	va_end(ap);
	va_start(ap, format);

	vsprintf(data, format, ap);
	if (resilientSend(stream, data, len)) {
		free(data);
		return 1;
	}
	free(data);
	return 0;
}

char *getCode(int code) {
	switch (code) {
		case 200:
			return strdup(CODE_200);
		case 400:
			return strdup(ERROR_400);
		case 403:
			return strdup(ERROR_403);
		case 404:
			return strdup(ERROR_404);
		case 500:
			return strdup(ERROR_500);
		default:
			return NULL;
	}
}

int sendStringResponse(Stream *stream, const char *status, char *str) {
	return sendStreamValist(stream,
		"HTTP/1.1 %s\r\n"
		CONST_FIELDS
		"Content-Length: %lu\r\n"
		"\r\n"
		"%s"
		, status, strlen(str), str
	);
}

int sendErrorResponse(Stream *stream, const char *error) {
	const char *template =
		"<meta charset=utf-8>"
		"<h1 text-align=center>"
		  "%s"
		"</h1>";
	int ret;
	int len = snprintf(NULL, 0, template, error);
	char *response = malloc(len + 1);
	sprintf(response, template, error);
	ret = sendStringResponse(stream, error, response);
	free(response);
	return ret;
}

int sendBinaryResponse(Stream *stream, const char *status,
		void *data, size_t len) {
	if (sendHeader(stream, status, len))
		return 1;
	return resilientSend(stream, data, len);
}

int sendHeader(Stream *stream, const char *status, size_t len) {
	return (sendStreamValist(stream,
		"HTTP/1.1 %s\r\n"
		CONST_FIELDS
		"Content-Length: %lu\r\n"
		"\r\n"
		, status, len));
}

int sendSeekableFile(Stream *stream, const char *status, int fd) {
	off_t len;
	len = lseek(fd, 0, SEEK_END);
	lseek(fd, 0, SEEK_SET);
	return sendKnownPipe(stream, status, fd, len);
}

int sendPipe(Stream *stream, const char *status, int fd) {
	size_t allocResponse = 1024;
	size_t responseLen = 0;
	char *response = malloc(allocResponse);
	for (;;) {
		ssize_t len;
		if (responseLen >= allocResponse) {
			char *newresponse;
			allocResponse *= 2;
			newresponse = realloc(response, allocResponse);
			if (newresponse == NULL)
				goto error;
			response = newresponse;
		}
		len = read(fd,
			response + responseLen,
			allocResponse - responseLen);
		if (len < 0)
			goto error;
		else if (len == 0)
			break;
		responseLen += len;
	}
	close(fd);
	sendHeader(stream, CODE_200, responseLen);
	if (resilientSend(stream, response, responseLen)) {
		free(response);
		return 1;
	}
	free(response);
	return 0;
error:
	close(fd);
	free(response);
	sendErrorResponse(stream, ERROR_500);
	return 1;
}

int sendKnownPipe(Stream *stream, const char *status, int fd, size_t len) {
	size_t totalSent = 0;
	sendHeader(stream, status, len);
	for (;;) {
		char buffer[1024];
		ssize_t inBuffer = read(fd, buffer, sizeof(buffer));
		if (inBuffer < 0)
			return 1;
		if (inBuffer == 0)
			return totalSent != len;
		if (resilientSend(stream, buffer, inBuffer))
			return 1;
	}
}
