#ifndef __PARSER_H__
#define __PARSER_H__ 1

#include "flex.h"

#include <wchar.h>

extern SPEC(CST,int);
#define _CST(x) WRITE(x,CST,int)
#define  CST(x) READ(x,CST,int)

extern SPEC(source,wint_t);
#define _source(x) WRITE(x,source,wint_t)
#define  source(x) READ(x,source,wint_t)

extern wchar_t *PHRASE(int PhraseStart);
extern wchar_t *TERM_NAME(int P);

extern int phrasenum(int PhraseStart);
extern int BIPnum(int BIPStart);
  
#endif //  __PARSER_H__
