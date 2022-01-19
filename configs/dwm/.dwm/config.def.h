/* appearance */
static const unsigned int borderpx  = 1;            /* border pixel of windows */
static const unsigned int snap      = 24;           /* shows how many pixels to stick
                                                       a window to screen border etc */
static const int showbar            = 1;            /* 0 means no bar */
static const int topbar             = 1;            /* 0 means bottom bar */
static const char *fonts[]          = { "VictorMono Nerd Font:size=13:style=SemiBold:antialias=true:autohint=true" };
static const char dmenufont[]       = "VictorMono Nerd Font:size=13:style=SemiBold:antialias=true:autohint=true";
// static const char *fonts[]          = { "Victor Mono:size=13:style=Semibold:antialias=true:autohint=true" };
// static const char dmenufont[]       = "Victor Mono:size=13:style=Semibold:antialias=true:autohint=true";
static const char col_gray1[]       = "#383c4a";    /* inactive background color */
static const char col_gray2[]       = "#383c4a";    /* inactive border color */
static const char col_gray3[]       = "#d3dae3";    /* inactive foreground color */
static const char col_gray4[]       = "#383c4a";    /* active foreground color */
static const char col_accent[]      = "#88c0d0";    /* accent color &
                                                       active bg and border color */
static const char *colors[][3]      = {
	/*               fg         bg          border    */
	[SchemeNorm] = { col_gray3, col_gray1,  col_gray2  },
	[SchemeSel]  = { col_gray4, col_accent, col_accent },
};

/* tagging */
/* I prefer to see tags as numbers and not icons */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Pcmanfm",  NULL,       NULL,       0,            1,           -1 },
	{ "Thunar",   NULL,       NULL,       0,            1,           -1 },
	{ "Zathura",  NULL,       NULL,       1 << 3,       0,           -1 },
	{ "Gimp",     NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact        = 0.5;  /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1;    /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_accent, "-sf", col_gray1, NULL };
static const char *termcmd[]  = { "kitty", NULL };
static const char *scrot_z[] = { "scrot", "-z", "/home/creasure/Others/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png", NULL };
static const char *scrot_zs[] = { "scrot", "-z", "-s", "/home/creasure/Others/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png", NULL };
static const char *scrot_zsf[] = { "scrot", "-z", "-s", "-f", "/home/creasure/Others/Pictures/Screenshots/%Y-%m-%d-%T-screenshot.png", NULL };

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	// { MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
	{ 0,                            XK_Print,  spawn,          { .v = scrot_z } },
	{ ShiftMask,                    XK_Print,  spawn,          { .v = scrot_zs } },
	{ ControlMask,                  XK_Print,  spawn,          { .v = scrot_zsf } },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
