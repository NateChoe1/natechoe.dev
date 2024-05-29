/* This website changes colors by 1 degree on the color wheel every day, which
 * means that we have to dynamically generate a few resources. */

#include <time.h>
#include <stdio.h>
#include <string.h>

#include <fcntl.h>
#include <unistd.h>

#include <swebs/util.h>
#include <swebs/swebs.h>

/* When I first created natechoe.dev, the colors didn't change. I didn't even
 * have support in swebs for dynamically generated responses. I just picked a
 * nice looking cyan color and ran with it. Now that cyan color serves as a
 * fallback whenever things go wrong. */
#define INITIAL_COLOR 203

static int getcolors(Request *request, Response *response);

#define BINARY_COLORS \
	X(getfavicon, "/site/favicon.ico", 326, C(62, 25, 255, 0)) \
	X(getbutton, "/site/site/resources/88x31.bmp", 1434, C(54, 0, 255, 0) C(62, 0, 255, 180))

#define X(funcname, filename, filelen, colors) \
	static int funcname(Request *request, Response *response);
BINARY_COLORS
#undef X

int getResponse(Request *request, Response *response) {
	if (strcmp(request->path.path.data, "/autogen/colors.css") == 0)
		return getcolors(request, response);
	if (strcmp(request->path.path.data, "/favicon.ico") == 0)
		return getfavicon(request, response);
	if (strcmp(request->path.path.data, "/resources/88x31.bmp") == 0)
		return getbutton(request, response);
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
	const int initial = INITIAL_COLOR;
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

/* returns 0 on failure and 1 on success */
static int injectcolor(int fd, int fileoffset, int hue, int satmin, int brightness) {
	unsigned char r, g, b;
	switch (hue / 60) {
#define UP_CASE(offset, high, shift, low)  \
	case offset: \
		high = brightness; \
		low = satmin; \
		shift = satmin + (brightness-satmin)*(hue-(offset)*60)/60;; \
		break
#define DOWN_CASE(offset, high, shift, low)  \
	case offset: \
		high = brightness; \
		low = satmin; \
		shift = brightness - (brightness-satmin)*(hue-(offset)*60)/60;; \
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
		return 0;
	}

	unsigned char payload[] = {b, g, r};

	lseek(fd, fileoffset, SEEK_SET);
	if (write(fd, payload, sizeof payload) < sizeof payload) {
		return 0;
	}
	lseek(fd, 0, SEEK_SET);
	return 1;
}

#define X(funcname, filename, filelen, colors) \
static int funcname(Request *request, Response *response) { \
	static long BINARY_COLORS_LAST_UPDATE_##funcname = -1; \
	int fd = open(filename, O_RDWR); \
	if (fd == -1) { \
		goto error_500; \
	} \
\
	long today = getday(); \
	if (BINARY_COLORS_LAST_UPDATE_##funcname != today) { \
		int color = getcolor(today); \
		colors \
		BINARY_COLORS_LAST_UPDATE_##funcname = today; \
	} \
\
	response->type = FILE_KNOWN_LENGTH; \
	response->response.file.fd = fd; \
	response->response.file.len = filelen; \
	return 200; \
error_500: \
	response->type = DEFAULT; \
	return 500; \
}
#define C(offset, sat, bri, angle) \
	if (!injectcolor(fd, offset, (color+angle)%360, sat, bri)) { \
		goto error_500; \
	}
BINARY_COLORS
#undef X
#undef C
