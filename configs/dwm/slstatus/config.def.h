const unsigned int interval      = 1000;
static const char unknown_str[]  = "N/A";
#define MAXLEN 512

static const struct arg args[] = {
	{ keymap,    " [  %s ]",   NULL          },
	{ ram_used,  " [  %s (",   NULL          },
	{ ram_perc,  "%s%%) ]",     NULL          },
	{ datetime,  " [  %s ] ",  "%d/%m %H:%M" },
};
