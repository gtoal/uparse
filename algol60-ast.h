//\\ B<EOF> = 0;
//\\#
//\\ B<nl> = 2;
//\\#
//\\ P<SS> =
   case G_SS:
                                    //\\    <init> <optional_stropping_conversion> <SOURCE> <terminate>;
     T[++phrases] = -1 +(0 * P++) /* S_init */ /* semantic call - temp for now. Could theoretically return a string like a terminal. Parser needs to insert something in CST. */;
     T[++phrases] = build_ast(CST(P++) /* G_optional_stropping_conversion */);
     T[++phrases] = build_ast(CST(P++) /* G_SOURCE */);
     T[++phrases] = -1 +(0 * P++) /* S_terminate */ /* semantic call - temp for now. Could theoretically return a string like a terminal. Parser needs to insert something in CST. */;
     return T[0] = mktuple(G_SS, alt, phrases, T);

//\\ P<SOURCE> =
   case G_SOURCE:
     if (alt == 0)               {  //\\    <MAIN_PROGRAM> <semi_opt> <EOF>,
       T[++phrases] = build_ast(CST(P++) /* G_MAIN_PROGRAM */);
       T[++phrases] = build_ast(CST(P++) /* G_semi_opt */);
       T[++phrases] = BIP(CST(P++), B_EOF);
     } else                      {  //\\    <EXTERNAL_LEVEL_OBJECTS> <EOF>;
       T[++phrases] = build_ast(CST(P++) /* G_EXTERNAL_LEVEL_OBJECTS */);
       T[++phrases] = BIP(CST(P++), B_EOF);
     }
     return T[0] = mktuple(G_SOURCE, alt, phrases, T);

//\\ P<semi_opt> =
   case G_semi_opt:
     if (alt == 0)               {  //\\    ';',
       T[++phrases] = ch(CST(P++), ';');
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_semi_opt, alt, phrases, T);

//\\ P<MAIN-PROGRAM> =
   case G_MAIN_PROGRAM:
                                    //\\    <PROGRAM_opt> <COMMENTS_opt> "b̲e̲g̲i̲n̲" <LOCAL_BLOCK> "e̲n̲d̲" <ENDTEXT>;
     T[++phrases] = build_ast(CST(P++) /* G_PROGRAM_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_COMMENTS_opt */);
     T[++phrases] = kw(CST(P++), "b̲e̲g̲i̲n̲");
     T[++phrases] = build_ast(CST(P++) /* G_LOCAL_BLOCK */);
     T[++phrases] = kw(CST(P++), "e̲n̲d̲");
     T[++phrases] = build_ast(CST(P++) /* G_ENDTEXT */);
     return T[0] = mktuple(G_MAIN_PROGRAM, alt, phrases, T);

//\\ P<PROGRAM_opt> =
   case G_PROGRAM_opt:
     if (alt == 0)               {  //\\    "p̲r̲o̲g̲r̲a̲m̲" <NAME> ';',
       T[++phrases] = kw(CST(P++), "p̲r̲o̲g̲r̲a̲m̲");
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = ch(CST(P++), ';');
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_PROGRAM_opt, alt, phrases, T);

//\\ P<EXTERNAL-LEVEL-OBJECTS> =
   case G_EXTERNAL_LEVEL_OBJECTS:
     if (alt == 0)               {  //\\    <EXTERNAL_LEVEL> <EXTERNAL_LEVEL_OBJECTS>,
       T[++phrases] = build_ast(CST(P++) /* G_EXTERNAL_LEVEL */);
       T[++phrases] = build_ast(CST(P++) /* G_EXTERNAL_LEVEL_OBJECTS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_EXTERNAL_LEVEL_OBJECTS, alt, phrases, T);

//\\ P<EXTERNAL-LEVEL> =
   case G_EXTERNAL_LEVEL:
     if (alt == 0)               {  //\\    "e̲o̲p̲",
       T[++phrases] = kw(CST(P++), "e̲o̲p̲");
     } else if (alt == 1)        {  //\\    "c̲o̲d̲e̲" <DIGITS> ';',
       T[++phrases] = kw(CST(P++), "c̲o̲d̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_DIGITS */);
       T[++phrases] = ch(CST(P++), ';');
     } else if (alt == 2)        {  //\\    <COMMENT>,
       T[++phrases] = build_ast(CST(P++) /* G_COMMENT */);
     } else if (alt == 3)        {  //\\    <PROCEDURE> ';',
       T[++phrases] = build_ast(CST(P++) /* G_PROCEDURE */);
       T[++phrases] = ch(CST(P++), ';');
     } else                      {  //\\    <OWN_DECLARATION> ';';
       T[++phrases] = build_ast(CST(P++) /* G_OWN_DECLARATION */);
       T[++phrases] = ch(CST(P++), ';');
     }
     return T[0] = mktuple(G_EXTERNAL_LEVEL, alt, phrases, T);

//\\ P<PROCTYPE_opt> =
   case G_PROCTYPE_opt:
     if (alt == 0)               {  //\\    "i̲n̲t̲e̲g̲e̲r̲",
       T[++phrases] = kw(CST(P++), "i̲n̲t̲e̲g̲e̲r̲");
     } else if (alt == 1)        {  //\\    "r̲e̲a̲l̲",
       T[++phrases] = kw(CST(P++), "r̲e̲a̲l̲");
     } else if (alt == 2)        {  //\\    <BOOLEAN>,
       T[++phrases] = build_ast(CST(P++) /* G_BOOLEAN */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_PROCTYPE_opt, alt, phrases, T);

//\\ P<BOOLEAN> =
   case G_BOOLEAN:
     if (alt == 0)               {  //\\    "B̲o̲o̲l̲e̲a̲n̲",
       T[++phrases] = kw(CST(P++), "B̲o̲o̲l̲e̲a̲n̲");
     } else                      {  //\\    "b̲o̲o̲l̲e̲a̲n̲";
       T[++phrases] = kw(CST(P++), "b̲o̲o̲l̲e̲a̲n̲");
     }
     return T[0] = mktuple(G_BOOLEAN, alt, phrases, T);

//\\ P<PROCEDURE> =
   case G_PROCEDURE:
                                    //\\    <PROCTYPE_opt> "p̲r̲o̲c̲e̲d̲u̲r̲e̲" <NAME> <FORMAL_PARAMS_opt> ';' <COMMENTS_opt> <VALUE_opt> <PARAMETER_TYPES_opt> <LABELS_opt> <PROCBODY>;
     T[++phrases] = build_ast(CST(P++) /* G_PROCTYPE_opt */);
     T[++phrases] = kw(CST(P++), "p̲r̲o̲c̲e̲d̲u̲r̲e̲");
     T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     T[++phrases] = build_ast(CST(P++) /* G_FORMAL_PARAMS_opt */);
     T[++phrases] = ch(CST(P++), ';');
     T[++phrases] = build_ast(CST(P++) /* G_COMMENTS_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_VALUE_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_PARAMETER_TYPES_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_PROCBODY */);
     return T[0] = mktuple(G_PROCEDURE, alt, phrases, T);

//\\ P<FORMAL_PARAMS_opt> =
   case G_FORMAL_PARAMS_opt:
     if (alt == 0)               {  //\\    "(" <NAME> <MORE_FP_LIST> ")",
       T[++phrases] = kw(CST(P++), "(");
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_FP_LIST */);
       T[++phrases] = kw(CST(P++), ")");
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_FORMAL_PARAMS_opt, alt, phrases, T);

//\\ P<MORE-FP-LIST> =
   case G_MORE_FP_LIST:
     if (alt == 0)               {  //\\    <FPSEP> <FORMAL_PARAMETER> <MORE_FP_LIST>,
       T[++phrases] = build_ast(CST(P++) /* G_FPSEP */);
       T[++phrases] = build_ast(CST(P++) /* G_FORMAL_PARAMETER */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_FP_LIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_FP_LIST, alt, phrases, T);

//\\ P<FORMAL-PARAMETER> =
   case G_FORMAL_PARAMETER:
                                    //\\    <NAME>;
     T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     return T[0] = mktuple(G_FORMAL_PARAMETER, alt, phrases, T);

//\\ P<VALUE_opt> =
   case G_VALUE_opt:
     if (alt == 0)               {  //\\    "v̲a̲l̲u̲e̲" <VALUE_NAMELIST> ';',
       T[++phrases] = kw(CST(P++), "v̲a̲l̲u̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_VALUE_NAMELIST */);
       T[++phrases] = ch(CST(P++), ';');
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_VALUE_opt, alt, phrases, T);

//\\ P<VALUE-NAMELIST> =
   case G_VALUE_NAMELIST:
                                    //\\    <VALUE_NAME> <MORE_VALUE_NAMELIST>;
     T[++phrases] = build_ast(CST(P++) /* G_VALUE_NAME */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_VALUE_NAMELIST */);
     return T[0] = mktuple(G_VALUE_NAMELIST, alt, phrases, T);

//\\ P<MORE-VALUE-NAMELIST> =
   case G_MORE_VALUE_NAMELIST:
     if (alt == 0)               {  //\\    "," <VALUE_NAMELIST>,
       T[++phrases] = kw(CST(P++), ",");
       T[++phrases] = build_ast(CST(P++) /* G_VALUE_NAMELIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_VALUE_NAMELIST, alt, phrases, T);

//\\ P<VALUE-NAME> =
   case G_VALUE_NAME:
                                    //\\    <NAME>;
     T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     return T[0] = mktuple(G_VALUE_NAME, alt, phrases, T);

//\\ P<COMMENT-NO-SEMI> =
   case G_COMMENT_NO_SEMI:
                                    //\\    "c̲o̲m̲m̲e̲n̲t̲" <COMMENTTEXT>;
     T[++phrases] = kw(CST(P++), "c̲o̲m̲m̲e̲n̲t̲");
     T[++phrases] = build_ast(CST(P++) /* G_COMMENTTEXT */);
     return T[0] = mktuple(G_COMMENT_NO_SEMI, alt, phrases, T);

//\\ P<COMMENT> =
   case G_COMMENT:
                                    //\\    <COMMENT_NO_SEMI> ';';
     T[++phrases] = build_ast(CST(P++) /* G_COMMENT_NO_SEMI */);
     T[++phrases] = ch(CST(P++), ';');
     return T[0] = mktuple(G_COMMENT, alt, phrases, T);

//\\ P<COMMENTS_opt> =
   case G_COMMENTS_opt:
     if (alt == 0)               {  //\\    <COMMENT> <MORE_COMMENTS>,
       T[++phrases] = build_ast(CST(P++) /* G_COMMENT */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_COMMENTS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_COMMENTS_opt, alt, phrases, T);

//\\ P<MORE-COMMENTS> =
   case G_MORE_COMMENTS:
     if (alt == 0)               {  //\\    ';' <COMMENT> <MORE_COMMENTS>,
       T[++phrases] = ch(CST(P++), ';');
       T[++phrases] = build_ast(CST(P++) /* G_COMMENT */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_COMMENTS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_COMMENTS, alt, phrases, T);

//\\ P<COMMENTTEXT> =
   case G_COMMENTTEXT:
                                    //\\    <NONSEMITEXT> <OPT_MORELINES>;
     T[++phrases] = build_ast(CST(P++) /* G_NONSEMITEXT */);
     T[++phrases] = build_ast(CST(P++) /* G_OPT_MORELINES */);
     return T[0] = mktuple(G_COMMENTTEXT, alt, phrases, T);

//\\ P<NONSEMITEXT> =
   case G_NONSEMITEXT:
                                    //\\    «[^;]*»;
     T[++phrases] = reg(CST(P++), "[^;]*");
     return T[0] = mktuple(G_NONSEMITEXT, alt, phrases, T);

//\\ P<OPT-MORELINES> =
   case G_OPT_MORELINES:
     if (alt == 0)               {  //\\    <EOF> <NONSEMITEXT> <OPT_MORELINES>,
       T[++phrases] = BIP(CST(P++), B_EOF);
       T[++phrases] = build_ast(CST(P++) /* G_NONSEMITEXT */);
       T[++phrases] = build_ast(CST(P++) /* G_OPT_MORELINES */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_OPT_MORELINES, alt, phrases, T);

//\\ P<LABELS_opt> =
   case G_LABELS_opt:
     if (alt == 0)               {  //\\    <NAME> <!assign> ":" <!comment_keyword> <LABELS_opt>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = -1 +(0 * P++);
       T[++phrases] = kw(CST(P++), ":");
       T[++phrases] = -1 +(0 * P++);
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_LABELS_opt, alt, phrases, T);

//\\ P<comment-keyword> =
   case G_comment_keyword:
                                    //\\    "c̲o̲m̲m̲e̲n̲t̲";
     T[++phrases] = kw(CST(P++), "c̲o̲m̲m̲e̲n̲t̲");
     return T[0] = mktuple(G_comment_keyword, alt, phrases, T);

//\\ P<assign> =
   case G_assign:
                                    //\\    ":=";
     T[++phrases] = kw(CST(P++), ":=");
     return T[0] = mktuple(G_assign, alt, phrases, T);

//\\ P<PARAMETER-TYPES_opt> =
   case G_PARAMETER_TYPES_opt:
     if (alt == 0)               {  //\\    <PARAMETER_TYPE> ';' <PARAMETER_TYPES_opt>,
       T[++phrases] = build_ast(CST(P++) /* G_PARAMETER_TYPE */);
       T[++phrases] = ch(CST(P++), ';');
       T[++phrases] = build_ast(CST(P++) /* G_PARAMETER_TYPES_opt */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_PARAMETER_TYPES_opt, alt, phrases, T);

//\\ P<PARAMETER-TYPE> =
   case G_PARAMETER_TYPE:
     if (alt == 0)               {  //\\    "l̲a̲b̲e̲l̲" <DECLIST>,
       T[++phrases] = kw(CST(P++), "l̲a̲b̲e̲l̲");
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     } else if (alt == 1)        {  //\\    "s̲w̲i̲t̲c̲h̲" <DECLIST>,
       T[++phrases] = kw(CST(P++), "s̲w̲i̲t̲c̲h̲");
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     } else if (alt == 2)        {  //\\    "s̲t̲r̲i̲n̲g̲" <DECLIST>,
       T[++phrases] = kw(CST(P++), "s̲t̲r̲i̲n̲g̲");
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     } else if (alt == 3)        {  //\\    "i̲n̲t̲e̲g̲e̲r̲" <PDECLN>,
       T[++phrases] = kw(CST(P++), "i̲n̲t̲e̲g̲e̲r̲");
       T[++phrases] = build_ast(CST(P++) /* G_PDECLN */);
     } else if (alt == 4)        {  //\\    "r̲e̲a̲l̲" <PDECLN>,
       T[++phrases] = kw(CST(P++), "r̲e̲a̲l̲");
       T[++phrases] = build_ast(CST(P++) /* G_PDECLN */);
     } else if (alt == 5)        {  //\\    <BOOLEAN> <PDECLN>,
       T[++phrases] = build_ast(CST(P++) /* G_BOOLEAN */);
       T[++phrases] = build_ast(CST(P++) /* G_PDECLN */);
     } else if (alt == 6)        {  //\\    <PDECLN>,
       T[++phrases] = build_ast(CST(P++) /* G_PDECLN */);
     } else                      {  //\\    <COMMENT_NO_SEMI>;
       T[++phrases] = build_ast(CST(P++) /* G_COMMENT_NO_SEMI */);
     }
     return T[0] = mktuple(G_PARAMETER_TYPE, alt, phrases, T);

//\\ P<PDECLN> =
   case G_PDECLN:
     if (alt == 0)               {  //\\    "a̲r̲r̲a̲y̲" <DECLIST>,
       T[++phrases] = kw(CST(P++), "a̲r̲r̲a̲y̲");
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     } else if (alt == 1)        {  //\\    "p̲r̲o̲c̲e̲d̲u̲r̲e̲" <DECLIST>,
       T[++phrases] = kw(CST(P++), "p̲r̲o̲c̲e̲d̲u̲r̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     } else                      {  //\\    <DECLIST>;
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     }
     return T[0] = mktuple(G_PDECLN, alt, phrases, T);

//\\ P<DECLIST> =
   case G_DECLIST:
                                    //\\    <NAME> <MORE_DECLIST>;
     T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_DECLIST */);
     return T[0] = mktuple(G_DECLIST, alt, phrases, T);

//\\ P<MORE-DECLIST> =
   case G_MORE_DECLIST:
     if (alt == 0)               {  //\\    "," <NAME> <MORE_DECLIST>,
       T[++phrases] = kw(CST(P++), ",");
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_DECLIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_DECLIST, alt, phrases, T);

//\\ P<LOCAL-DECLARATION> =
   case G_LOCAL_DECLARATION:
     if (alt == 0)               {  //\\    "i̲n̲t̲e̲g̲e̲r̲" <LOCAL_ARRAY_DECLN>,
       T[++phrases] = kw(CST(P++), "i̲n̲t̲e̲g̲e̲r̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_ARRAY_DECLN */);
     } else if (alt == 1)        {  //\\    "i̲n̲t̲e̲g̲e̲r̲" <LOCAL_SCALAR_DECLN>,
       T[++phrases] = kw(CST(P++), "i̲n̲t̲e̲g̲e̲r̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_SCALAR_DECLN */);
     } else if (alt == 2)        {  //\\    "r̲e̲a̲l̲" <LOCAL_ARRAY_DECLN>,
       T[++phrases] = kw(CST(P++), "r̲e̲a̲l̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_ARRAY_DECLN */);
     } else if (alt == 3)        {  //\\    <LOCAL_ARRAY_DECLN>,
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_ARRAY_DECLN */);
     } else if (alt == 4)        {  //\\    "r̲e̲a̲l̲" <LOCAL_SCALAR_DECLN>,
       T[++phrases] = kw(CST(P++), "r̲e̲a̲l̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_SCALAR_DECLN */);
     } else if (alt == 5)        {  //\\    <BOOLEAN> <LOCAL_ARRAY_DECLN>,
       T[++phrases] = build_ast(CST(P++) /* G_BOOLEAN */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_ARRAY_DECLN */);
     } else if (alt == 6)        {  //\\    <BOOLEAN> <LOCAL_SCALAR_DECLN>,
       T[++phrases] = build_ast(CST(P++) /* G_BOOLEAN */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_SCALAR_DECLN */);
     } else                      {  //\\    "s̲w̲i̲t̲c̲h̲" <NAME> ":=" <SWITCH_DECLS>;
       T[++phrases] = kw(CST(P++), "s̲w̲i̲t̲c̲h̲");
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = kw(CST(P++), ":=");
       T[++phrases] = build_ast(CST(P++) /* G_SWITCH_DECLS */);
     }
     return T[0] = mktuple(G_LOCAL_DECLARATION, alt, phrases, T);

//\\ P<SWITCH-DECLS> =
   case G_SWITCH_DECLS:
                                    //\\    <SWITCH_DECL> <MORE_SWITCH_DECLS>;
     T[++phrases] = build_ast(CST(P++) /* G_SWITCH_DECL */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_SWITCH_DECLS */);
     return T[0] = mktuple(G_SWITCH_DECLS, alt, phrases, T);

//\\ P<MORE-SWITCH-DECLS> =
   case G_MORE_SWITCH_DECLS:
     if (alt == 0)               {  //\\    ',' <SWITCH_DECL> <MORE_SWITCH_DECLS>,
       T[++phrases] = ch(CST(P++), ',');
       T[++phrases] = build_ast(CST(P++) /* G_SWITCH_DECL */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_SWITCH_DECLS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_SWITCH_DECLS, alt, phrases, T);

//\\ P<SWITCH-DECL> =
   case G_SWITCH_DECL:
     if (alt == 0)               {  //\\    <DECLIST> <ARRAY_LB> <CONST_EXPR> <ARRAY_RB>,
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_LB */);
       T[++phrases] = build_ast(CST(P++) /* G_CONST_EXPR */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_RB */);
     } else if (alt == 1)        {  //\\    <DECLIST>,
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     } else                      {  //\\    <LEXPR>;
       T[++phrases] = build_ast(CST(P++) /* G_LEXPR */);
     }
     return T[0] = mktuple(G_SWITCH_DECL, alt, phrases, T);

//\\ P<OPT-ARRAY> =
   case G_OPT_ARRAY:
     if (alt == 0)               {  //\\    <ARRAY_LB> <CONST_EXPR> <ARRAY_RB>,
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_LB */);
       T[++phrases] = build_ast(CST(P++) /* G_CONST_EXPR */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_RB */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_OPT_ARRAY, alt, phrases, T);

//\\ P<JUMP-TARGET> =
   case G_JUMP_TARGET:
                                    //\\    <LEXPR>;
     T[++phrases] = build_ast(CST(P++) /* G_LEXPR */);
     return T[0] = mktuple(G_JUMP_TARGET, alt, phrases, T);

//\\ P<LEXPR> =
   case G_LEXPR:
     if (alt == 0)               {  //\\    '(' <LEXPR> ')',
       T[++phrases] = ch(CST(P++), '(');
       T[++phrases] = build_ast(CST(P++) /* G_LEXPR */);
       T[++phrases] = ch(CST(P++), ')');
     } else if (alt == 1)        {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <SLEXPR> "e̲l̲s̲e̲" <LEXPR>,
       T[++phrases] = kw(CST(P++), "i̲f̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = kw(CST(P++), "t̲h̲e̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_SLEXPR */);
       T[++phrases] = kw(CST(P++), "e̲l̲s̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_LEXPR */);
     } else                      {  //\\    <SLEXPR>;
       T[++phrases] = build_ast(CST(P++) /* G_SLEXPR */);
     }
     return T[0] = mktuple(G_LEXPR, alt, phrases, T);

//\\ P<SLEXPR> =
   case G_SLEXPR:
     if (alt == 0)               {  //\\    <NAME> <OPT_ARRAY>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = build_ast(CST(P++) /* G_OPT_ARRAY */);
     } else                      {  //\\    "(" <LEXPR> ")";
       T[++phrases] = kw(CST(P++), "(");
       T[++phrases] = build_ast(CST(P++) /* G_LEXPR */);
       T[++phrases] = kw(CST(P++), ")");
     }
     return T[0] = mktuple(G_SLEXPR, alt, phrases, T);

//\\ P<OWN-DECLARATION> =
   case G_OWN_DECLARATION:
     if (alt == 0)               {  //\\    "o̲w̲n̲" "i̲n̲t̲e̲g̲e̲r̲" <OWN_ARRAY_DECLN>,
       T[++phrases] = kw(CST(P++), "o̲w̲n̲");
       T[++phrases] = kw(CST(P++), "i̲n̲t̲e̲g̲e̲r̲");
       T[++phrases] = build_ast(CST(P++) /* G_OWN_ARRAY_DECLN */);
     } else if (alt == 1)        {  //\\    "o̲w̲n̲" "i̲n̲t̲e̲g̲e̲r̲" <LOCAL_SCALAR_DECLN>,
       T[++phrases] = kw(CST(P++), "o̲w̲n̲");
       T[++phrases] = kw(CST(P++), "i̲n̲t̲e̲g̲e̲r̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_SCALAR_DECLN */);
     } else if (alt == 2)        {  //\\    "o̲w̲n̲" "r̲e̲a̲l̲" <OWN_ARRAY_DECLN>,
       T[++phrases] = kw(CST(P++), "o̲w̲n̲");
       T[++phrases] = kw(CST(P++), "r̲e̲a̲l̲");
       T[++phrases] = build_ast(CST(P++) /* G_OWN_ARRAY_DECLN */);
     } else if (alt == 3)        {  //\\    "o̲w̲n̲" <OWN_ARRAY_DECLN>,
       T[++phrases] = kw(CST(P++), "o̲w̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_OWN_ARRAY_DECLN */);
     } else if (alt == 4)        {  //\\    "o̲w̲n̲" "r̲e̲a̲l̲" <LOCAL_SCALAR_DECLN>,
       T[++phrases] = kw(CST(P++), "o̲w̲n̲");
       T[++phrases] = kw(CST(P++), "r̲e̲a̲l̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_SCALAR_DECLN */);
     } else if (alt == 5)        {  //\\    "o̲w̲n̲" <BOOLEAN> <OWN_ARRAY_DECLN>,
       T[++phrases] = kw(CST(P++), "o̲w̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_BOOLEAN */);
       T[++phrases] = build_ast(CST(P++) /* G_OWN_ARRAY_DECLN */);
     } else                      {  //\\    "o̲w̲n̲" <BOOLEAN> <LOCAL_SCALAR_DECLN>;
       T[++phrases] = kw(CST(P++), "o̲w̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_BOOLEAN */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_SCALAR_DECLN */);
     }
     return T[0] = mktuple(G_OWN_DECLARATION, alt, phrases, T);

//\\ P<OWN-ARRAY-DECLN> =
   case G_OWN_ARRAY_DECLN:
                                    //\\    "a̲r̲r̲a̲y̲" <OWN_BOUNDED_DECLIST>;
     T[++phrases] = kw(CST(P++), "a̲r̲r̲a̲y̲");
     T[++phrases] = build_ast(CST(P++) /* G_OWN_BOUNDED_DECLIST */);
     return T[0] = mktuple(G_OWN_ARRAY_DECLN, alt, phrases, T);

//\\ P<LOCAL-ARRAY-DECLN> =
   case G_LOCAL_ARRAY_DECLN:
                                    //\\    "a̲r̲r̲a̲y̲" <BOUNDED_DECLIST>;
     T[++phrases] = kw(CST(P++), "a̲r̲r̲a̲y̲");
     T[++phrases] = build_ast(CST(P++) /* G_BOUNDED_DECLIST */);
     return T[0] = mktuple(G_LOCAL_ARRAY_DECLN, alt, phrases, T);

//\\ P<LOCAL-SCALAR-DECLN> =
   case G_LOCAL_SCALAR_DECLN:
                                    //\\    <DECLIST>;
     T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     return T[0] = mktuple(G_LOCAL_SCALAR_DECLN, alt, phrases, T);

//\\ P<OWN-BOUNDED-DECLIST> =
   case G_OWN_BOUNDED_DECLIST:
                                    //\\    <DECLIST> <OWN_BOUNDS_DECLARATION> <MORE_OWN_BOUNDED_DECLIST>;
     T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     T[++phrases] = build_ast(CST(P++) /* G_OWN_BOUNDS_DECLARATION */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_OWN_BOUNDED_DECLIST */);
     return T[0] = mktuple(G_OWN_BOUNDED_DECLIST, alt, phrases, T);

//\\ P<BOUNDED-DECLIST> =
   case G_BOUNDED_DECLIST:
                                    //\\    <DECLIST> <BOUNDS_DECLARATION> <MORE_BOUNDED_DECLIST>;
     T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
     T[++phrases] = build_ast(CST(P++) /* G_BOUNDS_DECLARATION */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_BOUNDED_DECLIST */);
     return T[0] = mktuple(G_BOUNDED_DECLIST, alt, phrases, T);

//\\ P<MORE-OWN-BOUNDED-DECLIST> =
   case G_MORE_OWN_BOUNDED_DECLIST:
     if (alt == 0)               {  //\\    ',' <DECLIST> <OWN_BOUNDS_DECLARATION> <MORE_OWN_BOUNDED_DECLIST>,
       T[++phrases] = ch(CST(P++), ',');
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
       T[++phrases] = build_ast(CST(P++) /* G_OWN_BOUNDS_DECLARATION */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_OWN_BOUNDED_DECLIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_OWN_BOUNDED_DECLIST, alt, phrases, T);

//\\ P<MORE-BOUNDED-DECLIST> =
   case G_MORE_BOUNDED_DECLIST:
     if (alt == 0)               {  //\\    ',' <DECLIST> <BOUNDS_DECLARATION> <MORE_BOUNDED_DECLIST>,
       T[++phrases] = ch(CST(P++), ',');
       T[++phrases] = build_ast(CST(P++) /* G_DECLIST */);
       T[++phrases] = build_ast(CST(P++) /* G_BOUNDS_DECLARATION */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_BOUNDED_DECLIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_BOUNDED_DECLIST, alt, phrases, T);

//\\ P<OWN-BOUNDS-DECLARATION> =
   case G_OWN_BOUNDS_DECLARATION:
                                    //\\    <ARRAY_LB> <OWN_BOUNDS_DECLIST> <ARRAY_RB>;
     T[++phrases] = build_ast(CST(P++) /* G_ARRAY_LB */);
     T[++phrases] = build_ast(CST(P++) /* G_OWN_BOUNDS_DECLIST */);
     T[++phrases] = build_ast(CST(P++) /* G_ARRAY_RB */);
     return T[0] = mktuple(G_OWN_BOUNDS_DECLARATION, alt, phrases, T);

//\\ P<BOUNDS-DECLARATION> =
   case G_BOUNDS_DECLARATION:
                                    //\\    <ARRAY_LB> <BOUNDS_DECLIST> <ARRAY_RB>;
     T[++phrases] = build_ast(CST(P++) /* G_ARRAY_LB */);
     T[++phrases] = build_ast(CST(P++) /* G_BOUNDS_DECLIST */);
     T[++phrases] = build_ast(CST(P++) /* G_ARRAY_RB */);
     return T[0] = mktuple(G_BOUNDS_DECLARATION, alt, phrases, T);

//\\ P<OWN-BOUNDS-DECLIST> =
   case G_OWN_BOUNDS_DECLIST:
                                    //\\    <OWN_BOUND_DEC> <MORE_OWN_BOUNDS_DECLIST>;
     T[++phrases] = build_ast(CST(P++) /* G_OWN_BOUND_DEC */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_OWN_BOUNDS_DECLIST */);
     return T[0] = mktuple(G_OWN_BOUNDS_DECLIST, alt, phrases, T);

//\\ P<BOUNDS-DECLIST> =
   case G_BOUNDS_DECLIST:
                                    //\\    <BOUND_DEC> <MORE_BOUNDS_DECLIST>;
     T[++phrases] = build_ast(CST(P++) /* G_BOUND_DEC */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_BOUNDS_DECLIST */);
     return T[0] = mktuple(G_BOUNDS_DECLIST, alt, phrases, T);

//\\ P<MORE-OWN-BOUNDS-DECLIST> =
   case G_MORE_OWN_BOUNDS_DECLIST:
     if (alt == 0)               {  //\\    ',' <OWN_BOUND_DEC> <MORE_OWN_BOUNDS_DECLIST>,
       T[++phrases] = ch(CST(P++), ',');
       T[++phrases] = build_ast(CST(P++) /* G_OWN_BOUND_DEC */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_OWN_BOUNDS_DECLIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_OWN_BOUNDS_DECLIST, alt, phrases, T);

//\\ P<MORE-BOUNDS-DECLIST> =
   case G_MORE_BOUNDS_DECLIST:
     if (alt == 0)               {  //\\    ',' <BOUND_DEC> <MORE_BOUNDS_DECLIST>,
       T[++phrases] = ch(CST(P++), ',');
       T[++phrases] = build_ast(CST(P++) /* G_BOUND_DEC */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_BOUNDS_DECLIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_BOUNDS_DECLIST, alt, phrases, T);

//\\ P<OWN-BOUND-DEC> =
   case G_OWN_BOUND_DEC:
                                    //\\    <CONST_EXPR> <COLON_WARN_COMMA> <CONST_EXPR>;
     T[++phrases] = build_ast(CST(P++) /* G_CONST_EXPR */);
     T[++phrases] = build_ast(CST(P++) /* G_COLON_WARN_COMMA */);
     T[++phrases] = build_ast(CST(P++) /* G_CONST_EXPR */);
     return T[0] = mktuple(G_OWN_BOUND_DEC, alt, phrases, T);

//\\ P<BOUND-DEC> =
   case G_BOUND_DEC:
                                    //\\    <arithmetic_expression> <COLON_WARN_COMMA> <arithmetic_expression>;
     T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     T[++phrases] = build_ast(CST(P++) /* G_COLON_WARN_COMMA */);
     T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     return T[0] = mktuple(G_BOUND_DEC, alt, phrases, T);

//\\ P<COLON-WARN-COMMA> =
   case G_COLON_WARN_COMMA:
     if (alt == 0)               {  //\\    ':',
       T[++phrases] = ch(CST(P++), ':');
     } else if (alt == 1)        {  //\\    ',',
       T[++phrases] = ch(CST(P++), ',');
     } else                      {  //\\    "..";
       T[++phrases] = kw(CST(P++), "..");
     }
     return T[0] = mktuple(G_COLON_WARN_COMMA, alt, phrases, T);

//\\ P<CONST-EXPR> =
   case G_CONST_EXPR:
                                    //\\    <arithmetic_expression>;
     T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     return T[0] = mktuple(G_CONST_EXPR, alt, phrases, T);

//\\ P<PROCBODY> =
   case G_PROCBODY:
     if (alt == 0)               {  //\\    "c̲o̲d̲e̲" <DIGITS>,
       T[++phrases] = kw(CST(P++), "c̲o̲d̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_DIGITS */);
     } else if (alt == 1)        {  //\\    "a̲l̲g̲o̲l̲",
       T[++phrases] = kw(CST(P++), "a̲l̲g̲o̲l̲");
     } else if (alt == 2)        {  //\\    "f̲o̲r̲t̲r̲a̲n̲",
       T[++phrases] = kw(CST(P++), "f̲o̲r̲t̲r̲a̲n̲");
     } else if (alt == 3)        {  //\\    "e̲x̲t̲e̲r̲n̲a̲l̲",
       T[++phrases] = kw(CST(P++), "e̲x̲t̲e̲r̲n̲a̲l̲");
     } else if (alt == 4)        {  //\\    "b̲e̲g̲i̲n̲" <LOCAL_BLOCK> "e̲n̲d̲" <ENDTEXT>,
       T[++phrases] = kw(CST(P++), "b̲e̲g̲i̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_BLOCK */);
       T[++phrases] = kw(CST(P++), "e̲n̲d̲");
       T[++phrases] = build_ast(CST(P++) /* G_ENDTEXT */);
     } else if (alt == 5)        {  //\\    <ASSIGNMENT>,
       T[++phrases] = build_ast(CST(P++) /* G_ASSIGNMENT */);
     } else if (alt == 6)        {  //\\    <function_designator>,
       T[++phrases] = build_ast(CST(P++) /* G_function_designator */);
     } else if (alt == 7)        {  //\\    "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL_STATEMENT>,
       T[++phrases] = kw(CST(P++), "f̲o̲r̲");
       T[++phrases] = build_ast(CST(P++) /* G_LHS */);
       T[++phrases] = kw(CST(P++), ":=");
       T[++phrases] = build_ast(CST(P++) /* G_FLE */);
       T[++phrases] = build_ast(CST(P++) /* G_FORLIST */);
       T[++phrases] = kw(CST(P++), "d̲o̲");
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
     } else if (alt == 8)        {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL_STATEMENT> <OPT_ELSE>,
       T[++phrases] = kw(CST(P++), "i̲f̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = kw(CST(P++), "t̲h̲e̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
       T[++phrases] = build_ast(CST(P++) /* G_OPT_ELSE */);
     } else if (alt == 9)        {  //\\    "g̲o̲" "t̲o̲" <JUMP_TARGET>,
       T[++phrases] = kw(CST(P++), "g̲o̲");
       T[++phrases] = kw(CST(P++), "t̲o̲");
       T[++phrases] = build_ast(CST(P++) /* G_JUMP_TARGET */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_PROCBODY, alt, phrases, T);

//\\ P<LOCAL-BLOCK> =
   case G_LOCAL_BLOCK:
     if (alt == 0)               {  //\\    <LABELS_opt> <LOCAL_STATEMENT> <MORE_LOCAL_STATEMENTS>,
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_LOCAL_STATEMENTS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_LOCAL_BLOCK, alt, phrases, T);

//\\ P<MORE-LOCAL-STATEMENTS> =
   case G_MORE_LOCAL_STATEMENTS:
     if (alt == 0)               {  //\\    ';' <LABELS_opt> <LOCAL_STATEMENT> <MORE_LOCAL_STATEMENTS>,
       T[++phrases] = ch(CST(P++), ';');
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_LOCAL_STATEMENTS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_LOCAL_STATEMENTS, alt, phrases, T);

//\\ P<LOCAL-STATEMENT> =
   case G_LOCAL_STATEMENT:
     if (alt == 0)               {  //\\    <COMMENT_NO_SEMI>,
       T[++phrases] = build_ast(CST(P++) /* G_COMMENT_NO_SEMI */);
     } else if (alt == 1)        {  //\\    <ASSIGNMENT>,
       T[++phrases] = build_ast(CST(P++) /* G_ASSIGNMENT */);
     } else if (alt == 2)        {  //\\    <function_designator>,
       T[++phrases] = build_ast(CST(P++) /* G_function_designator */);
     } else if (alt == 3)        {  //\\    "b̲e̲g̲i̲n̲" <LOCAL_BLOCK> "e̲n̲d̲" <ENDTEXT>,
       T[++phrases] = kw(CST(P++), "b̲e̲g̲i̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_BLOCK */);
       T[++phrases] = kw(CST(P++), "e̲n̲d̲");
       T[++phrases] = build_ast(CST(P++) /* G_ENDTEXT */);
     } else if (alt == 4)        {  //\\    "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL_STATEMENT>,
       T[++phrases] = kw(CST(P++), "f̲o̲r̲");
       T[++phrases] = build_ast(CST(P++) /* G_LHS */);
       T[++phrases] = kw(CST(P++), ":=");
       T[++phrases] = build_ast(CST(P++) /* G_FLE */);
       T[++phrases] = build_ast(CST(P++) /* G_FORLIST */);
       T[++phrases] = kw(CST(P++), "d̲o̲");
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
     } else if (alt == 5)        {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL_STATEMENT> <OPT_ELSE>,
       T[++phrases] = kw(CST(P++), "i̲f̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = kw(CST(P++), "t̲h̲e̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
       T[++phrases] = build_ast(CST(P++) /* G_OPT_ELSE */);
     } else if (alt == 6)        {  //\\    "g̲o̲" "t̲o̲" <JUMP_TARGET>,
       T[++phrases] = kw(CST(P++), "g̲o̲");
       T[++phrases] = kw(CST(P++), "t̲o̲");
       T[++phrases] = build_ast(CST(P++) /* G_JUMP_TARGET */);
     } else if (alt == 7)        {  //\\    <CODE>,
       T[++phrases] = build_ast(CST(P++) /* G_CODE */);
     } else if (alt == 8)        {  //\\    <PROCEDURE>,
       T[++phrases] = build_ast(CST(P++) /* G_PROCEDURE */);
     } else if (alt == 9)        {  //\\    <OWN_DECLARATION>,
       T[++phrases] = build_ast(CST(P++) /* G_OWN_DECLARATION */);
     } else if (alt == 10)        {  //\\    <LOCAL_DECLARATION>,
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_DECLARATION */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_LOCAL_STATEMENT, alt, phrases, T);

//\\ P<CODE> =
   case G_CODE:
                                    //\\    "c̲o̲d̲e̲" <ONOFF>;
     T[++phrases] = kw(CST(P++), "c̲o̲d̲e̲");
     T[++phrases] = build_ast(CST(P++) /* G_ONOFF */);
     return T[0] = mktuple(G_CODE, alt, phrases, T);

//\\ P<ONOFF> =
   case G_ONOFF:
     if (alt == 0)               {  //\\    "o̲n̲",
       T[++phrases] = kw(CST(P++), "o̲n̲");
     } else                      {  //\\    "o̲f̲f̲";
       T[++phrases] = kw(CST(P++), "o̲f̲f̲");
     }
     return T[0] = mktuple(G_ONOFF, alt, phrases, T);

//\\ P<OPT-ELSE> =
   case G_OPT_ELSE:
     if (alt == 0)               {  //\\    "e̲l̲s̲e̲" <LABELS_opt> "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL_STATEMENT> <OPT_ELSE>,
       T[++phrases] = kw(CST(P++), "e̲l̲s̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = kw(CST(P++), "i̲f̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = kw(CST(P++), "t̲h̲e̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
       T[++phrases] = build_ast(CST(P++) /* G_OPT_ELSE */);
     } else if (alt == 1)        {  //\\    "e̲l̲s̲e̲" <LABELS_opt> <LOCAL_STATEMENT>,
       T[++phrases] = kw(CST(P++), "e̲l̲s̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_LABELS_opt */);
       T[++phrases] = build_ast(CST(P++) /* G_LOCAL_STATEMENT */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_OPT_ELSE, alt, phrases, T);

//\\ P<FLE> =
   case G_FLE:
                                    //\\    <arithmetic_expression> <REST_OF_FLE>;
     T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     T[++phrases] = build_ast(CST(P++) /* G_REST_OF_FLE */);
     return T[0] = mktuple(G_FLE, alt, phrases, T);

//\\ P<REST-OF-FLE> =
   case G_REST_OF_FLE:
     if (alt == 0)               {  //\\    "s̲t̲e̲p̲" <arithmetic_expression> "u̲n̲t̲i̲l̲" <arithmetic_expression>,
       T[++phrases] = kw(CST(P++), "s̲t̲e̲p̲");
       T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
       T[++phrases] = kw(CST(P++), "u̲n̲t̲i̲l̲");
       T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     } else if (alt == 1)        {  //\\    "w̲h̲i̲l̲e̲" <Boolean_expression>,
       T[++phrases] = kw(CST(P++), "w̲h̲i̲l̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_REST_OF_FLE, alt, phrases, T);

//\\ P<FORLIST> =
   case G_FORLIST:
     if (alt == 0)               {  //\\    "," <FLE> <FORLIST>,
       T[++phrases] = kw(CST(P++), ",");
       T[++phrases] = build_ast(CST(P++) /* G_FLE */);
       T[++phrases] = build_ast(CST(P++) /* G_FORLIST */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_FORLIST, alt, phrases, T);

//\\ P<MORE-LHS> =
   case G_MORE_LHS:
     if (alt == 0)               {  //\\    <LHS> ':' '=' <MORE_LHS>,
       T[++phrases] = build_ast(CST(P++) /* G_LHS */);
       T[++phrases] = ch(CST(P++), ':');
       T[++phrases] = ch(CST(P++), '=');
       T[++phrases] = build_ast(CST(P++) /* G_MORE_LHS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_LHS, alt, phrases, T);

//\\ P<ASSIGNMENT> =
   case G_ASSIGNMENT:
                                    //\\    <LHS> ':' '=' <MORE_LHS> <RHS>;
     T[++phrases] = build_ast(CST(P++) /* G_LHS */);
     T[++phrases] = ch(CST(P++), ':');
     T[++phrases] = ch(CST(P++), '=');
     T[++phrases] = build_ast(CST(P++) /* G_MORE_LHS */);
     T[++phrases] = build_ast(CST(P++) /* G_RHS */);
     return T[0] = mktuple(G_ASSIGNMENT, alt, phrases, T);

//\\ P<LHS> =
   case G_LHS:
     if (alt == 0)               {  //\\    <NAME> <ARRAY_LB> <ARRAY_INDEX> <ARRAY_INDICES> <ARRAY_RB>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_LB */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDEX */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDICES */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_RB */);
     } else                      {  //\\    <NAME>;
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     }
     return T[0] = mktuple(G_LHS, alt, phrases, T);

//\\ P<RHS> =
   case G_RHS:
     if (alt == 0)               {  //\\    <arithmetic_expression> <?closer>,
       T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
       T[++phrases] = -build_ast(CST(P++) /* G_closer */);
     } else                      {  //\\    <Boolean_expression> <?closer>;
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = -build_ast(CST(P++) /* G_closer */);
     }
     return T[0] = mktuple(G_RHS, alt, phrases, T);

//\\ P<function_designator> =
   case G_function_designator:
     if (alt == 0)               {  //\\    <NAME> <ACTUAL_PARAMETERS>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = build_ast(CST(P++) /* G_ACTUAL_PARAMETERS */);
     } else                      {  //\\    <NAME>;
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     }
     return T[0] = mktuple(G_function_designator, alt, phrases, T);

//\\ P<ACTUAL-PARAMETERS> =
   case G_ACTUAL_PARAMETERS:
                                    //\\    '(' <ACTUAL_PARAMETER> <MORE_ACTUAL_PARAMETERS> ')';
     T[++phrases] = ch(CST(P++), '(');
     T[++phrases] = build_ast(CST(P++) /* G_ACTUAL_PARAMETER */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_ACTUAL_PARAMETERS */);
     T[++phrases] = ch(CST(P++), ')');
     return T[0] = mktuple(G_ACTUAL_PARAMETERS, alt, phrases, T);

//\\ P<MORE-ACTUAL-PARAMETERS> =
   case G_MORE_ACTUAL_PARAMETERS:
     if (alt == 0)               {  //\\    <FPSEP> <ACTUAL_PARAMETER> <MORE_ACTUAL_PARAMETERS>,
       T[++phrases] = build_ast(CST(P++) /* G_FPSEP */);
       T[++phrases] = build_ast(CST(P++) /* G_ACTUAL_PARAMETER */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_ACTUAL_PARAMETERS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_ACTUAL_PARAMETERS, alt, phrases, T);

//\\ P<FPSEP> =
   case G_FPSEP:
     if (alt == 0)               {  //\\    ",",
       T[++phrases] = kw(CST(P++), ",");
     } else                      {  //\\    ")" «[ ]*[A-Za-z][A-Za-z ]*» ":" "(";
       T[++phrases] = kw(CST(P++), ")");
       T[++phrases] = reg(CST(P++), "[ ]*[A-Za-z][A-Za-z ]*");
       T[++phrases] = kw(CST(P++), ":");
       T[++phrases] = kw(CST(P++), "(");
     }
     return T[0] = mktuple(G_FPSEP, alt, phrases, T);

//\\ P<ACTUAL-PARAMETER> =
   case G_ACTUAL_PARAMETER:
     if (alt == 0)               {  //\\    <Boolean_expression> <?closer>,
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = -build_ast(CST(P++) /* G_closer */);
     } else if (alt == 1)        {  //\\    <arithmetic_expression> <?closer>,
       T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
       T[++phrases] = -build_ast(CST(P++) /* G_closer */);
     } else                      {  //\\    <string_literal>;
       T[++phrases] = build_ast(CST(P++) /* G_string_literal */);
     }
     return T[0] = mktuple(G_ACTUAL_PARAMETER, alt, phrases, T);

//\\ P<OPERAND> =
   case G_OPERAND:
     if (alt == 0)               {  //\\    <NAME> <ARRAY_LB> <ARRAY_INDEX> <ARRAY_INDICES> <ARRAY_RB>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_LB */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDEX */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDICES */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_RB */);
     } else if (alt == 1)        {  //\\    <function_designator>,
       T[++phrases] = build_ast(CST(P++) /* G_function_designator */);
     } else if (alt == 2)        {  //\\    <NAME>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     } else if (alt == 3)        {  //\\    <REAL_CONSTANT>,
       T[++phrases] = build_ast(CST(P++) /* G_REAL_CONSTANT */);
     } else                      {  //\\    "(" <arithmetic_expression> ")";
       T[++phrases] = kw(CST(P++), "(");
       T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
       T[++phrases] = kw(CST(P++), ")");
     }
     return T[0] = mktuple(G_OPERAND, alt, phrases, T);

//\\ P<ARRAY-INDEX> =
   case G_ARRAY_INDEX:
                                    //\\    <arithmetic_expression>;
     T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     return T[0] = mktuple(G_ARRAY_INDEX, alt, phrases, T);

//\\ P<ARRAY-INDICES> =
   case G_ARRAY_INDICES:
     if (alt == 0)               {  //\\    ',' <ARRAY_INDEX> <ARRAY_INDICES>,
       T[++phrases] = ch(CST(P++), ',');
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDEX */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDICES */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_ARRAY_INDICES, alt, phrases, T);

//\\ P<primary> =
   case G_primary:
                                    //\\    <PLUS_MINUS_opt> <OPERAND>;
     T[++phrases] = build_ast(CST(P++) /* G_PLUS_MINUS_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_OPERAND */);
     return T[0] = mktuple(G_primary, alt, phrases, T);

//\\ P<exp-op> =
   case G_exp_op:
     if (alt == 0)               {  //\\    "^",
       T[++phrases] = kw(CST(P++), "^");
     } else if (alt == 1)        {  //\\    "**",
       T[++phrases] = kw(CST(P++), "**");
     } else if (alt == 2)        {  //\\    "⭡",
       T[++phrases] = kw(CST(P++), "⭡");
     } else if (alt == 3)        {  //\\    "|^",
       T[++phrases] = kw(CST(P++), "|^");
     } else                      {  //\\    "p̲o̲w̲e̲r̲";
       T[++phrases] = kw(CST(P++), "p̲o̲w̲e̲r̲");
     }
     return T[0] = mktuple(G_exp_op, alt, phrases, T);

//\\ P<exp-factor> =
   case G_exp_factor:
     if (alt == 0)               {  //\\    <exp_op> <factor>,
       T[++phrases] = build_ast(CST(P++) /* G_exp_op */);
       T[++phrases] = build_ast(CST(P++) /* G_factor */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_exp_factor, alt, phrases, T);

//\\ P<factor> =
   case G_factor:
                                    //\\    <primary> <exp_factor>;
     T[++phrases] = build_ast(CST(P++) /* G_primary */);
     T[++phrases] = build_ast(CST(P++) /* G_exp_factor */);
     return T[0] = mktuple(G_factor, alt, phrases, T);

//\\ P<mul-op> =
   case G_mul_op:
     if (alt == 0)               {  //\\    "*",
       T[++phrases] = kw(CST(P++), "*");
     } else                      {  //\\    "×";
       T[++phrases] = kw(CST(P++), "×");
     }
     return T[0] = mktuple(G_mul_op, alt, phrases, T);

//\\ P<rdiv-op> =
   case G_rdiv_op:
                                    //\\    "/";
     T[++phrases] = kw(CST(P++), "/");
     return T[0] = mktuple(G_rdiv_op, alt, phrases, T);

//\\ P<idiv-op> =
   case G_idiv_op:
     if (alt == 0)               {  //\\    "//",
       T[++phrases] = kw(CST(P++), "//");
     } else if (alt == 1)        {  //\\    "÷",
       T[++phrases] = kw(CST(P++), "÷");
     } else if (alt == 2)        {  //\\    "%",
       T[++phrases] = kw(CST(P++), "%");
     } else if (alt == 3)        {  //\\    "d̲i̲v̲",
       T[++phrases] = kw(CST(P++), "d̲i̲v̲");
     } else                      {  //\\    "'/'";
       T[++phrases] = kw(CST(P++), "'/'");
     }
     return T[0] = mktuple(G_idiv_op, alt, phrases, T);

//\\ P<div-op> =
   case G_div_op:
     if (alt == 0)               {  //\\    <idiv_op>,
       T[++phrases] = build_ast(CST(P++) /* G_idiv_op */);
     } else                      {  //\\    <rdiv_op>;
       T[++phrases] = build_ast(CST(P++) /* G_rdiv_op */);
     }
     return T[0] = mktuple(G_div_op, alt, phrases, T);

//\\ P<muldiv-op> =
   case G_muldiv_op:
     if (alt == 0)               {  //\\    <mul_op>,
       T[++phrases] = build_ast(CST(P++) /* G_mul_op */);
     } else                      {  //\\    <div_op>;
       T[++phrases] = build_ast(CST(P++) /* G_div_op */);
     }
     return T[0] = mktuple(G_muldiv_op, alt, phrases, T);

//\\ P<mul-factor> =
   case G_mul_factor:
     if (alt == 0)               {  //\\    <muldiv_op> <term>,
       T[++phrases] = build_ast(CST(P++) /* G_muldiv_op */);
       T[++phrases] = build_ast(CST(P++) /* G_term */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_mul_factor, alt, phrases, T);

//\\ P<term> =
   case G_term:
                                    //\\    <factor> <mul_factor>;
     T[++phrases] = build_ast(CST(P++) /* G_factor */);
     T[++phrases] = build_ast(CST(P++) /* G_mul_factor */);
     return T[0] = mktuple(G_term, alt, phrases, T);

//\\ P<add-op> =
   case G_add_op:
                                    //\\    "+";
     T[++phrases] = kw(CST(P++), "+");
     return T[0] = mktuple(G_add_op, alt, phrases, T);

//\\ P<sub-op> =
   case G_sub_op:
                                    //\\    "-";
     T[++phrases] = kw(CST(P++), "-");
     return T[0] = mktuple(G_sub_op, alt, phrases, T);

//\\ P<addsub-op> =
   case G_addsub_op:
     if (alt == 0)               {  //\\    <add_op>,
       T[++phrases] = build_ast(CST(P++) /* G_add_op */);
     } else                      {  //\\    <sub_op>;
       T[++phrases] = build_ast(CST(P++) /* G_sub_op */);
     }
     return T[0] = mktuple(G_addsub_op, alt, phrases, T);

//\\ P<add-term> =
   case G_add_term:
     if (alt == 0)               {  //\\    <addsub_op> <simple_arithmetic_expression>,
       T[++phrases] = build_ast(CST(P++) /* G_addsub_op */);
       T[++phrases] = build_ast(CST(P++) /* G_simple_arithmetic_expression */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_add_term, alt, phrases, T);

//\\ P<simple_arithmetic_expression> =
   case G_simple_arithmetic_expression:
                                    //\\    <term> <add_term>;
     T[++phrases] = build_ast(CST(P++) /* G_term */);
     T[++phrases] = build_ast(CST(P++) /* G_add_term */);
     return T[0] = mktuple(G_simple_arithmetic_expression, alt, phrases, T);

//\\ P<arithmetic_expression> =
   case G_arithmetic_expression:
     if (alt == 0)               {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_arithmetic_expression> "e̲l̲s̲e̲" <arithmetic_expression>,
       T[++phrases] = kw(CST(P++), "i̲f̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = kw(CST(P++), "t̲h̲e̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_simple_arithmetic_expression */);
       T[++phrases] = kw(CST(P++), "e̲l̲s̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     } else                      {  //\\    <simple_arithmetic_expression>;
       T[++phrases] = build_ast(CST(P++) /* G_simple_arithmetic_expression */);
     }
     return T[0] = mktuple(G_arithmetic_expression, alt, phrases, T);

//\\ P<INTEGER-CONSTANT> =
   case G_INTEGER_CONSTANT:
                                    //\\    <PLUS_MINUS_opt> <DIGITS>;
     T[++phrases] = build_ast(CST(P++) /* G_PLUS_MINUS_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_DIGITS */);
     return T[0] = mktuple(G_INTEGER_CONSTANT, alt, phrases, T);

//\\ P<REAL-CONSTANT> =
   case G_REAL_CONSTANT:
                                    //\\    <PLUS_MINUS_opt> <unsigned>;
     T[++phrases] = build_ast(CST(P++) /* G_PLUS_MINUS_opt */);
     T[++phrases] = build_ast(CST(P++) /* G_unsigned */);
     return T[0] = mktuple(G_REAL_CONSTANT, alt, phrases, T);

//\\ P<unsigned> =
   case G_unsigned:
     if (alt == 0)               {  //\\    <decnum> <expart>,
       T[++phrases] = build_ast(CST(P++) /* G_decnum */);
       T[++phrases] = build_ast(CST(P++) /* G_expart */);
     } else if (alt == 1)        {  //\\    <expart>,
       T[++phrases] = build_ast(CST(P++) /* G_expart */);
     } else                      {  //\\    <decnum>;
       T[++phrases] = build_ast(CST(P++) /* G_decnum */);
     }
     return T[0] = mktuple(G_unsigned, alt, phrases, T);

//\\ P<decfract> =
   case G_decfract:
                                    //\\    <decimalpoint> <DIGITS>;
     T[++phrases] = build_ast(CST(P++) /* G_decimalpoint */);
     T[++phrases] = build_ast(CST(P++) /* G_DIGITS */);
     return T[0] = mktuple(G_decfract, alt, phrases, T);

//\\ P<decimalpoint> =
   case G_decimalpoint:
     if (alt == 0)               {  //\\    ".",
       T[++phrases] = kw(CST(P++), ".");
     } else                      {  //\\    "·";
       T[++phrases] = kw(CST(P++), "·");
     }
     return T[0] = mktuple(G_decimalpoint, alt, phrases, T);

//\\ P<expart> =
   case G_expart:
                                    //\\    <subten> <INTEGER_CONSTANT>;
     T[++phrases] = build_ast(CST(P++) /* G_subten */);
     T[++phrases] = build_ast(CST(P++) /* G_INTEGER_CONSTANT */);
     return T[0] = mktuple(G_expart, alt, phrases, T);

//\\ P<decnum> =
   case G_decnum:
     if (alt == 0)               {  //\\    <DIGITS> <decfract>,
       T[++phrases] = build_ast(CST(P++) /* G_DIGITS */);
       T[++phrases] = build_ast(CST(P++) /* G_decfract */);
     } else if (alt == 1)        {  //\\    <decfract>,
       T[++phrases] = build_ast(CST(P++) /* G_decfract */);
     } else                      {  //\\    <DIGITS>;
       T[++phrases] = build_ast(CST(P++) /* G_DIGITS */);
     }
     return T[0] = mktuple(G_decnum, alt, phrases, T);

//\\ P<subten> =
   case G_subten:
     if (alt == 0)               {  //\\    "@",
       T[++phrases] = kw(CST(P++), "@");
     } else if (alt == 1)        {  //\\    "&",
       T[++phrases] = kw(CST(P++), "&");
     } else if (alt == 2)        {  //\\    "⏨",
       T[++phrases] = kw(CST(P++), "⏨");
     } else if (alt == 3)        {  //\\    "\u23E8",
       T[++phrases] = kw(CST(P++), "\\u23E8");
     } else if (alt == 4)        {  //\\    "\u2081\u2080",
       T[++phrases] = kw(CST(P++), "\\u2081\\u2080");
     } else                      {  //\\    "'10'";
       T[++phrases] = kw(CST(P++), "'10'");
     }
     return T[0] = mktuple(G_subten, alt, phrases, T);

//\\ P<PLUS-MINUS-opt> =
   case G_PLUS_MINUS_opt:
     if (alt == 0)               {  //\\    "+" <PLUS_MINUS_opt>,
       T[++phrases] = kw(CST(P++), "+");
       T[++phrases] = build_ast(CST(P++) /* G_PLUS_MINUS_opt */);
     } else if (alt == 1)        {  //\\    "-" <PLUS_MINUS_opt>,
       T[++phrases] = kw(CST(P++), "-");
       T[++phrases] = build_ast(CST(P++) /* G_PLUS_MINUS_opt */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_PLUS_MINUS_opt, alt, phrases, T);

//\\ P<logical_value> =
   case G_logical_value:
     if (alt == 0)               {  //\\    "t̲r̲u̲e̲",
       T[++phrases] = kw(CST(P++), "t̲r̲u̲e̲");
     } else                      {  //\\    "f̲a̲l̲s̲e̲";
       T[++phrases] = kw(CST(P++), "f̲a̲l̲s̲e̲");
     }
     return T[0] = mktuple(G_logical_value, alt, phrases, T);

//\\ P<relational_operator> =
   case G_relational_operator:
     if (alt == 0)               {  //\\    "=",
       T[++phrases] = kw(CST(P++), "=");
     } else if (alt == 1)        {  //\\    "e̲q̲u̲a̲l̲",
       T[++phrases] = kw(CST(P++), "e̲q̲u̲a̲l̲");
     } else if (alt == 2)        {  //\\    "e̲q̲",
       T[++phrases] = kw(CST(P++), "e̲q̲");
     } else if (alt == 3)        {  //\\    ">=",
       T[++phrases] = kw(CST(P++), ">=");
     } else if (alt == 4)        {  //\\    "≥",
       T[++phrases] = kw(CST(P++), "≥");
     } else if (alt == 5)        {  //\\    "g̲e̲",
       T[++phrases] = kw(CST(P++), "g̲e̲");
     } else if (alt == 6)        {  //\\    "n̲o̲t̲l̲e̲s̲s̲",
       T[++phrases] = kw(CST(P++), "n̲o̲t̲l̲e̲s̲s̲");
     } else if (alt == 7)        {  //\\    "g̲r̲e̲q̲",
       T[++phrases] = kw(CST(P++), "g̲r̲e̲q̲");
     } else if (alt == 8)        {  //\\    ">",
       T[++phrases] = kw(CST(P++), ">");
     } else if (alt == 9)        {  //\\    "g̲t̲",
       T[++phrases] = kw(CST(P++), "g̲t̲");
     } else if (alt == 10)        {  //\\    "g̲r̲e̲a̲t̲e̲r̲",
       T[++phrases] = kw(CST(P++), "g̲r̲e̲a̲t̲e̲r̲");
     } else if (alt == 11)        {  //\\    "<>",
       T[++phrases] = kw(CST(P++), "<>");
     } else if (alt == 12)        {  //\\    "#",
       T[++phrases] = kw(CST(P++), "#");
     } else if (alt == 13)        {  //\\    "≠",
       T[++phrases] = kw(CST(P++), "≠");
     } else if (alt == 14)        {  //\\    "n̲e̲",
       T[++phrases] = kw(CST(P++), "n̲e̲");
     } else if (alt == 15)        {  //\\    "n̲o̲t̲e̲q̲u̲a̲l̲",
       T[++phrases] = kw(CST(P++), "n̲o̲t̲e̲q̲u̲a̲l̲");
     } else if (alt == 16)        {  //\\    "\=",
       T[++phrases] = kw(CST(P++), "\\=");
     } else if (alt == 17)        {  //\\    "¬=",
       T[++phrases] = kw(CST(P++), "¬=");
     } else if (alt == 18)        {  //\\    "!=",
       T[++phrases] = kw(CST(P++), "!=");
     } else if (alt == 19)        {  //\\    "^=",
       T[++phrases] = kw(CST(P++), "^=");
     } else if (alt == 20)        {  //\\    "|=",
       T[++phrases] = kw(CST(P++), "|=");
     } else if (alt == 21)        {  //\\    "<=",
       T[++phrases] = kw(CST(P++), "<=");
     } else if (alt == 22)        {  //\\    "≤",
       T[++phrases] = kw(CST(P++), "≤");
     } else if (alt == 23)        {  //\\    "l̲e̲s̲s̲e̲q̲",
       T[++phrases] = kw(CST(P++), "l̲e̲s̲s̲e̲q̲");
     } else if (alt == 24)        {  //\\    "n̲o̲t̲g̲r̲e̲a̲t̲e̲r̲",
       T[++phrases] = kw(CST(P++), "n̲o̲t̲g̲r̲e̲a̲t̲e̲r̲");
     } else if (alt == 25)        {  //\\    "<",
       T[++phrases] = kw(CST(P++), "<");
     } else if (alt == 26)        {  //\\    "l̲t̲",
       T[++phrases] = kw(CST(P++), "l̲t̲");
     } else if (alt == 27)        {  //\\    "l̲e̲s̲s̲",
       T[++phrases] = kw(CST(P++), "l̲e̲s̲s̲");
     } else                      {  //\\    "l̲e̲";
       T[++phrases] = kw(CST(P++), "l̲e̲");
     }
     return T[0] = mktuple(G_relational_operator, alt, phrases, T);

//\\ P<ARRAY-LB> =
   case G_ARRAY_LB:
     if (alt == 0)               {  //\\    '[',
       T[++phrases] = ch(CST(P++), '[');
     } else                      {  //\\    "(/";
       T[++phrases] = kw(CST(P++), "(/");
     }
     return T[0] = mktuple(G_ARRAY_LB, alt, phrases, T);

//\\ P<ARRAY-RB> =
   case G_ARRAY_RB:
     if (alt == 0)               {  //\\    ']',
       T[++phrases] = ch(CST(P++), ']');
     } else                      {  //\\    "/)";
       T[++phrases] = kw(CST(P++), "/)");
     }
     return T[0] = mktuple(G_ARRAY_RB, alt, phrases, T);

//\\ P<relation> =
   case G_relation:
                                    //\\    <arithmetic_expression> <relational_operator> <arithmetic_expression>;
     T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     T[++phrases] = build_ast(CST(P++) /* G_relational_operator */);
     T[++phrases] = build_ast(CST(P++) /* G_arithmetic_expression */);
     return T[0] = mktuple(G_relation, alt, phrases, T);

//\\ P<Boolean_primary> =
   case G_Boolean_primary:
     if (alt == 0)               {  //\\    <relation>,
       T[++phrases] = build_ast(CST(P++) /* G_relation */);
     } else if (alt == 1)        {  //\\    <NAME> <ARRAY_LB> <ARRAY_INDEX> <ARRAY_INDICES> <ARRAY_RB>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_LB */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDEX */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_INDICES */);
       T[++phrases] = build_ast(CST(P++) /* G_ARRAY_RB */);
     } else if (alt == 2)        {  //\\    <function_designator>,
       T[++phrases] = build_ast(CST(P++) /* G_function_designator */);
     } else if (alt == 3)        {  //\\    <NAME>,
       T[++phrases] = build_ast(CST(P++) /* G_NAME */);
     } else if (alt == 4)        {  //\\    <logical_value>,
       T[++phrases] = build_ast(CST(P++) /* G_logical_value */);
     } else                      {  //\\    "(" <Boolean_expression> ")";
       T[++phrases] = kw(CST(P++), "(");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = kw(CST(P++), ")");
     }
     return T[0] = mktuple(G_Boolean_primary, alt, phrases, T);

//\\ P<not-term> =
   case G_not_term:
     if (alt == 0)               {  //\\    "n̲o̲t̲",
       T[++phrases] = kw(CST(P++), "n̲o̲t̲");
     } else if (alt == 1)        {  //\\    "¬",
       T[++phrases] = kw(CST(P++), "¬");
     } else if (alt == 2)        {  //\\    "!",
       T[++phrases] = kw(CST(P++), "!");
     } else                      {  //\\    "~";
       T[++phrases] = kw(CST(P++), "~");
     }
     return T[0] = mktuple(G_not_term, alt, phrases, T);

//\\ P<not-terms> =
   case G_not_terms:
     if (alt == 0)               {  //\\    <not_term> <not_terms>,
       T[++phrases] = build_ast(CST(P++) /* G_not_term */);
       T[++phrases] = build_ast(CST(P++) /* G_not_terms */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_not_terms, alt, phrases, T);

//\\ P<Boolean_secondary> =
   case G_Boolean_secondary:
     if (alt == 0)               {  //\\    <not_term> <not_terms> <Boolean_primary>,
       T[++phrases] = build_ast(CST(P++) /* G_not_term */);
       T[++phrases] = build_ast(CST(P++) /* G_not_terms */);
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_primary */);
     } else                      {  //\\    <Boolean_primary>;
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_primary */);
     }
     return T[0] = mktuple(G_Boolean_secondary, alt, phrases, T);

//\\ P<and-term> =
   case G_and_term:
     if (alt == 0)               {  //\\    "a̲n̲d̲",
       T[++phrases] = kw(CST(P++), "a̲n̲d̲");
     } else if (alt == 1)        {  //\\    "∧",
       T[++phrases] = kw(CST(P++), "∧");
     } else                      {  //\\    "&";
       T[++phrases] = kw(CST(P++), "&");
     }
     return T[0] = mktuple(G_and_term, alt, phrases, T);

//\\ P<and_Boolean_factor> =
   case G_and_Boolean_factor:
     if (alt == 0)               {  //\\    <and_term> <Boolean_factor>,
       T[++phrases] = build_ast(CST(P++) /* G_and_term */);
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_factor */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_and_Boolean_factor, alt, phrases, T);

//\\ P<Boolean_factor> =
   case G_Boolean_factor:
                                    //\\    <Boolean_secondary> <and_Boolean_factor>;
     T[++phrases] = build_ast(CST(P++) /* G_Boolean_secondary */);
     T[++phrases] = build_ast(CST(P++) /* G_and_Boolean_factor */);
     return T[0] = mktuple(G_Boolean_factor, alt, phrases, T);

//\\ P<or-term> =
   case G_or_term:
     if (alt == 0)               {  //\\    "o̲r̲",
       T[++phrases] = kw(CST(P++), "o̲r̲");
     } else                      {  //\\    "∨";
       T[++phrases] = kw(CST(P++), "∨");
     }
     return T[0] = mktuple(G_or_term, alt, phrases, T);

//\\ P<or_Boolean_term> =
   case G_or_Boolean_term:
     if (alt == 0)               {  //\\    <or_term> <Boolean_term>,
       T[++phrases] = build_ast(CST(P++) /* G_or_term */);
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_term */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_or_Boolean_term, alt, phrases, T);

//\\ P<Boolean_term> =
   case G_Boolean_term:
                                    //\\    <Boolean_factor> <or_Boolean_term>;
     T[++phrases] = build_ast(CST(P++) /* G_Boolean_factor */);
     T[++phrases] = build_ast(CST(P++) /* G_or_Boolean_term */);
     return T[0] = mktuple(G_Boolean_term, alt, phrases, T);

//\\ P<impl-term> =
   case G_impl_term:
     if (alt == 0)               {  //\\    "i̲m̲p̲l̲i̲e̲s̲",
       T[++phrases] = kw(CST(P++), "i̲m̲p̲l̲i̲e̲s̲");
     } else if (alt == 1)        {  //\\    "i̲m̲p̲l̲",
       T[++phrases] = kw(CST(P++), "i̲m̲p̲l̲");
     } else if (alt == 2)        {  //\\    "i̲m̲p̲",
       T[++phrases] = kw(CST(P++), "i̲m̲p̲");
     } else if (alt == 3)        {  //\\    "⊃",
       T[++phrases] = kw(CST(P++), "⊃");
     } else if (alt == 4)        {  //\\    "\u2283",
       T[++phrases] = kw(CST(P++), "\\u2283");
     } else                      {  //\\    "->";
       T[++phrases] = kw(CST(P++), "->");
     }
     return T[0] = mktuple(G_impl_term, alt, phrases, T);

//\\ P<more_implication_Boolean> =
   case G_more_implication_Boolean:
     if (alt == 0)               {  //\\    <impl_term> <implication_Boolean>,
       T[++phrases] = build_ast(CST(P++) /* G_impl_term */);
       T[++phrases] = build_ast(CST(P++) /* G_implication_Boolean */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_more_implication_Boolean, alt, phrases, T);

//\\ P<implication_Boolean> =
   case G_implication_Boolean:
                                    //\\    <Boolean_term> <more_implication_Boolean>;
     T[++phrases] = build_ast(CST(P++) /* G_Boolean_term */);
     T[++phrases] = build_ast(CST(P++) /* G_more_implication_Boolean */);
     return T[0] = mktuple(G_implication_Boolean, alt, phrases, T);

//\\ P<equiv-term> =
   case G_equiv_term:
     if (alt == 0)               {  //\\    "e̲q̲u̲i̲v̲",
       T[++phrases] = kw(CST(P++), "e̲q̲u̲i̲v̲");
     } else if (alt == 1)        {  //\\    "e̲q̲v̲",
       T[++phrases] = kw(CST(P++), "e̲q̲v̲");
     } else if (alt == 2)        {  //\\    "≡",
       T[++phrases] = kw(CST(P++), "≡");
     } else                      {  //\\    "==";
       T[++phrases] = kw(CST(P++), "==");
     }
     return T[0] = mktuple(G_equiv_term, alt, phrases, T);

//\\ P<equiv_simple_Boolean> =
   case G_equiv_simple_Boolean:
     if (alt == 0)               {  //\\    <equiv_term> <simple_Boolean>,
       T[++phrases] = build_ast(CST(P++) /* G_equiv_term */);
       T[++phrases] = build_ast(CST(P++) /* G_simple_Boolean */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_equiv_simple_Boolean, alt, phrases, T);

//\\ P<simple_Boolean> =
   case G_simple_Boolean:
                                    //\\    <implication_Boolean> <equiv_simple_Boolean>;
     T[++phrases] = build_ast(CST(P++) /* G_implication_Boolean */);
     T[++phrases] = build_ast(CST(P++) /* G_equiv_simple_Boolean */);
     return T[0] = mktuple(G_simple_Boolean, alt, phrases, T);

//\\ P<Boolean_expression> =
   case G_Boolean_expression:
     if (alt == 0)               {  //\\    "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_Boolean> "e̲l̲s̲e̲" <Boolean_expression>,
       T[++phrases] = kw(CST(P++), "i̲f̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
       T[++phrases] = kw(CST(P++), "t̲h̲e̲n̲");
       T[++phrases] = build_ast(CST(P++) /* G_simple_Boolean */);
       T[++phrases] = kw(CST(P++), "e̲l̲s̲e̲");
       T[++phrases] = build_ast(CST(P++) /* G_Boolean_expression */);
     } else                      {  //\\    <simple_Boolean>;
       T[++phrases] = build_ast(CST(P++) /* G_simple_Boolean */);
     }
     return T[0] = mktuple(G_Boolean_expression, alt, phrases, T);

//\\ P<ch> =
   case G_ch:
     if (alt == 0)               {  //\\    <stropped>,
       T[++phrases] = build_ast(CST(P++) /* G_stropped */);
     } else                      {  //\\    «.»;
       T[++phrases] = reg(CST(P++), ".");
     }
     return T[0] = mktuple(G_ch, alt, phrases, T);

//\\ P<stropped> =
   case G_stropped:
                                    //\\    «(a̲|b̲|c̲|d̲|e̲|f̲|g̲|h̲|i̲|j̲|k̲|l̲|m̲|n̲|o̲|p̲|q̲|r̲|s̲|t̲|u̲|v̲|w̲|x̲|y̲|z̲|A̲|B̲|C̲|D̲|E̲|F̲|G̲|H̲|I̲|J̲|K̲|L̲|M̲|N̲|O̲|P̲|Q̲|R̲|S̲|T̲|U̲|V̲|W̲|X̲|Y̲|Z̲)»;
     T[++phrases] = reg(CST(P++), "(a̲|b̲|c̲|d̲|e̲|f̲|g̲|h̲|i̲|j̲|k̲|l̲|m̲|n̲|o̲|p̲|q̲|r̲|s̲|t̲|u̲|v̲|w̲|x̲|y̲|z̲|A̲|B̲|C̲|D̲|E̲|F̲|G̲|H̲|I̲|J̲|K̲|L̲|M̲|N̲|O̲|P̲|Q̲|R̲|S̲|T̲|U̲|V̲|W̲|X̲|Y̲|Z̲)");
     return T[0] = mktuple(G_stropped, alt, phrases, T);

//\\ P<NAME> =
   case G_NAME:
                                    //\\    <ALPHA> <ALPHANUMS>;
     T[++phrases] = build_ast(CST(P++) /* G_ALPHA */);
     T[++phrases] = build_ast(CST(P++) /* G_ALPHANUMS */);
     return T[0] = mktuple(G_NAME, alt, phrases, T);

//\\ P<ALPHANUMS> =
   case G_ALPHANUMS:
     if (alt == 0)               {  //\\    <ALPHANUM> <ALPHANUMS>,
       T[++phrases] = build_ast(CST(P++) /* G_ALPHANUM */);
       T[++phrases] = build_ast(CST(P++) /* G_ALPHANUMS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_ALPHANUMS, alt, phrases, T);

//\\ P<ALPHA> =
   case G_ALPHA:
                                    //\\    <!stropped> «[A-Za-z]»;
     T[++phrases] = -1 +(0 * P++);
     T[++phrases] = reg(CST(P++), "[A-Za-z]");
     return T[0] = mktuple(G_ALPHA, alt, phrases, T);

//\\ P<ALPHANUM> =
   case G_ALPHANUM:
                                    //\\    <!stropped> «[A-Za-z0-9 ]»;
     T[++phrases] = -1 +(0 * P++);
     T[++phrases] = reg(CST(P++), "[A-Za-z0-9 ]");
     return T[0] = mktuple(G_ALPHANUM, alt, phrases, T);

//\\ P<DIGITS> =
   case G_DIGITS:
                                    //\\    <DIGIT> <MORE_DIGITS>;
     T[++phrases] = build_ast(CST(P++) /* G_DIGIT */);
     T[++phrases] = build_ast(CST(P++) /* G_MORE_DIGITS */);
     return T[0] = mktuple(G_DIGITS, alt, phrases, T);

//\\ P<DIGIT> =
   case G_DIGIT:
                                    //\\    «[0-9]»;
     T[++phrases] = reg(CST(P++), "[0-9]");
     return T[0] = mktuple(G_DIGIT, alt, phrases, T);

//\\ P<MORE-DIGITS> =
   case G_MORE_DIGITS:
     if (alt == 0)               {  //\\    <DIGIT> <MORE_DIGITS>,
       T[++phrases] = build_ast(CST(P++) /* G_DIGIT */);
       T[++phrases] = build_ast(CST(P++) /* G_MORE_DIGITS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_MORE_DIGITS, alt, phrases, T);

//\\ P<string_literal> =
   case G_string_literal:
     if (alt == 0)               {  //\\    <BALANCED_STRING>,
       T[++phrases] = build_ast(CST(P++) /* G_BALANCED_STRING */);
     } else                      {  //\\    <C_STRING>;
       T[++phrases] = build_ast(CST(P++) /* G_C_STRING */);
     }
     return T[0] = mktuple(G_string_literal, alt, phrases, T);

//\\ P<dchs> =
   case G_dchs:
     if (alt == 0)               {  //\\    <dch> <dchs>,
       T[++phrases] = build_ast(CST(P++) /* G_dch */);
       T[++phrases] = build_ast(CST(P++) /* G_dchs */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_dchs, alt, phrases, T);

//\\ P<dch> =
   case G_dch:
                                    //\\    <!rdquo> <ch>;
     T[++phrases] = -1 +(0 * P++);
     T[++phrases] = build_ast(CST(P++) /* G_ch */);
     return T[0] = mktuple(G_dch, alt, phrases, T);

//\\ P<ldquo> =
   case G_ldquo:
     if (alt == 0)               {  //\\    "“",
       T[++phrases] = kw(CST(P++), "“");
     } else if (alt == 1)        {  //\\    '{',
       T[++phrases] = ch(CST(P++), '{');
     } else if (alt == 2)        {  //\\    "‘",
       T[++phrases] = kw(CST(P++), "‘");
     } else if (alt == 3)        {  //\\    "'('",
       T[++phrases] = kw(CST(P++), "'('");
     } else if (alt == 4)        {  //\\    "«",
       T[++phrases] = kw(CST(P++), "«");
     } else if (alt == 5)        {  //\\    "|<",
       T[++phrases] = kw(CST(P++), "|<");
     } else if (alt == 6)        {  //\\    "<",
       T[++phrases] = kw(CST(P++), "<");
     } else                      {  //\\    "«";
       T[++phrases] = kw(CST(P++), "«");
     }
     return T[0] = mktuple(G_ldquo, alt, phrases, T);

//\\ P<rdquo> =
   case G_rdquo:
     if (alt == 0)               {  //\\    "”",
       T[++phrases] = kw(CST(P++), "”");
     } else if (alt == 1)        {  //\\    '}',
       T[++phrases] = ch(CST(P++), '}');
     } else if (alt == 2)        {  //\\    "’",
       T[++phrases] = kw(CST(P++), "’");
     } else if (alt == 3)        {  //\\    "')'",
       T[++phrases] = kw(CST(P++), "')'");
     } else if (alt == 4)        {  //\\    "»",
       T[++phrases] = kw(CST(P++), "»");
     } else if (alt == 5)        {  //\\    "|>",
       T[++phrases] = kw(CST(P++), "|>");
     } else if (alt == 6)        {  //\\    ">",
       T[++phrases] = kw(CST(P++), ">");
     } else                      {  //\\    "»";
       T[++phrases] = kw(CST(P++), "»");
     }
     return T[0] = mktuple(G_rdquo, alt, phrases, T);

//\\ P<BALANCED-STRING> =
   case G_BALANCED_STRING:
                                    //\\    <ldquo> <BALANCED_CHAR_SEQUENCE> <rdquo>;
     T[++phrases] = build_ast(CST(P++) /* G_ldquo */);
     T[++phrases] = build_ast(CST(P++) /* G_BALANCED_CHAR_SEQUENCE */);
     T[++phrases] = build_ast(CST(P++) /* G_rdquo */);
     return T[0] = mktuple(G_BALANCED_STRING, alt, phrases, T);

//\\ P<BALANCED-CHAR-SEQUENCE> =
   case G_BALANCED_CHAR_SEQUENCE:
     if (alt == 0)               {  //\\    <BALANCED_CHAR> <BALANCED_CHAR_SEQUENCE>,
       T[++phrases] = build_ast(CST(P++) /* G_BALANCED_CHAR */);
       T[++phrases] = build_ast(CST(P++) /* G_BALANCED_CHAR_SEQUENCE */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_BALANCED_CHAR_SEQUENCE, alt, phrases, T);

//\\ P<BALANCED-CHAR> =
   case G_BALANCED_CHAR:
     if (alt == 0)               {  //\\    <BALANCED_STRING>,
       T[++phrases] = build_ast(CST(P++) /* G_BALANCED_STRING */);
     } else                      {  //\\    <!rdquo> <ch>;
       T[++phrases] = -1 +(0 * P++);
       T[++phrases] = build_ast(CST(P++) /* G_ch */);
     }
     return T[0] = mktuple(G_BALANCED_CHAR, alt, phrases, T);

//\\ P<RB> =
   case G_RB:
                                    //\\    '>';
     T[++phrases] = ch(CST(P++), '>');
     return T[0] = mktuple(G_RB, alt, phrases, T);

//\\ P<C-STRING> =
   case G_C_STRING:
     if (alt == 0)               {  //\\    '"' <C_CHARS> '"',
       T[++phrases] = ch(CST(P++), '"');
       T[++phrases] = build_ast(CST(P++) /* G_C_CHARS */);
       T[++phrases] = ch(CST(P++), '"');
     } else if (alt == 1)        {  //\\    "``" «[^']*» "''",
       T[++phrases] = kw(CST(P++), "``");
       T[++phrases] = reg(CST(P++), "[^']*");
       T[++phrases] = kw(CST(P++), "''");
     } else                      {  //\\    "`" «[^']*» "'";
       T[++phrases] = kw(CST(P++), "`");
       T[++phrases] = reg(CST(P++), "[^']*");
       T[++phrases] = kw(CST(P++), "'");
     }
     return T[0] = mktuple(G_C_STRING, alt, phrases, T);

//\\ P<C-CHARS> =
   case G_C_CHARS:
     if (alt == 0)               {  //\\    <stropped> <C_CHARS>,
       T[++phrases] = build_ast(CST(P++) /* G_stropped */);
       T[++phrases] = build_ast(CST(P++) /* G_C_CHARS */);
     } else if (alt == 1)        {  //\\    <!dquote> <ch> <C_CHARS>,
       T[++phrases] = -1 +(0 * P++);
       T[++phrases] = build_ast(CST(P++) /* G_ch */);
       T[++phrases] = build_ast(CST(P++) /* G_C_CHARS */);
     } else if (alt == 2)        {  //\\    '"' '"' <C_CHARS>,
       T[++phrases] = ch(CST(P++), '"');
       T[++phrases] = ch(CST(P++), '"');
       T[++phrases] = build_ast(CST(P++) /* G_C_CHARS */);
     } else if (alt == 3)        {  //\\    '\' <ch> <C_CHARS>,
       T[++phrases] = ch(CST(P++), '\\');
       T[++phrases] = build_ast(CST(P++) /* G_ch */);
       T[++phrases] = build_ast(CST(P++) /* G_C_CHARS */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_C_CHARS, alt, phrases, T);

//\\ P<dquote> =
   case G_dquote:
                                    //\\    '"';
     T[++phrases] = ch(CST(P++), '"');
     return T[0] = mktuple(G_dquote, alt, phrases, T);

//\\ P<closer> =
   case G_closer:
     if (alt == 0)               {  //\\    <semi>,
       T[++phrases] = build_ast(CST(P++) /* G_semi */);
     } else if (alt == 1)        {  //\\    <comma>,
       T[++phrases] = build_ast(CST(P++) /* G_comma */);
     } else if (alt == 2)        {  //\\    <rb>,
       T[++phrases] = build_ast(CST(P++) /* G_rb */);
     } else if (alt == 3)        {  //\\    <end>,
       T[++phrases] = build_ast(CST(P++) /* G_end */);
     } else if (alt == 4)        {  //\\    <else>,
       T[++phrases] = build_ast(CST(P++) /* G_else */);
     } else                      {  //\\    <then>;
       T[++phrases] = build_ast(CST(P++) /* G_then */);
     }
     return T[0] = mktuple(G_closer, alt, phrases, T);

//\\ P<semi> =
   case G_semi:
                                    //\\    ";";
     T[++phrases] = kw(CST(P++), ";");
     return T[0] = mktuple(G_semi, alt, phrases, T);

//\\ P<comma> =
   case G_comma:
                                    //\\    ",";
     T[++phrases] = kw(CST(P++), ",");
     return T[0] = mktuple(G_comma, alt, phrases, T);

//\\ P<rb> =
   case G_rb:
                                    //\\    ")";
     T[++phrases] = kw(CST(P++), ")");
     return T[0] = mktuple(G_rb, alt, phrases, T);

//\\ P<end> =
   case G_end:
                                    //\\    "e̲n̲d̲";
     T[++phrases] = kw(CST(P++), "e̲n̲d̲");
     return T[0] = mktuple(G_end, alt, phrases, T);

//\\ P<else> =
   case G_else:
                                    //\\    "e̲l̲s̲e̲";
     T[++phrases] = kw(CST(P++), "e̲l̲s̲e̲");
     return T[0] = mktuple(G_else, alt, phrases, T);

//\\ P<then> =
   case G_then:
                                    //\\    "t̲h̲e̲n̲";
     T[++phrases] = kw(CST(P++), "t̲h̲e̲n̲");
     return T[0] = mktuple(G_then, alt, phrases, T);

//\\ P<ENDTEXT> =
   case G_ENDTEXT:
     if (alt == 0)               {  //\\    <!semi> <!end> <!else> <ch> <ENDTEXT>,
       T[++phrases] = -1 +(0 * P++);
       T[++phrases] = -1 +(0 * P++);
       T[++phrases] = -1 +(0 * P++);
       T[++phrases] = build_ast(CST(P++) /* G_ch */);
       T[++phrases] = build_ast(CST(P++) /* G_ENDTEXT */);
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_ENDTEXT, alt, phrases, T);

//\\ P<stropped-keywords> =
   case G_stropped_keywords:
                                    //\\    "'";
     T[++phrases] = kw(CST(P++), "'");
     return T[0] = mktuple(G_stropped_keywords, alt, phrases, T);

//\\ P<optional-stropping-conversion> =
   case G_optional_stropping_conversion:
     if (alt == 0)               {  //\\    <?stropped_keywords> <convert-keywords>,
       T[++phrases] = -build_ast(CST(P++) /* G_stropped_keywords */);
       T[++phrases] = -1 +(0 * P++) /* S_convert-keywords */ /* semantic call - temp for now. Could theoretically return a string like a terminal. Parser needs to insert something in CST. */;
     } else                      {  //\\    ;
     }
     return T[0] = mktuple(G_optional_stropping_conversion, alt, phrases, T);

//\\ E
