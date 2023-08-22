LANGUAGE := algol60   # replace with your own language to be compiled

# setting CC to gcc or clang explicitly should be OK.  Don't use tcc - seriously broken wchar_t support.
CC=cc 

# Pick one:
#SAFEOPTS=-Ofast -DFAST   # for a factor of 3 speedup.
SAFEOPTS=-g -Wall 

# Pick one: (Note that two programs fail with runtime-checking options on, so those always use SAFEOPTS )
# btw running under valgrind gives it a clean bill of health.
OPTS=$(SAFEOPTS)
#OPTS=-DFAST -Wall -Wno-return-type -Wno-comment -fsanitize=undefined -fsanitize-undefined-trap-on-error  -fno-sanitize-recover=all -frecord-gcc-switches  -fsanitize=float-divide-by-zero -fsanitize=float-cast-overflow  -fstack-protector -O2  -ftrapv -grecord-gcc-switches  -ggdb3 # -fsanitize=address - always fails in getwc.

all: $(LANGUAGE:%=%) regen Makefile # $(LANGUAGE:%=%.ng)  # mnemalyse
	make regression
	echo All up to date.

# This builds the actual compiler.  The demo only outputs the compiler source
# but with variables converted into upper case as a demonstration.
# Your own code could be an actual compiler, or perhaps a translator
# from your language to C.
$(LANGUAGE:%=%): $(LANGUAGE:%=%.h) Makefile regexp-lexer.o mnemosyne.o flex.o uparse.o
	$(CC) $(OPTS) -o $(LANGUAGE:%=%) uparse.o regexp-lexer.o mnemosyne.o flex.o

# This regenerates the skeleton compiler code (CST to AST conversion) from the grammar.
$(LANGUAGE:%=%-ast.h): regen
	./regen > $(LANGUAGE:%=%-ast.h)

# This regenerates the skeleton compiler code (CST to AST conversion) from the grammar.
$(LANGUAGE:%=%-comp.h): gencomp
	./gencomp > $(LANGUAGE:%=%-comp.h)

# This builds the tool to regenerate the skeleton compiler code from the grammar.
# It currently only builds the CST to AST conversion.
regen: regen.c $(LANGUAGE:%=%.h) parser.h flex.o Makefile
	$(CC) $(SAFEOPTS) -o regen -DGRAMMAR=\"$(LANGUAGE:%=%.h)\" regen.c flex.o

# This builds the tool to regenerate the skeleton compiler code from the grammar.
# It currently only builds the CST to AST conversion.
gencomp: gencomp.c $(LANGUAGE:%=%.h) parser.h flex.o Makefile
	$(CC) $(SAFEOPTS) -o gencomp -DGRAMMAR=\"$(LANGUAGE:%=%.h)\" gencomp.c flex.o

# This is a backup of the grammar extracted from the grammar tables.
# Only the basic rules are saved. Comments and some grammar extensions are dropped.
# It may be useful when making changes to the grammar after the compiler code is written.
$(LANGUAGE:%=%.ng): $(LANGUAGE:%=%-ast.h)
	sed -ne 's|\(.*\)//\\\\ \(.*\)|\2|gp' $(LANGUAGE:%=%-ast.h) > $(LANGUAGE:%=%.ng)

# This is the body of the parser.  It requires the grammar to have been converted to table form.
uparse.o: uparse.c parser.h flex.h Makefile $(LANGUAGE:%=%.h) $(LANGUAGE:%=%-ast.h) $(LANGUAGE:%=%-comp.h) $(LANGUAGE:%=%-indent.c)
	$(CC) $(OPTS) -DGRAMMAR=\"$(LANGUAGE:%=%.h)\" \
	              -DAPPMODULE=\"$(LANGUAGE:%=%-indent.c)\" -DAPPCOMMAND=reindent \
	              -DCST2AST=\"$(LANGUAGE:%=%-ast.h)\" \
	      -Wno-unused-variable -c uparse.c 

##uparse.o: uparse.c parser.h flex.h Makefile $(LANGUAGE:%=%-ast.h) $(LANGUAGE:%=%-comp.h)
##	$(CC) $(OPTS) -DSUPPLY_DEFAULT_WALK_AST -DGRAMMAR=\"$(LANGUAGE:%=%.h)\" -DCST2AST=\"$(LANGUAGE:%=%-ast.h)\" -Wno-unused-variable -c uparse.c 

# This converts the grammar to table form.
$(LANGUAGE:%=%.h): $(LANGUAGE:%=%.g) takeon Makefile
	./takeon $(LANGUAGE:%=%.g) > $(LANGUAGE:%=%.h)

# This builds the utility which converts the grammar to table form.
# NOTE: -fsanitize=address causes erroneous trap when running takeon.  Do not use that option here.

takeon: takeon.c takeon-output.c flex.h takeon-checks.c Makefile flex.o
	$(CC) $(SAFEOPTS) -o takeon                                 takeon.c flex.o

# This is a utility used in much of the code to support flex arrays, i.e. arrays
# which extend their allocated space as more elements are accessed.  It also
# supplies some checks on array bounds and unassigned variables.  These are
# relatively cheap to implement - the runtime of a program using flex arrays
# and checking is about 3 times that of the same program with static arrays
# and no checks.  Use the "-DFAST" option at the head of this file for a
# faster executable but only once the code is stable and ready for release testing.
flex.o: flex.c flex.h Makefile
	$(CC) $(SAFEOPTS) -c flex.c

# This is an internal regular expression matcher which has been modified
# to support Unicode characters.
regexp-lexer.o: regexp-lexer.c tools/mnemosyne.h Makefile parser.h
	$(CC) $(OPTS) -c regexp-lexer.c -Itools

# This is an old memory leak utility I used to use in the 80's - you can get
# equally good results nowadays by using valgrind instead.  It is off by default.
mnemosyne.o: tools/mnemosyne.c tools/mnemosyne.h Makefile
	$(CC) $(OPTS) -Wno-unused-variable -Wno-pointer-to-int-cast -c tools/mnemosyne.c -Itools

# The post-execution analyzer for mnemosyne (the Greek Goddess of memory)
mnemalyse: tools/mnemalyse.c tools/mnemosyne.h Makefile
	$(CC) $(OPTS) -o mnemalyse tools/mnemalyse.c -Itools

web:
	make clean
	cc -o grammar2html tools/grammar2html.c
	cc -o ctohtml tools/ctohtml.c
	./grammar2html $(LANGUAGE:%=%.g) > $(LANGUAGE:%=%.g.html)
	./grammar2html calc.g > calc.g.html
	./ctohtml takeon.c > takeon.c.html
	./ctohtml takeon-output.c > takeon-output.c.html
	./ctohtml takeon-checks.c > takeon-checks.c.html
	./ctohtml uparse.c > uparse.c.html
	./ctohtml $(LANGUAGE:%=%.h) > $(LANGUAGE:%=%.h.html)
	./ctohtml regexp-lexer.c > regexp-lexer.c.html
	./ctohtml regexp-lexer.h > regexp-lexer.h.html
	./ctohtml flex.c > flex.c.html
	./ctohtml flex.h > flex.h.html
	./ctohtml parser.h > parser.h.html
	./ctohtml regen.c > regen.c.html
	./ctohtml gencomp.c > gencomp.c.html
	./ctohtml calc-compile.c > calc-compile.c.html
	./ctohtml $(LANGUAGE:%=%-ast.h) > $(LANGUAGE:%=%-ast.h.html)
	./ctohtml $(LANGUAGE:%=%-comp.h) > $(LANGUAGE:%=%-comp.h.html)
	./ctohtml $(LANGUAGE:%=%-indent.c) > $(LANGUAGE:%=%-indent.c.html)
	# vim was a bad choice and everyone may not have it installed.
	# vim's default is truly ugly and you need to add this to ~/.vimrc: colorscheme slate
	# bash -c 'vim -c TOhtml -c wqa build-parser.sh 2> /dev/null' || exit 0
	rm -f grammar2html ctohtml

# Only for the author. These won't work for anyone else.
upload:
	make web
	tar -cvf $(LANGUAGE:%=%.tar) *.[cgh] Makefile skeleton-Makefile *.sh README.html tools/mnem*.[ch] tools/grammar2html.c tools/ctohtml.c tests/*.a60 *.[chg].html test.calc skeleton-Makefile #*.sh.html
	make clean
	scp Makefile $(LANGUAGE:%=%.tar) gtoal@gtoal.com:gtoal.com/languages/$(LANGUAGE:%=%)/new-unicode-parser/
	ssh gtoal@gtoal.com "( cd gtoal.com/languages/$(LANGUAGE:%=%)/new-unicode-parser ; make clean )"
	ssh gtoal@gtoal.com "( cd gtoal.com/languages/$(LANGUAGE:%=%)/new-unicode-parser ; tar -xvf $(LANGUAGE:%=%.tar) )"

# Parse a lot of Algol source files with the ALGOL 60 demonstration parser.
regression:
	find tests -name '*.a60' > REGRESSION-TESTS.sh
	# Oops. Does require ecce. Need to avoid that. Use sed instead?
	ecce REGRESSION-TESTS.sh -command "(rli=./$(LANGUAGE:%=%) =m)0m-0i.#!/bin/sh.b;%c"
	chmod +x REGRESSION-TESTS.sh
	./REGRESSION-TESTS.sh -x

# Mr Sheen.
clean:
	rm -f *~ *.o $(LANGUAGE:%=%) mnemalyse takeon a60toul ecma_to_unicode fake2strop stropify regen gencomp ctohtml grammar2html a60tohtml unicode_to_jff \#*\# [a-z]*.[chg].html #*.sh.html

tidy:
	rm -f *~ *.o $(LANGUAGE:%=%) mnemalyse takeon a60toul ecma_to_unicode fake2strop stropify regen gencomp ctohtml grammar2html a60tohtml unicode_to_jff \#*\# 
