const unsigned int interval      = 1000;
static const char unknown_str[]  = "N/A";
#define MAXLEN 512

static const struct arg args[] = {
	   { keymap,        " [ %s ]",     NULL              },
	   { ram_used,      " [  %s (",   NULL              },
	   { ram_perc,      "%s%%) ]",     NULL              },
	// { battery_perc,  " [ %s%% ]",   "BAT0"            },
	   { datetime,      " [  %s ] ",  "%d(%u)/%m %H:%M" },
};
