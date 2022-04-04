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
#include <time.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

#include <fcntl.h>
#include <sys/shm.h>
#include <sys/socket.h>

#include <swebs/util.h>
#include <swebs/types.h>

static FILE *logs;

int initLogging(char *path) {
	logs = fopen(path, "a");
	return logs == NULL;
}

int smalloc(size_t size) {
	return shmget(IPC_PRIVATE, size,
			IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
}

void *saddr(int id) {
	void *addr;
	addr = shmat(id, NULL, 0);
	if (addr == (void *) -1)
		return NULL;
	return addr;
}

void sfree(void *addr) {
	shmdt(addr);
}

void sdestroy(int id) {
	shmctl(id, IPC_RMID, 0);
}

int createLog(char *msg) {
	time_t currenttime;
	struct tm *timeinfo;
	time(&currenttime);
	timeinfo = gmtime(&currenttime);
	if (timeinfo == NULL)
		return 1;
	fprintf(logs, "[%d-%02d-%02dT%02d:%02d:%02dZ] %s\n",
			timeinfo->tm_year + 1900,
			timeinfo->tm_mon + 1,
			timeinfo->tm_mday,
			timeinfo->tm_hour,
			timeinfo->tm_min,
			timeinfo->tm_sec,
			msg);
	fflush(logs);
	return 0;
}

int istrcmp(char *s1, char *s2) {
	int i;
	for (i = 0;; i++) {
		char c1 = tolower(s1[i]);
		char c2 = tolower(s2[i]);
		if (c1 != c2)
			return c1 - c2;
		if (c1 == '\0')
			return 0;
	}
}

RequestType getType(char *str) {
	if (strcmp(str, "GET") == 0)
		return GET;
	if (strcmp(str, "POST") == 0)
		return POST;
	if (strcmp(str, "PUT") == 0)
		return PUT;
	if (strcmp(str, "HEAD") == 0)
		return HEAD;
	if (strcmp(str, "DELETE") == 0)
		return DELETE;
	if (strcmp(str, "PATCH") == 0)
		return PATCH;
	if (strcmp(str, "OPTIONS") == 0)
		return OPTIONS;
	return INVALID;
}

void sendFd(int fd, int dest) {
	struct msghdr msg;
	struct cmsghdr *cmsg;
	char iobuf[1];
	struct iovec io;
	union {
		char buf[CMSG_SPACE(sizeof(fd))];
		struct cmsghdr align;
	} u;
	memset(&msg, 0, sizeof(msg));
	io.iov_base = iobuf;
	io.iov_len = sizeof(iobuf);
	msg.msg_iov = &io;
	msg.msg_iovlen = 1;
	msg.msg_control = u.buf;
	msg.msg_controllen = sizeof(u.buf);
	cmsg = CMSG_FIRSTHDR(&msg);
	cmsg->cmsg_level = SOL_SOCKET;
	cmsg->cmsg_type = SCM_RIGHTS;
	cmsg->cmsg_len = CMSG_LEN(sizeof(fd));
	memcpy(CMSG_DATA(cmsg), &fd, sizeof(fd));
	sendmsg(dest, &msg, 0);
}

int recvFd(int source) {
	union {
		char buff[CMSG_SPACE(sizeof(int))];
		struct cmsghdr align;
	} cmsghdr;
	struct msghdr msg;
	struct cmsghdr *cmsg;
	struct iovec iov;
	int data;
	ssize_t nr;
	int ret;

	msg.msg_name = NULL;
	msg.msg_namelen = 0;

	iov.iov_base = &data;
	iov.iov_len = sizeof(data);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	msg.msg_control = cmsghdr.buff;
	msg.msg_controllen = sizeof(cmsghdr.buff);
	nr = recvmsg(source, &msg, 0);
	if (nr < 0)
		return -1;

	cmsg = CMSG_FIRSTHDR(&msg);
	if (cmsg == NULL || cmsg->cmsg_len != CMSG_LEN(sizeof(data)))
		return -1;
	if (cmsg->cmsg_level != SOL_SOCKET)
		return -1;
	if (cmsg->cmsg_type != SCM_RIGHTS)
		return -1;

	memcpy(&ret, CMSG_DATA(cmsg), sizeof(ret));
	return ret;
}
