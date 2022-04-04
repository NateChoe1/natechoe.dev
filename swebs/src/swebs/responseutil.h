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
#ifndef HAVE_RESPONSE_UTIL
#define HAVE_RESPONSE_UTIL
#include <swebs/sockets.h>

#define CODE_200  "200 OK"
#define ERROR_400 "400 Bad Request"
#define ERROR_403 "403 Forbidden"
#define ERROR_404 "404 Not Found"
#define ERROR_500 "500 Internal Server Error"

char *getCode(int code);
int sendStringResponse(Stream *stream, const char *status, char *str);
int sendBinaryResponse(Stream *stream, const char *status,
		void *data, size_t len);
int sendErrorResponse(Stream *stream, const char *error);
/* sendErrorResponse(conn, ERROR_404); */
int sendHeader(Stream *stream, const char *status, size_t len);
int sendSeekableFile(Stream *stream, const char *status, int fd);
int sendPipe(Stream *stream, const char *status, int fd);
int sendKnownPipe(Stream *stream, const char *status, int fd, size_t len);
#endif
