// This is algol60-indent.c

// This file and algol60.g are the only two files that needed to be
// created manually to create the algol60 formatter - everything else
// is supplied or built automatically.  And this file was initially
// generated by gencomp, but subsequently manually edited to implement
// the indentation and symbol canonicalization:

// This module re-outputs the AST parse tree as text, but reindents the
// ALGOL 60 code. It *does not* break lines anywhere or join lines - it
// just adjusts the indentation of the existing line structure.  A 'wc'
// of the file before and after should show matching line counts.

// It also canonicalises much of the representation of the source to the
// preferred Unicode characters, except in the few cases where the appropriate
// Unicode character is not well supported at the time of writing this code.

// There are some small infelicities in the indentation algorithm that
// I decided to live with - fixing them looks like too much complexity,
// whereas we already get pretty good results with this simple algorithm.

#define INDENT "   "
#define CONTINUATION "  "
int ilev = 0; /* nested begin/end for now.  Later use a stack */
int delayed_ilev = 0;
int continuation_spaces = 0;
int suppress_spaces = TRUE;

typedef struct text_descriptor {
  int start;
  int end;
} text_descriptor;

// NOTE! With the simple addition of a flag and a test, re-indentation
// could be made into a run-time option.

void Outch(wint_t wch) {
  static wint_t lastwch = -1;
  if (suppress_spaces) {
    if (wch == ' ' || wch == '\t') return; // remove existing indentation
    if (wch != '\n') {      // then replace with calculated indentation
      // indent here by ilev then go back to 'normal' mode
      int i;
      for (i = 0; i < ilev; i++) printf(INDENT);
      if (continuation_spaces == 2) printf(CONTINUATION);
      fprintf(stdout, "%lc", wch);
      continuation_spaces = 2;
      suppress_spaces = FALSE;
    } else {
      fprintf(stdout, "\n");
      ilev += delayed_ilev; delayed_ilev = 0;
      // Continue to suppress leading spaces
    }
  } else {
    if (wch == '\n') {
      fprintf(stdout, "\n");
      ilev += delayed_ilev; delayed_ilev = 0;
      suppress_spaces = TRUE;
    } else {
      fprintf(stdout, "%lc", wch);
      continuation_spaces = 2;
    }
  }
}

void O(int Leading_spaces, wchar_t *Literal) {
  int i;
  // leading spaces
  for (i = atom(Leading_spaces).start; i < atom(Leading_spaces).end; i++) {
    if (source(i) != ' ') break;
    Outch(source(i));
  }
  // replacement text
  while (*Literal != '\0') Outch(*Literal++);
  i = atom(Leading_spaces).end;
  // trailing spaces.  Uncommon but can happen from a regex
  for (;;) {
    if (i <= atom(Leading_spaces).start) break;
    --i;
    if (source(i) != ' ') break;
    Outch(source(i));
  }
}

#define PrintIndent(x) PrintIndent_inner(x, __LINE__)
void PrintIndent_inner(int Literal, int line) {
  int i;
  // fprintf(stderr, "PrintIndent(%d) at line %d\n", Literal, line);
  for (i = atom(Literal).start; i < atom(Literal).end; i++)
    Outch(source(i));
}

text_descriptor reindent(int P, int depth) {
  text_descriptor r = {0,0};
  if (P <= 0) return r;
  int i;
  int AST_type = (int)((unsigned int)P&(((unsigned int)AST_type_mask)<<(unsigned int)AST_type_shift)); // runtime error: left shift of 15 by 28 places cannot be represented in type 'int'
  int AST_index = P&AST_idx_mask;
  int alt   = AST(AST_index+2);
  int count = AST(AST_index+3);

  //fprintf(stderr, "P=%d AST_type = %d  AST_index = %d  alt=%d  count=%d\n", P, AST_type>>AST_type_shift, AST_index, alt, count);

  if (AST_type == AST_PHRASE) {
    int i;
    int op = AST(AST_index+1);
    //fprintf(stderr, "op=%d %ls\n", op, PHRASE(op));

    // Let's test modifications to the tree walk by intercepting some phrases.
    // If you want to intercept a subset of some phrase (eg <NAME> but only in
    // the context of a procedure name, for example) then just add a dummy level
    // of indirection such as P<PROCNAME> = <NAME>;

    // This test will capitalize all <NAME>s.
    switch (op) {
      // What in yacc etc would be $1 is referred to here as SubPhrase(P,1)

//\\ P<ldquo> = "“", '{', "‘", "'('", "«", "|<";
   case G_ldquo:
     O(SubPhrase(P, 1), L"“");
     return r;

//\\ P<rdquo> = "”", '}', "’", "')'", "»", "|>";
   case G_rdquo:
     O(SubPhrase(P, 1), L"”");
     return r;

//\\ P<BALANCED_STRING> =
   case G_BALANCED_STRING:
     {                              //\\    <ldquo> <BALANCED_CHAR_SEQUENCE> <rdquo>;
     reindent(SubPhraseIdx(P, 1), depth+1 /* G_ldquo */);
     reindent(SubPhraseIdx(P, 2), depth+1 /* G_BALANCED_CHAR_SEQUENCE */);
     reindent(SubPhraseIdx(P, 3), depth+1 /* G_rdquo */);
     }
     return r;

//\\ P<RB> =
   case G_RB:
     {                              //\\    '>';
     O(SubPhrase(P, 3), L"”");
     }
     return r;

//\\ P<C_STRING> =
   case G_C_STRING:
     if (alt == 0)               {  //\\    '"' <C_CHARS> '"',
       O(SubPhrase(P, 1), L"“");
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_C_CHARS */);
       O(SubPhrase(P, 3), L"”");
     } else if (alt == 1)        {  //\\    "``" «[^']*» "''",
       // Needs a little more effort to massage
       O(SubPhrase(P, 1), L"“");
       PrintIndent(SubPhrase(P, 2));
       O(SubPhrase(P, 3), L"”");
     } else                      {  //\\    "`" «[^']*» "'";
       // Needs a little more effort to massage
       O(SubPhrase(P, 1), L"“");
       PrintIndent(SubPhrase(P, 2));
       O(SubPhrase(P, 3), L"”");
     }
     return r;
     
//\\ P<semi> =
    case G_semi:
     {                              //\\    ";";
     PrintIndent(SubPhrase(P, 1));
     continuation_spaces = 0;
     }
     return r;

//\\ P<else> =
   case G_else:
     {                              //\\    "e̲l̲s̲e̲";
     continuation_spaces = 0;
     PrintIndent(SubPhrase(P, 1));
     continuation_spaces = 2;
     }
     return r;

//\\ P<semi_opt> =
   case G_semi_opt:
     if (alt == 0)               {  //\\    ';',
       PrintIndent(SubPhrase(P, 1) /*, L';' */);
       continuation_spaces = 0;
     } else                      {  //\\    ;

     }
     return r;

//\\ P<MAIN_PROGRAM> =
   case G_MAIN_PROGRAM:
     {                              //\\    <PROGRAM_opt> <COMMENTS_opt> "b̲e̲g̲i̲n̲" <LOCAL_BLOCK> "e̲n̲d̲" <ENDTEXT>;
     reindent(SubPhraseIdx(P, 1), depth+1 /* G_PROGRAM_opt */);
     continuation_spaces = 0;
     reindent(SubPhraseIdx(P, 2), depth+1 /* G_COMMENTS_opt */);
     continuation_spaces = 0;
     PrintIndent(SubPhrase(P, 3));
     ilev += 1; continuation_spaces = 0;
     reindent(SubPhraseIdx(P, 4), depth+1 /* G_LOCAL_BLOCK */);
     ilev -= 1; continuation_spaces = 0;
     PrintIndent(SubPhrase(P, 5));
     reindent(SubPhraseIdx(P, 6), depth+1 /* G_ENDTEXT */);
     continuation_spaces = 0;
     }
     return r;

//\\ P<PROGRAM_opt> =
   case G_PROGRAM_opt:
     if (alt == 0)               {  //\\    "p̲r̲o̲g̲r̲a̲m̲" <NAME> ';',
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_NAME */);
       PrintIndent(SubPhrase(P, 3) /*, L';' */);
     } else                      {  //\\    ;

     }
     continuation_spaces = 0;
     return r;

//\\ P<EXTERNAL_LEVEL_OBJECTS> =
   case G_EXTERNAL_LEVEL_OBJECTS:
     if (alt == 0)               {  //\\    <EXTERNAL_LEVEL> <EXTERNAL_LEVEL_OBJECTS>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_EXTERNAL_LEVEL */);
       continuation_spaces = 0;
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_EXTERNAL_LEVEL_OBJECTS */);
     } else                      {  //\\    ;

     }
     return r;

//\\ P<EXTERNAL_LEVEL> =
   case G_EXTERNAL_LEVEL:
     if (alt == 0)               {  //\\    "e̲o̲p̲",
       PrintIndent(SubPhrase(P, 1));
     } else if (alt == 1)        {  //\\    "c̲o̲d̲e̲" <DIGITS> ';',
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_DIGITS */);
       PrintIndent(SubPhrase(P, 3) /*, L';' */);
     } else if (alt == 2)        {  //\\    <COMMENT>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_COMMENT */);
     } else if (alt == 3)        {  //\\    <PROCEDURE> ';',
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_PROCEDURE */);
       PrintIndent(SubPhrase(P, 2) /*, L';' */);
     } else                      {  //\\    <OWN_DECLARATION> ';';
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_OWN_DECLARATION */);
       PrintIndent(SubPhrase(P, 2) /*, L';' */);
     }
     continuation_spaces = 0;
     return r;

//\\ P<BOOLEAN> =
   case G_BOOLEAN:
     if (alt == 0)               {  //\\    "B̲o̲o̲l̲e̲a̲n̲",
       PrintIndent(SubPhrase(P, 1));
     } else                      {  //\\    "b̲o̲o̲l̲e̲a̲n̲";
       PrintIndent(SubPhrase(P, 1));
     }
     return r;

//\\ P<PROCEDURE> =
   case G_PROCEDURE:
     {                              //\\    <PROCTYPE_opt> "p̲r̲o̲c̲e̲d̲u̲r̲e̲" <NAME> <FORMAL_PARAMS_opt> ';' <COMMENTS_opt> <VALUE_opt> <PARAMETER_TYPES_opt> <LABELS_opt> <PROCBODY>;
     reindent(SubPhraseIdx(P, 1), depth+1 /* G_PROCTYPE_opt */);
     PrintIndent(SubPhrase(P, 2));
     reindent(SubPhraseIdx(P, 3), depth+1 /* G_NAME */);
     reindent(SubPhraseIdx(P, 4), depth+1 /* G_FORMAL_PARAMS_opt */);
     PrintIndent(SubPhrase(P, 5) /*, L';' */);
     ilev += 1;
     continuation_spaces = 0;
     reindent(SubPhraseIdx(P, 6), depth+1 /* G_COMMENTS_opt */);
     continuation_spaces = 0;
     reindent(SubPhraseIdx(P, 7), depth+1 /* G_VALUE_opt */);
     continuation_spaces = 0;
     reindent(SubPhraseIdx(P, 8), depth+1 /* G_PARAMETER_TYPES_opt */);
     continuation_spaces = 0;
     reindent(SubPhraseIdx(P, 9), depth+1 /* G_LABELS_opt */);
     continuation_spaces = 0;
     reindent(SubPhraseIdx(P, 10), depth+1 /* G_PROCBODY */);
     ilev -= 1;
     continuation_spaces = 0;
     }
     return r;

//\\ P<VALUE_opt> =
   case G_VALUE_opt:
     if (alt == 0)               {  //\\    "v̲a̲l̲u̲e̲" <ONAMELIST> ';',
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_ONAMELIST */);
       PrintIndent(SubPhrase(P, 3) /*, L';' */);
     } else                      {  //\\    ;

     }
     continuation_spaces = 0;
     return r;

//\\ P<COMMENT> =
   case G_COMMENT:
     {                              //\\    <COMMENT_NO_SEMI> ';';
     reindent(SubPhraseIdx(P, 1), depth+1 /* G_COMMENT_NO_SEMI */);
     PrintIndent(SubPhrase(P, 2) /*, L';' */);
     continuation_spaces = 0;
     }
     return r;

//\\ P<MORE_COMMENTS> =
   case G_MORE_COMMENTS:
     if (alt == 0)               {  //\\    ';' <COMMENT> <MORE_COMMENTS>,
       PrintIndent(SubPhrase(P, 1) /*, L';' */);
       continuation_spaces = 0;
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_COMMENT */);
       reindent(SubPhraseIdx(P, 3), depth+1 /* G_MORE_COMMENTS */);
     } else                      {  //\\    ;

     }
     return r;

//\\ P<LABELS_opt> =
   case G_LABELS_opt:
     if (alt == 0)               {  //\\    <NAME> <!assign> ":" <!comment_keyword> <LABELS_opt>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_NAME */);
       PrintIndent(SubPhrase(P, 3));
       continuation_spaces = 0;
       reindent(SubPhraseIdx(P, 5), depth+1 /* G_LABELS_opt */);
     } else                      {  //\\    ;

     }
     return r;

//\\ P<LEXPR> =
   case G_LEXPR:
     if (alt == 0)               {  //\\    '(' <LEXPR> ')',
       PrintIndent(SubPhrase(P, 1) /*, L'(' */);
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LEXPR */);
       PrintIndent(SubPhrase(P, 3) /*, L')' */);
     } else if (alt == 1)        {  //\\    "i̲f̲" <BEXPR> "t̲h̲e̲n̲" <SLEXPR> "e̲l̲s̲e̲" <LEXPR>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_BEXPR */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_SLEXPR */);
       continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 5));
       continuation_spaces = 2;
       reindent(SubPhraseIdx(P, 6), depth+1 /* G_LEXPR */);
     } else                      {  //\\    <SLEXPR>;
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_SLEXPR */);
     }
     return r;

//\\ P<COLON_WARN_COMMA> = ':', ',', "..";
   case G_COLON_WARN_COMMA:
     O(SubPhrase(P, 1), L":");
     return r;

//\\ P<PROCBODY> =
   case G_PROCBODY:
     if (alt == 0)               {  //\\    "c̲o̲d̲e̲" <DIGITS>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_DIGITS */);
     } else if (alt == 1)        {  //\\    "a̲l̲g̲o̲l̲",
       PrintIndent(SubPhrase(P, 1));
     } else if (alt == 2)        {  //\\    "f̲o̲r̲t̲r̲a̲n̲",
       PrintIndent(SubPhrase(P, 1));
     } else if (alt == 3)        {  //\\    "e̲x̲t̲e̲r̲n̲a̲l̲",
       PrintIndent(SubPhrase(P, 1));
     } else if (alt == 4)        {  //\\    "b̲e̲g̲i̲n̲" <LOCAL_BLOCK> "e̲n̲d̲" <ENDTEXT>,
       ilev -= 1;
       continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 1));
       ilev += 1; continuation_spaces = 0;
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LOCAL_BLOCK */);
       ilev -= 1; continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_ENDTEXT */);
       ilev += 1;
     } else if (alt == 5)        {  //\\    <ASSIGNMENT>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_ASSIGNMENT */);
     } else if (alt == 6)        {  //\\    <PROCEDURE_CALL>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_PROCEDURE_CALL */);
     } else if (alt == 7)        {  //\\    "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL_STATEMENT>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LHS */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_FLE */);
       reindent(SubPhraseIdx(P, 5), depth+1 /* G_FORLIST */);
       PrintIndent(SubPhrase(P, 6));
       ilev += 1;
       reindent(SubPhraseIdx(P, 7), depth+1 /* G_LABELS_opt */);
       reindent(SubPhraseIdx(P, 8), depth+1 /* G_LOCAL_STATEMENT */);
       ilev -= 1;
     } else if (alt == 8)        {  //\\    "i̲f̲" <BEXPR> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL_STATEMENT> <OPT_ELSE>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_BEXPR */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_LABELS_opt */);
       reindent(SubPhraseIdx(P, 5), depth+1 /* G_LOCAL_STATEMENT */);
       reindent(SubPhraseIdx(P, 6), depth+1 /* G_OPT_ELSE */);
     } else if (alt == 9)        {  //\\    "g̲o̲" "t̲o̲" <JUMP_TARGET>,
       PrintIndent(SubPhrase(P, 1));
       PrintIndent(SubPhrase(P, 2));
       reindent(SubPhraseIdx(P, 3), depth+1 /* G_JUMP_TARGET */);
     } else                      {  //\\    ;

     }
     return r;

//\\ P<MORE_LOCAL_STATEMENTS> =
   case G_MORE_LOCAL_STATEMENTS:
     if (alt == 0)               {  //\\    ';' <LABELS_opt> <LOCAL_STATEMENT> <MORE_LOCAL_STATEMENTS>,
       PrintIndent(SubPhrase(P, 1) /*, L';' */);
       continuation_spaces = 0;
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LABELS_opt */);
       reindent(SubPhraseIdx(P, 3), depth+1 /* G_LOCAL_STATEMENT */);
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_MORE_LOCAL_STATEMENTS */);
     } else                      {  //\\    ;

     }
     return r;

//\\ P<LOCAL_STATEMENT> =
   case G_LOCAL_STATEMENT:
     if (alt == 0)               {  //\\    <COMMENT_NO_SEMI>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_COMMENT_NO_SEMI */);
     } else if (alt == 1)        {  //\\    <ASSIGNMENT>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_ASSIGNMENT */);
     } else if (alt == 2)        {  //\\    <PROCEDURE_CALL>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_PROCEDURE_CALL */);
     } else if (alt == 3)        {  //\\    "b̲e̲g̲i̲n̲" <LOCAL_BLOCK> "e̲n̲d̲" <ENDTEXT>,
       continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 1));
       ilev += 1; continuation_spaces = 0;
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LOCAL_BLOCK */);
       ilev -= 1; continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_ENDTEXT */);
     } else if (alt == 4)        {  //\\   "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL-STATEMENT>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LHS */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_FLE */);
       reindent(SubPhraseIdx(P, 5), depth+1 /* G_MORE_FORLIST */);
       PrintIndent(SubPhrase(P, 6));
       ilev += 1;
       reindent(SubPhraseIdx(P, 7), depth+1 /* G_LABELS_opt */);
       reindent(SubPhraseIdx(P, 8), depth+1 /* G_LOCAL_STATEMENT */);
       ilev -= 1;
     } else if (alt == 5)        {  //\\    "i̲f̲" <BEXPR> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL_STATEMENT> <OPT_ELSE>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_BEXPR */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_LABELS_opt */);
       reindent(SubPhraseIdx(P, 5), depth+1 /* G_LOCAL_STATEMENT */);
       reindent(SubPhraseIdx(P, 6), depth+1 /* G_OPT_ELSE */);
     } else if (alt == 6)        {  //\\    "g̲o̲" "t̲o̲" <JUMP_TARGET>,
       PrintIndent(SubPhrase(P, 1));
       PrintIndent(SubPhrase(P, 2));
       reindent(SubPhraseIdx(P, 3), depth+1 /* G_JUMP_TARGET */);
     } else if (alt == 7)        {  //\\    <CODE>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_CODE */);
     } else if (alt == 8)        {  //\\    <PROCEDURE>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_PROCEDURE */);
     } else if (alt == 9)        {  //\\    <OWN_DECLARATION>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_OWN_DECLARATION */);
     } else if (alt == 10)        {  //\\    <LOCAL_DECLARATION>,
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_LOCAL_DECLARATION */);
     } else                      {  //\\    ;

     }
     return r;

//\\ P<OPT_ELSE> =
   case G_OPT_ELSE:
     if (alt == 0)               {  //\\    "e̲l̲s̲e̲" <LABELS_opt> "i̲f̲" <BEXPR> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL_STATEMENT> <OPT_ELSE>,
       continuation_spaces = 2;
       PrintIndent(SubPhrase(P, 1));
       continuation_spaces = 0;
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LABELS_opt */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_BEXPR */);
       PrintIndent(SubPhrase(P, 5));
       reindent(SubPhraseIdx(P, 6), depth+1 /* G_LABELS_opt */);
       reindent(SubPhraseIdx(P, 7), depth+1 /* G_LOCAL_STATEMENT */);
       reindent(SubPhraseIdx(P, 8), depth+1 /* G_OPT_ELSE */);
     } else if (alt == 1)        {  //\\    "e̲l̲s̲e̲" <LABELS_opt> <LOCAL_STATEMENT>,
       continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 1));
       continuation_spaces = 2;
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_LABELS_opt */);
       reindent(SubPhraseIdx(P, 3), depth+1 /* G_LOCAL_STATEMENT */);
     } else                      {  //\\    ;

     }
     return r;

//\\ P<simple_arithmetic_expression> =
   case G_arithmetic_expression:
     if (alt == 0)               {     //\\   "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_arithmetic_expression> "e̲l̲s̲e̲" <arithmetic_expression>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_Boolean_expression */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_simple_arithmetic_expression */);
       continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 5));
       continuation_spaces = 2;
       reindent(SubPhraseIdx(P, 6), depth+1 /* G_arithmetic_expression */);
     } else                      {     //\\   <simple_arithmetic_expression>
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_simple_arithmetic_expression */);
     }
     return r;

//\\ P<Boolean_expression> =
   case G_Boolean_expression:
     if (alt == 0)               {  //\\   "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_Boolean> "e̲l̲s̲e̲" <Boolean_expression>,
       PrintIndent(SubPhrase(P, 1));
       reindent(SubPhraseIdx(P, 2), depth+1 /* G_Boolean_expression */);
       PrintIndent(SubPhrase(P, 3));
       reindent(SubPhraseIdx(P, 4), depth+1 /* G_simple_Boolean */);
       continuation_spaces = 0;
       PrintIndent(SubPhrase(P, 5));
       continuation_spaces = 2;
       reindent(SubPhraseIdx(P, 6), depth+1 /* G_Boolean_expression */);
     } else                      {  //\\   <simple_Boolean>;
       reindent(SubPhraseIdx(P, 1), depth+1 /* G_Boolean_expression */);
     }
     return r;

     // We'll canonicalise _10 with IMP-style '@' for now,
     // until the Unicode character becomes more widely implemented
     
//\\ P<subten> = "@", "&", "⏨", "\u23E8", "\u2081\u2080";
   case G_subten:
     O(SubPhrase(P, 1), L"@"); // until ⏨ is better supported
     return r;

//\\ P<exp_op> = "^", "**", "⭡", "p̲o̲w̲e̲r̲";
  case G_exp_op:
     O(SubPhrase(P, 1), L"⭡");
     return r;

//\\ P<mul_op> = "*", "×";
   case G_mul_op:
     O(SubPhrase(P, 1), L"×");
     return r;

//\\ P<idiv_op> = "//", "÷", "%", "d̲i̲v̲";
   case G_idiv_op:
     // if (alt == 2) warn(L"Check that % was used as a substitute for ÷ and not as m̲o̲d̲\n");
     O(SubPhrase(P, 1), L"÷");
     return r;

//\\ P<and_term> = "a̲n̲d̲", "∧", "&";
   case G_and_term:
     O(SubPhrase(P, 1), L"∧");
     return r;

//\\ P<or_term> = "o̲r̲", "∨";
   case G_or_term:
     O(SubPhrase(P, 1), L"∨");
     return r;

//\\ P<equiv_term> = "e̲q̲u̲i̲v̲", "e̲q̲v̲", "≡";
   case G_equiv_term:
     O(SubPhrase(P, 1), L"≡");
     return r;

//\\ P<not_term> = "n̲o̲t̲", "¬", "!", "~";
   case G_not_term:
     O(SubPhrase(P, 1), L"¬");
     return r;

//\\ P<impl_term> = "i̲m̲p̲l̲", "⊃", "\u2283";
   case G_impl_term:
     O(SubPhrase(P, 1), L"i̲m̲p̲l̲"); // until ⊃ is supported properly
     return r;

   case G_relational_operator:
     if (alt == 0)               {  //\\    "=",
       O(SubPhrase(P, 1), L"=");
     } else if (alt == 1)        {  //\\    "e̲q̲u̲a̲l̲",
       O(SubPhrase(P, 1), L"=");
     } else if (alt == 2)        {  //\\    "e̲q̲",
       O(SubPhrase(P, 1), L"=");
     } else if (alt == 3)        {  //\\    ">=",
       O(SubPhrase(P, 1), L"≥");
     } else if (alt == 4)        {  //\\    "≥",
       O(SubPhrase(P, 1), L"≥");
     } else if (alt == 5)        {  //\\    "g̲e̲",
       O(SubPhrase(P, 1), L"≥");
     } else if (alt == 6)        {  //\\    "n̲o̲t̲l̲e̲s̲s̲",
       O(SubPhrase(P, 1), L"≥");
     } else if (alt == 7)        {  //\\    "g̲r̲e̲q̲",
       O(SubPhrase(P, 1), L"≥");
     } else if (alt == 8)        {  //\\    ">",
       O(SubPhrase(P, 1), L">");
     } else if (alt == 9)        {  //\\    "g̲t̲",
       O(SubPhrase(P, 1), L">");
     } else if (alt == 10)        {  //\\    "g̲r̲e̲a̲t̲e̲r̲",
       O(SubPhrase(P, 1), L">");
     } else if (alt == 11)        {  //\\    "<>",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 12)        {  //\\    "#",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 13)        {  //\\    "≠",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 14)        {  //\\    "n̲e̲",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 15)        {  //\\    "n̲o̲t̲e̲q̲u̲a̲l̲",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 16)        {  //\\    "\=",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 17)        {  //\\    "¬=",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 18)        {  //\\    "!=",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 19)        {  //\\    "^=",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 20)        {  //\\    "|=",
       O(SubPhrase(P, 1), L"≠");
     } else if (alt == 21)        {  //\\    "<=",
       O(SubPhrase(P, 1), L"≤");
     } else if (alt == 22)        {  //\\    "≤",
       O(SubPhrase(P, 1), L"≤");
     } else if (alt == 23)        {  //\\    "l̲e̲s̲s̲e̲q̲",
       O(SubPhrase(P, 1), L"≤");
     } else if (alt == 24)        {  //\\    "n̲o̲t̲g̲r̲e̲a̲t̲e̲r̲",
       O(SubPhrase(P, 1), L"≤");
     } else if (alt == 25)        {  //\\    "<",
       O(SubPhrase(P, 1), L"<");
     } else if (alt == 26)        {  //\\    "l̲t̲",
       O(SubPhrase(P, 1), L"<");
     } else if (alt == 27)        {  //\\    "l̲e̲s̲s̲",
       O(SubPhrase(P, 1), L"<");
     } else                      {  //\\    "l̲e̲";
       O(SubPhrase(P, 1), L"≤");
     }
     return r;

//\\ P<ARRAY_LB> =
   case G_ARRAY_LB:
     if (alt == 0)               {  //\\    '[',
       PrintIndent(SubPhrase(P, 1) /*, L'[' */);
     } else                      {  //\\    "(/";
       O(SubPhrase(P, 1), L"[");
     }
     return r;

//\\ P<ARRAY_RB> =
   case G_ARRAY_RB:
     if (alt == 0)               {  //\\    ']',
       PrintIndent(SubPhrase(P, 1) /*, L']' */);
     } else                      {  //\\    "/)";
       O(SubPhrase(P, 1), L"]");
     }
     return r;

//\\ E

    default: // Everything else can use the default output code:
      for (i = 1; i <= count; i++) reindent(SubPhraseIdx/*Idx*/(P,i), depth+1);
    }

  } else if ((AST_type == AST_LITERAL) || (AST_type == AST_BIP)) {
    // Will only be called for phrases not specifically listed above.
    PrintIndent(AST_index);
  }
  return r;
}
