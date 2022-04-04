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


#include <swebs/config.h>
#if DYNAMIC_LINKED_PAGES
#include <dlfcn.h>
#include <swebs/dynamic.h>

int (*loadGetResponse(char *library))(Request *, Response *) {
	void *handle = dlopen(library, RTLD_LAZY);
	int (*ret)(Request *, Response *);

	*(void **) &ret = dlsym(handle, "getResponse");
	/* Dirty hack to make this code ANSI C compliant*/
	return ret;
}
#else
#include <stdlib.h>

#include <swebs/types.h>

int (*loadGetResponse(char *library))(Request *, Response *) {
	/* The code should NEVER reach this state */
	exit(EXIT_FAILURE);
}
#endif
