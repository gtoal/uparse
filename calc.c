#include "parser.h"

int debug_ast = 0; // levels: 0 1 2 3

DECLARE(AST,int,8000000); // abstract syntax tree
#define _AST(x) WRITE(x,AST,int)
#define  AST(x) READ(x,AST,int)
int AST_nextfree = 0;

// TUPLE_RESULT_FIELDS represents the count of all the extra fields that can
// be added to every tuple (and which are filled in later) with things like
// the inferred type of an expression (bottom-up), or line numbers or whatever
// may turn out to be needed that wasn't thought of when the code was first
// designed.
// There are no extra fields in the CST, only in the AST.

#define TUPLE_RESULT_FIELDS 3
#define RESULT_FIELD_TYPEINFO 0
#define RESULT_FIELD_WHATEVER1 1
#define RESULT_FIELD_WHATEVER2 2

#define AST_idx_mask 0xfFFFFFF
#define AST_type_shift 28
#define AST_type_mask  15

#define AST_BIP     (1 << AST_type_shift)
#define AST_PHRASE  (2 << AST_type_shift)
#define AST_LITERAL (3 << AST_type_shift)


#define SubPhraseIdx(P,N)  AST(((P)&AST_idx_mask)+4+TUPLE_RESULT_FIELDS+N-1)
//#define SubPhrase(P,N)    (AST(((P)&AST_idx_mask)+4+TUPLE_RESULT_FIELDS+N-1)&AST_idx_mask)
#define SubPhrase(P,N)    (SubPhraseIdx(P,N)&AST_idx_mask)

void PrintLower(int Literal) {
  int i;
  int inclusive_start = atom(Literal).start;
  int exclusive_end = atom(Literal).end;
  for (i = inclusive_start; i < exclusive_end; i++) {
    wint_t c = source(i);
    if (isalpha(c) && isupper(c)) c = tolower(c);
    fprintf(stdout, "%lc", c);
  }
}

void PrintUpper(int Literal) {
  int i;
  int inclusive_start = atom(Literal).start;
  int exclusive_end = atom(Literal).end;
  for (i = inclusive_start; i < exclusive_end; i++) {
    wint_t c = source(i);
    if (isalpha(c) && islower(c)) c = toupper(c);
    fprintf(stdout, "%lc", c);
  }
}

#ifdef EXTRA_DEBUG
void XPrintAtom(int Literal, char *filename, int line) {
  int i;
  fprintf(stderr, "\"%s\", Line %d: Literal = %x\n", filename, line, Literal);
  for (i = atom(Literal).start; i < atom(Literal).end; i++) fprintf(stdout, "%lc", source(i));
}
#define PrintAtom(x) XPrintAtom(x, __FILE__, __LINE__)
#else
void PrintAtom(int Literal) {
  int i;
  for (i = atom(Literal).start; i < atom(Literal).end; i++) fprintf(stdout, "%lc", source(i));
}
#endif
#define S(x) ((wchar_t *)&Stringpool(x))
int wlit(int Literal) { // an int index into stringpool, not a wchar_t *, because the stringpool
                        // may be relocated underfoot.  To get a wchar_t from a stringpool index,
                        // use macro S(), but only in contexts where the stringpool cannot be relocated
                        // during the lifetime of the pointer.
  int i, Sp = Stringpool_nextfree;
  for (i = atom(Literal).start; i < atom(Literal).end; i++) _Stringpool(Stringpool_nextfree++) = source(i);
  _Stringpool(Stringpool_nextfree++) = 0;
  fprintf(stderr, "%ls", S(Sp));
  return Sp;
}

#ifdef SUPPLY_DEFAULT_WALK_AST
void walk_ast(int P, int depth) {
  if (P <= 0) return;
  int i;
  // int AST_type = P&(AST_type_mask<<AST_type_shift);
  int AST_type = (int)((unsigned int)P&(((unsigned int)AST_type_mask)<<(unsigned int)AST_type_shift)); // runtime error: left shift of 15 by 28 places
  int AST_index = P&AST_idx_mask;
  int count = AST(AST_index+3);

  if (AST_type == AST_PHRASE) {
    int i;
    int op = AST(AST_index+1);

    // Let's test modifications to the tree walk by intercepting some phrases.
    // If you want to intercept a subset of some phrase (eg <NAME> but only in
    // the context of a procedure name, for example) then just add a dummy level
    // of indirection such as P<PROCNAME> = <NAME>;

    // This test will capitalize all <NAME>s.
    switch (op) {

    default: // Everything else can use the default output code:
      for (i = 1; i <= count; i++) walk_ast(SubPhraseIdx(P,i), depth+1);
    }

  } else if ((AST_type == AST_LITERAL) || (AST_type == AST_BIP)) {
    PrintAtom(AST_index);
  }
}
#endif

// #define LARGEST_ALT 128 // max phrases in any Alt. - now supplied from tables.
int mktuple(int op, int alt, int count, int T[]) {
#define T(x) BOUNDS_CHECK(T,x,LARGEST_ALT)


  // T[] comes from a small array in build_ast that is only large enough
  // to hold the number of elements in the largest alt of a phrase.
  // We want to keep the amount of stack space claimed by
  // an instantiation of 'parse()' to a minimum, as we want to allow
  // whole-program parsing, not just line-at-a-time style.  So in
  // theory there may be as many calls to parse() as there are characters
  // in the file you are parsing, and that number would be multiplied
  // by the size of local stack data per call. (In practice, far fewer, but
  // since a typical large program may be 500,000 characters, that's still
  // a potentially huge stack frame if local data per call is not minimised)

  T[0] = -1; // unused for now
  
  int i, tuple = AST_nextfree;  // 'op' is the G_whatever used in the grammar
  _AST(AST_nextfree++) = 0;     // reserved field
  _AST(AST_nextfree++) = op;    // AST_op_offset
  _AST(AST_nextfree++) = alt;   // AST_alt_offset
  _AST(AST_nextfree++) = count; // AST_count_offset

  for (i = 0; i < TUPLE_RESULT_FIELDS; i++) {
    _AST(AST_nextfree++) = 0;   // source line where tuple was created etc
  }

  // Add tuple phrases to CST.  Include T[0]
  if (debug_ast) fprintf(stderr, "AST[%x] = mktuple(%ls, %d, %d, [ ", tuple&AST_idx_mask, PHRASE(op), alt, count);
  for (i = 1; i <= count; i++) {
    if (debug_ast) fprintf(stderr, "%x ", T(i));
    _AST(AST_nextfree++) = T(i);
  }
  if (debug_ast) fprintf(stderr, "]) {Type %d}\n", AST_PHRASE>>AST_type_shift);
  return AST_PHRASE | tuple;
#undef T
}

int reg(int C,char *s) {
  if (debug_ast >= 2) fprintf(stderr, "reg(%d /* %s */)\n", C, s);
  return AST_LITERAL | C;
}

int kw(int C, char *s) {
  if (debug_ast >= 2) fprintf(stderr, "kw(%d /* %s */)\n", C, s);
  return AST_LITERAL | C;
}

int ch(int C, char c) {
  if (debug_ast >= 2) fprintf(stderr, "ch(%d /* '%c'*/)\n", C, c);
  return AST_LITERAL | C;
}

int BIP(int C, int P) {
  if (debug_ast >= 2) fprintf(stderr, "BIP(%d)\n", C);
  return AST_BIP | C;
}


// Convert CST to AST.

int build_ast(int P) { // Parameter is index into CST (with type info); returns an index into an AST.
  int T[LARGEST_ALT];  // DAMN!!! This *has* to be local stack data,
                  // otherwise two successive calls will corrupt
                  // the first call's results.  This is not ideal, 

  //fprintf(stderr, "build_ast(%d -> %d,%d)\n", P, CST(P)&INDEX_MASK, P_);
  //if ((CST(P)&INDEX_MASK) != P_) {
  //  fprintf(stderr, " MISMATCH!\n"); exit(EXIT_FAILURE);
  //}

  int phrases = 0;
  int phrase  = CST(P++);
  int alt     = CST(P++);
  int P_      = phrase&INDEX_MASK;
  int type    = PhraseType(phrase);

  if ((P&(~INDEX_MASK)) != 0) {
    fprintf(stderr, "build_ast(0x%x) was passed a parameter that was not a simple index into CST[]\n", P&(~INDEX_MASK));
    exit(EXIT_FAILURE);
  }
  if (type != PhraseType(PHRASE_TYPE)) {
    fprintf(stderr, "build_ast(TYPE=0x%x) was passed a parameter that does not point to a PHRASE_TYPE\n", type);
    exit(EXIT_FAILURE);
  }
  if (debug_ast >= 2) fprintf(stderr, "build_ast(%d /* %ls */)\n", P-2, phrasename[phrasenum(P_)]);
  
  switch (P_) {
#include CST2AST // e.g. "algol60-ast.h"
  }
  return -1;
}
