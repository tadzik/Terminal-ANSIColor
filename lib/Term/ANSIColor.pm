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
	reset      => "0",
	bold       => "1",
	underline  => "4",
	inverse    => "7",
	black      => "30",
	red        => "31",
	green      => "32",
	yellow     => "33",
	blue       => "34",
	magenta    => "35",
	cyan       => "36",
	white      => "37",
	default    => "39",
	on_black   => "40",
	on_red     => "41",
	on_green   => "42",
	on_yellow  => "43",
	on_blue    => "44",
	on_magenta => "45",
	on_cyan    => "46",
	on_white   => "47",
	on_default => "49";

sub color (Str $what) is export {
	my @res;
	my @a = $what.split(' ');
	for @a -> $attr {
		if %attrs.exists($attr) {
			@res.push: %attrs{$attr}
		} else {
			die("No such attribute: '$attr'")
		}
	}
	return "\e[" ~ @res.join(';') ~ "m";
}

sub colored (Str $what, Str $how) is export {
	color($how) ~ $what ~ color('reset');
}

sub colorvalid (*@a) is export {
	for @a -> $el {
		return False unless %attrs.exists($el)
	}
	return True;
}

sub colorstrip (*@a) is export {
	my @res;
	for @a -> $str {
		@res.push: $str.subst(/\e\[ <[0..9;]>+ m/, '', :g);
	}
	return @res.join;
}

sub uncolor (Str $what) is export {
	my @res;
	my @list = $what.comb(/\d+/);
	for @list -> $elem {
		if %attrs.reverse.exists($elem) {
			@res.push: %attrs.reverse{$elem}
		} else {
			die("No such sequence: {'\e[' ~ $elem ~ 'm'}")
		}
	}
	return @res.join(' ');
}
