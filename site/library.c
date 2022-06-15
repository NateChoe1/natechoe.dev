#include <time.h>
#include <stdio.h>
#include <string.h>

#include <swebs/util.h>
#include <swebs/swebs.h>

static long currday = -1;
static char buff[300];
static int currlen;

static int getcolors(Request *request, Response *response);

int getResponse(Request *request, Response *response) {
	if (strcmp(request->path.path.data, "/autogen/colors.css") == 0)
		return getcolors(request, response);
	response->type = DEFAULT;
	return 404;
}

static int getcolors(Request *request, Response *response) {
	long realday;

	{
		time_t currtime;
		const time_t reference = 1655182800;
		/* Midnight of the day of implementation in CST */
		const int perday = 86400;
		/* Seconds per day */
		currtime = time(NULL);
		if (currtime == -1)
			realday = 0;
		else
			realday = (currtime - reference) / perday;
	}

	if (currday != realday) {
		int color;
		const int initial = 203;
		/* The initial color at the time of implementation */
		color = (realday + initial) % 360;
		currday = realday;

		currlen = sprintf(buff,
":root{"
	"--backcol:hsl(%d,93%%,84%%);"
	"--doccol:hsl(%d,92%%,75%%);"
	"--shadowcol:#444444;"
	"--codeback:#d3d3d3;"
	"--codecol:#000000;"
	"--barcol:hsl(%d,96%%,68%%);"
	"--textcol:#000000;"
"} /*%ld %ld*/", color, color, color, currday, realday
		);
	}
	response->type = BUFFER_NOFREE;
	response->response.buffer.data = buff;
	response->response.buffer.len = currlen;
	return 200;
}
