use v6;
use Term::ANSIColor;

# constants. Should not be exported by default, TBD
say BOLD, "Oh, so good to be fat!", RESET;
say color('underline red on_yellow'),
	"Hey, isn't it awesome?", color('reset');
say colored("IM IN UR MODULE MESSING WITH UR COLOURS",
			"bold green on_blue");
