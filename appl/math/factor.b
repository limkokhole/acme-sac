#
#	initially generated by c2l
#

implement Factor;

include "draw.m";

Factor: module
{
	init: fn(nil: ref Draw->Context, argl: list of string);
};

include "sys.m";
	sys: Sys;
include "bufio.m";
	bufio: Bufio;
	Iobuf:  import bufio;
include "math.m";
	maths: Math;
	modf: import maths;

init(nil: ref Draw->Context, argl: list of string)
{
	sys = load Sys Sys->PATH;
	bufio = load Bufio Bufio->PATH;
	maths = load Math Math->PATH;
	main(len argl, argl);
}

WHLEN: con 48;
wheel := array[WHLEN] of {
	real 2,
	real 10,
	real 2,
	real 4,
	real 2,
	real 4,
	real 6,
	real 2,
	real 6,
	real 4,
	real 2,
	real 4,
	real 6,
	real 6,
	real 2,
	real 6,
	real 4,
	real 2,
	real 6,
	real 4,
	real 6,
	real 8,
	real 4,
	real 2,
	real 4,
	real 2,
	real 4,
	real 8,
	real 6,
	real 4,
	real 6,
	real 2,
	real 4,
	real 6,
	real 2,
	real 6,
	real 6,
	real 4,
	real 2,
	real 4,
	real 6,
	real 2,
	real 6,
	real 4,
	real 2,
	real 4,
	real 2,
	real 10,
};
bin: ref Iobuf;

main(argc: int, argv: list of string)
{
	n: real;
	i: int;
	l: string;

	if(argc > 1){
		argv = tl argv;
		for(i = 1; i < argc; i++){
			n = real hd argv;
			factor(n);
			argv = tl argv;
		}
		exit;
	}
	bin = bufio->fopen(sys->fildes(0), Sys->OREAD);
	for(;;){
		l = bin.gets('\n');
		if(l == nil)
			break;
		n = real l;
		if(n <= real 0)
			break;
		factor(n);
	}
	exit;
}

factor(n: real)
{
	quot, d, s: real;
	i: int;

	sys->print("%d\n", int n);
	if(n == real 0)
		return;
	s = maths->sqrt(n)+real 1;
	for(;;){
		(iquot, frac) := modf(n/real 2);
		if(frac != real 0)
			break;
		quot = real iquot;
		sys->print("     2\n");
		n = quot;
		s = maths->sqrt(n)+real 1;
	}
	for(;;){
		(iquot, frac) := modf(n/real 3);
		if(frac != real 0)
			break;
		quot = real iquot;
		sys->print("     3\n");
		n = quot;
		s = maths->sqrt(n)+real 1;
	}
	for(;;){
		(iquot, frac) := modf(n/real 5);
		if(frac != real 0)
			break;
		quot = real iquot;
		sys->print("     5\n");
		n = quot;
		s = maths->sqrt(n)+real 1;
	}
	for(;;){
		(iquot, frac) := modf(n/real 7);
		if(frac != real 0)
			break;
		quot = real iquot;
		sys->print("     7\n");
		n = quot;
		s = maths->sqrt(n)+real 1;
	}
	d = real 1;
	for(i = 1;;){
		d += wheel[i];
		for(;;){
			(iquot, frac) := modf(n/d);
			if(frac != real 0)
				break;
			quot = real iquot;
			sys->print("     %d\n", int d);
			n = quot;
			s = maths->sqrt(n)+real 1;
		}
		i++;
		if(i >= WHLEN){
			i = 0;
			if(d > s)
				break;
		}
	}
	if(n > real 1)
		sys->print("     %d\n", int n);
	sys->print("\n");
}

