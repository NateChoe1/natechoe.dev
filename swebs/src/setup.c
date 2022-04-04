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
#include <stdarg.h>
#include <stdlib.h>

#include <pwd.h>
#include <unistd.h>

#include <swebs/util.h>
#include <swebs/setup.h>

static void daemonize(char *pidfile) {
	pid_t pid;
	FILE *pidout;
	pid = fork();
	switch (pid) {
		case -1:
			exit(EXIT_FAILURE);
		case 0:
			break;
		default:
			pidout = fopen(pidfile, "w");
			fprintf(pidout, "%d\n", pid);
			fclose(pidout);
			exit(EXIT_SUCCESS);
	}

	if (setsid() < 0)
		exit(EXIT_FAILURE);
}

static void printLongMessage(char *first, ...) {
	va_list ap;
	va_start(ap, first);
	puts(first);
	for (;;) {
		char *nextarg = va_arg(ap, char *);
		if (nextarg == NULL)
			break;
		puts(nextarg);
	}
	va_end(ap);
}

void setup(int argc, char **argv,
		Sitefile **site, Listener **listener, int *processes) {
	char *logout = "/var/log/swebs.log";
	char *sitefile = NULL;
	int backlog = 100;
	char shouldDaemonize = 0;
	char *pidfile = "/run/swebs.pid";

	*processes = sysconf(_SC_NPROCESSORS_ONLN) + 1;

	for (;;) {
		int c = getopt(argc, argv, "o:j:s:b:c:Bp:hl");
		if (c == -1)
			break;
		switch (c) {
			case 'o':
				logout = optarg;
				break;
			case 'j':
				*processes = atoi(optarg);
				break;
			case 's':
				sitefile = optarg;
				break;
			case 'b':
				backlog = atoi(optarg);
				break;
			case 'B':
				shouldDaemonize = 1;
				break;
			case 'p':
				pidfile = optarg;
				break;
			case 'l':
				printLongMessage(
"swebs  Copyright (C) 2022 Nate Choe",
"This is free software, and you are welcome to redistribute under certain",
"conditions, but comes with ABSOLUTELY NO WARRANTY. For more details see the",
"GNU General Public License Version 3\n",

"This program dynamically links with:",
"  gnutls (gnutls.org)\n",

"For any complaints, email me at natechoe9@gmail.com",
"I'm a programmer not a lawyer, so there's a good chance I accidentally",
"violated the LGPL.",
NULL
				);
				exit(EXIT_SUCCESS);
			case 'h':
				printLongMessage(
"Usage: swebs [options]",
"  -o [out]                  Set the log file (default: /var/log/swebs.log)",
"  -j [cores]                Use that many cores (default: $(nproc)+1)",
"  -s [site file]            Use that site file (required)",
"  -b [backlog]              Set the socket backlog (default: 100)",
"  -B                        Run swebs in the background and daemonize",
"  -p [pidfile]              Specify PID file if daemonizing",
"                              (defualt: /run/swebs.pid)",
"  -l                        Show some legal details",
"  -h                        Show this help message",
NULL
				);
				exit(EXIT_SUCCESS);
			case '?':
				fprintf(stderr, "-h for help\n");
				exit(EXIT_FAILURE);
		}
	}

	if (sitefile == NULL) {
		fprintf(stderr, "No sitefile configured\n");
		exit(EXIT_FAILURE);
	}

	*site = parseSitefile(sitefile);
	if (site == NULL) {
		fprintf(stderr, "Invalid sitefile %s\n", sitefile);
		exit(EXIT_FAILURE);
	}

	*listener = createListener((*site)->port, backlog);
	if (listener == NULL) {
		fprintf(stderr, "Failed to create socket\n");
		exit(EXIT_FAILURE);
	}

	if (shouldDaemonize)
		daemonize(pidfile);

	if (initLogging(logout)) {
		fprintf(stderr, "Couldn't open logs file %s\n", logout);
		exit(EXIT_FAILURE);
	}

	{
		struct passwd *swebs, *root;
		swebs = getpwnam("swebs");
		if (swebs == NULL)
			createLog("Couldn't find swebs user");
		else
			if (seteuid(swebs->pw_uid))
				createLog("seteuid() failed");
		root = getpwnam("root");
		if (root == NULL) {
			createLog("Couldn't find root user, quitting");
			exit(EXIT_FAILURE);
		}
		if (geteuid() == root->pw_uid) {
			createLog("swebs should not be run as root");
			exit(EXIT_FAILURE);
		}
	}
}
