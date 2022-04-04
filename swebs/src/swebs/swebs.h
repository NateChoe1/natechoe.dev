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

/*
 * This file is called swebs.h because it's the main thing that the end users
 * are going to be interfacing with.
 * */
#ifndef HAVE_SWEBS
#define HAVE_SWEBS
#include <swebs/config.h>
#if DYNAMIC_LINKED_PAGES
#include <swebs/types.h>

int getResponse(Request *request, Response *response);
/* Returns the HTTP response code, the user is responsible for writing this */

#else
#error "This version of swebs has no dynamic linked page support"
#endif
#endif
