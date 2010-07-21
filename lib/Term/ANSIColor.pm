use v6;

module Term::ANSIColor;

# these will be macros one day, yet macros can't be exported so far
sub RESET         is export { "\e[0m"  }
sub BOLD          is export { "\e[1m"  }
sub UNDERLINE     is export { "\e[4m"  }
sub INVERSE       is export { "\e[7m"  }
sub BOLD_OFF      is export { "\e[22m" }
sub UNDERLINE_OFF is export { "\e[24m" }
sub INVERSE_OFF   is export { "\e[27m" }

my %attrs = 
	reset      => "\e[0m",
	bold       => "\e[1m",
	underline  => "\e[4m",
	inverse    => "\e[7m",
	black      => "\e[30m",
	red        => "\e[31m",
	green      => "\e[32m",
	yellow     => "\e[33m",
	blue       => "\e[34m",
	magenta    => "\e[35m",
	cyan       => "\e[36m",
	white      => "\e[37m",
	default    => "\e[39m",
	on_black   => "\e[40m",
	on_red     => "\e[41m",
	on_green   => "\e[42m",
	on_yellow  => "\e[43m",
	on_blue    => "\e[44m",
	on_magenta => "\e[45m",
	on_cyan    => "\e[46m",
	on_white   => "\e[47m",
	on_default => "\e[49m";

sub color (Str $what) is export {
	my $res;
	my @a = $what.split(' ');
	for @a -> $attr {
		my $buf = %attrs{$attr};
		$buf ?? ($res ~= $buf) !! (die "No such attribute: $attr");
	}
	return $res;
}

sub colored (Str $what, Str $how) is export {
	color($how) ~ $what ~ color('reset');
}
