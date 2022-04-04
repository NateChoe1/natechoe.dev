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
#ifndef HAVE_TYPES
#define HAVE_TYPES

#include <stddef.h>
#include <swebs/config.h>

typedef enum {
	TCP,
	TLS
} SocketType;

typedef enum {
	GET,
	POST,
	PUT,
	HEAD,
	DELETE,
	PATCH,
	OPTIONS,
	INVALID
	/*
	 * this indicates an invalid type of request, there is no request called
	 * INVALID in HTTP/1.1.
	 * */
} RequestType;

typedef struct {
	char *data;
	/* data is guarunteed to be NULL terminated, although not necessarily
	 * once. */
	size_t len;
	size_t allocatedLen;
	/* The amount of bytes allocated, for internal use. */
} BinaryString;

typedef struct {
	BinaryString var;
	BinaryString value;
} PathField;

typedef struct {
	BinaryString path;
	long fieldCount;
	PathField *fields;
} Path;

typedef struct {
	char *field;
	char *value;
} Field;

typedef struct {
	long fieldCount;
	Field *fields;
	Path path;
	RequestType type;
	void *body;
	size_t bodylen;
} Request;

typedef enum {
	FILE_KNOWN_LENGTH,
	FILE_UNKNOWN_LENGTH,
	BUFFER,
	DEFAULT
	/* Return the default value for this error code */
} ResponseType;

typedef struct {
	int fd;
	size_t len;
	/* Sometimes optional */
} File;

typedef struct {
	void *data;
	size_t len;
} Buffer;

typedef struct {
	ResponseType type;
	union {
		File file;
		Buffer buffer;
	} response;
} Response;
#endif
