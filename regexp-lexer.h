#ifndef _REGEXP_H
#define _REGEXP_H

/*
 * Definitions etc. for regexp(3) routines.
 *
 * Caveat:  this is V8 regexp(3) [actually, a reimplementation thereof],
 * not the System V one.
 */

// Convert from data being char* to data being in a struct...

typedef wint_t CHAR;
CHAR XSTRING[10240]; // global!!!

typedef int CHARINDEX;

#define NSUBEXP  10
typedef struct regexp {
        CHARINDEX startp[NSUBEXP];
        CHARINDEX endp[NSUBEXP];
        wchar_t regstart;          /* Internal use only. */
        wchar_t reganch;           /* Internal use only. */
        wchar_t *regmust;          /* Internal use only. */
        int regmlen;            /* Internal use only. */
        wchar_t program[1];        /* Unwarranted chumminess with compiler. */
} regexp;


/*
 * The first byte of the regexp internal "program" is actually this magic
 * number; the start node begins in the second byte.
 */
#define MAGIC   (unsigned char)0234

/* Headers for regexp.c */
extern regexp *regcomp(const wchar_t *exp);
extern int regexec(regexp *prog, CHARINDEX string);
extern int regsub(regexp *prog, wchar_t *source, wchar_t *dest);
extern void regerror(wchar_t *s);
/* End of headers for regexp.c */

#ifdef DEBUG
extern void regdump(regexp *r);
#endif

#endif /* _REGEXP_H */
