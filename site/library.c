/* It's been less than a week and my blog post is already inaccurate :(
 * 
 * https://natechoe.dev/blog/2023-12-28.html
 * 
 * I added a favicon to this page which also has to be dynamically generated so
 * I rewrote this entire file. The general control flow is still the same.
 *
 * By the way, I generate that favicon using an assembler! See site/favicon.asm
 * for more info.
 * */

#include <time.h>
#include <stdio.h>
#include <string.h>

#include <fcntl.h>
#include <unistd.h>

#include <swebs/util.h>
#include <swebs/swebs.h>

static int getcolors(Request *request, Response *response);
static int getfavicon(Request *request, Response *response);

int getResponse(Request *request, Response *response) {
	if (strcmp(request->path.path.data, "/autogen/colors.css") == 0)
		return getcolors(request, response);
	if (strcmp(request->path.path.data, "/favicon.ico") == 0)
		return getfavicon(request, response);
	response->type = DEFAULT;
	return 404;
}

static long getday() {
	time_t currtime;
	const time_t reference = 1655182800;
	/* Midnight of the day of implementation in CST */
	const int perday = 86400;
	/* Seconds per day */
	currtime = time(NULL);
	if (currtime == -1) {
		return 0;
	}
	return (currtime - reference) / perday;
}

static int getcolor(long day) {
	/* The initial color at the time of implementation, just an arbitrary
	 * choice that I liked */
	const int initial = 203;
	return (day + initial) % 360;
}

static int getcolors(Request *request, Response *response) {
	static long lastcolorupdate = -1;
	static char colorbuff[300];
	static int colorlen = 0;

	long today = getday();;

	if (lastcolorupdate != today) {
		int color;
		color = getcolor(today);
		lastcolorupdate = today;

		colorlen = sprintf(colorbuff,
":root{"
	"--backcol:hsl(%d,93%%,84%%);"
	"--doccol:hsl(%d,92%%,75%%);"
	"--shadowcol:#444444;"
	"--codeback:#d3d3d3;"
	"--codecol:#000000;"
	"--barcol:hsl(%d,96%%,68%%);"
	"--textcol:#000000;"
"} /*%ld %ld*/", color, color, color, lastcolorupdate, today
		);
	}
	response->type = BUFFER_NOFREE;
	response->response.buffer.data = colorbuff;
	response->response.buffer.len = colorlen;
	return 200;
}

static int getfavicon(Request *request, Response *response) {
	static long lastfaviconupdate = -1;

	/* The important color is in BGRA format at this location in
	 * /site/favicon.ico */
	const int color_offset = 62;

	/* The favicon is this many bytes */
	const int favicon_len = 326;

	int fd = open("/site/favicon.ico", O_RDWR);
	if (fd == -1) {
		request->type = DEFAULT;
		return 500;
	}

	long today = getday();

	if (lastfaviconupdate != today) {
		int color;
		unsigned char r, g, b;
		color = getcolor(today);
		switch (color / 60) {
#define UP_CASE(offset, high, shift, low)  \
		case offset: \
			high = 255; \
			low = 25; \
			shift = 25 + (255-25)*(color-(offset)*60)/60;; \
			break
#define DOWN_CASE(offset, high, shift, low)  \
		case offset: \
			high = 255; \
			low = 25; \
			shift = 255 - (255-25)*(color-(offset)*60)/60;; \
			break
		UP_CASE(0, r, g, b);
		DOWN_CASE(1, g, r, b);
		UP_CASE(2, g, b, r);
		DOWN_CASE(3, b, g, r);
		UP_CASE(4, b, r, g);
		DOWN_CASE(5, r, b, g);
#undef UP_CASE
#undef DOWN_CASE
		default:
			request->type = DEFAULT;
			return 500;
		}

		unsigned char payload[] = {b, g, r};

		lseek(fd, color_offset, SEEK_SET);
		if (write(fd, payload, sizeof payload) < sizeof payload) {
			close(fd);
			request->type = DEFAULT;
			return 500;
		}
		lastfaviconupdate = today;
		lseek(fd, 0, SEEK_SET);
	}

	response->type = FILE_KNOWN_LENGTH;
	response->response.file.fd = fd;
	response->response.file.len = favicon_len;
	return 200;
}
