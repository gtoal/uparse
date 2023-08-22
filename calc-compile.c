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

//\\ P<any> =
   case P_any:
     {                              //\\    «.»;
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<EOF> =
   case P_EOF:
     {                              //\\    <!any> "";
     /* ignore negative guard */;
     t[2] = wlit(P(2));
     }
     return t[0];

//\\ P<SS> =
   case P_SS:
     {                              //\\    <EXPRS> <EOF>;
     t[1] = compile(P(1), depth+1 /* P_EXPRS */);
     t[2] = compile(P(2), depth+1 /* P_EOF */);
     }
     return t[0];

//\\ P<EXPRS> =
   case P_EXPRS:
     {                              //\\    <SETVAR> "=" <EXPR> ";" <MORE-EXPRS>;
     t[1] = compile(P(1), depth+1 /* P_SETVAR */);
     t[2] = wlit(P(2));
     t[3] = compile(P(3), depth+1 /* P_EXPR */);
     t[4] = wlit(P(4));
     t[5] = compile(P(5), depth+1 /* P_MORE_EXPRS */);
     }
     return t[0];

//\\ P<MORE-EXPRS> =
   case P_MORE_EXPRS:
     if (alt == 0)               {  //\\    <EXPRS>,
       t[1] = compile(P(1), depth+1 /* P_EXPRS */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<EXPR> =
   case P_EXPR:
     {                              //\\    <OPT-MONOP> <TERM> <MORE-TERMS>;
     t[1] = compile(P(1), depth+1 /* P_OPT_MONOP */);
     t[2] = compile(P(2), depth+1 /* P_TERM */);
     t[3] = compile(P(3), depth+1 /* P_MORE_TERMS */);
     }
     return t[0];

//\\ P<MORE-TERMS> =
   case P_MORE_TERMS:
     if (alt == 0)               {  //\\    <OP> <EXPR>,
       t[1] = compile(P(1), depth+1 /* P_OP */);
       t[2] = compile(P(2), depth+1 /* P_EXPR */);
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<TERM> =
   case P_TERM:
     if (alt == 0)               {  //\\    <VAR>,
       t[1] = compile(P(1), depth+1 /* P_VAR */);
     } else if (alt == 1)        {  //\\    <NUM>,
       t[1] = compile(P(1), depth+1 /* P_NUM */);
     } else                      {  //\\    "(" <EXPR> ")";
       t[1] = wlit(P(1));
       t[2] = compile(P(2), depth+1 /* P_EXPR */);
       t[3] = wlit(P(3));
     }
     return t[0];

//\\ P<OP> =
   case P_OP:
     if (alt == 0)               {  //\\    "*",
       t[1] = wlit(P(1));
     } else if (alt == 1)        {  //\\    "/",
       t[1] = wlit(P(1));
     } else if (alt == 2)        {  //\\    "+",
       t[1] = wlit(P(1));
     } else                      {  //\\    "-";
       t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<OPT-MONOP> =
   case P_OPT_MONOP:
     if (alt == 0)               {  //\\    "-",
       t[1] = wlit(P(1));
     } else                      {  //\\    ;

     }
     return t[0];

//\\ P<NUM> =
   case P_NUM:
     {                              //\\    «[1-9][0-9]*»;
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<VAR> =
   case P_VAR:
     {                              //\\    «[A-Za-z][A-Za-z]*»;
     t[1] = wlit(P(1));
     }
     return t[0];

//\\ P<SETVAR> =
   case P_SETVAR:
     {                              //\\    <VAR>;
     t[1] = compile(P(1), depth+1 /* P_VAR */);
     }
     return t[0];

//\\ E
   default:
     return r;
  }
}
