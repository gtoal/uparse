#ifdef FAST
#define PARM_NO_FLEX 1
#endif

/*
     This is a modification of the lightweight regexp package (copyright below) 
   which passes the data to be searched in via a global array rather than a string.
   Access to the array is encapsulated in the procedure demandload_ch(int required_string_offset)
   which fetches data into the array only when needed.  This allows us to modify
   the line reconstruction process on the fly under the control of the higher
   level software - typically the grammar level of a parser guiding the lexing level.

   When this code was added to my parser for parsing programming languages, the
   input stream consisted of a struct containing the reconstructed character,
   the original text, start and end pointers for the original text, and a type
   field.  At this point, when modifying the code to support Unicode, I've temporarily
   removed that code and replaced with a quick hack where the input is a wchar_t string
   terminating in a 0.  This will be rationalised soon.

   It appears that the malloc call here does not claim sufficient space for the
   data needed.  I've bodged it by adding a slop factor to the malloc call for now.
   Most likely the reason is that Unicode characters now take 4 bytes compared to
   the 1 per character that the original 'char' version needed.  At some point I'll
   go back and fix it properly, but since the absolute numbers are so small, it's
   not a critical issue.

 */
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <wchar.h>

//#include "mnemosyne.h"

//#define REGEXP_DEBUG 1
int regexp_debug = 0;

#include "regexp-lexer.h"
#include "parser.h"
extern int *TP;

wchar_t demandload_ch(int offset) {
  if (regexp_debug) fprintf(stderr, "demandload_ch(%d) -> '%lc'\n", offset+(*TP), source(offset+(*TP)));
  return source(offset+(*TP));
}

// modified string routines based on simple implementation
// at https://android.googlesource.com/platform/bionic/+/ics-mr0/libc/string/

int STRINGlen(CHARINDEX p) {
  int len = 0;
  for (;;) {
    int ch = demandload_ch(p);
    //if (ch == '\n') ch = '\0';
    if (ch == '\0') return len;
    p++; len++;
  }
}

CHARINDEX STRINGchr_STR_char(CHARINDEX p, int ch) {
  for (;; ++p) {
    int pch = demandload_ch(p);
    //if (pch == '\n') pch = '\0';
    if (pch == ch) return(p);
    if (!pch)      return(-1);
  }
}

CHARINDEX STRINGchr_STR_CHAR(CHARINDEX p, CHAR ch) {
  //if (ch == '\n') ch = '\0';
  for (;; ++p) {
    int pch = demandload_ch(p);
    //if (pch == '\n') pch = '\0';
    if (pch == ch)   return(p);
    if (pch == '\0') return(-1);
  }
}

wchar_t *STRINGchr_str_CHAR(wchar_t *p, CHAR ch) {
  //if (ch == '\n') ch = '\0';
  for (;; ++p) {
    if (*p == ch)   return(p);
    if (*p == '\0') return(NULL);
  }
}

void STRINGncpy_str_STR(wchar_t *dst, CHARINDEX src, int n) {
  if (n != 0) {
    wchar_t *d = dst;
    CHARINDEX s = src;
    int ch;
    do {
      ch = demandload_ch(s++);
      //if (ch == '\n') ch = '\0';
      *d++ = ch;
      if (ch == '\0') {
        /* NUL pad the remaining n-1 bytes */
        while (--n != 0) *d++ = '\0';
        break;
      }
    } while (--n != 0);
  }
  // return (dst);
}

int STRINGncmp_STR_str(CHARINDEX s1, wchar_t *s2, int n) {
  if (n != 0) do {
    int s1ch = demandload_ch(s1);
    //if (s1ch == '\n') s1ch = '\0';
    if (s1ch != *(wchar_t *)s2) return (s1ch - *(wchar_t *)s2);
    if (s1ch == '\0') break;
    s1++;
    s2++;
  } while (--n != 0);
  return (0);
}

int STRINGncmp_str_STR(wchar_t *s1, CHARINDEX s2, int n) {
  if (n != 0) do {
    int s2ch = demandload_ch(s2);
    //if (s2ch == '\n') s2ch = '\0';
    if (*s1 != s2ch) return (*(wchar_t *)s1 - s2ch);
    if (*s1 == '\0') break;
    s1++; s2++;
  } while (--n != 0);
  return 0;
}

/*
 * regexp.c - regular expression matching
 *
 * DESCRIPTION
 *
 *      This source was taken from the pax posting in comp.sources.unix.
 *
 *      Underneath the reformatting and comment blocks which were added to
 *      make it consistent with the rest of the code, you will find a
 *      modified version of Henry Spencer's regular expression library.
 *      Henry's functions were modified to provide the minimal regular
 *      expression matching, as required by P1003.  Henry's code was
 *      copyrighted, and copy of the copyright message and restrictions
 *      are provided, verbatim, below:
 *
 *      Copyright (c) 1986 by University of Toronto.
 *      Written by Henry Spencer.  Not derived from licensed software.
 *
 *      Permission is granted to anyone to use this software for any
 *      purpose on any computer system, and to redistribute it freely,
 *      subject to the following restrictions:
 *
 *      1. The author is not responsible for the consequences of use of
 *         this software, no matter how awful, even if they arise
 *         from defects in it.
 *
 *      2. The origin of this software must not be misrepresented, either
 *         by explicit claim or by omission.
 *
 *      3. Altered versions must be plainly marked as such, and must not
 *         be misrepresented as being the original software.
 *
 *      PLAIN MARKINGS:
 *      GA: 11th June 1992: removed regerror() function (void regerror(wchar_t *s))
 *      so that it can be provided by client (e.g., ED); and regsub() now
 *      returns 1 for success, 0 for failure, instead of returning void.
 *      There is already a test harness by G. Toal at the end.
 *
 *      GT: Modified 1 Jul 2023 to convert all strings to wchar_t (UTF-32).
 *
 *      Beware that some of this code is subtly aware of the way operator
 *      precedence is structured in regular expressions.  Serious changes in
 *      regular-expression syntax might require a total rethink.
 *
 * AUTHORS
 *
 *     Mark H. Colburn, NAPS International (mark@jhereg.mn.org)
 *     Henry Spencer, University of Toronto (henry@utzoo.edu)
 *
 * Sponsored by The USENIX Association for public distribution.
 *
 */

// Note this is derived from an early version of Henry's code, before
// some tweaks were added by John Gilmore and James Wood.
// See https://opensource.apple.com/source/jam/jam-52/regexp.c.auto.html
// if you want to add those.

/* Headers */

/* Headers for regexp.c */
static wchar_t *reg(int paren, int *flagp);
static wchar_t *regbranch(int *flagp);
static wchar_t *regpiece(int *flagp);
static wchar_t *regatom(int *flagp);
static wchar_t *regnode(wchar_t op);
static void regc(wchar_t b);
static void reginsert(wchar_t op, wchar_t *opnd);
static void regtail(wchar_t *p, wchar_t *val);
static void regoptail(wchar_t *p, wchar_t *val);
static int regtry(regexp *prog, CHARINDEX string);
static int regmatch(wchar_t *prog);
static int regrepeat(wchar_t *p);
static wchar_t *regnext(register wchar_t *p);
/* End of headers for regexp.c */

static wchar_t *regprop(wchar_t *op); // Used in debug

/*
 * The "internal use only" fields in regexp.h are present to pass info from
 * compile to execute that permits the execute phase to run lots faster on
 * simple cases.  They are:
 *
 * regstart     wchar_t that must begin a match; '\0' if none obvious
 * reganch      is the match anchored (at beginning-of-line only)?
 * regmust      string (pointer into program) that match must include, or NULL
 * regmlen      length of regmust string
 *
 * Regstart and reganch permit very fast decisions on suitable starting points
 * for a match, cutting down the work a lot.  Regmust permits fast rejection
 * of lines that cannot possibly match.  The regmust tests are costly enough
 * that regcomp() supplies a regmust only if the r.e. contains something
 * potentially expensive (at present, the only such thing detected is * or +
 * at the start of the r.e., which can involve a lot of backup).  Regmlen is
 * supplied because the test in regexec() needs it and regcomp() is computing
 * it anyway.
 */

/*
 * Structure for regexp "program".  This is essentially a linear encoding
 * of a nondeterministic finite-state machine (aka syntax charts or
 * "railroad normal form" in parsing technology).  Each node is an opcode
 * plus a "nxt" pointer, possibly plus an operand.  "Nxt" pointers of
 * all nodes except BRANCH implement concatenation; a "nxt" pointer with
 * a BRANCH on both ends of it is connecting two alternatives.  (Here we
 * have one of the subtle syntax dependencies:  an individual BRANCH (as
 * opposed to a collection of them) is never concatenated with anything
 * because of operator precedence.)  The operand of some types of node is
 * a literal string; for others, it is a node leading into a sub-FSM.  In
 * particular, the operand of a BRANCH node is the first node of the branch.
 * (NB this is *not* a tree structure:  the tail of the branch connects
 * to the thing following the set of BRANCHes.)  The opcodes are:
 */

/* definition   number  opnd?   meaning */
#define END     (wchar_t)0               /* no   End of program. */
#define BOL     (wchar_t)1               /* no   Match "" at beginning of line. */
#define EOL     (wchar_t)2               /* no   Match "" at end of line. */
#define ANY     (wchar_t)3               /* no   Match any one character. */
#define ANYOF   (wchar_t)4               /* str  Match any character in this string. */
#define ANYBUT  (wchar_t)5               /* str  Match any character not in this string. */
#define BRANCH  (wchar_t)6               /* node Match this alternative, or the nxt... */
#define BACK    (wchar_t)7               /* no   Match "", "nxt" ptr points backward. */
#define EXACTLY (wchar_t)8               /* str  Match this string. */
#define NOTHING (wchar_t)9               /* no   Match empty string. */
#define	PLUS	(wchar_t)11	         /* node	Match this (simple) thing 1 or more times. */
#define STAR    (wchar_t)10              /* node Match this (simple) thing 0 or more times. */
#define OPEN    (wchar_t)20              /* no   Mark this point in input as start of #n. */
/* OPEN+1 is number 1, etc. */
#define CLOSE   (wchar_t)30              /* no   Analogous to OPEN. */

/*
 * Opcode notes:
 *
 * BRANCH       The set of branches constituting a single choice are hooked
 *              together with their "nxt" pointers, since precedence prevents
 *              anything being concatenated to any individual branch.  The
 *              "nxt" pointer of the last BRANCH in a choice points to the
 *              thing following the whole choice.  This is also where the
 *              final "nxt" pointer of each individual branch points; each
 *              branch starts with the operand node of a BRANCH node.
 *
 * BACK         Normal "nxt" pointers all implicitly point forward; BACK
 *              exists to make loop structures possible.
 *
 * STAR,PLUS	'?', and complex '*' and '+', are implemented as circular
 *		BRANCH structures using BACK.  Simple cases (one character
 *		per match) are implemented with STAR and PLUS for speed
 *		and to minimize recursive plunges.
 *
 * OPEN,CLOSE   ...are numbered at compile time.
 */

/*
 * A node is one wchar_t of opcode followed by two chars of "nxt" pointer.
 * "Nxt" pointers are stored as two 8-bit pieces, high order first.  The
 * value is a positive offset from the opcode of the node containing it.
 * An operand, if any, simply follows the node.  (Note that much of the
 * code generation knows about this implicit relationship.)
 *
 * Using two bytes for the "nxt" pointer is vast overkill for most things,
 * but allows patterns to get big without disasters.
 */
#define OP(p)   (*(p))
#define NEXT(p) (((*((p)+1)&0377)<<8) + (*((p)+2)&0377))
#define OPERAND(p)      ((p) + 3)

/*
 * Utility definitions.
 */

#define FAIL(m) { regerror(m); return(NULL); }
#define ISMULT(c)       ((c) == '*' || (c) == '+' || (c) == '?')
#define META    L"^$.[()|*+?\\"

#ifndef CHARBITS
#define UCHARAT(p)      ((wint_t) *((wchar_t *)(p)))
#else
#define UCHARAT(p)      ((wint_t) (*(p))&CHARBITS)
#endif

/*
 * Flags to be passed up and down.
 */
#define HASWIDTH        01      /* Known never to match null string. */
#define SIMPLE          02      /* Simple enough to be STAR operand. */
#define SPSTART         04      /* Starts with * */
#define WORST           0       /* Worst case. */

/*
 * Global work variables for regcomp().
 */
static wchar_t    *regparse;       /* Input-scan pointer. */
static int      regnpar;        /* () count. */
static wchar_t     regdummy;
static wchar_t    *regcode;        /* Code-emit pointer; &regdummy = don't. */
static long     regsize;        /* Code size. */

/*
 * Forward declarations for regcomp()'s friends.
 */
#ifndef STATIC
#define STATIC  static
#endif

/*
 - regcomp - compile a regular expression into internal code
 *
 * We can't allocate space until we know how big the compiled form will be,
 * but we can't compile it (and thus know how big it is) until we've got a
 * place to put the code.  So we cheat:  we compile it twice, once with code
 * generation turned off and size counting turned on, and once "for real".
 * This also means that we don't allocate space until we are sure that the
 * thing really will compile successfully, and we never have to move the
 * code and thus invalidate pointers into it.  (Note that it has to be in
 * one piece because free() must be able to free it all.)
 *
 * Beware that the optimization-preparation code in here knows about some
 * of the structure of the compiled regexp.
 */
regexp *regcomp(const wchar_t *uexp) {
    wchar_t *exp = (wchar_t *)uexp;
    register regexp *r;
    register wchar_t  *scan;
    register wchar_t  *longest;
    register int    len;
    int             flags;

    if (exp == NULL)
	FAIL(L"NULL argument");

    /* First pass: determine size, legality. */
    regparse = exp;
    regnpar = 1;
    regsize = 0L;
    regcode = &regdummy;
    regc(MAGIC);
    if (reg(0, &flags) == NULL)
	return (NULL);

    /* Small enough for pointer-storage convention? */
    if (regsize >= 32767L)      /* Probably could be 65535L. */
	FAIL(L"regexp too big");

    /* Allocate space. */
    r = (regexp *) malloc(sizeof(regexp) + (unsigned) regsize * 4 + 1024 /* BIG SLOPPY KISS courtesy of Valery Grind */);
    if (r == NULL)
	FAIL(L"out of space");

    /* Second pass: emit code. */
    regparse = exp;
    regnpar = 1;
    regcode = r->program;
    regc(MAGIC);
    if (reg(0, &flags) == NULL)
	return (NULL);

    /* Dig out information for optimizations. */
    r->regstart = '\0';         /* Worst-case defaults. */
    r->reganch = 0;
    r->regmust = NULL;
    r->regmlen = 0;
    scan = r->program + 1;      /* First BRANCH. */
    if (OP(regnext(scan)) == END) {     /* Only one top-level choice. */
	scan = OPERAND(scan);

	/* Starting-point info. */
	if (OP(scan) == EXACTLY)
	    r->regstart = *OPERAND(scan);
	else if (OP(scan) == BOL)
	    r->reganch++;

	/*
	 * If there's something expensive in the r.e., find the longest
	 * literal string that must appear and make it the regmust.  Resolve
	 * ties in favor of later strings, since the regstart check works
	 * with the beginning of the r.e. and avoiding duplication
	 * strengthens checking.  Not a strong reason, but sufficient in the
	 * absence of others.
	 */
	if (flags & SPSTART) {
	    longest = NULL;
	    len = 0;
	    for (; scan != NULL; scan = regnext(scan))
		if (OP(scan) == EXACTLY && wcslen((wchar_t *)OPERAND(scan)) >= len) {
		    longest = OPERAND(scan);
		    len = wcslen((wchar_t *)OPERAND(scan));
		}
	    r->regmust = longest;
	    r->regmlen = len;
	}
    }
    return (r);
}

/*
 - reg - regular expression, i.e. main body or parenthesized thing
 *
 * Caller must absorb opening parenthesis.
 *
 * Combining parenthesis handling with the base level of regular expression
 * is a trifle forced, but the need to tie the tails of the branches to what
 * follows makes it hard to avoid.
 */
static wchar_t *reg(paren, flagp)
int             paren;          /* Parenthesized? */
int            *flagp;
{
    register wchar_t  *ret;
    register wchar_t  *br;
    register wchar_t  *ender;
    register int    parno = 0; // suppress warning: ‘parno’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    int             flags;

    *flagp = HASWIDTH;          /* Tentatively. */

    /* Make an OPEN node, if parenthesized. */
    if (paren) {
	if (regnpar >= NSUBEXP)
	    FAIL(L"too many ()");
	parno = regnpar;
	regnpar++;
	ret = regnode((wchar_t)(OPEN + parno));
    } else
	ret = NULL;

    /* Pick up the branches, linking them together. */
    br = regbranch(&flags);
    if (br == NULL)
	return (NULL);
    if (ret != NULL)
	regtail(ret, br);       /* OPEN -> first. */
    else
	ret = br;
    if (!(flags & HASWIDTH))
	*flagp &= ~HASWIDTH;
    *flagp |= flags & SPSTART;
    while (*regparse == '|') {
	regparse++;
	br = regbranch(&flags);
	if (br == NULL)
	    return (NULL);
	regtail(ret, br);       /* BRANCH -> BRANCH. */
	if (!(flags & HASWIDTH))
	    *flagp &= ~HASWIDTH;
	*flagp |= flags & SPSTART;
    }

    /* Make a closing node, and hook it on the end. */
    ender = regnode((wchar_t)((paren) ? CLOSE + parno : END)); // warning: ‘parno’ may be used uninitialized in this function [-Wmaybe-uninitialized]
    regtail(ret, ender);

    /* Hook the tails of the branches to the closing node. */
    for (br = ret; br != NULL; br = regnext(br))
	regoptail(br, ender);

    /* Check for proper termination. */
    if (paren && *regparse++ != ')') {
	FAIL(L"unmatched ()");
    } else if (!paren && *regparse != '\0') {
	if (*regparse == ')') {
	    FAIL(L"unmatched ()");
	} else
	    FAIL(L"junk on end");/* "Can't happen". */
	/* NOTREACHED */
    }
    return (ret);
}

/*
 - regbranch - one alternative of an | operator
 *
 * Implements the concatenation operator.
 */
static wchar_t  *regbranch(int *flagp)
{
    register wchar_t  *ret;
    register wchar_t  *chain;
    register wchar_t  *latest;
    int             flags;

    *flagp = WORST;             /* Tentatively. */

    ret = regnode(BRANCH);
    chain = NULL;
    while (*regparse != '\0' && *regparse != '|' && *regparse != ')') {
	latest = regpiece(&flags);
	if (latest == NULL)
	    return (NULL);
	*flagp |= flags & HASWIDTH;
	if (chain == NULL)      /* First piece. */
	    *flagp |= flags & SPSTART;
	else
	    regtail(chain, latest);
	chain = latest;
    }
    if (chain == NULL)          /* Loop ran zero times. */
	regnode(NOTHING);

    return (ret);
}

/*
 - regpiece - something followed by possible [*+?]
 *
 * Note that the branching code sequences used for ? and the general cases
 * of * and + are somewhat optimized:  they use the same NOTHING node as
 * both the endmarker for their branch list and the body of the last branch.
 * It might seem that this node could be dispensed with entirely, but the
 * endmarker role is not redundant.
 */
static wchar_t *regpiece(int *flagp)
{
    register wchar_t  *ret;
    register wchar_t   op;
    register wchar_t  *next;
    int             flags;

    ret = regatom(&flags);
    if (ret == NULL)
	return (NULL);

    op = *regparse;
    if (!ISMULT(op)) {
	*flagp = flags;
	return (ret);
    }
    
    if (!(flags&HASWIDTH) && op != '?')
	FAIL(L"*+ operand could be empty");
    *flagp = (op != '+') ? (WORST|SPSTART) : (WORST|HASWIDTH);

    if (op == '*' && (flags & SIMPLE))
	reginsert(STAR, ret);
    else if (op == '*') {
	/* Emit x* as (x&|), where & means "self". */
	reginsert(BRANCH, ret); /* Either x */
	regoptail(ret, regnode(BACK));  /* and loop */
	regoptail(ret, ret);    /* back */
	regtail(ret, regnode(BRANCH));  /* or */
	regtail(ret, regnode(NOTHING)); /* null. */
    } else if (op == '+' && (flags&SIMPLE)) {
	reginsert(PLUS, ret);
    } else if (op == '+') {
	/* Emit x+ as x(&|), where & means "self". */
	next = regnode(BRANCH);			/* Either */
	regtail(ret, next);
	regtail(regnode(BACK), ret);		/* loop back */
	regtail(next, regnode(BRANCH));		/* or */
	regtail(ret, regnode(NOTHING));		/* null. */
    } else if (op == '?') {
	/* Emit x? as (x|) */
	reginsert(BRANCH, ret);			/* Either x */
	regtail(ret, regnode(BRANCH));		/* or */
	next = regnode(NOTHING);		/* null. */
        regtail(ret, next);
	regoptail(ret, next);
    }
    regparse++;
    if (ISMULT(*regparse))
	FAIL(L"nested *?+");

    return (ret);
}

/*
 - regatom - the lowest level
 *
 * Optimization:  gobbles an entire sequence of ordinary characters so that
 * it can turn them into a single node, which is smaller to store and
 * faster to run.  Backslashed characters are exceptions, each becoming a
 * separate node; the code is simpler that way and it's not worth fixing.
 */
static wchar_t *regatom(int *flagp)
{
    register wchar_t  *ret;
    int             flags;

    *flagp = WORST;             /* Tentatively. */

    switch (*regparse++) {
    case '^':
	ret = regnode(BOL);
	break;
    case '$':
	ret = regnode(EOL);
	break;
    case '.':
	ret = regnode(ANY);
	*flagp |= HASWIDTH | SIMPLE;
	break;
    case '[':{
	    register int    class;
	    register int    classend;

	    if (*regparse == '^') {     /* Complement of range. */
		ret = regnode(ANYBUT);
		regparse++;
	    } else
		ret = regnode(ANYOF);
	    if (*regparse == ']' || *regparse == '-')
		regc(*regparse++);
	    while (*regparse != '\0' && *regparse != ']') {
		if (*regparse == '-') {
		    regparse++;
		    if (*regparse == ']' || *regparse == '\0')
			regc('-');
		    else {
			class = UCHARAT(regparse - 2) + 1;
			classend = UCHARAT(regparse);
			if (class > classend + 1)
			    FAIL(L"invalid [] range");
			for (; class <= classend; class++)
			    regc((wchar_t)class);
			regparse++;
		    }
		} else
		    regc(*regparse++);
	    }
	    regc('\0');
	    if (*regparse != ']')
		FAIL(L"unmatched []");
	    regparse++;
	    *flagp |= HASWIDTH | SIMPLE;
	}
	break;
    case '(':
	ret = reg(1, &flags);
	if (ret == NULL)
	    return (NULL);
	*flagp |= flags & (HASWIDTH | SPSTART);
	break;
    case '\0':
    case '|':
    case ')':
	FAIL(L"internal urp");   /* Supposed to be caught earlier. */
	break;
    case '?':
    case '+':
    case '*':
	FAIL(L"?+* follows nothing");
	break;
    case '\\':
	if (*regparse == '\0')
	    FAIL(L"trailing \\");
	ret = regnode(EXACTLY);
	regc(*regparse++);
	regc('\0');
	*flagp |= HASWIDTH | SIMPLE;
	break;
    default:{
#ifdef NEWCODE
			char *regprev;
			register char ch;
#else
	    register int    len;
	    register wchar_t   ender;
#endif
	    regparse--;
#ifdef NEWCODE
			ret = regnode(EXACTLY);
			for ( regprev = 0 ; ; ) {
				ch = *regparse++;	/* Get current char */
				switch (*regparse) {	/* look at next one */

				default:
					regc(ch);	/* Add cur to string */
					break;

				case '.': case '[': case '(':
				case ')': case '|': case '\n':
				case '$': case '^':
				case '\0':
				/* FIXME, $ and ^ should not always be magic */
				magic:
					regc(ch);	/* dump cur char */
					goto done;	/* and we are done */

				case '?': case '+': case '*':
					if (!regprev) 	/* If just ch in str, */
						goto magic;	/* use it */
					/* End mult-char string one early */
					regparse = regprev; /* Back up parse */
					goto done;

				case '\\':
					regc(ch);	/* Cur char OK */
					switch (regparse[1]){ /* Look after \ */
					case '\0':
					case '<':
					case '>':
					/* FIXME: Someday handle \1, \2, ... */
						goto done; /* Not quoted */
					default:
						/* Backup point is \, scan							 * point is after it. */
						regprev = regparse;
						regparse++; 
						continue;	/* NOT break; */
					}
				}
				regprev = regparse;	/* Set backup point */
			}
		done:
			regc('\0');
			*flagp |= HASWIDTH;
			if (!regprev)		/* One char? */
				*flagp |= SIMPLE;
#else
	    len = wcscspn((wchar_t *)regparse, META);
	    if (len <= 0)
		FAIL(L"internal disaster");
	    ender = *(regparse + len);
	    if (len > 1 && ISMULT(ender))
		len--;          /* Back off clear of *+ operand. */
	    *flagp |= HASWIDTH;
	    if (len == 1)
		*flagp |= SIMPLE;
	    ret = regnode(EXACTLY);
	    while (len > 0) {
		regc(*regparse++);
		len--;
	    }
	    regc('\0');
	}
#endif
	break;
    }

    return (ret);
}

/*
 - regnode - emit a node
 */
static wchar_t *regnode(wchar_t op)
{
    register wchar_t  *ret;
    register wchar_t  *ptr;

    ret = regcode;
    if (ret == &regdummy) {
	regsize += 3;
	return (ret);
    }
    ptr = ret;
    *ptr++ = op;
    *ptr++ = '\0';              /* Null "nxt" pointer. */
    *ptr++ = '\0';
    regcode = ptr;

    return (ret);
}

/*
 - regc - emit (if appropriate) a byte of code
 */
static void regc(wchar_t b)
{
    if (regcode != &regdummy)
	*regcode++ = b;
    else
	regsize++;
}

/*
 - reginsert - insert an operator in front of already-emitted operand
 *
 * Means relocating the operand.
 */
static void reginsert(wchar_t op, wchar_t *opnd)
{
    register wchar_t  *src;
    register wchar_t  *dst;
    register wchar_t  *place;

    if (regcode == &regdummy) {
	regsize += 3;
	return;
    }
    src = regcode;
    regcode += 3;
    dst = regcode;
    while (src > opnd)
	*--dst = *--src;

    place = opnd;               /* Op node, where operand used to be. */
    *place++ = op;
    *place++ = '\0';
    *place++ = '\0';
}

/*
 - regtail - set the next-pointer at the end of a node chain
 */
static void regtail(p, val)
wchar_t           *p;
wchar_t           *val;
{
    register wchar_t  *scan;
    register wchar_t  *temp;
    register int    offset;

    if (p == &regdummy)
	return;

    /* Find last node. */
    scan = p;
    for (;;) {
	temp = regnext(scan);
	if (temp == NULL)
	    break;
	scan = temp;
    }

    if (OP(scan) == BACK)
	offset = scan - val;
    else
	offset = val - scan;
    *(scan + 1) = (offset >> 8) & 0377;
    *(scan + 2) = offset & 0377;
}

/*
 - regoptail - regtail on operand of first argument; nop if operandless
 */
static void regoptail(p, val)
wchar_t           *p;
wchar_t           *val;
{
    /* "Operandless" and "op != BRANCH" are synonymous in practice. */
    if (p == NULL || p == &regdummy || OP(p) != BRANCH)
	return;
    regtail(OPERAND(p), val);
}

/*
 * regexec and friends
 */

/*
 * Global work variables for regexec().
 */
static CHARINDEX   reginput;       /* String-input pointer. */
static CHARINDEX   regbol;         /* Beginning of input, for ^ check. */
static CHARINDEX *regstartp;      /* Pointer to startp array. */
static CHARINDEX *regendp;        /* Ditto for endp. */


int             regnarrate = 1;     // Used in debug
void            regdump(regexp *r);

/*
 - regexec - match a regexp against a string
 */

int regexec(regexp *prog,  CHARINDEX string) {
    CHARINDEX s;

    /* Be paranoid... */
    if (prog == NULL) {
	regerror(L"NULL parameter");
	return (0);
    }
    /* Check validity of program. */
    if (UCHARAT(prog->program) != MAGIC) {
	regerror(L"corrupted program");
	return (0);
    }
    /* If there is a "must appear" string, look for it. */
    if (prog->regmust != NULL) {
	s = string;
	while ((s = STRINGchr_STR_char(s, prog->regmust[0])) >= 0) {
	    if (STRINGncmp_STR_str(s, (wchar_t *)prog->regmust, prog->regmlen) == 0)
		break;          /* Found it. */
	    s++;
	}
	if (s < 0)          /* Not present. */
	    return (0);
    }
    /* Mark beginning of line for ^ . */
    regbol = string;

    /* Simplest case:  anchored match need be tried only once. */
    if (prog->reganch)
	return (regtry(prog, string));

    /* Messy cases:  unanchored match. */
    s = string;
    if (prog->regstart != '\0')
	/* We know what wchar_t it must start with. */
	while ((s = STRINGchr_STR_char(s, prog->regstart)) >= 0) {
	    if (regtry(prog, s)) return (1);
	    s++;
	}
    else
	/* We don't -- general case. */
	do {
	    if (regtry(prog, s)) return (1);
	} while (demandload_ch(s++) != '\0'); // != '\0'

    /* Failure. */
    return (0);
}

/*
 - regtry - try match at specific point
 */
static int regtry(regexp *prog, CHARINDEX string)
{
    register int    i;
    CHARINDEX      *sp;
    CHARINDEX      *ep;

    reginput = string;
    regstartp = prog->startp;
    regendp = prog->endp;

    sp = prog->startp;
    ep = prog->endp;
    for (i = NSUBEXP; i > 0; i--) {
      *sp++ = -1;  // NULL  ->  -1
      *ep++ = -1;
    }
    if (regmatch(prog->program + 1)) {
	prog->startp[0] = string;
	prog->endp[0] = reginput;
	return (1);
    } else
	return (0);
}

/*
 - regmatch - main matching routine
 *
 * Conceptually the strategy is simple:  check to see whether the current
 * node matches, call self recursively to see whether the rest matches,
 * and then act accordingly.  In practice we make some effort to avoid
 * recursion, in particular by going through "ordinary" nodes (that don't
 * need to know whether the rest of the match failed) by a loop instead of
 * by recursion.
 */
static int regmatch(wchar_t *prog)
{
    register wchar_t  *scan;       /* Current node. */
    wchar_t           *nxt;        /* nxt node. */

    scan = prog;

    if (regexp_debug && scan != NULL && regnarrate)
	fprintf(stderr, "%ls(\n", regprop(scan));

    while (scan != NULL) {

	if (regexp_debug && regnarrate)
	    fprintf(stderr, "%ls...\n", regprop(scan));

	nxt = regnext(scan);

	switch (OP(scan)) {
	case BOL:
	    if (reginput != regbol)
		return (0);
	    break;
	case EOL:
            {
              int ch = demandload_ch(reginput); //if (ch == '\n') ch = '\0';
              if (ch != '\0') // '\0' -> '\n'
		return (0);
            }
	    break;
	case ANY:
            if (demandload_ch(reginput) == '\0') // '\0' -> '\n'
		return (0);
	    reginput++;
	    break;
	case EXACTLY:{
		register int    len;
		register wchar_t  *opnd;

		opnd = OPERAND(scan);
		/* Inline the first character, for speed. */
		if (*opnd != demandload_ch(reginput))
		    return (0);
		len = wcslen((wchar_t *)opnd);
		if (len > 1 && STRINGncmp_str_STR((wchar_t *)opnd, reginput, len) != 0)
		    return (0);
		reginput += len;
	    }
	    break;
	case ANYOF:
            {
              int xch = demandload_ch(reginput); //if (xch == '\n') xch = '\0';
              if (xch == '\0' || wcschr((wchar_t *)OPERAND(scan), xch) == NULL) return (0); // \0 -> \n
            }
	    reginput++;
	    break;
	case ANYBUT:
            if (demandload_ch(reginput) == '\0' || wcschr((wchar_t *)OPERAND(scan), demandload_ch(reginput)) != NULL) // \0 -> \n
		return (0);
	    reginput++;
	    break;
	case NOTHING:
	    break;
	case BACK:
	    break;
	case OPEN + 1:
	case OPEN + 2:
	case OPEN + 3:
	case OPEN + 4:
	case OPEN + 5:
	case OPEN + 6:
	case OPEN + 7:
	case OPEN + 8:
	case OPEN + 9:{
		register int    no;
		CHARINDEX save;

		no = OP(scan) - OPEN;
		save = reginput;

		if (regmatch(nxt)) {
		    /*
		     * Don't set startp if some later invocation of the same
		     * parentheses already has.
		     */
                  if (regstartp[no] < 0) regstartp[no] = save; // NULL -> -1
		  return (1);
		} else return (0);
	    }
	    break;
	case CLOSE + 1:
	case CLOSE + 2:
	case CLOSE + 3:
	case CLOSE + 4:
	case CLOSE + 5:
	case CLOSE + 6:
	case CLOSE + 7:
	case CLOSE + 8:
	case CLOSE + 9:{
		register int    no;
		CHARINDEX save;

		no = OP(scan) - CLOSE;
		save = reginput;

		if (regmatch(nxt)) {
		    /*
		     * Don't set endp if some later invocation of the same
		     * parentheses already has.
		     */
                    if (regendp[no] < 0) regendp[no] = save;  // == NULL  ->  < 0
		    return (1);
		} else return (0);
	    }
	    break;
	case BRANCH:{
		CHARINDEX save;

		if (OP(nxt) != BRANCH)  /* No choice. */
		    nxt = OPERAND(scan);        /* Avoid recursion. */
		else {
		    do {
			save = reginput;
			if (regmatch(OPERAND(scan))) return (1);
			reginput = save;
			scan = regnext(scan);
		    } while (scan != NULL && OP(scan) == BRANCH);
		    return (0);
		    /* NOTREACHED */
		}
	    }
	    break;
	case PLUS:
	case STAR: {
		register wchar_t   nextch;
		register int    no;
		CHARINDEX save;
		register int    min;

		/*
		 * Lookahead to avoid useless match attempts when we know
		 * what character comes next.
		 */
		nextch = '\0';
		if (OP(nxt) == EXACTLY) nextch = *OPERAND(nxt);
		min = (OP(scan) == STAR) ? 0 : 1;
		save = reginput;
		no = regrepeat(OPERAND(scan));
		while (no >= min) {
		    /* If it could work, try it. */
                    int reginput_ch = demandload_ch(reginput); //if (reginput_ch == '\n') reginput_ch = '\0';
		    if (nextch == '\0' || reginput_ch == nextch) if (regmatch(nxt)) return (1);
		    /* Couldn't or didn't -- back up. */
		    no--;
		    reginput = save + no;
		}
		return (0);
	    }
	    break;
	case END:
	    return (1);         /* Success! */
	    break;
	default:
	    regerror(L"memory corruption");
	    return (0);
	    break;
	}

	scan = nxt;
    }

    /*
     * We get here only if there's trouble -- normally "case END" is the
     * terminating point.
     */
    regerror(L"corrupted pointers");
    return (0);
}

/*
 - regrepeat - repeatedly match something simple, report how many
 */
static int regrepeat(wchar_t *p)
{
    register int    count = 0;
    CHARINDEX scan;
    register wchar_t  *opnd;
    int OPp;
    scan = reginput;
    opnd = OPERAND(p);
    OPp = OP(p);
    switch (OPp) {
    case ANY:
	count = STRINGlen(scan);
	scan += count;
	break;
    case EXACTLY:
	while (*opnd == demandload_ch(scan)) {
	    count++;
	    scan++;
	}
	break;
    case ANYOF:
        {
          int xch = demandload_ch(scan); //if (xch == '\n') xch = '\0';
          wchar_t *stch = STRINGchr_str_CHAR((wchar_t *)opnd, xch);
          while ((xch != '\0') && stch != NULL) { //  \0  ->  \n
	      count++;
	      scan++;
              xch = demandload_ch(scan); //if (xch == '\n') xch = '\0';
              stch = STRINGchr_str_CHAR((wchar_t *)opnd, xch);
	  }
        }
	break;
    case ANYBUT:
        while ((demandload_ch(scan) != '\0') && STRINGchr_str_CHAR((wchar_t *)opnd, demandload_ch(scan)) == NULL) { //  \0  ->  \n
	    count++;
	    scan++;
	}
	break;
    default:                    /* Oh dear.  Called inappropriately. */
	regerror(L"internal foulup");
	count = 0;              /* Best compromise. */
	break;
    }
    reginput = scan;

    return (count);
}


/*
 - regnext - dig the "nxt" pointer out of a node
 */
static wchar_t *regnext(register wchar_t *p)
{
    register int    offset;

    if (p == &regdummy)
	return (NULL);

    offset = NEXT(p);
    if (offset == 0)
	return (NULL);

    if (OP(p) == BACK)
	return (p - offset);
    else
	return (p + offset);
}


/*
 - regdump - dump a regexp onto stdout in vaguely comprehensible form
 */
void regdump(regexp *r)
{
    register wchar_t  *s;
    register wchar_t   op = EXACTLY;       /* Arbitrary non-END op. */
    register wchar_t  *nxt;

    fprintf(stderr, "IN regdump\n");
    s = r->program + 1;
    while (op != END) {         /* While that wasn't END last time... */
        fprintf(stderr, "IN regdump loop\n");
	op = OP(s);
	fprintf(stderr, "%2ld%ls", (long)(s - r->program), regprop(s));    /* Where, what. */
	nxt = regnext(s);
	if (nxt == NULL)        /* nxt ptr. */
          fprintf(stderr, "(0)");
	else
          fprintf(stderr, "(%ld)", (long)(s - r->program) + (nxt - s));
	s += 3;
	if (op == ANYOF || op == ANYBUT || op == EXACTLY) {
	    /* Literal string, where present. */
	    while (*s != '\0') {
                fputwc(*s, stderr);
		s++;
	    }
	    s++;
	}
	fputwc('\n', stderr);
    }

    /* Header fields of interest. */
    if (r->regstart != '\0')
        fprintf(stderr, "start `%lc' ", (wint_t)r->regstart);
    if (r->reganch)
        fprintf(stderr, "anchored ");
    if (r->regmust != NULL)
        fprintf(stderr, "must have \"%ls\"", r->regmust);
    fprintf(stderr, "\n");
}

/*
 - regprop - printable representation of opcode
 */
static wchar_t *regprop(wchar_t *op)
{
    register wchar_t  *p = NULL;
    static wchar_t     buf[512] = {[511]=0xB4};

    wcscpy((wchar_t *)buf, L":");

    if (buf[511] != 0xB4) {
      fprintf(stderr, "regprop: buffer was overwritten!\n"); exit(1);
    }
    
    switch (OP(op)) {
    case BOL:
	p = (wchar_t *)L"BOL";
	break;
    case EOL:
	p = (wchar_t *)L"EOL";
	break;
    case ANY:
	p = (wchar_t *)L"ANY";
	break;
    case ANYOF:
	p = (wchar_t *)L"ANYOF";
	break;
    case ANYBUT:
	p = (wchar_t *)L"ANYBUT";
	break;
    case BRANCH:
	p = (wchar_t *)L"BRANCH";
	break;
    case EXACTLY:
	p = (wchar_t *)L"EXACTLY";
	break;
    case NOTHING:
	p = (wchar_t *)L"NOTHING";
	break;
    case BACK:
	p = (wchar_t *)L"BACK";
	break;
    case END:
	p = (wchar_t *)L"END";
	break;
    case OPEN + 1:
    case OPEN + 2:
    case OPEN + 3:
    case OPEN + 4:
    case OPEN + 5:
    case OPEN + 6:
    case OPEN + 7:
    case OPEN + 8:
    case OPEN + 9:
        wprintf((wchar_t *)buf + wcslen((wchar_t *)buf), L"OPEN%d", OP(op) - OPEN);
	p = NULL;
	break;
    case CLOSE + 1:
    case CLOSE + 2:
    case CLOSE + 3:
    case CLOSE + 4:
    case CLOSE + 5:
    case CLOSE + 6:
    case CLOSE + 7:
    case CLOSE + 8:
    case CLOSE + 9:
        wprintf((wchar_t *)buf + wcslen((wchar_t *)buf), L"CLOSE%d", OP(op) - CLOSE);
	p = NULL;
	break;
    case STAR:
	p = (wchar_t *)L"STAR";
	break;
    case PLUS:
	p = (wchar_t *)L"PLUS";
	break;
    default:
	regerror(L"corrupted opcode");
	break;
    }
    if (p != NULL)
      wcscat(/*(wchar_t *)*/buf, /*(wchar_t *)*/p);
    return (buf);
}

/*
 - regsub - perform substitutions after a regexp match
 */
int regsub(regexp *prog, wchar_t *usource, wchar_t *udest)
{
    wchar_t *rsource = (wchar_t *)usource;
    wchar_t *dest = (wchar_t *)udest;
    register wchar_t  *src;
    register wchar_t  *dst;
    register wchar_t   c;
    register int    no;
    register int    len;

    if (prog == NULL || rsource == NULL || dest == NULL) {
      regerror(L"NULL parm to regsub");
	return (0);
    }
    if (UCHARAT(prog->program) != MAGIC) {
	regerror(L"damaged regexp fed to regsub");
	return (0);
    }
    src = rsource;
    dst = dest;
    while ((c = *src++) != '\0') {
	if (c == '&')
	    no = 0;
	else if (c == '\\' && '0' <= *src && *src <= '9')
	    no = *src++ - '0';
	else
	    no = -1;

	if (no < 0) {           /* Ordinary character. */
	    if (c == '\\' && (*src == '\\' || *src == '&'))
		c = *src++;
	    *dst++ = c;
	} else if (prog->startp[no] >= 0 && prog->endp[no] >= 0) {  // != NULL   ->  >= 0
	    len = prog->endp[no] - prog->startp[no];
	    STRINGncpy_str_STR((wchar_t *)dst, prog->startp[no], len);
	    dst += len;
	    if (len != 0 && *(dst - 1) == '\0') {       /* strncpy hit NUL. */
		regerror(L"damaged match string");
		return (0);
	    }
	}
    }
    *dst++ = '\0';

  return (1);
}

#ifdef TEST
void regerror(wchar_t *s)
{
  fprintf(stderr, "regexp: %ls\n", s);
}

int regex_main(int argc, char **argv) {
wchar_t result[128];
wchar_t wargv[128];
regexp *r;
int i;
  if (argc <= 2 || argc > 5) {
    fprintf(stderr, "syntax: regexp pattern string [replacement]\n");
    exit(2);
  }
  if (strcmp(argv[1], "-d") == 0) {
    argc -= 1; argv += 1;
    regexp_debug = 1;
  }
  if (regexp_debug) fprintf(stderr, "Converting '%s' to wcs format.\n", argv[1]);
  mbstowcs(wargv, argv[1], 127);
  if (regexp_debug) fprintf(stderr, "regcomp(%ls)\n", wargv);
  r = regcomp(wargv);
  if (regexp_debug) {
    fprintf(stderr, "regdump(r)\n");
    regdump(r);
  }
  if (r == NULL) fprintf(stderr, "r null\n");
  if (regexp_debug) fprintf(stderr, "i = regexec(r, 0)\n");
  i = regexec(r, (CHARINDEX)0);
  if (i == 1) fprintf(stderr, "Found %s in %s\n", argv[1], argv[2]);
  if (argc <= 3) return(1);
  if (regexp_debug) fprintf(stderr, "Converting '%s' to wcs format.\n", argv[3]);
  mbstowcs(wargv, argv[3], 127);
  *result = '\0';
  if (regexp_debug) fprintf(stderr, "regdump(r, wargv, result)\n");
  regsub(r, wargv, result);
  if (regexp_debug) fprintf(stderr, "argv[3] = %s; result = %ls\n", argv[3], result);
  return(0);
}
#endif
