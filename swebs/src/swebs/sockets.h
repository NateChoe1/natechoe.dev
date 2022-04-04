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
#ifndef HAVE_SOCKETS
#define HAVE_SOCKETS
#include <stddef.h>

#include <netinet/in.h>
#include <gnutls/gnutls.h>

#include <swebs/types.h>

typedef struct {
	int fd;
	struct sockaddr_in addr;
	socklen_t addrlen;
} Listener;

typedef struct {
	SocketType type;
	gnutls_certificate_credentials_t creds;
	gnutls_priority_t priority;
	/* creds and priority are only used in TLS structs. */
} Context;

typedef struct {
	SocketType type;
	int fd;
	gnutls_session_t session;
} Stream;

int initTLS();
Listener *createListener(uint16_t port, int backlog);
Context *createContext(SocketType type, ...);
/*
 * extra arguments depend on type (similar to fcntl):
 * tcp: (void)
 * tls: (char *keyfile, char *certfile)
 * */
int acceptConnection(Listener *listener);
/* Returns a file descriptor from the listener */
Stream *createStream(Context *context, int flags, int fd);
/* flags are fcntl flags */

void freeListener(Listener *listener);
void freeContext(Context *context);
void freeStream(Stream *stream);

ssize_t sendStream(Stream *stream, const void *data, size_t len);
ssize_t recvStream(Stream *stream, void *data, size_t len);
/* return value is the same as the read and write syscalls. */
#endif
