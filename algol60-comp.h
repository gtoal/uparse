#error This is not directly used in anything at the moment.
// It is here for incorporating as the basis of a compile() function to do something useful with an AST.
// For example this generated the code that was manually converted into algol60-indent.h

#include <stdio.h>

#define AST_idx_mask 0xfFFFFFF
#define AST_type_shift 28
#define AST_type_mask  15
#define AST_BIP     (1 << AST_type_shift)
#define AST_PHRASE  (2 << AST_type_shift)
#define AST_LITERAL (3 << AST_type_shift)

int AST(int idx) {
}

int wlit(int P) {
}

int P(int P_) {
}
int compile(int Ph, int depth) {

  // AST format not properly designed yet.  These are placeholders:
#define P(x) (x) // TEMP
#define A(x) (x) // TEMP
#define wlit(x) (x)

  int AST_index = Ph&AST_idx_mask;
  int AST_type  = Ph & (AST_type_mask << AST_type_shift);
  int op    = A(AST_index+1);
  int alt   = A(AST_index+2);
  int count = A(AST_index+3);
  int t[LARGEST_ALT];
  int r = 0;

  fprintf(stderr, "Ph=%d AST_type = %d  AST_index = %d  op=%d  alt=%d  count=%d\n", Ph, AST_type>>AST_type_shift, AST_index, op, alt, count);

  switch (op) {
    // It is here for incorporating as the basis of a compile() function to do something useful with an AST.
    // For example this generated the code that was manually converted into algol60-indent.h

//\\ B<EOF> = 0;
//\\#
//\\ B<nl> = 2;
//\\#
//\\ P<SS> =
   case P_SS:
     {                              //\\    <init> <optional-stropping-conversion> <SOURCE> <terminate>;
     /* semantic procedure init */;
     t[2] = compile(P(2), depth+1 /* P_optional_stropping_conversion */);
     t[3] = compile(P(3), depth+1 /* P_SOURCE */);
     /* semantic procedure terminate */;
     }
     return t[0];

//\\ P<SOURCE> =
   case P_SOURCE:
     if (alt == 0)               {  //\\    <MAIN-PROGRAM> <semi_opt> <EOF>,
       t[1] = compile(P(1), depth+1 /* P_MAIN_PROGRAM */);
       t[2] = compile(P(2), depth+1 /* P_semi_opt */);
       t[3] = wlit(P(3) /*, L"EOF" */);
     } else                      {  //\\    <EXTERNAL-LEVEL-OBJECTS> <EOF>;
       t[1] = compile(P(1), depth+1 /* P_EXTERNAL_LEVEL_OBJECTS */);
       t[2] = wlit(P(2) /*, L"EOF" */);
     }
     return t[0];

//\\ P<semi_opt> =
   case P_semi_opt:
     if (alt == 0)               {  //\\    ';',
       t[1] = wlit(P(1) /*, L';' */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<MAIN-PROGRAM> =
   case P_MAIN_PROGRAM:
     {                              //\\    <PROGRAM_opt> <COMMENTS_opt> "b̲e̲g̲i̲n̲" <LOCAL-BLOCK> "e̲n̲d̲" <ENDTEXT>;
     t[1] = compile(P(1), depth+1 /* P_PROGRAM_opt */);
     t[2] = compile(P(2), depth+1 /* P_COMMENTS_opt */);
     t[3] = wlit(P(3));
     t[4] = compile(P(4), depth+1 /* P_LOCAL_BLOCK */);
     t[5] = wlit(P(5));
     t[6] = compile(P(6), depth+1 /* P_ENDTEXT */);
     }
     return t[0];

//\\ P<PROGRAM_opt> =
   case P_PROGRAM_opt:
     if (alt == 0)               {  //\\    "p̲r̲o̲g̲r̲a̲m̲" <NAME> ';',
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_NAME */);
       t[3] = wlit(P(3) /*, L';' */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<EXTERNAL-LEVEL-OBJECTS> =
   case P_EXTERNAL_LEVEL_OBJECTS:
     if (alt == 0)               {  //\\    <EXTERNAL-LEVEL> <EXTERNAL-LEVEL-OBJECTS>,
       t[1] = compile(P(1), depth+1 /* P_EXTERNAL_LEVEL */);
       t[2] = compile(P(2), depth+1 /* P_EXTERNAL_LEVEL_OBJECTS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<EXTERNAL-LEVEL> =
   case P_EXTERNAL_LEVEL:
     if (alt == 0)               {  //\\    "e̲o̲p̲",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "c̲o̲d̲e̲" <DIGITS> ';',
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_DIGITS */);
       t[3] = wlit(P(3) /*, L';' */);
     } else if (alt == 2)        {  //\\    <COMMENT>,
       t[1] = compile(P(1), depth+1 /* P_COMMENT */);
     } else if (alt == 3)        {  //\\    <PROCEDURE> ';',
       t[1] = compile(P(1), depth+1 /* P_PROCEDURE */);
       t[2] = wlit(P(2) /*, L';' */);
     } else                      {  //\\    <OWN-DECLARATION> ';';
       t[1] = compile(P(1), depth+1 /* P_OWN_DECLARATION */);
       t[2] = wlit(P(2) /*, L';' */);
     }
     return t[0];

//\\ P<PROCTYPE_opt> =
   case P_PROCTYPE_opt:
     if (alt == 0)               {  //\\    "i̲n̲t̲e̲g̲e̲r̲",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "r̲e̲a̲l̲",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    <BOOLEAN>,
       t[1] = compile(P(1), depth+1 /* P_BOOLEAN */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<BOOLEAN> =
   case P_BOOLEAN:
     if (alt == 0)               {  //\\    "B̲o̲o̲l̲e̲a̲n̲",
       t[1] = wlit(P(1));
     } else                      {  //\\    "b̲o̲o̲l̲e̲a̲n̲";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<PROCEDURE> =
   case P_PROCEDURE:
     {                              //\\    <PROCTYPE_opt> "p̲r̲o̲c̲e̲d̲u̲r̲e̲" <NAME> <FORMAL_PARAMS_opt> ';' <COMMENTS_opt> <VALUE_opt> <PARAMETER-TYPES_opt> <LABELS_opt> <PROCBODY>;
     t[1] = compile(P(1), depth+1 /* P_PROCTYPE_opt */);
     t[2] = wlit(P(2));
     t[3] = compile(P(3), depth+1 /* P_NAME */);
     t[4] = compile(P(4), depth+1 /* P_FORMAL_PARAMS_opt */);
     t[5] = wlit(P(5) /*, L';' */);
     t[6] = compile(P(6), depth+1 /* P_COMMENTS_opt */);
     t[7] = compile(P(7), depth+1 /* P_VALUE_opt */);
     t[8] = compile(P(8), depth+1 /* P_PARAMETER_TYPES_opt */);
     t[9] = compile(P(9), depth+1 /* P_LABELS_opt */);
     t[10] = compile(P(10), depth+1 /* P_PROCBODY */);
     }
     return t[0];

//\\ P<FORMAL_PARAMS_opt> =
   case P_FORMAL_PARAMS_opt:
     if (alt == 0)               {  //\\    "(" <NAME> <MORE-FP-LIST> ")",
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_NAME */);
       t[3] = compile(P(3), depth+1 /* P_MORE_FP_LIST */);
       t[4] = wlit(P(4));
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<MORE-FP-LIST> =
   case P_MORE_FP_LIST:
     if (alt == 0)               {  //\\    <FPSEP> <FORMAL-PARAMETER> <MORE-FP-LIST>,
       t[1] = compile(P(1), depth+1 /* P_FPSEP */);
       t[2] = compile(P(2), depth+1 /* P_FORMAL_PARAMETER */);
       t[3] = compile(P(3), depth+1 /* P_MORE_FP_LIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<FORMAL-PARAMETER> =
   case P_FORMAL_PARAMETER:
     {                              //\\    <NAME>;
     t[1] = compile(P(1), depth+1 /* P_NAME */);
     }
     return t[0];

//\\ P<VALUE_opt> =
   case P_VALUE_opt:
     if (alt == 0)               {  //\\    "v̲a̲l̲u̲e̲" <VALUE-NAMELIST> ';',
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_VALUE_NAMELIST */);
       t[3] = wlit(P(3) /*, L';' */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<VALUE-NAMELIST> =
   case P_VALUE_NAMELIST:
     {                              //\\    <VALUE-NAME> <MORE-VALUE-NAMELIST>;
     t[1] = compile(P(1), depth+1 /* P_VALUE_NAME */);
     t[2] = compile(P(2), depth+1 /* P_MORE_VALUE_NAMELIST */);
     }
     return t[0];

//\\ P<MORE-VALUE-NAMELIST> =
   case P_MORE_VALUE_NAMELIST:
     if (alt == 0)               {  //\\    "," <VALUE-NAMELIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_VALUE_NAMELIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<VALUE-NAME> =
   case P_VALUE_NAME:
     {                              //\\    <NAME>;
     t[1] = compile(P(1), depth+1 /* P_NAME */);
     }
     return t[0];

//\\ P<COMMENT-NO-SEMI> =
   case P_COMMENT_NO_SEMI:
     {                              //\\    "c̲o̲m̲m̲e̲n̲t̲" <COMMENTTEXT>;
     t[1] = wlit(P(1));
     t[2] = compile(P(2), depth+1 /* P_COMMENTTEXT */);
     }
     return t[0];

//\\ P<COMMENT> =
   case P_COMMENT:
     {                              //\\    <COMMENT-NO-SEMI> ';';
     t[1] = compile(P(1), depth+1 /* P_COMMENT_NO_SEMI */);
     t[2] = wlit(P(2) /*, L';' */);
     }
     return t[0];

//\\ P<COMMENTS_opt> =
   case P_COMMENTS_opt:
     if (alt == 0)               {  //\\    <COMMENT> <MORE-COMMENTS>,
       t[1] = compile(P(1), depth+1 /* P_COMMENT */);
       t[2] = compile(P(2), depth+1 /* P_MORE_COMMENTS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<MORE-COMMENTS> =
   case P_MORE_COMMENTS:
     if (alt == 0)               {  //\\    ';' <COMMENT> <MORE-COMMENTS>,
       t[1] = wlit(P(1) /*, L';' */);
       t[2] = compile(P(2), depth+1 /* P_COMMENT */);
       t[3] = compile(P(3), depth+1 /* P_MORE_COMMENTS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<COMMENTTEXT> =
   case P_COMMENTTEXT:
     {                              //\\    <NONSEMITEXT> <OPT-MORELINES>;
     t[1] = compile(P(1), depth+1 /* P_NONSEMITEXT */);
     t[2] = compile(P(2), depth+1 /* P_OPT_MORELINES */);
     }
     return t[0];

//\\ P<NONSEMITEXT> =
   case P_NONSEMITEXT:
     {                              //\\    «[^;]*»;
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<OPT-MORELINES> =
   case P_OPT_MORELINES:
     if (alt == 0)               {  //\\    <SS> <NONSEMITEXT> <OPT-MORELINES>,
       t[1] = wlit(P(1) /*, L"nl" */);
       t[2] = compile(P(2), depth+1 /* P_NONSEMITEXT */);
       t[3] = compile(P(3), depth+1 /* P_OPT_MORELINES */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<LABELS_opt> =
   case P_LABELS_opt:
     if (alt == 0)               {  //\\    <NAME> <!assign> ":" <!comment-keyword> <LABELS_opt>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
       /* ignore negative guard */;
       t[3] = wlit(P(3));
       /* ignore negative guard */;
       t[5] = compile(P(5), depth+1 /* P_LABELS_opt */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<comment-keyword> =
   case P_comment_keyword:
     {                              //\\    "c̲o̲m̲m̲e̲n̲t̲";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<assign> =
   case P_assign:
     {                              //\\    ":=";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<PARAMETER-TYPES_opt> =
   case P_PARAMETER_TYPES_opt:
     if (alt == 0)               {  //\\    <PARAMETER-TYPE> ';' <PARAMETER-TYPES_opt>,
       t[1] = compile(P(1), depth+1 /* P_PARAMETER_TYPE */);
       t[2] = wlit(P(2) /*, L';' */);
       t[3] = compile(P(3), depth+1 /* P_PARAMETER_TYPES_opt */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<PARAMETER-TYPE> =
   case P_PARAMETER_TYPE:
     if (alt == 0)               {  //\\    "l̲a̲b̲e̲l̲" <DECLIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_DECLIST */);
     } else if (alt == 1)        {  //\\    "s̲w̲i̲t̲c̲h̲" <DECLIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_DECLIST */);
     } else if (alt == 2)        {  //\\    "s̲t̲r̲i̲n̲g̲" <DECLIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_DECLIST */);
     } else if (alt == 3)        {  //\\    "i̲n̲t̲e̲g̲e̲r̲" <PDECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_PDECLN */);
     } else if (alt == 4)        {  //\\    "r̲e̲a̲l̲" <PDECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_PDECLN */);
     } else if (alt == 5)        {  //\\    <BOOLEAN> <PDECLN>,
       t[1] = compile(P(1), depth+1 /* P_BOOLEAN */);
       t[2] = compile(P(2), depth+1 /* P_PDECLN */);
     } else if (alt == 6)        {  //\\    <PDECLN>,
       t[1] = compile(P(1), depth+1 /* P_PDECLN */);
     } else                      {  //\\    <COMMENT-NO-SEMI>;
       t[1] = compile(P(1), depth+1 /* P_COMMENT_NO_SEMI */);
     }
     return t[0];

//\\ P<PDECLN> =
   case P_PDECLN:
     if (alt == 0)               {  //\\    "a̲r̲r̲a̲y̲" <DECLIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_DECLIST */);
     } else if (alt == 1)        {  //\\    "p̲r̲o̲c̲e̲d̲u̲r̲e̲" <DECLIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_DECLIST */);
     } else                      {  //\\    <DECLIST>;
       t[1] = compile(P(1), depth+1 /* P_DECLIST */);
     }
     return t[0];

//\\ P<DECLIST> =
   case P_DECLIST:
     {                              //\\    <NAME> <MORE-DECLIST>;
     t[1] = compile(P(1), depth+1 /* P_NAME */);
     t[2] = compile(P(2), depth+1 /* P_MORE_DECLIST */);
     }
     return t[0];

//\\ P<MORE-DECLIST> =
   case P_MORE_DECLIST:
     if (alt == 0)               {  //\\    "," <NAME> <MORE-DECLIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_NAME */);
       t[3] = compile(P(3), depth+1 /* P_MORE_DECLIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<LOCAL-DECLARATION> =
   case P_LOCAL_DECLARATION:
     if (alt == 0)               {  //\\    "i̲n̲t̲e̲g̲e̲r̲" <LOCAL-ARRAY-DECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LOCAL_ARRAY_DECLN */);
     } else if (alt == 1)        {  //\\    "i̲n̲t̲e̲g̲e̲r̲" <LOCAL-SCALAR-DECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LOCAL_SCALAR_DECLN */);
     } else if (alt == 2)        {  //\\    "r̲e̲a̲l̲" <LOCAL-ARRAY-DECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LOCAL_ARRAY_DECLN */);
     } else if (alt == 3)        {  //\\    <LOCAL-ARRAY-DECLN>,
       t[1] = compile(P(1), depth+1 /* P_LOCAL_ARRAY_DECLN */);
     } else if (alt == 4)        {  //\\    "r̲e̲a̲l̲" <LOCAL-SCALAR-DECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LOCAL_SCALAR_DECLN */);
     } else if (alt == 5)        {  //\\    <BOOLEAN> <LOCAL-ARRAY-DECLN>,
       t[1] = compile(P(1), depth+1 /* P_BOOLEAN */);
       t[2] = compile(P(2), depth+1 /* P_LOCAL_ARRAY_DECLN */);
     } else if (alt == 6)        {  //\\    <BOOLEAN> <LOCAL-SCALAR-DECLN>,
       t[1] = compile(P(1), depth+1 /* P_BOOLEAN */);
       t[2] = compile(P(2), depth+1 /* P_LOCAL_SCALAR_DECLN */);
     } else                      {  //\\    "s̲w̲i̲t̲c̲h̲" <NAME> ":=" <SWITCH-DECLS>;
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_NAME */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_SWITCH_DECLS */);
     }
     return t[0];

//\\ P<SWITCH-DECLS> =
   case P_SWITCH_DECLS:
     {                              //\\    <SWITCH-DECL> <MORE-SWITCH-DECLS>;
     t[1] = compile(P(1), depth+1 /* P_SWITCH_DECL */);
     t[2] = compile(P(2), depth+1 /* P_MORE_SWITCH_DECLS */);
     }
     return t[0];

//\\ P<MORE-SWITCH-DECLS> =
   case P_MORE_SWITCH_DECLS:
     if (alt == 0)               {  //\\    ',' <SWITCH-DECL> <MORE-SWITCH-DECLS>,
       t[1] = wlit(P(1) /*, L',' */);
       t[2] = compile(P(2), depth+1 /* P_SWITCH_DECL */);
       t[3] = compile(P(3), depth+1 /* P_MORE_SWITCH_DECLS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<SWITCH-DECL> =
   case P_SWITCH_DECL:
     if (alt == 0)               {  //\\    <DECLIST> <ARRAY-LB> <CONST-EXPR> <ARRAY-RB>,
       t[1] = compile(P(1), depth+1 /* P_DECLIST */);
       t[2] = compile(P(2), depth+1 /* P_ARRAY_LB */);
       t[3] = compile(P(3), depth+1 /* P_CONST_EXPR */);
       t[4] = compile(P(4), depth+1 /* P_ARRAY_RB */);
     } else if (alt == 1)        {  //\\    <DECLIST>,
       t[1] = compile(P(1), depth+1 /* P_DECLIST */);
     } else                      {  //\\    <LEXPR>;
       t[1] = compile(P(1), depth+1 /* P_LEXPR */);
     }
     return t[0];

//\\ P<OPT-ARRAY> =
   case P_OPT_ARRAY:
     if (alt == 0)               {  //\\    <ARRAY-LB> <CONST-EXPR> <ARRAY-RB>,
       t[1] = compile(P(1), depth+1 /* P_ARRAY_LB */);
       t[2] = compile(P(2), depth+1 /* P_CONST_EXPR */);
       t[3] = compile(P(3), depth+1 /* P_ARRAY_RB */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<JUMP-TARGET> =
   case P_JUMP_TARGET:
     {                              //\\    <LEXPR>;
     t[1] = compile(P(1), depth+1 /* P_LEXPR */);
     }
     return t[0];

//\\ P<LEXPR> =
   case P_LEXPR:
     if (alt == 0)               {  //\\    '(' <LEXPR> ')',
       t[1] = wlit(P(1) /*, L'(' */);
       t[2] = compile(P(2), depth+1 /* P_LEXPR */);
       t[3] = wlit(P(3) /*, L')' */);
     } else if (alt == 1)        {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <SLEXPR> "e̲l̲s̲e̲" <LEXPR>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_Boolean_expression */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_SLEXPR */);
       t[5] = wlit(P(5));
       t[6] = compile(P(6), depth+1 /* P_LEXPR */);
     } else                      {  //\\    <SLEXPR>;
       t[1] = compile(P(1), depth+1 /* P_SLEXPR */);
     }
     return t[0];

//\\ P<SLEXPR> =
   case P_SLEXPR:
     if (alt == 0)               {  //\\    <NAME> <OPT-ARRAY>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
       t[2] = compile(P(2), depth+1 /* P_OPT_ARRAY */);
     } else                      {  //\\    "(" <LEXPR> ")";
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LEXPR */);
       t[3] = wlit(P(3));
     }
     return t[0];

//\\ P<OWN-DECLARATION> =
   case P_OWN_DECLARATION:
     if (alt == 0)               {  //\\    "o̲w̲n̲" "i̲n̲t̲e̲g̲e̲r̲" <OWN-ARRAY-DECLN>,
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = compile(P(3), depth+1 /* P_OWN_ARRAY_DECLN */);
     } else if (alt == 1)        {  //\\    "o̲w̲n̲" "i̲n̲t̲e̲g̲e̲r̲" <LOCAL-SCALAR-DECLN>,
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = compile(P(3), depth+1 /* P_LOCAL_SCALAR_DECLN */);
     } else if (alt == 2)        {  //\\    "o̲w̲n̲" "r̲e̲a̲l̲" <OWN-ARRAY-DECLN>,
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = compile(P(3), depth+1 /* P_OWN_ARRAY_DECLN */);
     } else if (alt == 3)        {  //\\    "o̲w̲n̲" <OWN-ARRAY-DECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_OWN_ARRAY_DECLN */);
     } else if (alt == 4)        {  //\\    "o̲w̲n̲" "r̲e̲a̲l̲" <LOCAL-SCALAR-DECLN>,
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = compile(P(3), depth+1 /* P_LOCAL_SCALAR_DECLN */);
     } else if (alt == 5)        {  //\\    "o̲w̲n̲" <BOOLEAN> <OWN-ARRAY-DECLN>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_BOOLEAN */);
       t[3] = compile(P(3), depth+1 /* P_OWN_ARRAY_DECLN */);
     } else                      {  //\\    "o̲w̲n̲" <BOOLEAN> <LOCAL-SCALAR-DECLN>;
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_BOOLEAN */);
       t[3] = compile(P(3), depth+1 /* P_LOCAL_SCALAR_DECLN */);
     }
     return t[0];

//\\ P<OWN-ARRAY-DECLN> =
   case P_OWN_ARRAY_DECLN:
     {                              //\\    "a̲r̲r̲a̲y̲" <OWN-BOUNDED-DECLIST>;
     t[1] = wlit(P(1));
     t[2] = compile(P(2), depth+1 /* P_OWN_BOUNDED_DECLIST */);
     }
     return t[0];

//\\ P<LOCAL-ARRAY-DECLN> =
   case P_LOCAL_ARRAY_DECLN:
     {                              //\\    "a̲r̲r̲a̲y̲" <BOUNDED-DECLIST>;
     t[1] = wlit(P(1));
     t[2] = compile(P(2), depth+1 /* P_BOUNDED_DECLIST */);
     }
     return t[0];

//\\ P<LOCAL-SCALAR-DECLN> =
   case P_LOCAL_SCALAR_DECLN:
     {                              //\\    <DECLIST>;
     t[1] = compile(P(1), depth+1 /* P_DECLIST */);
     }
     return t[0];

//\\ P<OWN-BOUNDED-DECLIST> =
   case P_OWN_BOUNDED_DECLIST:
     {                              //\\    <DECLIST> <OWN-BOUNDS-DECLARATION> <MORE-OWN-BOUNDED-DECLIST>;
     t[1] = compile(P(1), depth+1 /* P_DECLIST */);
     t[2] = compile(P(2), depth+1 /* P_OWN_BOUNDS_DECLARATION */);
     t[3] = compile(P(3), depth+1 /* P_MORE_OWN_BOUNDED_DECLIST */);
     }
     return t[0];

//\\ P<BOUNDED-DECLIST> =
   case P_BOUNDED_DECLIST:
     {                              //\\    <DECLIST> <BOUNDS-DECLARATION> <MORE-BOUNDED-DECLIST>;
     t[1] = compile(P(1), depth+1 /* P_DECLIST */);
     t[2] = compile(P(2), depth+1 /* P_BOUNDS_DECLARATION */);
     t[3] = compile(P(3), depth+1 /* P_MORE_BOUNDED_DECLIST */);
     }
     return t[0];

//\\ P<MORE-OWN-BOUNDED-DECLIST> =
   case P_MORE_OWN_BOUNDED_DECLIST:
     if (alt == 0)               {  //\\    ',' <DECLIST> <OWN-BOUNDS-DECLARATION> <MORE-OWN-BOUNDED-DECLIST>,
       t[1] = wlit(P(1) /*, L',' */);
       t[2] = compile(P(2), depth+1 /* P_DECLIST */);
       t[3] = compile(P(3), depth+1 /* P_OWN_BOUNDS_DECLARATION */);
       t[4] = compile(P(4), depth+1 /* P_MORE_OWN_BOUNDED_DECLIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<MORE-BOUNDED-DECLIST> =
   case P_MORE_BOUNDED_DECLIST:
     if (alt == 0)               {  //\\    ',' <DECLIST> <BOUNDS-DECLARATION> <MORE-BOUNDED-DECLIST>,
       t[1] = wlit(P(1) /*, L',' */);
       t[2] = compile(P(2), depth+1 /* P_DECLIST */);
       t[3] = compile(P(3), depth+1 /* P_BOUNDS_DECLARATION */);
       t[4] = compile(P(4), depth+1 /* P_MORE_BOUNDED_DECLIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<OWN-BOUNDS-DECLARATION> =
   case P_OWN_BOUNDS_DECLARATION:
     {                              //\\    <ARRAY-LB> <OWN-BOUNDS-DECLIST> <ARRAY-RB>;
     t[1] = compile(P(1), depth+1 /* P_ARRAY_LB */);
     t[2] = compile(P(2), depth+1 /* P_OWN_BOUNDS_DECLIST */);
     t[3] = compile(P(3), depth+1 /* P_ARRAY_RB */);
     }
     return t[0];

//\\ P<BOUNDS-DECLARATION> =
   case P_BOUNDS_DECLARATION:
     {                              //\\    <ARRAY-LB> <BOUNDS-DECLIST> <ARRAY-RB>;
     t[1] = compile(P(1), depth+1 /* P_ARRAY_LB */);
     t[2] = compile(P(2), depth+1 /* P_BOUNDS_DECLIST */);
     t[3] = compile(P(3), depth+1 /* P_ARRAY_RB */);
     }
     return t[0];

//\\ P<OWN-BOUNDS-DECLIST> =
   case P_OWN_BOUNDS_DECLIST:
     {                              //\\    <OWN-BOUND-DEC> <MORE-OWN-BOUNDS-DECLIST>;
     t[1] = compile(P(1), depth+1 /* P_OWN_BOUND_DEC */);
     t[2] = compile(P(2), depth+1 /* P_MORE_OWN_BOUNDS_DECLIST */);
     }
     return t[0];

//\\ P<BOUNDS-DECLIST> =
   case P_BOUNDS_DECLIST:
     {                              //\\    <BOUND-DEC> <MORE-BOUNDS-DECLIST>;
     t[1] = compile(P(1), depth+1 /* P_BOUND_DEC */);
     t[2] = compile(P(2), depth+1 /* P_MORE_BOUNDS_DECLIST */);
     }
     return t[0];

//\\ P<MORE-OWN-BOUNDS-DECLIST> =
   case P_MORE_OWN_BOUNDS_DECLIST:
     if (alt == 0)               {  //\\    ',' <OWN-BOUND-DEC> <MORE-OWN-BOUNDS-DECLIST>,
       t[1] = wlit(P(1) /*, L',' */);
       t[2] = compile(P(2), depth+1 /* P_OWN_BOUND_DEC */);
       t[3] = compile(P(3), depth+1 /* P_MORE_OWN_BOUNDS_DECLIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<MORE-BOUNDS-DECLIST> =
   case P_MORE_BOUNDS_DECLIST:
     if (alt == 0)               {  //\\    ',' <BOUND-DEC> <MORE-BOUNDS-DECLIST>,
       t[1] = wlit(P(1) /*, L',' */);
       t[2] = compile(P(2), depth+1 /* P_BOUND_DEC */);
       t[3] = compile(P(3), depth+1 /* P_MORE_BOUNDS_DECLIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<OWN-BOUND-DEC> =
   case P_OWN_BOUND_DEC:
     {                              //\\    <CONST-EXPR> <COLON-WARN-COMMA> <CONST-EXPR>;
     t[1] = compile(P(1), depth+1 /* P_CONST_EXPR */);
     t[2] = compile(P(2), depth+1 /* P_COLON_WARN_COMMA */);
     t[3] = compile(P(3), depth+1 /* P_CONST_EXPR */);
     }
     return t[0];

//\\ P<BOUND-DEC> =
   case P_BOUND_DEC:
     {                              //\\    <arithmetic_expression> <COLON-WARN-COMMA> <arithmetic_expression>;
     t[1] = compile(P(1), depth+1 /* P_arithmetic_expression */);
     t[2] = compile(P(2), depth+1 /* P_COLON_WARN_COMMA */);
     t[3] = compile(P(3), depth+1 /* P_arithmetic_expression */);
     }
     return t[0];

//\\ P<COLON-WARN-COMMA> =
   case P_COLON_WARN_COMMA:
     if (alt == 0)               {  //\\    ':',
       t[1] = wlit(P(1) /*, L':' */);
     } else if (alt == 1)        {  //\\    ',',
       t[1] = wlit(P(1) /*, L',' */);
     } else                      {  //\\    "..";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<CONST-EXPR> =
   case P_CONST_EXPR:
     {                              //\\    <arithmetic_expression>;
     t[1] = compile(P(1), depth+1 /* P_arithmetic_expression */);
     }
     return t[0];

//\\ P<PROCBODY> =
   case P_PROCBODY:
     if (alt == 0)               {  //\\    "c̲o̲d̲e̲" <DIGITS>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_DIGITS */);
     } else if (alt == 1)        {  //\\    "a̲l̲g̲o̲l̲",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "f̲o̲r̲t̲r̲a̲n̲",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    "e̲x̲t̲e̲r̲n̲a̲l̲",
       t[1] = wlit(P(1));
     } else if (alt == 4)        {  //\\    "b̲e̲g̲i̲n̲" <LOCAL-BLOCK> "e̲n̲d̲" <ENDTEXT>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LOCAL_BLOCK */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_ENDTEXT */);
     } else if (alt == 5)        {  //\\    <ASSIGNMENT>,
       t[1] = compile(P(1), depth+1 /* P_ASSIGNMENT */);
     } else if (alt == 6)        {  //\\    <function_designator>,
       t[1] = compile(P(1), depth+1 /* P_function_designator */);
     } else if (alt == 7)        {  //\\    "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL-STATEMENT>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LHS */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_FLE */);
       t[5] = compile(P(5), depth+1 /* P_FORLIST */);
       t[6] = wlit(P(6));
       t[7] = compile(P(7), depth+1 /* P_LABELS_opt */);
       t[8] = compile(P(8), depth+1 /* P_LOCAL_STATEMENT */);
     } else if (alt == 8)        {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL-STATEMENT> <OPT-ELSE>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_Boolean_expression */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_LABELS_opt */);
       t[5] = compile(P(5), depth+1 /* P_LOCAL_STATEMENT */);
       t[6] = compile(P(6), depth+1 /* P_OPT_ELSE */);
     } else if (alt == 9)        {  //\\    "g̲o̲" "t̲o̲" <JUMP-TARGET>,
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = compile(P(3), depth+1 /* P_JUMP_TARGET */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<LOCAL-BLOCK> =
   case P_LOCAL_BLOCK:
     if (alt == 0)               {  //\\    <LABELS_opt> <LOCAL-STATEMENT> <MORE-LOCAL-STATEMENTS>,
       t[1] = compile(P(1), depth+1 /* P_LABELS_opt */);
       t[2] = compile(P(2), depth+1 /* P_LOCAL_STATEMENT */);
       t[3] = compile(P(3), depth+1 /* P_MORE_LOCAL_STATEMENTS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<MORE-LOCAL-STATEMENTS> =
   case P_MORE_LOCAL_STATEMENTS:
     if (alt == 0)               {  //\\    ';' <LABELS_opt> <LOCAL-STATEMENT> <MORE-LOCAL-STATEMENTS>,
       t[1] = wlit(P(1) /*, L';' */);
       t[2] = compile(P(2), depth+1 /* P_LABELS_opt */);
       t[3] = compile(P(3), depth+1 /* P_LOCAL_STATEMENT */);
       t[4] = compile(P(4), depth+1 /* P_MORE_LOCAL_STATEMENTS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<LOCAL-STATEMENT> =
   case P_LOCAL_STATEMENT:
     if (alt == 0)               {  //\\    <COMMENT-NO-SEMI>,
       t[1] = compile(P(1), depth+1 /* P_COMMENT_NO_SEMI */);
     } else if (alt == 1)        {  //\\    <ASSIGNMENT>,
       t[1] = compile(P(1), depth+1 /* P_ASSIGNMENT */);
     } else if (alt == 2)        {  //\\    <function_designator>,
       t[1] = compile(P(1), depth+1 /* P_function_designator */);
     } else if (alt == 3)        {  //\\    "b̲e̲g̲i̲n̲" <LOCAL-BLOCK> "e̲n̲d̲" <ENDTEXT>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LOCAL_BLOCK */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_ENDTEXT */);
     } else if (alt == 4)        {  //\\    "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL-STATEMENT>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LHS */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_FLE */);
       t[5] = compile(P(5), depth+1 /* P_FORLIST */);
       t[6] = wlit(P(6));
       t[7] = compile(P(7), depth+1 /* P_LABELS_opt */);
       t[8] = compile(P(8), depth+1 /* P_LOCAL_STATEMENT */);
     } else if (alt == 5)        {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL-STATEMENT> <OPT-ELSE>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_Boolean_expression */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_LABELS_opt */);
       t[5] = compile(P(5), depth+1 /* P_LOCAL_STATEMENT */);
       t[6] = compile(P(6), depth+1 /* P_OPT_ELSE */);
     } else if (alt == 6)        {  //\\    "g̲o̲" "t̲o̲" <JUMP-TARGET>,
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = compile(P(3), depth+1 /* P_JUMP_TARGET */);
     } else if (alt == 7)        {  //\\    <CODE>,
       t[1] = compile(P(1), depth+1 /* P_CODE */);
     } else if (alt == 8)        {  //\\    <PROCEDURE>,
       t[1] = compile(P(1), depth+1 /* P_PROCEDURE */);
     } else if (alt == 9)        {  //\\    <OWN-DECLARATION>,
       t[1] = compile(P(1), depth+1 /* P_OWN_DECLARATION */);
     } else if (alt == 10)        {  //\\    <LOCAL-DECLARATION>,
       t[1] = compile(P(1), depth+1 /* P_LOCAL_DECLARATION */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<CODE> =
   case P_CODE:
     {                              //\\    "c̲o̲d̲e̲" <ONOFF>;
     t[1] = wlit(P(1));
     t[2] = compile(P(2), depth+1 /* P_ONOFF */);
     }
     return t[0];

//\\ P<ONOFF> =
   case P_ONOFF:
     if (alt == 0)               {  //\\    "o̲n̲",
       t[1] = wlit(P(1));
     } else                      {  //\\    "o̲f̲f̲";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<OPT-ELSE> =
   case P_OPT_ELSE:
     if (alt == 0)               {  //\\    "e̲l̲s̲e̲" <LABELS_opt> "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL-STATEMENT> <OPT-ELSE>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LABELS_opt */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_Boolean_expression */);
       t[5] = wlit(P(5));
       t[6] = compile(P(6), depth+1 /* P_LABELS_opt */);
       t[7] = compile(P(7), depth+1 /* P_LOCAL_STATEMENT */);
       t[8] = compile(P(8), depth+1 /* P_OPT_ELSE */);
     } else if (alt == 1)        {  //\\    "e̲l̲s̲e̲" <LABELS_opt> <LOCAL-STATEMENT>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_LABELS_opt */);
       t[3] = compile(P(3), depth+1 /* P_LOCAL_STATEMENT */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<FLE> =
   case P_FLE:
     {                              //\\    <arithmetic_expression> <REST-OF-FLE>;
     t[1] = compile(P(1), depth+1 /* P_arithmetic_expression */);
     t[2] = compile(P(2), depth+1 /* P_REST_OF_FLE */);
     }
     return t[0];

//\\ P<REST-OF-FLE> =
   case P_REST_OF_FLE:
     if (alt == 0)               {  //\\    "s̲t̲e̲p̲" <arithmetic_expression> "u̲n̲t̲i̲l̲" <arithmetic_expression>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_arithmetic_expression */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_arithmetic_expression */);
     } else if (alt == 1)        {  //\\    "w̲h̲i̲l̲e̲" <Boolean_expression>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_Boolean_expression */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<FORLIST> =
   case P_FORLIST:
     if (alt == 0)               {  //\\    "," <FLE> <FORLIST>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_FLE */);
       t[3] = compile(P(3), depth+1 /* P_FORLIST */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<MORE-LHS> =
   case P_MORE_LHS:
     if (alt == 0)               {  //\\    <LHS> ':' '=' <MORE-LHS>,
       t[1] = compile(P(1), depth+1 /* P_LHS */);
       t[2] = wlit(P(2) /*, L':' */);
       t[3] = wlit(P(3) /*, L'=' */);
       t[4] = compile(P(4), depth+1 /* P_MORE_LHS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<ASSIGNMENT> =
   case P_ASSIGNMENT:
     {                              //\\    <LHS> ':' '=' <MORE-LHS> <RHS>;
     t[1] = compile(P(1), depth+1 /* P_LHS */);
     t[2] = wlit(P(2) /*, L':' */);
     t[3] = wlit(P(3) /*, L'=' */);
     t[4] = compile(P(4), depth+1 /* P_MORE_LHS */);
     t[5] = compile(P(5), depth+1 /* P_RHS */);
     }
     return t[0];

//\\ P<LHS> =
   case P_LHS:
     if (alt == 0)               {  //\\    <NAME> <ARRAY-LB> <ARRAY-INDEX> <ARRAY-INDICES> <ARRAY-RB>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
       t[2] = compile(P(2), depth+1 /* P_ARRAY_LB */);
       t[3] = compile(P(3), depth+1 /* P_ARRAY_INDEX */);
       t[4] = compile(P(4), depth+1 /* P_ARRAY_INDICES */);
       t[5] = compile(P(5), depth+1 /* P_ARRAY_RB */);
     } else                      {  //\\    <NAME>;
       t[1] = compile(P(1), depth+1 /* P_NAME */);
     }
     return t[0];

//\\ P<RHS> =
   case P_RHS:
     if (alt == 0)               {  //\\    <arithmetic_expression> <?closer>,
       t[1] = compile(P(1), depth+1 /* P_arithmetic_expression */);
       /* ignore guard */;
     } else                      {  //\\    <Boolean_expression> <?closer>;
       t[1] = compile(P(1), depth+1 /* P_Boolean_expression */);
       /* ignore guard */;
     }
     return t[0];

//\\ P<function_designator> =
   case P_function_designator:
     if (alt == 0)               {  //\\    <NAME> <ACTUAL-PARAMETERS>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
       t[2] = compile(P(2), depth+1 /* P_ACTUAL_PARAMETERS */);
     } else                      {  //\\    <NAME>;
       t[1] = compile(P(1), depth+1 /* P_NAME */);
     }
     return t[0];

//\\ P<ACTUAL-PARAMETERS> =
   case P_ACTUAL_PARAMETERS:
     {                              //\\    '(' <ACTUAL-PARAMETER> <MORE-ACTUAL-PARAMETERS> ')';
     t[1] = wlit(P(1) /*, L'(' */);
     t[2] = compile(P(2), depth+1 /* P_ACTUAL_PARAMETER */);
     t[3] = compile(P(3), depth+1 /* P_MORE_ACTUAL_PARAMETERS */);
     t[4] = wlit(P(4) /*, L')' */);
     }
     return t[0];

//\\ P<MORE-ACTUAL-PARAMETERS> =
   case P_MORE_ACTUAL_PARAMETERS:
     if (alt == 0)               {  //\\    <FPSEP> <ACTUAL-PARAMETER> <MORE-ACTUAL-PARAMETERS>,
       t[1] = compile(P(1), depth+1 /* P_FPSEP */);
       t[2] = compile(P(2), depth+1 /* P_ACTUAL_PARAMETER */);
       t[3] = compile(P(3), depth+1 /* P_MORE_ACTUAL_PARAMETERS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<FPSEP> =
   case P_FPSEP:
     if (alt == 0)               {  //\\    ",",
       t[1] = wlit(P(1));
     } else                      {  //\\    ")" «[ ]*[A-Za-z][A-Za-z ]*» ":" "(";
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = wlit(P(3));
       t[4] = wlit(P(4));
     }
     return t[0];

//\\ P<ACTUAL-PARAMETER> =
   case P_ACTUAL_PARAMETER:
     if (alt == 0)               {  //\\    <Boolean_expression> <?closer>,
       t[1] = compile(P(1), depth+1 /* P_Boolean_expression */);
       /* ignore guard */;
     } else if (alt == 1)        {  //\\    <arithmetic_expression> <?closer>,
       t[1] = compile(P(1), depth+1 /* P_arithmetic_expression */);
       /* ignore guard */;
     } else                      {  //\\    <string_literal>;
       t[1] = compile(P(1), depth+1 /* P_string_literal */);
     }
     return t[0];

//\\ P<OPERAND> =
   case P_OPERAND:
     if (alt == 0)               {  //\\    <NAME> <ARRAY-LB> <ARRAY-INDEX> <ARRAY-INDICES> <ARRAY-RB>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
       t[2] = compile(P(2), depth+1 /* P_ARRAY_LB */);
       t[3] = compile(P(3), depth+1 /* P_ARRAY_INDEX */);
       t[4] = compile(P(4), depth+1 /* P_ARRAY_INDICES */);
       t[5] = compile(P(5), depth+1 /* P_ARRAY_RB */);
     } else if (alt == 1)        {  //\\    <function_designator>,
       t[1] = compile(P(1), depth+1 /* P_function_designator */);
     } else if (alt == 2)        {  //\\    <NAME>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
     } else if (alt == 3)        {  //\\    <REAL-CONSTANT>,
       t[1] = compile(P(1), depth+1 /* P_REAL_CONSTANT */);
     } else                      {  //\\    "(" <arithmetic_expression> ")";
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_arithmetic_expression */);
       t[3] = wlit(P(3));
     }
     return t[0];

//\\ P<ARRAY-INDEX> =
   case P_ARRAY_INDEX:
     {                              //\\    <arithmetic_expression>;
     t[1] = compile(P(1), depth+1 /* P_arithmetic_expression */);
     }
     return t[0];

//\\ P<ARRAY-INDICES> =
   case P_ARRAY_INDICES:
     if (alt == 0)               {  //\\    ',' <ARRAY-INDEX> <ARRAY-INDICES>,
       t[1] = wlit(P(1) /*, L',' */);
       t[2] = compile(P(2), depth+1 /* P_ARRAY_INDEX */);
       t[3] = compile(P(3), depth+1 /* P_ARRAY_INDICES */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<primary> =
   case P_primary:
     {                              //\\    <PLUS-MINUS-opt> <OPERAND>;
     t[1] = compile(P(1), depth+1 /* P_PLUS_MINUS_opt */);
     t[2] = compile(P(2), depth+1 /* P_OPERAND */);
     }
     return t[0];

//\\ P<exp-op> =
   case P_exp_op:
     if (alt == 0)               {  //\\    "^",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "**",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "⭡",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    "|^",
       t[1] = wlit(P(1));
     } else                      {  //\\    "p̲o̲w̲e̲r̲";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<exp-factor> =
   case P_exp_factor:
     if (alt == 0)               {  //\\    <exp-op> <factor>,
       t[1] = compile(P(1), depth+1 /* P_exp_op */);
       t[2] = compile(P(2), depth+1 /* P_factor */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<factor> =
   case P_factor:
     {                              //\\    <primary> <exp-factor>;
     t[1] = compile(P(1), depth+1 /* P_primary */);
     t[2] = compile(P(2), depth+1 /* P_exp_factor */);
     }
     return t[0];

//\\ P<mul-op> =
   case P_mul_op:
     if (alt == 0)               {  //\\    "*",
       t[1] = wlit(P(1));
     } else                      {  //\\    "×";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<rdiv-op> =
   case P_rdiv_op:
     {                              //\\    "/";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<idiv-op> =
   case P_idiv_op:
     if (alt == 0)               {  //\\    "//",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "÷",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "%",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    "d̲i̲v̲",
       t[1] = wlit(P(1));
     } else                      {  //\\    "'/'";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<div-op> =
   case P_div_op:
     if (alt == 0)               {  //\\    <idiv-op>,
       t[1] = compile(P(1), depth+1 /* P_idiv_op */);
     } else                      {  //\\    <rdiv-op>;
       t[1] = compile(P(1), depth+1 /* P_rdiv_op */);
     }
     return t[0];

//\\ P<muldiv-op> =
   case P_muldiv_op:
     if (alt == 0)               {  //\\    <mul-op>,
       t[1] = compile(P(1), depth+1 /* P_mul_op */);
     } else                      {  //\\    <div-op>;
       t[1] = compile(P(1), depth+1 /* P_div_op */);
     }
     return t[0];

//\\ P<mul-factor> =
   case P_mul_factor:
     if (alt == 0)               {  //\\    <muldiv-op> <term>,
       t[1] = compile(P(1), depth+1 /* P_muldiv_op */);
       t[2] = compile(P(2), depth+1 /* P_term */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<term> =
   case P_term:
     {                              //\\    <factor> <mul-factor>;
     t[1] = compile(P(1), depth+1 /* P_factor */);
     t[2] = compile(P(2), depth+1 /* P_mul_factor */);
     }
     return t[0];

//\\ P<add-op> =
   case P_add_op:
     {                              //\\    "+";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<sub-op> =
   case P_sub_op:
     {                              //\\    "-";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<addsub-op> =
   case P_addsub_op:
     if (alt == 0)               {  //\\    <add-op>,
       t[1] = compile(P(1), depth+1 /* P_add_op */);
     } else                      {  //\\    <sub-op>;
       t[1] = compile(P(1), depth+1 /* P_sub_op */);
     }
     return t[0];

//\\ P<add-term> =
   case P_add_term:
     if (alt == 0)               {  //\\    <addsub-op> <simple_arithmetic_expression>,
       t[1] = compile(P(1), depth+1 /* P_addsub_op */);
       t[2] = compile(P(2), depth+1 /* P_simple_arithmetic_expression */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<simple_arithmetic_expression> =
   case P_simple_arithmetic_expression:
     {                              //\\    <term> <add-term>;
     t[1] = compile(P(1), depth+1 /* P_term */);
     t[2] = compile(P(2), depth+1 /* P_add_term */);
     }
     return t[0];

//\\ P<arithmetic_expression> =
   case P_arithmetic_expression:
     if (alt == 0)               {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_arithmetic_expression> "e̲l̲s̲e̲" <arithmetic_expression>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_Boolean_expression */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_simple_arithmetic_expression */);
       t[5] = wlit(P(5));
       t[6] = compile(P(6), depth+1 /* P_arithmetic_expression */);
     } else                      {  //\\    <simple_arithmetic_expression>;
       t[1] = compile(P(1), depth+1 /* P_simple_arithmetic_expression */);
     }
     return t[0];

//\\ P<INTEGER-CONSTANT> =
   case P_INTEGER_CONSTANT:
     {                              //\\    <PLUS-MINUS-opt> <DIGITS>;
     t[1] = compile(P(1), depth+1 /* P_PLUS_MINUS_opt */);
     t[2] = compile(P(2), depth+1 /* P_DIGITS */);
     }
     return t[0];

//\\ P<REAL-CONSTANT> =
   case P_REAL_CONSTANT:
     {                              //\\    <PLUS-MINUS-opt> <unsigned>;
     t[1] = compile(P(1), depth+1 /* P_PLUS_MINUS_opt */);
     t[2] = compile(P(2), depth+1 /* P_unsigned */);
     }
     return t[0];

//\\ P<unsigned> =
   case P_unsigned:
     if (alt == 0)               {  //\\    <decnum> <expart>,
       t[1] = compile(P(1), depth+1 /* P_decnum */);
       t[2] = compile(P(2), depth+1 /* P_expart */);
     } else if (alt == 1)        {  //\\    <expart>,
       t[1] = compile(P(1), depth+1 /* P_expart */);
     } else                      {  //\\    <decnum>;
       t[1] = compile(P(1), depth+1 /* P_decnum */);
     }
     return t[0];

//\\ P<decfract> =
   case P_decfract:
     {                              //\\    <decimalpoint> <DIGITS>;
     t[1] = compile(P(1), depth+1 /* P_decimalpoint */);
     t[2] = compile(P(2), depth+1 /* P_DIGITS */);
     }
     return t[0];

//\\ P<decimalpoint> =
   case P_decimalpoint:
     if (alt == 0)               {  //\\    ".",
       t[1] = wlit(P(1));
     } else                      {  //\\    "·";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<expart> =
   case P_expart:
     {                              //\\    <subten> <INTEGER-CONSTANT>;
     t[1] = compile(P(1), depth+1 /* P_subten */);
     t[2] = compile(P(2), depth+1 /* P_INTEGER_CONSTANT */);
     }
     return t[0];

//\\ P<decnum> =
   case P_decnum:
     if (alt == 0)               {  //\\    <DIGITS> <decfract>,
       t[1] = compile(P(1), depth+1 /* P_DIGITS */);
       t[2] = compile(P(2), depth+1 /* P_decfract */);
     } else if (alt == 1)        {  //\\    <decfract>,
       t[1] = compile(P(1), depth+1 /* P_decfract */);
     } else                      {  //\\    <DIGITS>;
       t[1] = compile(P(1), depth+1 /* P_DIGITS */);
     }
     return t[0];

//\\ P<subten> =
   case P_subten:
     if (alt == 0)               {  //\\    "@",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "&",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "⏨",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    "\u23E8",
       t[1] = wlit(P(1));
     } else if (alt == 4)        {  //\\    "\u2081\u2080",
       t[1] = wlit(P(1));
     } else                      {  //\\    "'10'";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<PLUS-MINUS-opt> =
   case P_PLUS_MINUS_opt:
     if (alt == 0)               {  //\\    "+" <PLUS-MINUS-opt>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_PLUS_MINUS_opt */);
     } else if (alt == 1)        {  //\\    "-" <PLUS-MINUS-opt>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_PLUS_MINUS_opt */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<logical_value> =
   case P_logical_value:
     if (alt == 0)               {  //\\    "t̲r̲u̲e̲",
       t[1] = wlit(P(1));
     } else                      {  //\\    "f̲a̲l̲s̲e̲";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<relational_operator> =
   case P_relational_operator:
     if (alt == 0)               {  //\\    "=",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "e̲q̲u̲a̲l̲",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "e̲q̲",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    ">=",
       t[1] = wlit(P(1));
     } else if (alt == 4)        {  //\\    "≥",
       t[1] = wlit(P(1));
     } else if (alt == 5)        {  //\\    "g̲e̲",
       t[1] = wlit(P(1));
     } else if (alt == 6)        {  //\\    "n̲o̲t̲l̲e̲s̲s̲",
       t[1] = wlit(P(1));
     } else if (alt == 7)        {  //\\    "g̲r̲e̲q̲",
       t[1] = wlit(P(1));
     } else if (alt == 8)        {  //\\    ">",
       t[1] = wlit(P(1));
     } else if (alt == 9)        {  //\\    "g̲t̲",
       t[1] = wlit(P(1));
     } else if (alt == 10)        {  //\\    "g̲r̲e̲a̲t̲e̲r̲",
       t[1] = wlit(P(1));
     } else if (alt == 11)        {  //\\    "<>",
       t[1] = wlit(P(1));
     } else if (alt == 12)        {  //\\    "#",
       t[1] = wlit(P(1));
     } else if (alt == 13)        {  //\\    "≠",
       t[1] = wlit(P(1));
     } else if (alt == 14)        {  //\\    "n̲e̲",
       t[1] = wlit(P(1));
     } else if (alt == 15)        {  //\\    "n̲o̲t̲e̲q̲u̲a̲l̲",
       t[1] = wlit(P(1));
     } else if (alt == 16)        {  //\\    "\=",
       t[1] = wlit(P(1));
     } else if (alt == 17)        {  //\\    "¬=",
       t[1] = wlit(P(1));
     } else if (alt == 18)        {  //\\    "!=",
       t[1] = wlit(P(1));
     } else if (alt == 19)        {  //\\    "^=",
       t[1] = wlit(P(1));
     } else if (alt == 20)        {  //\\    "|=",
       t[1] = wlit(P(1));
     } else if (alt == 21)        {  //\\    "<=",
       t[1] = wlit(P(1));
     } else if (alt == 22)        {  //\\    "≤",
       t[1] = wlit(P(1));
     } else if (alt == 23)        {  //\\    "l̲e̲s̲s̲e̲q̲",
       t[1] = wlit(P(1));
     } else if (alt == 24)        {  //\\    "n̲o̲t̲g̲r̲e̲a̲t̲e̲r̲",
       t[1] = wlit(P(1));
     } else if (alt == 25)        {  //\\    "<",
       t[1] = wlit(P(1));
     } else if (alt == 26)        {  //\\    "l̲t̲",
       t[1] = wlit(P(1));
     } else if (alt == 27)        {  //\\    "l̲e̲s̲s̲",
       t[1] = wlit(P(1));
     } else                      {  //\\    "l̲e̲";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<ARRAY-LB> =
   case P_ARRAY_LB:
     if (alt == 0)               {  //\\    '[',
       t[1] = wlit(P(1) /*, L'[' */);
     } else                      {  //\\    "(/";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<ARRAY-RB> =
   case P_ARRAY_RB:
     if (alt == 0)               {  //\\    ']',
       t[1] = wlit(P(1) /*, L']' */);
     } else                      {  //\\    "/)";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<relation> =
   case P_relation:
     {                              //\\    <arithmetic_expression> <relational_operator> <arithmetic_expression>;
     t[1] = compile(P(1), depth+1 /* P_arithmetic_expression */);
     t[2] = compile(P(2), depth+1 /* P_relational_operator */);
     t[3] = compile(P(3), depth+1 /* P_arithmetic_expression */);
     }
     return t[0];

//\\ P<Boolean_primary> =
   case P_Boolean_primary:
     if (alt == 0)               {  //\\    <relation>,
       t[1] = compile(P(1), depth+1 /* P_relation */);
     } else if (alt == 1)        {  //\\    <NAME> <ARRAY-LB> <ARRAY-INDEX> <ARRAY-INDICES> <ARRAY-RB>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
       t[2] = compile(P(2), depth+1 /* P_ARRAY_LB */);
       t[3] = compile(P(3), depth+1 /* P_ARRAY_INDEX */);
       t[4] = compile(P(4), depth+1 /* P_ARRAY_INDICES */);
       t[5] = compile(P(5), depth+1 /* P_ARRAY_RB */);
     } else if (alt == 2)        {  //\\    <function_designator>,
       t[1] = compile(P(1), depth+1 /* P_function_designator */);
     } else if (alt == 3)        {  //\\    <NAME>,
       t[1] = compile(P(1), depth+1 /* P_NAME */);
     } else if (alt == 4)        {  //\\    <logical_value>,
       t[1] = compile(P(1), depth+1 /* P_logical_value */);
     } else                      {  //\\    "(" <Boolean_expression> ")";
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_Boolean_expression */);
       t[3] = wlit(P(3));
     }
     return t[0];

//\\ P<not-term> =
   case P_not_term:
     if (alt == 0)               {  //\\    "n̲o̲t̲",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "¬",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "!",
       t[1] = wlit(P(1));
     } else                      {  //\\    "~";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<not-terms> =
   case P_not_terms:
     if (alt == 0)               {  //\\    <not-term> <not-terms>,
       t[1] = compile(P(1), depth+1 /* P_not_term */);
       t[2] = compile(P(2), depth+1 /* P_not_terms */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<Boolean_secondary> =
   case P_Boolean_secondary:
     if (alt == 0)               {  //\\    <not-term> <not-terms> <Boolean_primary>,
       t[1] = compile(P(1), depth+1 /* P_not_term */);
       t[2] = compile(P(2), depth+1 /* P_not_terms */);
       t[3] = compile(P(3), depth+1 /* P_Boolean_primary */);
     } else                      {  //\\    <Boolean_primary>;
       t[1] = compile(P(1), depth+1 /* P_Boolean_primary */);
     }
     return t[0];

//\\ P<and-term> =
   case P_and_term:
     if (alt == 0)               {  //\\    "a̲n̲d̲",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "∧",
       t[1] = wlit(P(1));
     } else                      {  //\\    "&";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<and_Boolean_factor> =
   case P_and_Boolean_factor:
     if (alt == 0)               {  //\\    <and-term> <Boolean_factor>,
       t[1] = compile(P(1), depth+1 /* P_and_term */);
       t[2] = compile(P(2), depth+1 /* P_Boolean_factor */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<Boolean_factor> =
   case P_Boolean_factor:
     {                              //\\    <Boolean_secondary> <and_Boolean_factor>;
     t[1] = compile(P(1), depth+1 /* P_Boolean_secondary */);
     t[2] = compile(P(2), depth+1 /* P_and_Boolean_factor */);
     }
     return t[0];

//\\ P<or-term> =
   case P_or_term:
     if (alt == 0)               {  //\\    "o̲r̲",
       t[1] = wlit(P(1));
     } else                      {  //\\    "∨";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<or_Boolean_term> =
   case P_or_Boolean_term:
     if (alt == 0)               {  //\\    <or-term> <Boolean_term>,
       t[1] = compile(P(1), depth+1 /* P_or_term */);
       t[2] = compile(P(2), depth+1 /* P_Boolean_term */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<Boolean_term> =
   case P_Boolean_term:
     {                              //\\    <Boolean_factor> <or_Boolean_term>;
     t[1] = compile(P(1), depth+1 /* P_Boolean_factor */);
     t[2] = compile(P(2), depth+1 /* P_or_Boolean_term */);
     }
     return t[0];

//\\ P<impl-term> =
   case P_impl_term:
     if (alt == 0)               {  //\\    "i̲m̲p̲l̲i̲e̲s̲",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "i̲m̲p̲l̲",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "i̲m̲p̲",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    "⊃",
       t[1] = wlit(P(1));
     } else if (alt == 4)        {  //\\    "\u2283",
       t[1] = wlit(P(1));
     } else                      {  //\\    "->";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<more_implication_Boolean> =
   case P_more_implication_Boolean:
     if (alt == 0)               {  //\\    <impl-term> <implication_Boolean>,
       t[1] = compile(P(1), depth+1 /* P_impl_term */);
       t[2] = compile(P(2), depth+1 /* P_implication_Boolean */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<implication_Boolean> =
   case P_implication_Boolean:
     {                              //\\    <Boolean_term> <more_implication_Boolean>;
     t[1] = compile(P(1), depth+1 /* P_Boolean_term */);
     t[2] = compile(P(2), depth+1 /* P_more_implication_Boolean */);
     }
     return t[0];

//\\ P<equiv-term> =
   case P_equiv_term:
     if (alt == 0)               {  //\\    "e̲q̲u̲i̲v̲",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "e̲q̲v̲",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "≡",
       t[1] = wlit(P(1));
     } else                      {  //\\    "==";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<equiv_simple_Boolean> =
   case P_equiv_simple_Boolean:
     if (alt == 0)               {  //\\    <equiv-term> <simple_Boolean>,
       t[1] = compile(P(1), depth+1 /* P_equiv_term */);
       t[2] = compile(P(2), depth+1 /* P_simple_Boolean */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<simple_Boolean> =
   case P_simple_Boolean:
     {                              //\\    <implication_Boolean> <equiv_simple_Boolean>;
     t[1] = compile(P(1), depth+1 /* P_implication_Boolean */);
     t[2] = compile(P(2), depth+1 /* P_equiv_simple_Boolean */);
     }
     return t[0];

//\\ P<Boolean_expression> =
   case P_Boolean_expression:
     if (alt == 0)               {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_Boolean> "e̲l̲s̲e̲" <Boolean_expression>,
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_Boolean_expression */);
       t[3] = wlit(P(3));
       t[4] = compile(P(4), depth+1 /* P_simple_Boolean */);
       t[5] = wlit(P(5));
       t[6] = compile(P(6), depth+1 /* P_Boolean_expression */);
     } else                      {  //\\    <simple_Boolean>;
       t[1] = compile(P(1), depth+1 /* P_simple_Boolean */);
     }
     return t[0];

//\\ P<ch> =
   case P_ch:
     if (alt == 0)               {  //\\    <stropped>,
       t[1] = compile(P(1), depth+1 /* P_stropped */);
     } else                      {  //\\    «.»;
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<stropped> =
   case P_stropped:
     {                              //\\    «(a̲|b̲|c̲|d̲|e̲|f̲|g̲|h̲|i̲|j̲|k̲|l̲|m̲|n̲|o̲|p̲|q̲|r̲|s̲|t̲|u̲|v̲|w̲|x̲|y̲|z̲|A̲|B̲|C̲|D̲|E̲|F̲|G̲|H̲|I̲|J̲|K̲|L̲|M̲|N̲|O̲|P̲|Q̲|R̲|S̲|T̲|U̲|V̲|W̲|X̲|Y̲|Z̲)»;
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<NAME> =
   case P_NAME:
     {                              //\\    <ALPHA> <ALPHANUMS>;
     t[1] = compile(P(1), depth+1 /* P_ALPHA */);
     t[2] = compile(P(2), depth+1 /* P_ALPHANUMS */);
     }
     return t[0];

//\\ P<ALPHANUMS> =
   case P_ALPHANUMS:
     if (alt == 0)               {  //\\    <ALPHANUM> <ALPHANUMS>,
       t[1] = compile(P(1), depth+1 /* P_ALPHANUM */);
       t[2] = compile(P(2), depth+1 /* P_ALPHANUMS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<ALPHA> =
   case P_ALPHA:
     {                              //\\    <!stropped> «[A-Za-z]»;
     /* ignore negative guard */;
     t[2] = wlit(P(2));
     }
     return t[0];

//\\ P<ALPHANUM> =
   case P_ALPHANUM:
     {                              //\\    <!stropped> «[A-Za-z0-9 ]»;
     /* ignore negative guard */;
     t[2] = wlit(P(2));
     }
     return t[0];

//\\ P<DIGITS> =
   case P_DIGITS:
     {                              //\\    <DIGIT> <MORE-DIGITS>;
     t[1] = compile(P(1), depth+1 /* P_DIGIT */);
     t[2] = compile(P(2), depth+1 /* P_MORE_DIGITS */);
     }
     return t[0];

//\\ P<DIGIT> =
   case P_DIGIT:
     {                              //\\    «[0-9]»;
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<MORE-DIGITS> =
   case P_MORE_DIGITS:
     if (alt == 0)               {  //\\    <DIGIT> <MORE-DIGITS>,
       t[1] = compile(P(1), depth+1 /* P_DIGIT */);
       t[2] = compile(P(2), depth+1 /* P_MORE_DIGITS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<string_literal> =
   case P_string_literal:
     if (alt == 0)               {  //\\    <BALANCED-STRING>,
       t[1] = compile(P(1), depth+1 /* P_BALANCED_STRING */);
     } else                      {  //\\    <C-STRING>;
       t[1] = compile(P(1), depth+1 /* P_C_STRING */);
     }
     return t[0];

//\\ P<dchs> =
   case P_dchs:
     if (alt == 0)               {  //\\    <dch> <dchs>,
       t[1] = compile(P(1), depth+1 /* P_dch */);
       t[2] = compile(P(2), depth+1 /* P_dchs */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<dch> =
   case P_dch:
     {                              //\\    <!rdquo> <ch>;
     /* ignore negative guard */;
     t[2] = compile(P(2), depth+1 /* P_ch */);
     }
     return t[0];

//\\ P<ldquo> =
   case P_ldquo:
     if (alt == 0)               {  //\\    "“",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    '{',
       t[1] = wlit(P(1) /*, L'{' */);
     } else if (alt == 2)        {  //\\    "‘",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    "'('",
       t[1] = wlit(P(1));
     } else if (alt == 4)        {  //\\    "«",
       t[1] = wlit(P(1));
     } else if (alt == 5)        {  //\\    "|<",
       t[1] = wlit(P(1));
     } else if (alt == 6)        {  //\\    "<",
       t[1] = wlit(P(1));
     } else                      {  //\\    "«";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<rdquo> =
   case P_rdquo:
     if (alt == 0)               {  //\\    "”",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    '}',
       t[1] = wlit(P(1) /*, L'}' */);
     } else if (alt == 2)        {  //\\    "’",
       t[1] = wlit(P(1));
     } else if (alt == 3)        {  //\\    "')'",
       t[1] = wlit(P(1));
     } else if (alt == 4)        {  //\\    "»",
       t[1] = wlit(P(1));
     } else if (alt == 5)        {  //\\    "|>",
       t[1] = wlit(P(1));
     } else if (alt == 6)        {  //\\    ">",
       t[1] = wlit(P(1));
     } else                      {  //\\    "»";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<BALANCED-STRING> =
   case P_BALANCED_STRING:
     {                              //\\    <ldquo> <BALANCED-CHAR-SEQUENCE> <rdquo>;
     t[1] = compile(P(1), depth+1 /* P_ldquo */);
     t[2] = compile(P(2), depth+1 /* P_BALANCED_CHAR_SEQUENCE */);
     t[3] = compile(P(3), depth+1 /* P_rdquo */);
     }
     return t[0];

//\\ P<BALANCED-CHAR-SEQUENCE> =
   case P_BALANCED_CHAR_SEQUENCE:
     if (alt == 0)               {  //\\    <BALANCED-CHAR> <BALANCED-CHAR-SEQUENCE>,
       t[1] = compile(P(1), depth+1 /* P_BALANCED_CHAR */);
       t[2] = compile(P(2), depth+1 /* P_BALANCED_CHAR_SEQUENCE */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<BALANCED-CHAR> =
   case P_BALANCED_CHAR:
     if (alt == 0)               {  //\\    <BALANCED-STRING>,
       t[1] = compile(P(1), depth+1 /* P_BALANCED_STRING */);
     } else                      {  //\\    <!rdquo> <ch>;
       /* ignore negative guard */;
       t[2] = compile(P(2), depth+1 /* P_ch */);
     }
     return t[0];

//\\ P<RB> =
   case P_RB:
     {                              //\\    '>';
     t[1] = wlit(P(1) /*, L'>' */);
     }
     return t[0];

//\\ P<C-STRING> =
   case P_C_STRING:
     if (alt == 0)               {  //\\    '"' <C-CHARS> '"',
       t[1] = wlit(P(1) /*, L'"' */);
       t[2] = compile(P(2), depth+1 /* P_C_CHARS */);
       t[3] = wlit(P(3) /*, L'"' */);
     } else if (alt == 1)        {  //\\    "``" «[^']*» "''",
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = wlit(P(3));
     } else                      {  //\\    "`" «[^']*» "'";
       t[1] = wlit(P(1));
       t[2] = wlit(P(2));
       t[3] = wlit(P(3));
     }
     return t[0];

//\\ P<C-CHARS> =
   case P_C_CHARS:
     if (alt == 0)               {  //\\    <stropped> <C-CHARS>,
       t[1] = compile(P(1), depth+1 /* P_stropped */);
       t[2] = compile(P(2), depth+1 /* P_C_CHARS */);
     } else if (alt == 1)        {  //\\    <!dquote> <ch> <C-CHARS>,
       /* ignore negative guard */;
       t[2] = compile(P(2), depth+1 /* P_ch */);
       t[3] = compile(P(3), depth+1 /* P_C_CHARS */);
     } else if (alt == 2)        {  //\\    '"' '"' <C-CHARS>,
       t[1] = wlit(P(1) /*, L'"' */);
       t[2] = wlit(P(2) /*, L'"' */);
       t[3] = compile(P(3), depth+1 /* P_C_CHARS */);
     } else if (alt == 3)        {  //\\    '\' <ch> <C-CHARS>,
       t[1] = wlit(P(1) /*, L'\\' */);
       t[2] = compile(P(2), depth+1 /* P_ch */);
       t[3] = compile(P(3), depth+1 /* P_C_CHARS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<dquote> =
   case P_dquote:
     {                              //\\    '"';
     t[1] = wlit(P(1) /*, L'"' */);
     }
     return t[0];

//\\ P<closer> =
   case P_closer:
     if (alt == 0)               {  //\\    <semi>,
       t[1] = compile(P(1), depth+1 /* P_semi */);
     } else if (alt == 1)        {  //\\    <comma>,
       t[1] = compile(P(1), depth+1 /* P_comma */);
     } else if (alt == 2)        {  //\\    <rb>,
       t[1] = compile(P(1), depth+1 /* P_rb */);
     } else if (alt == 3)        {  //\\    <end>,
       t[1] = compile(P(1), depth+1 /* P_end */);
     } else if (alt == 4)        {  //\\    <else>,
       t[1] = compile(P(1), depth+1 /* P_else */);
     } else                      {  //\\    <then>;
       t[1] = compile(P(1), depth+1 /* P_then */);
     }
     return t[0];

//\\ P<semi> =
   case P_semi:
     {                              //\\    ";";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<comma> =
   case P_comma:
     {                              //\\    ",";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<rb> =
   case P_rb:
     {                              //\\    ")";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<end> =
   case P_end:
     {                              //\\    "e̲n̲d̲";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<else> =
   case P_else:
     {                              //\\    "e̲l̲s̲e̲";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<then> =
   case P_then:
     {                              //\\    "t̲h̲e̲n̲";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<ENDTEXT> =
   case P_ENDTEXT:
     if (alt == 0)               {  //\\    <!semi> <!end> <!else> <ch> <ENDTEXT>,
       /* ignore negative guard */;
       /* ignore negative guard */;
       /* ignore negative guard */;
       t[4] = compile(P(4), depth+1 /* P_ch */);
       t[5] = compile(P(5), depth+1 /* P_ENDTEXT */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<stropped-keywords> =
   case P_stropped_keywords:
     {                              //\\    "'";
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<optional-stropping-conversion> =
   case P_optional_stropping_conversion:
     if (alt == 0)               {  //\\    <?stropped-keywords> <convert-keywords>,
       /* ignore guard */;
       /* semantic procedure convert-keywords */;
     } else                      {  //\\    ;

     }
     return t[0];

//\\ E
   default:
     return r;
  }
}
