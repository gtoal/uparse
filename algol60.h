#ifndef _GRAMMAR_H_
#define _GRAMMAR_H_ 1

#include <wchar.h>

#ifndef TRUE
#define TRUE (0==0)
#endif

#ifndef FALSE
#define FALSE (0!=0)
#endif

typedef int (*parsefn)(void);

#define LARGEST_ALT 13 // Max number of phrases in any Alt: 0 (Reserved), 1:12

#define NEGATED_PHRASE     (1U<<24U)
#define GUARD_PHRASE       (1U<<25U)
#define WHITESPACE_ALLOWED (1U<<26U)
#define GRAMMAR_TYPE_SHIFT 27U
#define GRAMMAR_TYPE_MASK  31U
#define BIP_TYPE         (1U <<27U)
#define PHRASE_TYPE      (2U <<27U)
#define SEMANTIC_TYPE    (3U <<27U)
#define KEYWORD_TYPE     (4U <<27U)
#define CHAR_TYPE        (5U <<27U)
#define UTF32CHAR_TYPE   (6U <<27U)
#define STRING_TYPE      (7U <<27U)
#define UTF32STRING_TYPE (8U <<27U)
#define REGEXP_TYPE      (9U <<27U)
#define OPTION_TYPE      (10U <<27U)
#define COUNT_OF_ALTS    (11U <<27U)
#define COUNT_OF_PHRASES (12U <<27U)
#define ALT_NUMBER       (13U <<27U)
#define INDEX_MASK       0xFFFFFFU
// (We have room for types 1..31)
#define PhraseType(idx)  ((((idx)>>27U)&31U))


#define BIP_BASE 0
#define PHRASE_BASE 2
#define SEMANTIC_BASE 161
#define AST_BASE 164

#define NUM_BIPS 2
#define NUM_SIMPLE_PHRASES 159
#define NUM_SEMANTIC_PHRASES 3
#define NUM_PHRASES (NUM_BIPS+NUM_SIMPLE_PHRASES+NUM_SEMANTIC_PHRASES)

#define NUM_KEYWORDS 127
#define NUM_REGEXPS 8
#define NUM_GRAMMAR 1157

#define B_EOF 0
#define B_nl 2
#define P_SS 2
#define P_SOURCE 3
#define P_semi_opt 4
#define P_MAIN_PROGRAM 5
#define P_PROGRAM_opt 6
#define P_EXTERNAL_LEVEL_OBJECTS 7
#define P_EXTERNAL_LEVEL 8
#define P_PROCTYPE_opt 9
#define P_BOOLEAN 10
#define P_PROCEDURE 11
#define P_FORMAL_PARAMS_opt 12
#define P_MORE_FP_LIST 13
#define P_FORMAL_PARAMETER 14
#define P_VALUE_opt 15
#define P_VALUE_NAMELIST 16
#define P_MORE_VALUE_NAMELIST 17
#define P_VALUE_NAME 18
#define P_COMMENT_NO_SEMI 19
#define P_COMMENT 20
#define P_COMMENTS_opt 21
#define P_MORE_COMMENTS 22
#define P_COMMENTTEXT 23
#define P_NONSEMITEXT 24
#define P_OPT_MORELINES 25
#define P_LABELS_opt 26
#define P_comment_keyword 27
#define P_assign 28
#define P_PARAMETER_TYPES_opt 29
#define P_PARAMETER_TYPE 30
#define P_PDECLN 31
#define P_DECLIST 32
#define P_MORE_DECLIST 33
#define P_LOCAL_DECLARATION 34
#define P_SWITCH_DECLS 35
#define P_MORE_SWITCH_DECLS 36
#define P_SWITCH_DECL 37
#define P_OPT_ARRAY 38
#define P_JUMP_TARGET 39
#define P_LEXPR 40
#define P_SLEXPR 41
#define P_OWN_DECLARATION 42
#define P_OWN_ARRAY_DECLN 43
#define P_LOCAL_ARRAY_DECLN 44
#define P_LOCAL_SCALAR_DECLN 45
#define P_OWN_BOUNDED_DECLIST 46
#define P_BOUNDED_DECLIST 47
#define P_MORE_OWN_BOUNDED_DECLIST 48
#define P_MORE_BOUNDED_DECLIST 49
#define P_OWN_BOUNDS_DECLARATION 50
#define P_BOUNDS_DECLARATION 51
#define P_OWN_BOUNDS_DECLIST 52
#define P_BOUNDS_DECLIST 53
#define P_MORE_OWN_BOUNDS_DECLIST 54
#define P_MORE_BOUNDS_DECLIST 55
#define P_OWN_BOUND_DEC 56
#define P_BOUND_DEC 57
#define P_COLON_WARN_COMMA 58
#define P_CONST_EXPR 59
#define P_PROCBODY 60
#define P_LOCAL_BLOCK 61
#define P_MORE_LOCAL_STATEMENTS 62
#define P_LOCAL_STATEMENT 63
#define P_CODE 64
#define P_ONOFF 65
#define P_OPT_ELSE 66
#define P_FLE 67
#define P_REST_OF_FLE 68
#define P_FORLIST 69
#define P_MORE_LHS 70
#define P_ASSIGNMENT 71
#define P_LHS 72
#define P_RHS 73
#define P_function_designator 74
#define P_ACTUAL_PARAMETERS 75
#define P_MORE_ACTUAL_PARAMETERS 76
#define P_FPSEP 77
#define P_ACTUAL_PARAMETER 78
#define P_OPERAND 79
#define P_ARRAY_INDEX 80
#define P_ARRAY_INDICES 81
#define P_primary 82
#define P_exp_op 83
#define P_exp_factor 84
#define P_factor 85
#define P_mul_op 86
#define P_rdiv_op 87
#define P_idiv_op 88
#define P_div_op 89
#define P_muldiv_op 90
#define P_mul_factor 91
#define P_term 92
#define P_add_op 93
#define P_sub_op 94
#define P_addsub_op 95
#define P_add_term 96
#define P_simple_arithmetic_expression 97
#define P_arithmetic_expression 98
#define P_INTEGER_CONSTANT 99
#define P_REAL_CONSTANT 100
#define P_unsigned 101
#define P_decfract 102
#define P_decimalpoint 103
#define P_expart 104
#define P_decnum 105
#define P_subten 106
#define P_PLUS_MINUS_opt 107
#define P_logical_value 108
#define P_relational_operator 109
#define P_ARRAY_LB 110
#define P_ARRAY_RB 111
#define P_relation 112
#define P_Boolean_primary 113
#define P_not_term 114
#define P_not_terms 115
#define P_Boolean_secondary 116
#define P_and_term 117
#define P_and_Boolean_factor 118
#define P_Boolean_factor 119
#define P_or_term 120
#define P_or_Boolean_term 121
#define P_Boolean_term 122
#define P_impl_term 123
#define P_more_implication_Boolean 124
#define P_implication_Boolean 125
#define P_equiv_term 126
#define P_equiv_simple_Boolean 127
#define P_simple_Boolean 128
#define P_Boolean_expression 129
#define P_ch 130
#define P_stropped 131
#define P_NAME 132
#define P_ALPHANUMS 133
#define P_ALPHA 134
#define P_ALPHANUM 135
#define P_DIGITS 136
#define P_DIGIT 137
#define P_MORE_DIGITS 138
#define P_string_literal 139
#define P_dchs 140
#define P_dch 141
#define P_ldquo 142
#define P_rdquo 143
#define P_BALANCED_STRING 144
#define P_BALANCED_CHAR_SEQUENCE 145
#define P_BALANCED_CHAR 146
#define P_RB 147
#define P_C_STRING 148
#define P_C_CHARS 149
#define P_dquote 150
#define P_closer 151
#define P_semi 152
#define P_comma 153
#define P_rb 154
#define P_end 155
#define P_else 156
#define P_then 157
#define P_ENDTEXT 158
#define P_stropped_keywords 159
#define P_optional_stropping_conversion 160
#define S_init 0
#define S_terminate 1
#define S_convert_keywords 2

extern const int bip_map[NUM_BIPS];
extern const int sequential_phrase_no_to_grammar_index[NUM_SIMPLE_PHRASES];
extern const wchar_t *phrasename[NUM_BIPS+NUM_SIMPLE_PHRASES+NUM_SEMANTIC_PHRASES];

extern const wchar_t *semantic_phrasename[NUM_SEMANTIC_PHRASES];
extern const wchar_t *semantic_code[NUM_SEMANTIC_PHRASES];
extern const wchar_t *xcomment[NUM_PHRASES];
extern const wchar_t *keyword[NUM_KEYWORDS];
extern const wchar_t *regexps[NUM_REGEXPS];

extern const int gram[NUM_GRAMMAR];
#define G_SS 0
#define G_SOURCE 6
#define G_semi_opt 14
#define G_MAIN_PROGRAM 18
#define G_PROGRAM_opt 26
#define G_EXTERNAL_LEVEL_OBJECTS 32
#define G_EXTERNAL_LEVEL 37
#define G_PROCTYPE_opt 52
#define G_BOOLEAN 60
#define G_PROCEDURE 65
#define G_FORMAL_PARAMS_opt 77
#define G_MORE_FP_LIST 84
#define G_FORMAL_PARAMETER 90
#define G_VALUE_opt 93
#define G_VALUE_NAMELIST 99
#define G_MORE_VALUE_NAMELIST 103
#define G_VALUE_NAME 108
#define G_COMMENT_NO_SEMI 111
#define G_COMMENT 115
#define G_COMMENTS_opt 119
#define G_MORE_COMMENTS 124
#define G_COMMENTTEXT 130
#define G_NONSEMITEXT 134
#define G_OPT_MORELINES 137
#define G_LABELS_opt 143
#define G_comment_keyword 151
#define G_assign 154
#define G_PARAMETER_TYPES_opt 157
#define G_PARAMETER_TYPE 163
#define G_PDECLN 186
#define G_DECLIST 195
#define G_MORE_DECLIST 199
#define G_LOCAL_DECLARATION 205
#define G_SWITCH_DECLS 231
#define G_MORE_SWITCH_DECLS 235
#define G_SWITCH_DECL 241
#define G_OPT_ARRAY 251
#define G_JUMP_TARGET 257
#define G_LEXPR 260
#define G_SLEXPR 274
#define G_OWN_DECLARATION 282
#define G_OWN_ARRAY_DECLN 310
#define G_LOCAL_ARRAY_DECLN 314
#define G_LOCAL_SCALAR_DECLN 318
#define G_OWN_BOUNDED_DECLIST 321
#define G_BOUNDED_DECLIST 326
#define G_MORE_OWN_BOUNDED_DECLIST 331
#define G_MORE_BOUNDED_DECLIST 338
#define G_OWN_BOUNDS_DECLARATION 345
#define G_BOUNDS_DECLARATION 350
#define G_OWN_BOUNDS_DECLIST 355
#define G_BOUNDS_DECLIST 359
#define G_MORE_OWN_BOUNDS_DECLIST 363
#define G_MORE_BOUNDS_DECLIST 369
#define G_OWN_BOUND_DEC 375
#define G_BOUND_DEC 380
#define G_COLON_WARN_COMMA 385
#define G_CONST_EXPR 392
#define G_PROCBODY 395
#define G_LOCAL_BLOCK 435
#define G_MORE_LOCAL_STATEMENTS 441
#define G_LOCAL_STATEMENT 448
#define G_CODE 489
#define G_ONOFF 493
#define G_OPT_ELSE 498
#define G_FLE 513
#define G_REST_OF_FLE 517
#define G_FORLIST 527
#define G_MORE_LHS 533
#define G_ASSIGNMENT 540
#define G_LHS 547
#define G_RHS 556
#define G_function_designator 563
#define G_ACTUAL_PARAMETERS 569
#define G_MORE_ACTUAL_PARAMETERS 575
#define G_FPSEP 581
#define G_ACTUAL_PARAMETER 589
#define G_OPERAND 598
#define G_ARRAY_INDEX 615
#define G_ARRAY_INDICES 618
#define G_primary 624
#define G_exp_op 628
#define G_exp_factor 639
#define G_factor 644
#define G_mul_op 648
#define G_rdiv_op 653
#define G_idiv_op 656
#define G_div_op 667
#define G_muldiv_op 672
#define G_mul_factor 677
#define G_term 682
#define G_add_op 686
#define G_sub_op 689
#define G_addsub_op 692
#define G_add_term 697
#define G_simple_arithmetic_expression 702
#define G_arithmetic_expression 706
#define G_INTEGER_CONSTANT 716
#define G_REAL_CONSTANT 720
#define G_unsigned 724
#define G_decfract 732
#define G_decimalpoint 736
#define G_expart 741
#define G_decnum 745
#define G_subten 753
#define G_PLUS_MINUS_opt 766
#define G_logical_value 774
#define G_relational_operator 779
#define G_ARRAY_LB 838
#define G_ARRAY_RB 843
#define G_relation 848
#define G_Boolean_primary 853
#define G_not_term 872
#define G_not_terms 881
#define G_Boolean_secondary 886
#define G_and_term 893
#define G_and_Boolean_factor 900
#define G_Boolean_factor 905
#define G_or_term 909
#define G_or_Boolean_term 914
#define G_Boolean_term 919
#define G_impl_term 923
#define G_more_implication_Boolean 936
#define G_implication_Boolean 941
#define G_equiv_term 945
#define G_equiv_simple_Boolean 954
#define G_simple_Boolean 959
#define G_Boolean_expression 963
#define G_ch 973
#define G_stropped 978
#define G_NAME 981
#define G_ALPHANUMS 985
#define G_ALPHA 990
#define G_ALPHANUM 994
#define G_DIGITS 998
#define G_DIGIT 1002
#define G_MORE_DIGITS 1005
#define G_string_literal 1010
#define G_dchs 1015
#define G_dch 1020
#define G_ldquo 1024
#define G_rdquo 1041
#define G_BALANCED_STRING 1058
#define G_BALANCED_CHAR_SEQUENCE 1063
#define G_BALANCED_CHAR 1068
#define G_RB 1074
#define G_C_STRING 1077
#define G_C_CHARS 1090
#define G_dquote 1107
#define G_closer 1110
#define G_semi 1123
#define G_comma 1126
#define G_rb 1129
#define G_end 1132
#define G_else 1135
#define G_then 1138
#define G_ENDTEXT 1141
#define G_stropped_keywords 1149
#define G_optional_stropping_conversion 1152

extern parsefn parsetime[NUM_SEMANTIC_PHRASES];
extern int parse_init(void);
extern int parse_terminate(void);
extern int parse_convert_keywords(void);

#ifndef SUPPRESS_DATA
const wchar_t *phrasename[NUM_BIPS+NUM_SIMPLE_PHRASES+NUM_SEMANTIC_PHRASES] = {
  /*0+0*/   L"EOF" /*0*/,
  /*0+1*/   L"nl" /*2*/,
  /*2+0*/   L"SS",
  /*2+1*/   L"SOURCE",
  /*2+2*/   L"semi_opt",
  /*2+3*/   L"MAIN-PROGRAM",
  /*2+4*/   L"PROGRAM_opt",
  /*2+5*/   L"EXTERNAL-LEVEL-OBJECTS",
  /*2+6*/   L"EXTERNAL-LEVEL",
  /*2+7*/   L"PROCTYPE_opt",
  /*2+8*/   L"BOOLEAN",
  /*2+9*/   L"PROCEDURE",
  /*2+10*/   L"FORMAL_PARAMS_opt",
  /*2+11*/   L"MORE-FP-LIST",
  /*2+12*/   L"FORMAL-PARAMETER",
  /*2+13*/   L"VALUE_opt",
  /*2+14*/   L"VALUE-NAMELIST",
  /*2+15*/   L"MORE-VALUE-NAMELIST",
  /*2+16*/   L"VALUE-NAME",
  /*2+17*/   L"COMMENT-NO-SEMI",
  /*2+18*/   L"COMMENT",
  /*2+19*/   L"COMMENTS_opt",
  /*2+20*/   L"MORE-COMMENTS",
  /*2+21*/   L"COMMENTTEXT",
  /*2+22*/   L"NONSEMITEXT",
  /*2+23*/   L"OPT-MORELINES",
  /*2+24*/   L"LABELS_opt",
  /*2+25*/   L"comment-keyword",
  /*2+26*/   L"assign",
  /*2+27*/   L"PARAMETER-TYPES_opt",
  /*2+28*/   L"PARAMETER-TYPE",
  /*2+29*/   L"PDECLN",
  /*2+30*/   L"DECLIST",
  /*2+31*/   L"MORE-DECLIST",
  /*2+32*/   L"LOCAL-DECLARATION",
  /*2+33*/   L"SWITCH-DECLS",
  /*2+34*/   L"MORE-SWITCH-DECLS",
  /*2+35*/   L"SWITCH-DECL",
  /*2+36*/   L"OPT-ARRAY",
  /*2+37*/   L"JUMP-TARGET",
  /*2+38*/   L"LEXPR",
  /*2+39*/   L"SLEXPR",
  /*2+40*/   L"OWN-DECLARATION",
  /*2+41*/   L"OWN-ARRAY-DECLN",
  /*2+42*/   L"LOCAL-ARRAY-DECLN",
  /*2+43*/   L"LOCAL-SCALAR-DECLN",
  /*2+44*/   L"OWN-BOUNDED-DECLIST",
  /*2+45*/   L"BOUNDED-DECLIST",
  /*2+46*/   L"MORE-OWN-BOUNDED-DECLIST",
  /*2+47*/   L"MORE-BOUNDED-DECLIST",
  /*2+48*/   L"OWN-BOUNDS-DECLARATION",
  /*2+49*/   L"BOUNDS-DECLARATION",
  /*2+50*/   L"OWN-BOUNDS-DECLIST",
  /*2+51*/   L"BOUNDS-DECLIST",
  /*2+52*/   L"MORE-OWN-BOUNDS-DECLIST",
  /*2+53*/   L"MORE-BOUNDS-DECLIST",
  /*2+54*/   L"OWN-BOUND-DEC",
  /*2+55*/   L"BOUND-DEC",
  /*2+56*/   L"COLON-WARN-COMMA",
  /*2+57*/   L"CONST-EXPR",
  /*2+58*/   L"PROCBODY",
  /*2+59*/   L"LOCAL-BLOCK",
  /*2+60*/   L"MORE-LOCAL-STATEMENTS",
  /*2+61*/   L"LOCAL-STATEMENT",
  /*2+62*/   L"CODE",
  /*2+63*/   L"ONOFF",
  /*2+64*/   L"OPT-ELSE",
  /*2+65*/   L"FLE",
  /*2+66*/   L"REST-OF-FLE",
  /*2+67*/   L"FORLIST",
  /*2+68*/   L"MORE-LHS",
  /*2+69*/   L"ASSIGNMENT",
  /*2+70*/   L"LHS",
  /*2+71*/   L"RHS",
  /*2+72*/   L"function_designator",
  /*2+73*/   L"ACTUAL-PARAMETERS",
  /*2+74*/   L"MORE-ACTUAL-PARAMETERS",
  /*2+75*/   L"FPSEP",
  /*2+76*/   L"ACTUAL-PARAMETER",
  /*2+77*/   L"OPERAND",
  /*2+78*/   L"ARRAY-INDEX",
  /*2+79*/   L"ARRAY-INDICES",
  /*2+80*/   L"primary",
  /*2+81*/   L"exp-op",
  /*2+82*/   L"exp-factor",
  /*2+83*/   L"factor",
  /*2+84*/   L"mul-op",
  /*2+85*/   L"rdiv-op",
  /*2+86*/   L"idiv-op",
  /*2+87*/   L"div-op",
  /*2+88*/   L"muldiv-op",
  /*2+89*/   L"mul-factor",
  /*2+90*/   L"term",
  /*2+91*/   L"add-op",
  /*2+92*/   L"sub-op",
  /*2+93*/   L"addsub-op",
  /*2+94*/   L"add-term",
  /*2+95*/   L"simple_arithmetic_expression",
  /*2+96*/   L"arithmetic_expression",
  /*2+97*/   L"INTEGER-CONSTANT",
  /*2+98*/   L"REAL-CONSTANT",
  /*2+99*/   L"unsigned",
  /*2+100*/   L"decfract",
  /*2+101*/   L"decimalpoint",
  /*2+102*/   L"expart",
  /*2+103*/   L"decnum",
  /*2+104*/   L"subten",
  /*2+105*/   L"PLUS-MINUS-opt",
  /*2+106*/   L"logical_value",
  /*2+107*/   L"relational_operator",
  /*2+108*/   L"ARRAY-LB",
  /*2+109*/   L"ARRAY-RB",
  /*2+110*/   L"relation",
  /*2+111*/   L"Boolean_primary",
  /*2+112*/   L"not-term",
  /*2+113*/   L"not-terms",
  /*2+114*/   L"Boolean_secondary",
  /*2+115*/   L"and-term",
  /*2+116*/   L"and_Boolean_factor",
  /*2+117*/   L"Boolean_factor",
  /*2+118*/   L"or-term",
  /*2+119*/   L"or_Boolean_term",
  /*2+120*/   L"Boolean_term",
  /*2+121*/   L"impl-term",
  /*2+122*/   L"more_implication_Boolean",
  /*2+123*/   L"implication_Boolean",
  /*2+124*/   L"equiv-term",
  /*2+125*/   L"equiv_simple_Boolean",
  /*2+126*/   L"simple_Boolean",
  /*2+127*/   L"Boolean_expression",
  /*2+128*/   L"ch",
  /*2+129*/   L"stropped",
  /*2+130*/   L"NAME",
  /*2+131*/   L"ALPHANUMS",
  /*2+132*/   L"ALPHA",
  /*2+133*/   L"ALPHANUM",
  /*2+134*/   L"DIGITS",
  /*2+135*/   L"DIGIT",
  /*2+136*/   L"MORE-DIGITS",
  /*2+137*/   L"string_literal",
  /*2+138*/   L"dchs",
  /*2+139*/   L"dch",
  /*2+140*/   L"ldquo",
  /*2+141*/   L"rdquo",
  /*2+142*/   L"BALANCED-STRING",
  /*2+143*/   L"BALANCED-CHAR-SEQUENCE",
  /*2+144*/   L"BALANCED-CHAR",
  /*2+145*/   L"RB",
  /*2+146*/   L"C-STRING",
  /*2+147*/   L"C-CHARS",
  /*2+148*/   L"dquote",
  /*2+149*/   L"closer",
  /*2+150*/   L"semi",
  /*2+151*/   L"comma",
  /*2+152*/   L"rb",
  /*2+153*/   L"end",
  /*2+154*/   L"else",
  /*2+155*/   L"then",
  /*2+156*/   L"ENDTEXT",
  /*2+157*/   L"stropped-keywords",
  /*2+158*/   L"optional-stropping-conversion",
  /*161+0*/   L"init",
  /*161+1*/   L"terminate",
  /*161+2*/   L"convert-keywords",
};
const wchar_t *phrasename_c[NUM_BIPS+NUM_SIMPLE_PHRASES+NUM_SEMANTIC_PHRASES] = {
  /*0+0*/   L"EOF" /*0*/,
  /*0+1*/   L"nl" /*2*/,
  /*2+0*/   L"SS",
  /*2+1*/   L"SOURCE",
  /*2+2*/   L"semi_opt",
  /*2+3*/   L"MAIN_PROGRAM",
  /*2+4*/   L"PROGRAM_opt",
  /*2+5*/   L"EXTERNAL_LEVEL_OBJECTS",
  /*2+6*/   L"EXTERNAL_LEVEL",
  /*2+7*/   L"PROCTYPE_opt",
  /*2+8*/   L"BOOLEAN",
  /*2+9*/   L"PROCEDURE",
  /*2+10*/   L"FORMAL_PARAMS_opt",
  /*2+11*/   L"MORE_FP_LIST",
  /*2+12*/   L"FORMAL_PARAMETER",
  /*2+13*/   L"VALUE_opt",
  /*2+14*/   L"VALUE_NAMELIST",
  /*2+15*/   L"MORE_VALUE_NAMELIST",
  /*2+16*/   L"VALUE_NAME",
  /*2+17*/   L"COMMENT_NO_SEMI",
  /*2+18*/   L"COMMENT",
  /*2+19*/   L"COMMENTS_opt",
  /*2+20*/   L"MORE_COMMENTS",
  /*2+21*/   L"COMMENTTEXT",
  /*2+22*/   L"NONSEMITEXT",
  /*2+23*/   L"OPT_MORELINES",
  /*2+24*/   L"LABELS_opt",
  /*2+25*/   L"comment_keyword",
  /*2+26*/   L"assign",
  /*2+27*/   L"PARAMETER_TYPES_opt",
  /*2+28*/   L"PARAMETER_TYPE",
  /*2+29*/   L"PDECLN",
  /*2+30*/   L"DECLIST",
  /*2+31*/   L"MORE_DECLIST",
  /*2+32*/   L"LOCAL_DECLARATION",
  /*2+33*/   L"SWITCH_DECLS",
  /*2+34*/   L"MORE_SWITCH_DECLS",
  /*2+35*/   L"SWITCH_DECL",
  /*2+36*/   L"OPT_ARRAY",
  /*2+37*/   L"JUMP_TARGET",
  /*2+38*/   L"LEXPR",
  /*2+39*/   L"SLEXPR",
  /*2+40*/   L"OWN_DECLARATION",
  /*2+41*/   L"OWN_ARRAY_DECLN",
  /*2+42*/   L"LOCAL_ARRAY_DECLN",
  /*2+43*/   L"LOCAL_SCALAR_DECLN",
  /*2+44*/   L"OWN_BOUNDED_DECLIST",
  /*2+45*/   L"BOUNDED_DECLIST",
  /*2+46*/   L"MORE_OWN_BOUNDED_DECLIST",
  /*2+47*/   L"MORE_BOUNDED_DECLIST",
  /*2+48*/   L"OWN_BOUNDS_DECLARATION",
  /*2+49*/   L"BOUNDS_DECLARATION",
  /*2+50*/   L"OWN_BOUNDS_DECLIST",
  /*2+51*/   L"BOUNDS_DECLIST",
  /*2+52*/   L"MORE_OWN_BOUNDS_DECLIST",
  /*2+53*/   L"MORE_BOUNDS_DECLIST",
  /*2+54*/   L"OWN_BOUND_DEC",
  /*2+55*/   L"BOUND_DEC",
  /*2+56*/   L"COLON_WARN_COMMA",
  /*2+57*/   L"CONST_EXPR",
  /*2+58*/   L"PROCBODY",
  /*2+59*/   L"LOCAL_BLOCK",
  /*2+60*/   L"MORE_LOCAL_STATEMENTS",
  /*2+61*/   L"LOCAL_STATEMENT",
  /*2+62*/   L"CODE",
  /*2+63*/   L"ONOFF",
  /*2+64*/   L"OPT_ELSE",
  /*2+65*/   L"FLE",
  /*2+66*/   L"REST_OF_FLE",
  /*2+67*/   L"FORLIST",
  /*2+68*/   L"MORE_LHS",
  /*2+69*/   L"ASSIGNMENT",
  /*2+70*/   L"LHS",
  /*2+71*/   L"RHS",
  /*2+72*/   L"function_designator",
  /*2+73*/   L"ACTUAL_PARAMETERS",
  /*2+74*/   L"MORE_ACTUAL_PARAMETERS",
  /*2+75*/   L"FPSEP",
  /*2+76*/   L"ACTUAL_PARAMETER",
  /*2+77*/   L"OPERAND",
  /*2+78*/   L"ARRAY_INDEX",
  /*2+79*/   L"ARRAY_INDICES",
  /*2+80*/   L"primary",
  /*2+81*/   L"exp_op",
  /*2+82*/   L"exp_factor",
  /*2+83*/   L"factor",
  /*2+84*/   L"mul_op",
  /*2+85*/   L"rdiv_op",
  /*2+86*/   L"idiv_op",
  /*2+87*/   L"div_op",
  /*2+88*/   L"muldiv_op",
  /*2+89*/   L"mul_factor",
  /*2+90*/   L"term",
  /*2+91*/   L"add_op",
  /*2+92*/   L"sub_op",
  /*2+93*/   L"addsub_op",
  /*2+94*/   L"add_term",
  /*2+95*/   L"simple_arithmetic_expression",
  /*2+96*/   L"arithmetic_expression",
  /*2+97*/   L"INTEGER_CONSTANT",
  /*2+98*/   L"REAL_CONSTANT",
  /*2+99*/   L"unsigned",
  /*2+100*/   L"decfract",
  /*2+101*/   L"decimalpoint",
  /*2+102*/   L"expart",
  /*2+103*/   L"decnum",
  /*2+104*/   L"subten",
  /*2+105*/   L"PLUS_MINUS_opt",
  /*2+106*/   L"logical_value",
  /*2+107*/   L"relational_operator",
  /*2+108*/   L"ARRAY_LB",
  /*2+109*/   L"ARRAY_RB",
  /*2+110*/   L"relation",
  /*2+111*/   L"Boolean_primary",
  /*2+112*/   L"not_term",
  /*2+113*/   L"not_terms",
  /*2+114*/   L"Boolean_secondary",
  /*2+115*/   L"and_term",
  /*2+116*/   L"and_Boolean_factor",
  /*2+117*/   L"Boolean_factor",
  /*2+118*/   L"or_term",
  /*2+119*/   L"or_Boolean_term",
  /*2+120*/   L"Boolean_term",
  /*2+121*/   L"impl_term",
  /*2+122*/   L"more_implication_Boolean",
  /*2+123*/   L"implication_Boolean",
  /*2+124*/   L"equiv_term",
  /*2+125*/   L"equiv_simple_Boolean",
  /*2+126*/   L"simple_Boolean",
  /*2+127*/   L"Boolean_expression",
  /*2+128*/   L"ch",
  /*2+129*/   L"stropped",
  /*2+130*/   L"NAME",
  /*2+131*/   L"ALPHANUMS",
  /*2+132*/   L"ALPHA",
  /*2+133*/   L"ALPHANUM",
  /*2+134*/   L"DIGITS",
  /*2+135*/   L"DIGIT",
  /*2+136*/   L"MORE_DIGITS",
  /*2+137*/   L"string_literal",
  /*2+138*/   L"dchs",
  /*2+139*/   L"dch",
  /*2+140*/   L"ldquo",
  /*2+141*/   L"rdquo",
  /*2+142*/   L"BALANCED_STRING",
  /*2+143*/   L"BALANCED_CHAR_SEQUENCE",
  /*2+144*/   L"BALANCED_CHAR",
  /*2+145*/   L"RB",
  /*2+146*/   L"C_STRING",
  /*2+147*/   L"C_CHARS",
  /*2+148*/   L"dquote",
  /*2+149*/   L"closer",
  /*2+150*/   L"semi",
  /*2+151*/   L"comma",
  /*2+152*/   L"rb",
  /*2+153*/   L"end",
  /*2+154*/   L"else",
  /*2+155*/   L"then",
  /*2+156*/   L"ENDTEXT",
  /*2+157*/   L"stropped_keywords",
  /*2+158*/   L"optional_stropping_conversion",
  /*161+0*/   L"init",
  /*161+1*/   L"terminate",
  /*161+2*/   L"convert_keywords",
};
const int bip_map[NUM_BIPS] = {
  /*0*/   0,
  /*1*/   2,
};
const int sequential_phrase_no_to_grammar_index[NUM_SIMPLE_PHRASES] = {
  G_SS,  /*0*/
  G_SOURCE,  /*6*/
  G_semi_opt,  /*14*/
  G_MAIN_PROGRAM,  /*18*/
  G_PROGRAM_opt,  /*26*/
  G_EXTERNAL_LEVEL_OBJECTS,  /*32*/
  G_EXTERNAL_LEVEL,  /*37*/
  G_PROCTYPE_opt,  /*52*/
  G_BOOLEAN,  /*60*/
  G_PROCEDURE,  /*65*/
  G_FORMAL_PARAMS_opt,  /*77*/
  G_MORE_FP_LIST,  /*84*/
  G_FORMAL_PARAMETER,  /*90*/
  G_VALUE_opt,  /*93*/
  G_VALUE_NAMELIST,  /*99*/
  G_MORE_VALUE_NAMELIST,  /*103*/
  G_VALUE_NAME,  /*108*/
  G_COMMENT_NO_SEMI,  /*111*/
  G_COMMENT,  /*115*/
  G_COMMENTS_opt,  /*119*/
  G_MORE_COMMENTS,  /*124*/
  G_COMMENTTEXT,  /*130*/
  G_NONSEMITEXT,  /*134*/
  G_OPT_MORELINES,  /*137*/
  G_LABELS_opt,  /*143*/
  G_comment_keyword,  /*151*/
  G_assign,  /*154*/
  G_PARAMETER_TYPES_opt,  /*157*/
  G_PARAMETER_TYPE,  /*163*/
  G_PDECLN,  /*186*/
  G_DECLIST,  /*195*/
  G_MORE_DECLIST,  /*199*/
  G_LOCAL_DECLARATION,  /*205*/
  G_SWITCH_DECLS,  /*231*/
  G_MORE_SWITCH_DECLS,  /*235*/
  G_SWITCH_DECL,  /*241*/
  G_OPT_ARRAY,  /*251*/
  G_JUMP_TARGET,  /*257*/
  G_LEXPR,  /*260*/
  G_SLEXPR,  /*274*/
  G_OWN_DECLARATION,  /*282*/
  G_OWN_ARRAY_DECLN,  /*310*/
  G_LOCAL_ARRAY_DECLN,  /*314*/
  G_LOCAL_SCALAR_DECLN,  /*318*/
  G_OWN_BOUNDED_DECLIST,  /*321*/
  G_BOUNDED_DECLIST,  /*326*/
  G_MORE_OWN_BOUNDED_DECLIST,  /*331*/
  G_MORE_BOUNDED_DECLIST,  /*338*/
  G_OWN_BOUNDS_DECLARATION,  /*345*/
  G_BOUNDS_DECLARATION,  /*350*/
  G_OWN_BOUNDS_DECLIST,  /*355*/
  G_BOUNDS_DECLIST,  /*359*/
  G_MORE_OWN_BOUNDS_DECLIST,  /*363*/
  G_MORE_BOUNDS_DECLIST,  /*369*/
  G_OWN_BOUND_DEC,  /*375*/
  G_BOUND_DEC,  /*380*/
  G_COLON_WARN_COMMA,  /*385*/
  G_CONST_EXPR,  /*392*/
  G_PROCBODY,  /*395*/
  G_LOCAL_BLOCK,  /*435*/
  G_MORE_LOCAL_STATEMENTS,  /*441*/
  G_LOCAL_STATEMENT,  /*448*/
  G_CODE,  /*489*/
  G_ONOFF,  /*493*/
  G_OPT_ELSE,  /*498*/
  G_FLE,  /*513*/
  G_REST_OF_FLE,  /*517*/
  G_FORLIST,  /*527*/
  G_MORE_LHS,  /*533*/
  G_ASSIGNMENT,  /*540*/
  G_LHS,  /*547*/
  G_RHS,  /*556*/
  G_function_designator,  /*563*/
  G_ACTUAL_PARAMETERS,  /*569*/
  G_MORE_ACTUAL_PARAMETERS,  /*575*/
  G_FPSEP,  /*581*/
  G_ACTUAL_PARAMETER,  /*589*/
  G_OPERAND,  /*598*/
  G_ARRAY_INDEX,  /*615*/
  G_ARRAY_INDICES,  /*618*/
  G_primary,  /*624*/
  G_exp_op,  /*628*/
  G_exp_factor,  /*639*/
  G_factor,  /*644*/
  G_mul_op,  /*648*/
  G_rdiv_op,  /*653*/
  G_idiv_op,  /*656*/
  G_div_op,  /*667*/
  G_muldiv_op,  /*672*/
  G_mul_factor,  /*677*/
  G_term,  /*682*/
  G_add_op,  /*686*/
  G_sub_op,  /*689*/
  G_addsub_op,  /*692*/
  G_add_term,  /*697*/
  G_simple_arithmetic_expression,  /*702*/
  G_arithmetic_expression,  /*706*/
  G_INTEGER_CONSTANT,  /*716*/
  G_REAL_CONSTANT,  /*720*/
  G_unsigned,  /*724*/
  G_decfract,  /*732*/
  G_decimalpoint,  /*736*/
  G_expart,  /*741*/
  G_decnum,  /*745*/
  G_subten,  /*753*/
  G_PLUS_MINUS_opt,  /*766*/
  G_logical_value,  /*774*/
  G_relational_operator,  /*779*/
  G_ARRAY_LB,  /*838*/
  G_ARRAY_RB,  /*843*/
  G_relation,  /*848*/
  G_Boolean_primary,  /*853*/
  G_not_term,  /*872*/
  G_not_terms,  /*881*/
  G_Boolean_secondary,  /*886*/
  G_and_term,  /*893*/
  G_and_Boolean_factor,  /*900*/
  G_Boolean_factor,  /*905*/
  G_or_term,  /*909*/
  G_or_Boolean_term,  /*914*/
  G_Boolean_term,  /*919*/
  G_impl_term,  /*923*/
  G_more_implication_Boolean,  /*936*/
  G_implication_Boolean,  /*941*/
  G_equiv_term,  /*945*/
  G_equiv_simple_Boolean,  /*954*/
  G_simple_Boolean,  /*959*/
  G_Boolean_expression,  /*963*/
  G_ch,  /*973*/
  G_stropped,  /*978*/
  G_NAME,  /*981*/
  G_ALPHANUMS,  /*985*/
  G_ALPHA,  /*990*/
  G_ALPHANUM,  /*994*/
  G_DIGITS,  /*998*/
  G_DIGIT,  /*1002*/
  G_MORE_DIGITS,  /*1005*/
  G_string_literal,  /*1010*/
  G_dchs,  /*1015*/
  G_dch,  /*1020*/
  G_ldquo,  /*1024*/
  G_rdquo,  /*1041*/
  G_BALANCED_STRING,  /*1058*/
  G_BALANCED_CHAR_SEQUENCE,  /*1063*/
  G_BALANCED_CHAR,  /*1068*/
  G_RB,  /*1074*/
  G_C_STRING,  /*1077*/
  G_C_CHARS,  /*1090*/
  G_dquote,  /*1107*/
  G_closer,  /*1110*/
  G_semi,  /*1123*/
  G_comma,  /*1126*/
  G_rb,  /*1129*/
  G_end,  /*1132*/
  G_else,  /*1135*/
  G_then,  /*1138*/
  G_ENDTEXT,  /*1141*/
  G_stropped_keywords,  /*1149*/
  G_optional_stropping_conversion,  /*1152*/
};

const wchar_t *semantic_phrasename[NUM_SEMANTIC_PHRASES] = {
  /*0*/   L"init",
  /*1*/   L"terminate",
  /*2*/   L"convert-keywords",
};

const wchar_t *semantic_code[NUM_SEMANTIC_PHRASES] = {
  /*0*/   L"\n"
             "  // peform any initialisation required by the parse-time semantic routines.\n"
             "  // Note that for now, we have no way of declaring data outside of\n"
             "  // those procedures.  Obviously this will have to change.\n"
             "  return TRUE;\n",
  /*1*/   L"\n"
             "  // perform any final tidy-up required by the parse-time semantic routines.\n"
             "  return TRUE;\n",
  /*2*/   L"\n"
             "#ifdef IN_PARSER\n"
             "  int debug_stropping = 0;\n"
             "\n"
             "  // Loop through the source() array and convert 'stropped' keywords into u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲ keywords.\n"
             "  // This draft version unfortunately *will* convert stropped words in strings and comments.\n"
             "  // - see tests/cacm/101.a60 for examples...\n"
             "  // Will try to fix later although the syntax of comments at the end of a procedure block\n"
             "  // means that a simple lexical filter may just not be possible.\n"
             "\n"
             "  int FP = 0, PP = 0;\n"
             "\n"
             "  // AN EXTRA ARRAY IS NEEDED HERE BECAUSE THE STROPPING ADDS AN EXTRA\n"
             "  // CHARACTER *PER LETTER* AND OVERWRITES THE INPUT AT FP!  These extra\n"
             "  // characters are not compensated for by the removal of the two quotes.\n"
             "  // It would be so much nicer if we had a single Unicode character representing\n"
             "  // a stropped letter.  Would solve a nasty lexing problem as well as this.\n"
             "\n"
             "  DECLARE(stropped_source, wint_t, 600000); \n"
             "  #define _stropped_source(x) WRITE(x,stropped_source,wint_t)\n"
             "  #define  stropped_source(x) READ(x,stropped_source,wint_t)\n"
             "\n"
             "  for (;;) {\n"
             "    wint_t WC = source(FP++);\n"
             "    if (WC == '\\'') {\n"
             "      int Peek = FP;\n"
             "      while (isalpha(source(Peek))) { Peek += 1; };\n"
             "      if (source(Peek) == '\\'') {\n"
             "        // We have 'KEYWORD'\n"
             "        // opening ' skipped already\n"
             "        while (isalpha(source(FP))) {\n"
             "          WC = source(FP++);\n"
             "          if (isupper(WC)) WC = tolower(WC);\n"
             "          _stropped_source(PP++) = WC; _stropped_source(PP++) = 818 /* Unicode COMBINING LOW LINE */;\n"
             "          if (debug_stropping) fwprintf(stderr, L\"%lc%lc\", WC, (wchar_t)818);\n"
             "        }\n"
             "        FP++; // skip closing '\n"
             "      } else {\n"
             "        // Doesn't fit the pattern, so don't convert\n"
             "        // But first, check for character constants, eg '('\n"
             "        Peek = FP; WC = source(Peek);\n"
             "        if (WC != 0 && source(Peek+1) == '\\'') {\n"
             "          // Single character constant.  We'll worry about strings later.\n"
             "          _stropped_source(PP++) = '\\'';\n"
             "          _stropped_source(PP++) = WC;    FP += 1;\n"
             "          _stropped_source(PP++) = '\\'';  FP += 1;\n"
             "          if (debug_stropping) fwprintf(stderr, L\"'%lc'\", WC);\n"
             "        } else {\n"
             "          _stropped_source(PP++) = '\\'';\n"
             "          if (debug_stropping) fwprintf(stderr, L\"'\");\n"
             "        }\n"
             "      }\n"
             "      continue;\n"
             "    }\n"
             "    _stropped_source(PP++) = WC;\n"
             "    if (debug_stropping) if (WC) fwprintf(stderr, L\"%lc\", WC);\n"
             "    if (WC == 0) break; // convert up to end of file.\n"
             "  }\n"
             "\n"
             "  // copy back from stropped_source to source\n"
             "  for (FP = 0; FP < PP; FP++) {\n"
             "    _source(FP) = stropped_source(FP);\n"
             "  }\n"
             "  // free stropped_source\n"
             "  FREE_FLEX(stropped_source);\n"
             "\n"
             "#endif\n"
             "  return TRUE;\n",
};

parsefn parsetime[NUM_SEMANTIC_PHRASES] = {
  /*0*/   &parse_init,
  /*1*/   &parse_terminate,
  /*2*/   &parse_convert_keywords,
};

// Comments are stored so that they can be re-inserted, should
// we need to regenerate a grammar.g file from this header file.
const wchar_t *xcomment[NUM_PHRASES] = {
  /*  0*/   NULL,
  /*  1*/   NULL,
  /*  2*/   NULL,
  /*  3*/   NULL,
  /*  4*/   NULL,
  /*  5*/   NULL,
  /*  6*/   NULL,
  /*  7*/   NULL,
  /*  8*/   NULL,
  /*  9*/   NULL,
  /* 10*/   NULL,
  /* 11*/   NULL,
  /* 12*/   NULL,
  /* 13*/   NULL,
  /* 14*/   NULL,
  /* 15*/   NULL,
  /* 16*/   NULL,
  /* 17*/   NULL,
  /* 18*/   NULL,
  /* 19*/   NULL,
  /* 20*/   NULL,
  /* 21*/   NULL,
  /* 22*/   NULL,
  /* 23*/   NULL,
  /* 24*/   NULL,
  /* 25*/   NULL,
  /* 26*/   NULL,
  /* 27*/   NULL,
  /* 28*/   NULL,
  /* 29*/   NULL,
  /* 30*/   NULL,
  /* 31*/   NULL,
  /* 32*/   NULL,
  /* 33*/   NULL,
  /* 34*/   NULL,
  /* 35*/   NULL,
  /* 36*/   NULL,
  /* 37*/   NULL,
  /* 38*/   NULL,
  /* 39*/   NULL,
  /* 40*/   NULL,
  /* 41*/   NULL,
  /* 42*/   NULL,
  /* 43*/   NULL,
  /* 44*/   NULL,
  /* 45*/   NULL,
  /* 46*/   NULL,
  /* 47*/   NULL,
  /* 48*/   NULL,
  /* 49*/   NULL,
  /* 50*/   NULL,
  /* 51*/   NULL,
  /* 52*/   NULL,
  /* 53*/   NULL,
  /* 54*/   NULL,
  /* 55*/   NULL,
  /* 56*/   NULL,
  /* 57*/   NULL,
  /* 58*/   NULL,
  /* 59*/   NULL,
  /* 60*/   NULL,
  /* 61*/   NULL,
  /* 62*/   NULL,
  /* 63*/   NULL,
  /* 64*/   NULL,
  /* 65*/   NULL,
  /* 66*/   NULL,
  /* 67*/   NULL,
  /* 68*/   NULL,
  /* 69*/   NULL,
  /* 70*/   NULL,
  /* 71*/   NULL,
  /* 72*/   NULL,
  /* 73*/   NULL,
  /* 74*/   NULL,
  /* 75*/   NULL,
  /* 76*/   NULL,
  /* 77*/   NULL,
  /* 78*/   NULL,
  /* 79*/   NULL,
  /* 80*/   NULL,
  /* 81*/   NULL,
  /* 82*/   NULL,
  /* 83*/   NULL,
  /* 84*/   NULL,
  /* 85*/   NULL,
  /* 86*/   NULL,
  /* 87*/   NULL,
  /* 88*/   NULL,
  /* 89*/   NULL,
  /* 90*/   NULL,
  /* 91*/   NULL,
  /* 92*/   NULL,
  /* 93*/   NULL,
  /* 94*/   NULL,
  /* 95*/   NULL,
  /* 96*/   NULL,
  /* 97*/   NULL,
  /* 98*/   NULL,
  /* 99*/   NULL,
  /*100*/   NULL,
  /*101*/   NULL,
  /*102*/   NULL,
  /*103*/   NULL,
  /*104*/   NULL,
  /*105*/   NULL,
  /*106*/   NULL,
  /*107*/   NULL,
  /*108*/   NULL,
  /*109*/   NULL,
  /*110*/   NULL,
  /*111*/   NULL,
  /*112*/   NULL,
  /*113*/   NULL,
  /*114*/   NULL,
  /*115*/   NULL,
  /*116*/   NULL,
  /*117*/   NULL,
  /*118*/   NULL,
  /*119*/   NULL,
  /*120*/   NULL,
  /*121*/   NULL,
  /*122*/   NULL,
  /*123*/   NULL,
  /*124*/   NULL,
  /*125*/   NULL,
  /*126*/   NULL,
  /*127*/   NULL,
  /*128*/   NULL,
  /*129*/   NULL,
  /*130*/   NULL,
  /*131*/   NULL,
  /*132*/   NULL,
  /*133*/   NULL,
  /*134*/   NULL,
  /*135*/   NULL,
  /*136*/   NULL,
  /*137*/   NULL,
  /*138*/   NULL,
  /*139*/   NULL,
  /*140*/   NULL,
  /*141*/   NULL,
  /*142*/   NULL,
  /*143*/   NULL,
  /*144*/   NULL,
  /*145*/   NULL,
  /*146*/   NULL,
  /*147*/   NULL,
  /*148*/   NULL,
  /*149*/   NULL,
  /*150*/   NULL,
  /*151*/   NULL,
  /*152*/   NULL,
  /*153*/   NULL,
  /*154*/   NULL,
  /*155*/   NULL,
  /*156*/   NULL,
  /*157*/   NULL,
  /*158*/   NULL,
  /*159*/   NULL,
  /*160*/   NULL,
  /*161*/   NULL,
  /*162*/   NULL,
  /*163*/   NULL,
};
const wchar_t *keyword[NUM_KEYWORDS] = {
  /*  0*/   L"b̲e̲g̲i̲n̲",
  /*  1*/   L"e̲n̲d̲",
  /*  2*/   L"p̲r̲o̲g̲r̲a̲m̲",
  /*  3*/   L"e̲o̲p̲",
  /*  4*/   L"c̲o̲d̲e̲",
  /*  5*/   L"i̲n̲t̲e̲g̲e̲r̲",
  /*  6*/   L"r̲e̲a̲l̲",
  /*  7*/   L"B̲o̲o̲l̲e̲a̲n̲",
  /*  8*/   L"b̲o̲o̲l̲e̲a̲n̲",
  /*  9*/   L"p̲r̲o̲c̲e̲d̲u̲r̲e̲",
  /* 10*/   L"(",
  /* 11*/   L")",
  /* 12*/   L"v̲a̲l̲u̲e̲",
  /* 13*/   L",",
  /* 14*/   L"c̲o̲m̲m̲e̲n̲t̲",
  /* 15*/   L":",
  /* 16*/   L":=",
  /* 17*/   L"l̲a̲b̲e̲l̲",
  /* 18*/   L"s̲w̲i̲t̲c̲h̲",
  /* 19*/   L"s̲t̲r̲i̲n̲g̲",
  /* 20*/   L"a̲r̲r̲a̲y̲",
  /* 21*/   L"i̲f̲",
  /* 22*/   L"t̲h̲e̲n̲",
  /* 23*/   L"e̲l̲s̲e̲",
  /* 24*/   L"o̲w̲n̲",
  /* 25*/   L"..",
  /* 26*/   L"a̲l̲g̲o̲l̲",
  /* 27*/   L"f̲o̲r̲t̲r̲a̲n̲",
  /* 28*/   L"e̲x̲t̲e̲r̲n̲a̲l̲",
  /* 29*/   L"f̲o̲r̲",
  /* 30*/   L"d̲o̲",
  /* 31*/   L"g̲o̲",
  /* 32*/   L"t̲o̲",
  /* 33*/   L"o̲n̲",
  /* 34*/   L"o̲f̲f̲",
  /* 35*/   L"s̲t̲e̲p̲",
  /* 36*/   L"u̲n̲t̲i̲l̲",
  /* 37*/   L"w̲h̲i̲l̲e̲",
  /* 38*/   L"^",
  /* 39*/   L"**",
  /* 40*/   L"⭡",
  /* 41*/   L"|^",
  /* 42*/   L"p̲o̲w̲e̲r̲",
  /* 43*/   L"*",
  /* 44*/   L"×",
  /* 45*/   L"/",
  /* 46*/   L"//",
  /* 47*/   L"÷",
  /* 48*/   L"%",
  /* 49*/   L"d̲i̲v̲",
  /* 50*/   L"'/'",
  /* 51*/   L"+",
  /* 52*/   L"-",
  /* 53*/   L".",
  /* 54*/   L"·",
  /* 55*/   L"@",
  /* 56*/   L"&",
  /* 57*/   L"⏨",
  /* 58*/   L"\\u23E8",
  /* 59*/   L"\\u2081\\u2080",
  /* 60*/   L"'10'",
  /* 61*/   L"t̲r̲u̲e̲",
  /* 62*/   L"f̲a̲l̲s̲e̲",
  /* 63*/   L"=",
  /* 64*/   L"e̲q̲u̲a̲l̲",
  /* 65*/   L"e̲q̲",
  /* 66*/   L">=",
  /* 67*/   L"≥",
  /* 68*/   L"g̲e̲",
  /* 69*/   L"n̲o̲t̲l̲e̲s̲s̲",
  /* 70*/   L"g̲r̲e̲q̲",
  /* 71*/   L">",
  /* 72*/   L"g̲t̲",
  /* 73*/   L"g̲r̲e̲a̲t̲e̲r̲",
  /* 74*/   L"<>",
  /* 75*/   L"#",
  /* 76*/   L"≠",
  /* 77*/   L"n̲e̲",
  /* 78*/   L"n̲o̲t̲e̲q̲u̲a̲l̲",
  /* 79*/   L"\\=",
  /* 80*/   L"¬=",
  /* 81*/   L"!=",
  /* 82*/   L"^=",
  /* 83*/   L"|=",
  /* 84*/   L"<=",
  /* 85*/   L"≤",
  /* 86*/   L"l̲e̲s̲s̲e̲q̲",
  /* 87*/   L"n̲o̲t̲g̲r̲e̲a̲t̲e̲r̲",
  /* 88*/   L"<",
  /* 89*/   L"l̲t̲",
  /* 90*/   L"l̲e̲s̲s̲",
  /* 91*/   L"l̲e̲",
  /* 92*/   L"(/",
  /* 93*/   L"/)",
  /* 94*/   L"n̲o̲t̲",
  /* 95*/   L"¬",
  /* 96*/   L"!",
  /* 97*/   L"~",
  /* 98*/   L"a̲n̲d̲",
  /* 99*/   L"∧",
  /*100*/   L"o̲r̲",
  /*101*/   L"∨",
  /*102*/   L"i̲m̲p̲l̲i̲e̲s̲",
  /*103*/   L"i̲m̲p̲l̲",
  /*104*/   L"i̲m̲p̲",
  /*105*/   L"⊃",
  /*106*/   L"\\u2283",
  /*107*/   L"->",
  /*108*/   L"e̲q̲u̲i̲v̲",
  /*109*/   L"e̲q̲v̲",
  /*110*/   L"≡",
  /*111*/   L"==",
  /*112*/   L"“",
  /*113*/   L"‘",
  /*114*/   L"'('",
  /*115*/   L"«",
  /*116*/   L"|<",
  /*117*/   L"”",
  /*118*/   L"’",
  /*119*/   L"')'",
  /*120*/   L"»",
  /*121*/   L"|>",
  /*122*/   L"``",
  /*123*/   L"''",
  /*124*/   L"`",
  /*125*/   L"'",
  /*126*/   L";",
};
const wchar_t *regexps[NUM_REGEXPS] = {
  /*0*/   L"^[^;]*",
  /*1*/   L"^[ ]*[A-Za-z][A-Za-z ]*",
  /*2*/   L"^.",
  /*3*/   L"^(a̲|b̲|c̲|d̲|e̲|f̲|g̲|h̲|i̲|j̲|k̲|l̲|m̲|n̲|o̲|p̲|q̲|r̲|s̲|t̲|u̲|v̲|w̲|x̲|y̲|z̲|A̲|B̲|C̲|D̲|E̲|F̲|G̲|H̲|I̲|J̲|K̲|L̲|M̲|N̲|O̲|P̲|Q̲|R̲|S̲|T̲|U̲|V̲|W̲|X̲|Y̲|Z̲)",
  /*4*/   L"^[A-Za-z]",
  /*5*/   L"^[A-Za-z0-9 ]",
  /*6*/   L"^[0-9]",
  /*7*/   L"^[^']*",
};
const int gram[NUM_GRAMMAR /* 1157 */] = {

// P<SS> = ...;
  /*  0*/ COUNT_OF_ALTS    | 0x000001,
  /*  1*/ COUNT_OF_PHRASES | 0x000004,
  /*  2*/ SEMANTIC_TYPE    | S_init,
  /*  3*/ PHRASE_TYPE      | G_optional_stropping_conversion,
  /*  4*/ PHRASE_TYPE      | G_SOURCE,
  /*  5*/ SEMANTIC_TYPE    | S_terminate,

// P<SOURCE> = ...;
  /*  6*/ COUNT_OF_ALTS    | 0x000002,
  /*  7*/ COUNT_OF_PHRASES | 0x000003,
  /*  8*/ PHRASE_TYPE      | G_MAIN_PROGRAM,
  /*  9*/ PHRASE_TYPE      | G_semi_opt,
  /* 10*/ BIP_TYPE         | WHITESPACE_ALLOWED | B_EOF,
  /* 11*/ COUNT_OF_PHRASES | 0x000002,
  /* 12*/ PHRASE_TYPE      | G_EXTERNAL_LEVEL_OBJECTS,
  /* 13*/ BIP_TYPE         | WHITESPACE_ALLOWED | B_EOF,

// P<semi_opt> = ...;
  /* 14*/ COUNT_OF_ALTS    | 0x000002,
  /* 15*/ COUNT_OF_PHRASES | 0x000001,
  /* 16*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /* 17*/ COUNT_OF_PHRASES | 0x000000,

// P<MAIN-PROGRAM> = ...;
  /* 18*/ COUNT_OF_ALTS    | 0x000001,
  /* 19*/ COUNT_OF_PHRASES | 0x000006,
  /* 20*/ PHRASE_TYPE      | G_PROGRAM_opt,
  /* 21*/ PHRASE_TYPE      | G_COMMENTS_opt,
  /* 22*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000000,  /* b̲e̲g̲i̲n̲ */
  /* 23*/ PHRASE_TYPE      | G_LOCAL_BLOCK,
  /* 24*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000001,  /* e̲n̲d̲ */
  /* 25*/ PHRASE_TYPE      | G_ENDTEXT,

// P<PROGRAM_opt> = ...;
  /* 26*/ COUNT_OF_ALTS    | 0x000002,
  /* 27*/ COUNT_OF_PHRASES | 0x000003,
  /* 28*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000002,  /* p̲r̲o̲g̲r̲a̲m̲ */
  /* 29*/ PHRASE_TYPE      | G_NAME,
  /* 30*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /* 31*/ COUNT_OF_PHRASES | 0x000000,

// P<EXTERNAL-LEVEL-OBJECTS> = ...;
  /* 32*/ COUNT_OF_ALTS    | 0x000002,
  /* 33*/ COUNT_OF_PHRASES | 0x000002,
  /* 34*/ PHRASE_TYPE      | G_EXTERNAL_LEVEL,
  /* 35*/ PHRASE_TYPE      | G_EXTERNAL_LEVEL_OBJECTS,
  /* 36*/ COUNT_OF_PHRASES | 0x000000,

// P<EXTERNAL-LEVEL> = ...;
  /* 37*/ COUNT_OF_ALTS    | 0x000005,
  /* 38*/ COUNT_OF_PHRASES | 0x000001,
  /* 39*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000003,  /* e̲o̲p̲ */
  /* 40*/ COUNT_OF_PHRASES | 0x000003,
  /* 41*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000004,  /* c̲o̲d̲e̲ */
  /* 42*/ PHRASE_TYPE      | G_DIGITS,
  /* 43*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /* 44*/ COUNT_OF_PHRASES | 0x000001,
  /* 45*/ PHRASE_TYPE      | G_COMMENT,
  /* 46*/ COUNT_OF_PHRASES | 0x000002,
  /* 47*/ PHRASE_TYPE      | G_PROCEDURE,
  /* 48*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /* 49*/ COUNT_OF_PHRASES | 0x000002,
  /* 50*/ PHRASE_TYPE      | G_OWN_DECLARATION,
  /* 51*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */

// P<PROCTYPE_opt> = ...;
  /* 52*/ COUNT_OF_ALTS    | 0x000004,
  /* 53*/ COUNT_OF_PHRASES | 0x000001,
  /* 54*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000005,  /* i̲n̲t̲e̲g̲e̲r̲ */
  /* 55*/ COUNT_OF_PHRASES | 0x000001,
  /* 56*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000006,  /* r̲e̲a̲l̲ */
  /* 57*/ COUNT_OF_PHRASES | 0x000001,
  /* 58*/ PHRASE_TYPE      | G_BOOLEAN,
  /* 59*/ COUNT_OF_PHRASES | 0x000000,

// P<BOOLEAN> = ...;
  /* 60*/ COUNT_OF_ALTS    | 0x000002,
  /* 61*/ COUNT_OF_PHRASES | 0x000001,
  /* 62*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000007,  /* B̲o̲o̲l̲e̲a̲n̲ */
  /* 63*/ COUNT_OF_PHRASES | 0x000001,
  /* 64*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000008,  /* b̲o̲o̲l̲e̲a̲n̲ */

// P<PROCEDURE> = ...;
  /* 65*/ COUNT_OF_ALTS    | 0x000001,
  /* 66*/ COUNT_OF_PHRASES | 0x00000a,
  /* 67*/ PHRASE_TYPE      | G_PROCTYPE_opt,
  /* 68*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000009,  /* p̲r̲o̲c̲e̲d̲u̲r̲e̲ */
  /* 69*/ PHRASE_TYPE      | G_NAME,
  /* 70*/ PHRASE_TYPE      | G_FORMAL_PARAMS_opt,
  /* 71*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /* 72*/ PHRASE_TYPE      | G_COMMENTS_opt,
  /* 73*/ PHRASE_TYPE      | G_VALUE_opt,
  /* 74*/ PHRASE_TYPE      | G_PARAMETER_TYPES_opt,
  /* 75*/ PHRASE_TYPE      | G_LABELS_opt,
  /* 76*/ PHRASE_TYPE      | G_PROCBODY,

// P<FORMAL_PARAMS_opt> = ...;
  /* 77*/ COUNT_OF_ALTS    | 0x000002,
  /* 78*/ COUNT_OF_PHRASES | 0x000004,
  /* 79*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000a,  /* ( */
  /* 80*/ PHRASE_TYPE      | G_NAME,
  /* 81*/ PHRASE_TYPE      | G_MORE_FP_LIST,
  /* 82*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000b,  /* ) */
  /* 83*/ COUNT_OF_PHRASES | 0x000000,

// P<MORE-FP-LIST> = ...;
  /* 84*/ COUNT_OF_ALTS    | 0x000002,
  /* 85*/ COUNT_OF_PHRASES | 0x000003,
  /* 86*/ PHRASE_TYPE      | G_FPSEP,
  /* 87*/ PHRASE_TYPE      | G_FORMAL_PARAMETER,
  /* 88*/ PHRASE_TYPE      | G_MORE_FP_LIST,
  /* 89*/ COUNT_OF_PHRASES | 0x000000,

// P<FORMAL-PARAMETER> = ...;
  /* 90*/ COUNT_OF_ALTS    | 0x000001,
  /* 91*/ COUNT_OF_PHRASES | 0x000001,
  /* 92*/ PHRASE_TYPE      | G_NAME,

// P<VALUE_opt> = ...;
  /* 93*/ COUNT_OF_ALTS    | 0x000002,
  /* 94*/ COUNT_OF_PHRASES | 0x000003,
  /* 95*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000c,  /* v̲a̲l̲u̲e̲ */
  /* 96*/ PHRASE_TYPE      | G_VALUE_NAMELIST,
  /* 97*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /* 98*/ COUNT_OF_PHRASES | 0x000000,

// P<VALUE-NAMELIST> = ...;
  /* 99*/ COUNT_OF_ALTS    | 0x000001,
  /*100*/ COUNT_OF_PHRASES | 0x000002,
  /*101*/ PHRASE_TYPE      | G_VALUE_NAME,
  /*102*/ PHRASE_TYPE      | G_MORE_VALUE_NAMELIST,

// P<MORE-VALUE-NAMELIST> = ...;
  /*103*/ COUNT_OF_ALTS    | 0x000002,
  /*104*/ COUNT_OF_PHRASES | 0x000002,
  /*105*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000d,  /* , */
  /*106*/ PHRASE_TYPE      | G_VALUE_NAMELIST,
  /*107*/ COUNT_OF_PHRASES | 0x000000,

// P<VALUE-NAME> = ...;
  /*108*/ COUNT_OF_ALTS    | 0x000001,
  /*109*/ COUNT_OF_PHRASES | 0x000001,
  /*110*/ PHRASE_TYPE      | G_NAME,

// P<COMMENT-NO-SEMI> = ...;
  /*111*/ COUNT_OF_ALTS    | 0x000001,
  /*112*/ COUNT_OF_PHRASES | 0x000002,
  /*113*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000e,  /* c̲o̲m̲m̲e̲n̲t̲ */
  /*114*/ PHRASE_TYPE      | G_COMMENTTEXT,

// P<COMMENT> = ...;
  /*115*/ COUNT_OF_ALTS    | 0x000001,
  /*116*/ COUNT_OF_PHRASES | 0x000002,
  /*117*/ PHRASE_TYPE      | G_COMMENT_NO_SEMI,
  /*118*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */

// P<COMMENTS_opt> = ...;
  /*119*/ COUNT_OF_ALTS    | 0x000002,
  /*120*/ COUNT_OF_PHRASES | 0x000002,
  /*121*/ PHRASE_TYPE      | G_COMMENT,
  /*122*/ PHRASE_TYPE      | G_MORE_COMMENTS,
  /*123*/ COUNT_OF_PHRASES | 0x000000,

// P<MORE-COMMENTS> = ...;
  /*124*/ COUNT_OF_ALTS    | 0x000002,
  /*125*/ COUNT_OF_PHRASES | 0x000003,
  /*126*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /*127*/ PHRASE_TYPE      | G_COMMENT,
  /*128*/ PHRASE_TYPE      | G_MORE_COMMENTS,
  /*129*/ COUNT_OF_PHRASES | 0x000000,

// P<COMMENTTEXT> = ...;
  /*130*/ COUNT_OF_ALTS    | 0x000001,
  /*131*/ COUNT_OF_PHRASES | 0x000002,
  /*132*/ PHRASE_TYPE      | G_NONSEMITEXT,
  /*133*/ PHRASE_TYPE      | G_OPT_MORELINES,

// P<NONSEMITEXT> = ...;
  /*134*/ COUNT_OF_ALTS    | 0x000001,
  /*135*/ COUNT_OF_PHRASES | 0x000001,
  /*136*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000000,  /* ^[^;]* */

// P<OPT-MORELINES> = ...;
  /*137*/ COUNT_OF_ALTS    | 0x000002,
  /*138*/ COUNT_OF_PHRASES | 0x000003,
  /*139*/ BIP_TYPE         | B_nl,
  /*140*/ PHRASE_TYPE      | G_NONSEMITEXT,
  /*141*/ PHRASE_TYPE      | G_OPT_MORELINES,
  /*142*/ COUNT_OF_PHRASES | 0x000000,

// P<LABELS_opt> = ...;
  /*143*/ COUNT_OF_ALTS    | 0x000002,
  /*144*/ COUNT_OF_PHRASES | 0x000005,
  /*145*/ PHRASE_TYPE      | G_NAME,
  /*146*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_assign,
  /*147*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000f,  /* : */
  /*148*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_comment_keyword,
  /*149*/ PHRASE_TYPE      | G_LABELS_opt,
  /*150*/ COUNT_OF_PHRASES | 0x000000,

// P<comment-keyword> = ...;
  /*151*/ COUNT_OF_ALTS    | 0x000001,
  /*152*/ COUNT_OF_PHRASES | 0x000001,
  /*153*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000e,  /* c̲o̲m̲m̲e̲n̲t̲ */

// P<assign> = ...;
  /*154*/ COUNT_OF_ALTS    | 0x000001,
  /*155*/ COUNT_OF_PHRASES | 0x000001,
  /*156*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000010,  /* := */

// P<PARAMETER-TYPES_opt> = ...;
  /*157*/ COUNT_OF_ALTS    | 0x000002,
  /*158*/ COUNT_OF_PHRASES | 0x000003,
  /*159*/ PHRASE_TYPE      | G_PARAMETER_TYPE,
  /*160*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /*161*/ PHRASE_TYPE      | G_PARAMETER_TYPES_opt,
  /*162*/ COUNT_OF_PHRASES | 0x000000,

// P<PARAMETER-TYPE> = ...;
  /*163*/ COUNT_OF_ALTS    | 0x000008,
  /*164*/ COUNT_OF_PHRASES | 0x000002,
  /*165*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000011,  /* l̲a̲b̲e̲l̲ */
  /*166*/ PHRASE_TYPE      | G_DECLIST,
  /*167*/ COUNT_OF_PHRASES | 0x000002,
  /*168*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000012,  /* s̲w̲i̲t̲c̲h̲ */
  /*169*/ PHRASE_TYPE      | G_DECLIST,
  /*170*/ COUNT_OF_PHRASES | 0x000002,
  /*171*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000013,  /* s̲t̲r̲i̲n̲g̲ */
  /*172*/ PHRASE_TYPE      | G_DECLIST,
  /*173*/ COUNT_OF_PHRASES | 0x000002,
  /*174*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000005,  /* i̲n̲t̲e̲g̲e̲r̲ */
  /*175*/ PHRASE_TYPE      | G_PDECLN,
  /*176*/ COUNT_OF_PHRASES | 0x000002,
  /*177*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000006,  /* r̲e̲a̲l̲ */
  /*178*/ PHRASE_TYPE      | G_PDECLN,
  /*179*/ COUNT_OF_PHRASES | 0x000002,
  /*180*/ PHRASE_TYPE      | G_BOOLEAN,
  /*181*/ PHRASE_TYPE      | G_PDECLN,
  /*182*/ COUNT_OF_PHRASES | 0x000001,
  /*183*/ PHRASE_TYPE      | G_PDECLN,
  /*184*/ COUNT_OF_PHRASES | 0x000001,
  /*185*/ PHRASE_TYPE      | G_COMMENT_NO_SEMI,

// P<PDECLN> = ...;
  /*186*/ COUNT_OF_ALTS    | 0x000003,
  /*187*/ COUNT_OF_PHRASES | 0x000002,
  /*188*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000014,  /* a̲r̲r̲a̲y̲ */
  /*189*/ PHRASE_TYPE      | G_DECLIST,
  /*190*/ COUNT_OF_PHRASES | 0x000002,
  /*191*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000009,  /* p̲r̲o̲c̲e̲d̲u̲r̲e̲ */
  /*192*/ PHRASE_TYPE      | G_DECLIST,
  /*193*/ COUNT_OF_PHRASES | 0x000001,
  /*194*/ PHRASE_TYPE      | G_DECLIST,

// P<DECLIST> = ...;
  /*195*/ COUNT_OF_ALTS    | 0x000001,
  /*196*/ COUNT_OF_PHRASES | 0x000002,
  /*197*/ PHRASE_TYPE      | G_NAME,
  /*198*/ PHRASE_TYPE      | G_MORE_DECLIST,

// P<MORE-DECLIST> = ...;
  /*199*/ COUNT_OF_ALTS    | 0x000002,
  /*200*/ COUNT_OF_PHRASES | 0x000003,
  /*201*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000d,  /* , */
  /*202*/ PHRASE_TYPE      | G_NAME,
  /*203*/ PHRASE_TYPE      | G_MORE_DECLIST,
  /*204*/ COUNT_OF_PHRASES | 0x000000,

// P<LOCAL-DECLARATION> = ...;
  /*205*/ COUNT_OF_ALTS    | 0x000008,
  /*206*/ COUNT_OF_PHRASES | 0x000002,
  /*207*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000005,  /* i̲n̲t̲e̲g̲e̲r̲ */
  /*208*/ PHRASE_TYPE      | G_LOCAL_ARRAY_DECLN,
  /*209*/ COUNT_OF_PHRASES | 0x000002,
  /*210*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000005,  /* i̲n̲t̲e̲g̲e̲r̲ */
  /*211*/ PHRASE_TYPE      | G_LOCAL_SCALAR_DECLN,
  /*212*/ COUNT_OF_PHRASES | 0x000002,
  /*213*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000006,  /* r̲e̲a̲l̲ */
  /*214*/ PHRASE_TYPE      | G_LOCAL_ARRAY_DECLN,
  /*215*/ COUNT_OF_PHRASES | 0x000001,
  /*216*/ PHRASE_TYPE      | G_LOCAL_ARRAY_DECLN,
  /*217*/ COUNT_OF_PHRASES | 0x000002,
  /*218*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000006,  /* r̲e̲a̲l̲ */
  /*219*/ PHRASE_TYPE      | G_LOCAL_SCALAR_DECLN,
  /*220*/ COUNT_OF_PHRASES | 0x000002,
  /*221*/ PHRASE_TYPE      | G_BOOLEAN,
  /*222*/ PHRASE_TYPE      | G_LOCAL_ARRAY_DECLN,
  /*223*/ COUNT_OF_PHRASES | 0x000002,
  /*224*/ PHRASE_TYPE      | G_BOOLEAN,
  /*225*/ PHRASE_TYPE      | G_LOCAL_SCALAR_DECLN,
  /*226*/ COUNT_OF_PHRASES | 0x000004,
  /*227*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000012,  /* s̲w̲i̲t̲c̲h̲ */
  /*228*/ PHRASE_TYPE      | G_NAME,
  /*229*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000010,  /* := */
  /*230*/ PHRASE_TYPE      | G_SWITCH_DECLS,

// P<SWITCH-DECLS> = ...;
  /*231*/ COUNT_OF_ALTS    | 0x000001,
  /*232*/ COUNT_OF_PHRASES | 0x000002,
  /*233*/ PHRASE_TYPE      | G_SWITCH_DECL,
  /*234*/ PHRASE_TYPE      | G_MORE_SWITCH_DECLS,

// P<MORE-SWITCH-DECLS> = ...;
  /*235*/ COUNT_OF_ALTS    | 0x000002,
  /*236*/ COUNT_OF_PHRASES | 0x000003,
  /*237*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00002c,  /* ',' */
  /*238*/ PHRASE_TYPE      | G_SWITCH_DECL,
  /*239*/ PHRASE_TYPE      | G_MORE_SWITCH_DECLS,
  /*240*/ COUNT_OF_PHRASES | 0x000000,

// P<SWITCH-DECL> = ...;
  /*241*/ COUNT_OF_ALTS    | 0x000003,
  /*242*/ COUNT_OF_PHRASES | 0x000004,
  /*243*/ PHRASE_TYPE      | G_DECLIST,
  /*244*/ PHRASE_TYPE      | G_ARRAY_LB,
  /*245*/ PHRASE_TYPE      | G_CONST_EXPR,
  /*246*/ PHRASE_TYPE      | G_ARRAY_RB,
  /*247*/ COUNT_OF_PHRASES | 0x000001,
  /*248*/ PHRASE_TYPE      | G_DECLIST,
  /*249*/ COUNT_OF_PHRASES | 0x000001,
  /*250*/ PHRASE_TYPE      | G_LEXPR,

// P<OPT-ARRAY> = ...;
  /*251*/ COUNT_OF_ALTS    | 0x000002,
  /*252*/ COUNT_OF_PHRASES | 0x000003,
  /*253*/ PHRASE_TYPE      | G_ARRAY_LB,
  /*254*/ PHRASE_TYPE      | G_CONST_EXPR,
  /*255*/ PHRASE_TYPE      | G_ARRAY_RB,
  /*256*/ COUNT_OF_PHRASES | 0x000000,

// P<JUMP-TARGET> = ...;
  /*257*/ COUNT_OF_ALTS    | 0x000001,
  /*258*/ COUNT_OF_PHRASES | 0x000001,
  /*259*/ PHRASE_TYPE      | G_LEXPR,

// P<LEXPR> = ...;
  /*260*/ COUNT_OF_ALTS    | 0x000003,
  /*261*/ COUNT_OF_PHRASES | 0x000003,
  /*262*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000028,  /* '(' */
  /*263*/ PHRASE_TYPE      | G_LEXPR,
  /*264*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000029,  /* ')' */
  /*265*/ COUNT_OF_PHRASES | 0x000006,
  /*266*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000015,  /* i̲f̲ */
  /*267*/ PHRASE_TYPE      | G_Boolean_expression,
  /*268*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000016,  /* t̲h̲e̲n̲ */
  /*269*/ PHRASE_TYPE      | G_SLEXPR,
  /*270*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000017,  /* e̲l̲s̲e̲ */
  /*271*/ PHRASE_TYPE      | G_LEXPR,
  /*272*/ COUNT_OF_PHRASES | 0x000001,
  /*273*/ PHRASE_TYPE      | G_SLEXPR,

// P<SLEXPR> = ...;
  /*274*/ COUNT_OF_ALTS    | 0x000002,
  /*275*/ COUNT_OF_PHRASES | 0x000002,
  /*276*/ PHRASE_TYPE      | G_NAME,
  /*277*/ PHRASE_TYPE      | G_OPT_ARRAY,
  /*278*/ COUNT_OF_PHRASES | 0x000003,
  /*279*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000a,  /* ( */
  /*280*/ PHRASE_TYPE      | G_LEXPR,
  /*281*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000b,  /* ) */

// P<OWN-DECLARATION> = ...;
  /*282*/ COUNT_OF_ALTS    | 0x000007,
  /*283*/ COUNT_OF_PHRASES | 0x000003,
  /*284*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000018,  /* o̲w̲n̲ */
  /*285*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000005,  /* i̲n̲t̲e̲g̲e̲r̲ */
  /*286*/ PHRASE_TYPE      | G_OWN_ARRAY_DECLN,
  /*287*/ COUNT_OF_PHRASES | 0x000003,
  /*288*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000018,  /* o̲w̲n̲ */
  /*289*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000005,  /* i̲n̲t̲e̲g̲e̲r̲ */
  /*290*/ PHRASE_TYPE      | G_LOCAL_SCALAR_DECLN,
  /*291*/ COUNT_OF_PHRASES | 0x000003,
  /*292*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000018,  /* o̲w̲n̲ */
  /*293*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000006,  /* r̲e̲a̲l̲ */
  /*294*/ PHRASE_TYPE      | G_OWN_ARRAY_DECLN,
  /*295*/ COUNT_OF_PHRASES | 0x000002,
  /*296*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000018,  /* o̲w̲n̲ */
  /*297*/ PHRASE_TYPE      | G_OWN_ARRAY_DECLN,
  /*298*/ COUNT_OF_PHRASES | 0x000003,
  /*299*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000018,  /* o̲w̲n̲ */
  /*300*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000006,  /* r̲e̲a̲l̲ */
  /*301*/ PHRASE_TYPE      | G_LOCAL_SCALAR_DECLN,
  /*302*/ COUNT_OF_PHRASES | 0x000003,
  /*303*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000018,  /* o̲w̲n̲ */
  /*304*/ PHRASE_TYPE      | G_BOOLEAN,
  /*305*/ PHRASE_TYPE      | G_OWN_ARRAY_DECLN,
  /*306*/ COUNT_OF_PHRASES | 0x000003,
  /*307*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000018,  /* o̲w̲n̲ */
  /*308*/ PHRASE_TYPE      | G_BOOLEAN,
  /*309*/ PHRASE_TYPE      | G_LOCAL_SCALAR_DECLN,

// P<OWN-ARRAY-DECLN> = ...;
  /*310*/ COUNT_OF_ALTS    | 0x000001,
  /*311*/ COUNT_OF_PHRASES | 0x000002,
  /*312*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000014,  /* a̲r̲r̲a̲y̲ */
  /*313*/ PHRASE_TYPE      | G_OWN_BOUNDED_DECLIST,

// P<LOCAL-ARRAY-DECLN> = ...;
  /*314*/ COUNT_OF_ALTS    | 0x000001,
  /*315*/ COUNT_OF_PHRASES | 0x000002,
  /*316*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000014,  /* a̲r̲r̲a̲y̲ */
  /*317*/ PHRASE_TYPE      | G_BOUNDED_DECLIST,

// P<LOCAL-SCALAR-DECLN> = ...;
  /*318*/ COUNT_OF_ALTS    | 0x000001,
  /*319*/ COUNT_OF_PHRASES | 0x000001,
  /*320*/ PHRASE_TYPE      | G_DECLIST,

// P<OWN-BOUNDED-DECLIST> = ...;
  /*321*/ COUNT_OF_ALTS    | 0x000001,
  /*322*/ COUNT_OF_PHRASES | 0x000003,
  /*323*/ PHRASE_TYPE      | G_DECLIST,
  /*324*/ PHRASE_TYPE      | G_OWN_BOUNDS_DECLARATION,
  /*325*/ PHRASE_TYPE      | G_MORE_OWN_BOUNDED_DECLIST,

// P<BOUNDED-DECLIST> = ...;
  /*326*/ COUNT_OF_ALTS    | 0x000001,
  /*327*/ COUNT_OF_PHRASES | 0x000003,
  /*328*/ PHRASE_TYPE      | G_DECLIST,
  /*329*/ PHRASE_TYPE      | G_BOUNDS_DECLARATION,
  /*330*/ PHRASE_TYPE      | G_MORE_BOUNDED_DECLIST,

// P<MORE-OWN-BOUNDED-DECLIST> = ...;
  /*331*/ COUNT_OF_ALTS    | 0x000002,
  /*332*/ COUNT_OF_PHRASES | 0x000004,
  /*333*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00002c,  /* ',' */
  /*334*/ PHRASE_TYPE      | G_DECLIST,
  /*335*/ PHRASE_TYPE      | G_OWN_BOUNDS_DECLARATION,
  /*336*/ PHRASE_TYPE      | G_MORE_OWN_BOUNDED_DECLIST,
  /*337*/ COUNT_OF_PHRASES | 0x000000,

// P<MORE-BOUNDED-DECLIST> = ...;
  /*338*/ COUNT_OF_ALTS    | 0x000002,
  /*339*/ COUNT_OF_PHRASES | 0x000004,
  /*340*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00002c,  /* ',' */
  /*341*/ PHRASE_TYPE      | G_DECLIST,
  /*342*/ PHRASE_TYPE      | G_BOUNDS_DECLARATION,
  /*343*/ PHRASE_TYPE      | G_MORE_BOUNDED_DECLIST,
  /*344*/ COUNT_OF_PHRASES | 0x000000,

// P<OWN-BOUNDS-DECLARATION> = ...;
  /*345*/ COUNT_OF_ALTS    | 0x000001,
  /*346*/ COUNT_OF_PHRASES | 0x000003,
  /*347*/ PHRASE_TYPE      | G_ARRAY_LB,
  /*348*/ PHRASE_TYPE      | G_OWN_BOUNDS_DECLIST,
  /*349*/ PHRASE_TYPE      | G_ARRAY_RB,

// P<BOUNDS-DECLARATION> = ...;
  /*350*/ COUNT_OF_ALTS    | 0x000001,
  /*351*/ COUNT_OF_PHRASES | 0x000003,
  /*352*/ PHRASE_TYPE      | G_ARRAY_LB,
  /*353*/ PHRASE_TYPE      | G_BOUNDS_DECLIST,
  /*354*/ PHRASE_TYPE      | G_ARRAY_RB,

// P<OWN-BOUNDS-DECLIST> = ...;
  /*355*/ COUNT_OF_ALTS    | 0x000001,
  /*356*/ COUNT_OF_PHRASES | 0x000002,
  /*357*/ PHRASE_TYPE      | G_OWN_BOUND_DEC,
  /*358*/ PHRASE_TYPE      | G_MORE_OWN_BOUNDS_DECLIST,

// P<BOUNDS-DECLIST> = ...;
  /*359*/ COUNT_OF_ALTS    | 0x000001,
  /*360*/ COUNT_OF_PHRASES | 0x000002,
  /*361*/ PHRASE_TYPE      | G_BOUND_DEC,
  /*362*/ PHRASE_TYPE      | G_MORE_BOUNDS_DECLIST,

// P<MORE-OWN-BOUNDS-DECLIST> = ...;
  /*363*/ COUNT_OF_ALTS    | 0x000002,
  /*364*/ COUNT_OF_PHRASES | 0x000003,
  /*365*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00002c,  /* ',' */
  /*366*/ PHRASE_TYPE      | G_OWN_BOUND_DEC,
  /*367*/ PHRASE_TYPE      | G_MORE_OWN_BOUNDS_DECLIST,
  /*368*/ COUNT_OF_PHRASES | 0x000000,

// P<MORE-BOUNDS-DECLIST> = ...;
  /*369*/ COUNT_OF_ALTS    | 0x000002,
  /*370*/ COUNT_OF_PHRASES | 0x000003,
  /*371*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00002c,  /* ',' */
  /*372*/ PHRASE_TYPE      | G_BOUND_DEC,
  /*373*/ PHRASE_TYPE      | G_MORE_BOUNDS_DECLIST,
  /*374*/ COUNT_OF_PHRASES | 0x000000,

// P<OWN-BOUND-DEC> = ...;
  /*375*/ COUNT_OF_ALTS    | 0x000001,
  /*376*/ COUNT_OF_PHRASES | 0x000003,
  /*377*/ PHRASE_TYPE      | G_CONST_EXPR,
  /*378*/ PHRASE_TYPE      | G_COLON_WARN_COMMA,
  /*379*/ PHRASE_TYPE      | G_CONST_EXPR,

// P<BOUND-DEC> = ...;
  /*380*/ COUNT_OF_ALTS    | 0x000001,
  /*381*/ COUNT_OF_PHRASES | 0x000003,
  /*382*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*383*/ PHRASE_TYPE      | G_COLON_WARN_COMMA,
  /*384*/ PHRASE_TYPE      | G_arithmetic_expression,

// P<COLON-WARN-COMMA> = ...;
  /*385*/ COUNT_OF_ALTS    | 0x000003,
  /*386*/ COUNT_OF_PHRASES | 0x000001,
  /*387*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003a,  /* ':' */
  /*388*/ COUNT_OF_PHRASES | 0x000001,
  /*389*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00002c,  /* ',' */
  /*390*/ COUNT_OF_PHRASES | 0x000001,
  /*391*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000019,  /* .. */

// P<CONST-EXPR> = ...;
  /*392*/ COUNT_OF_ALTS    | 0x000001,
  /*393*/ COUNT_OF_PHRASES | 0x000001,
  /*394*/ PHRASE_TYPE      | G_arithmetic_expression,

// P<PROCBODY> = ...;
  /*395*/ COUNT_OF_ALTS    | 0x00000b,
  /*396*/ COUNT_OF_PHRASES | 0x000002,
  /*397*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000004,  /* c̲o̲d̲e̲ */
  /*398*/ PHRASE_TYPE      | G_DIGITS,
  /*399*/ COUNT_OF_PHRASES | 0x000001,
  /*400*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001a,  /* a̲l̲g̲o̲l̲ */
  /*401*/ COUNT_OF_PHRASES | 0x000001,
  /*402*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001b,  /* f̲o̲r̲t̲r̲a̲n̲ */
  /*403*/ COUNT_OF_PHRASES | 0x000001,
  /*404*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001c,  /* e̲x̲t̲e̲r̲n̲a̲l̲ */
  /*405*/ COUNT_OF_PHRASES | 0x000004,
  /*406*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000000,  /* b̲e̲g̲i̲n̲ */
  /*407*/ PHRASE_TYPE      | G_LOCAL_BLOCK,
  /*408*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000001,  /* e̲n̲d̲ */
  /*409*/ PHRASE_TYPE      | G_ENDTEXT,
  /*410*/ COUNT_OF_PHRASES | 0x000001,
  /*411*/ PHRASE_TYPE      | G_ASSIGNMENT,
  /*412*/ COUNT_OF_PHRASES | 0x000001,
  /*413*/ PHRASE_TYPE      | G_function_designator,
  /*414*/ COUNT_OF_PHRASES | 0x000008,
  /*415*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001d,  /* f̲o̲r̲ */
  /*416*/ PHRASE_TYPE      | G_LHS,
  /*417*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000010,  /* := */
  /*418*/ PHRASE_TYPE      | G_FLE,
  /*419*/ PHRASE_TYPE      | G_FORLIST,
  /*420*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001e,  /* d̲o̲ */
  /*421*/ PHRASE_TYPE      | G_LABELS_opt,
  /*422*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*423*/ COUNT_OF_PHRASES | 0x000006,
  /*424*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000015,  /* i̲f̲ */
  /*425*/ PHRASE_TYPE      | G_Boolean_expression,
  /*426*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000016,  /* t̲h̲e̲n̲ */
  /*427*/ PHRASE_TYPE      | G_LABELS_opt,
  /*428*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*429*/ PHRASE_TYPE      | G_OPT_ELSE,
  /*430*/ COUNT_OF_PHRASES | 0x000003,
  /*431*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001f,  /* g̲o̲ */
  /*432*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000020,  /* t̲o̲ */
  /*433*/ PHRASE_TYPE      | G_JUMP_TARGET,
  /*434*/ COUNT_OF_PHRASES | 0x000000,

// P<LOCAL-BLOCK> = ...;
  /*435*/ COUNT_OF_ALTS    | 0x000002,
  /*436*/ COUNT_OF_PHRASES | 0x000003,
  /*437*/ PHRASE_TYPE      | G_LABELS_opt,
  /*438*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*439*/ PHRASE_TYPE      | G_MORE_LOCAL_STATEMENTS,
  /*440*/ COUNT_OF_PHRASES | 0x000000,

// P<MORE-LOCAL-STATEMENTS> = ...;
  /*441*/ COUNT_OF_ALTS    | 0x000002,
  /*442*/ COUNT_OF_PHRASES | 0x000004,
  /*443*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003b,  /* ';' */
  /*444*/ PHRASE_TYPE      | G_LABELS_opt,
  /*445*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*446*/ PHRASE_TYPE      | G_MORE_LOCAL_STATEMENTS,
  /*447*/ COUNT_OF_PHRASES | 0x000000,

// P<LOCAL-STATEMENT> = ...;
  /*448*/ COUNT_OF_ALTS    | 0x00000c,
  /*449*/ COUNT_OF_PHRASES | 0x000001,
  /*450*/ PHRASE_TYPE      | G_COMMENT_NO_SEMI,
  /*451*/ COUNT_OF_PHRASES | 0x000001,
  /*452*/ PHRASE_TYPE      | G_ASSIGNMENT,
  /*453*/ COUNT_OF_PHRASES | 0x000001,
  /*454*/ PHRASE_TYPE      | G_function_designator,
  /*455*/ COUNT_OF_PHRASES | 0x000004,
  /*456*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000000,  /* b̲e̲g̲i̲n̲ */
  /*457*/ PHRASE_TYPE      | G_LOCAL_BLOCK,
  /*458*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000001,  /* e̲n̲d̲ */
  /*459*/ PHRASE_TYPE      | G_ENDTEXT,
  /*460*/ COUNT_OF_PHRASES | 0x000008,
  /*461*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001d,  /* f̲o̲r̲ */
  /*462*/ PHRASE_TYPE      | G_LHS,
  /*463*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000010,  /* := */
  /*464*/ PHRASE_TYPE      | G_FLE,
  /*465*/ PHRASE_TYPE      | G_FORLIST,
  /*466*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001e,  /* d̲o̲ */
  /*467*/ PHRASE_TYPE      | G_LABELS_opt,
  /*468*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*469*/ COUNT_OF_PHRASES | 0x000006,
  /*470*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000015,  /* i̲f̲ */
  /*471*/ PHRASE_TYPE      | G_Boolean_expression,
  /*472*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000016,  /* t̲h̲e̲n̲ */
  /*473*/ PHRASE_TYPE      | G_LABELS_opt,
  /*474*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*475*/ PHRASE_TYPE      | G_OPT_ELSE,
  /*476*/ COUNT_OF_PHRASES | 0x000003,
  /*477*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00001f,  /* g̲o̲ */
  /*478*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000020,  /* t̲o̲ */
  /*479*/ PHRASE_TYPE      | G_JUMP_TARGET,
  /*480*/ COUNT_OF_PHRASES | 0x000001,
  /*481*/ PHRASE_TYPE      | G_CODE,
  /*482*/ COUNT_OF_PHRASES | 0x000001,
  /*483*/ PHRASE_TYPE      | G_PROCEDURE,
  /*484*/ COUNT_OF_PHRASES | 0x000001,
  /*485*/ PHRASE_TYPE      | G_OWN_DECLARATION,
  /*486*/ COUNT_OF_PHRASES | 0x000001,
  /*487*/ PHRASE_TYPE      | G_LOCAL_DECLARATION,
  /*488*/ COUNT_OF_PHRASES | 0x000000,

// P<CODE> = ...;
  /*489*/ COUNT_OF_ALTS    | 0x000001,
  /*490*/ COUNT_OF_PHRASES | 0x000002,
  /*491*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000004,  /* c̲o̲d̲e̲ */
  /*492*/ PHRASE_TYPE      | G_ONOFF,

// P<ONOFF> = ...;
  /*493*/ COUNT_OF_ALTS    | 0x000002,
  /*494*/ COUNT_OF_PHRASES | 0x000001,
  /*495*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000021,  /* o̲n̲ */
  /*496*/ COUNT_OF_PHRASES | 0x000001,
  /*497*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000022,  /* o̲f̲f̲ */

// P<OPT-ELSE> = ...;
  /*498*/ COUNT_OF_ALTS    | 0x000003,
  /*499*/ COUNT_OF_PHRASES | 0x000008,
  /*500*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000017,  /* e̲l̲s̲e̲ */
  /*501*/ PHRASE_TYPE      | G_LABELS_opt,
  /*502*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000015,  /* i̲f̲ */
  /*503*/ PHRASE_TYPE      | G_Boolean_expression,
  /*504*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000016,  /* t̲h̲e̲n̲ */
  /*505*/ PHRASE_TYPE      | G_LABELS_opt,
  /*506*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*507*/ PHRASE_TYPE      | G_OPT_ELSE,
  /*508*/ COUNT_OF_PHRASES | 0x000003,
  /*509*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000017,  /* e̲l̲s̲e̲ */
  /*510*/ PHRASE_TYPE      | G_LABELS_opt,
  /*511*/ PHRASE_TYPE      | G_LOCAL_STATEMENT,
  /*512*/ COUNT_OF_PHRASES | 0x000000,

// P<FLE> = ...;
  /*513*/ COUNT_OF_ALTS    | 0x000001,
  /*514*/ COUNT_OF_PHRASES | 0x000002,
  /*515*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*516*/ PHRASE_TYPE      | G_REST_OF_FLE,

// P<REST-OF-FLE> = ...;
  /*517*/ COUNT_OF_ALTS    | 0x000003,
  /*518*/ COUNT_OF_PHRASES | 0x000004,
  /*519*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000023,  /* s̲t̲e̲p̲ */
  /*520*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*521*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000024,  /* u̲n̲t̲i̲l̲ */
  /*522*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*523*/ COUNT_OF_PHRASES | 0x000002,
  /*524*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000025,  /* w̲h̲i̲l̲e̲ */
  /*525*/ PHRASE_TYPE      | G_Boolean_expression,
  /*526*/ COUNT_OF_PHRASES | 0x000000,

// P<FORLIST> = ...;
  /*527*/ COUNT_OF_ALTS    | 0x000002,
  /*528*/ COUNT_OF_PHRASES | 0x000003,
  /*529*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000d,  /* , */
  /*530*/ PHRASE_TYPE      | G_FLE,
  /*531*/ PHRASE_TYPE      | G_FORLIST,
  /*532*/ COUNT_OF_PHRASES | 0x000000,

// P<MORE-LHS> = ...;
  /*533*/ COUNT_OF_ALTS    | 0x000002,
  /*534*/ COUNT_OF_PHRASES | 0x000004,
  /*535*/ PHRASE_TYPE      | G_LHS,
  /*536*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003a,  /* ':' */
  /*537*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003d,  /* '=' */
  /*538*/ PHRASE_TYPE      | G_MORE_LHS,
  /*539*/ COUNT_OF_PHRASES | 0x000000,

// P<ASSIGNMENT> = ...;
  /*540*/ COUNT_OF_ALTS    | 0x000001,
  /*541*/ COUNT_OF_PHRASES | 0x000005,
  /*542*/ PHRASE_TYPE      | G_LHS,
  /*543*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003a,  /* ':' */
  /*544*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003d,  /* '=' */
  /*545*/ PHRASE_TYPE      | G_MORE_LHS,
  /*546*/ PHRASE_TYPE      | G_RHS,

// P<LHS> = ...;
  /*547*/ COUNT_OF_ALTS    | 0x000002,
  /*548*/ COUNT_OF_PHRASES | 0x000005,
  /*549*/ PHRASE_TYPE      | G_NAME,
  /*550*/ PHRASE_TYPE      | G_ARRAY_LB,
  /*551*/ PHRASE_TYPE      | G_ARRAY_INDEX,
  /*552*/ PHRASE_TYPE      | G_ARRAY_INDICES,
  /*553*/ PHRASE_TYPE      | G_ARRAY_RB,
  /*554*/ COUNT_OF_PHRASES | 0x000001,
  /*555*/ PHRASE_TYPE      | G_NAME,

// P<RHS> = ...;
  /*556*/ COUNT_OF_ALTS    | 0x000002,
  /*557*/ COUNT_OF_PHRASES | 0x000002,
  /*558*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*559*/ PHRASE_TYPE      | GUARD_PHRASE       | G_closer,
  /*560*/ COUNT_OF_PHRASES | 0x000002,
  /*561*/ PHRASE_TYPE      | G_Boolean_expression,
  /*562*/ PHRASE_TYPE      | GUARD_PHRASE       | G_closer,

// P<function_designator> = ...;
  /*563*/ COUNT_OF_ALTS    | 0x000002,
  /*564*/ COUNT_OF_PHRASES | 0x000002,
  /*565*/ PHRASE_TYPE      | G_NAME,
  /*566*/ PHRASE_TYPE      | G_ACTUAL_PARAMETERS,
  /*567*/ COUNT_OF_PHRASES | 0x000001,
  /*568*/ PHRASE_TYPE      | G_NAME,

// P<ACTUAL-PARAMETERS> = ...;
  /*569*/ COUNT_OF_ALTS    | 0x000001,
  /*570*/ COUNT_OF_PHRASES | 0x000004,
  /*571*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000028,  /* '(' */
  /*572*/ PHRASE_TYPE      | G_ACTUAL_PARAMETER,
  /*573*/ PHRASE_TYPE      | G_MORE_ACTUAL_PARAMETERS,
  /*574*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000029,  /* ')' */

// P<MORE-ACTUAL-PARAMETERS> = ...;
  /*575*/ COUNT_OF_ALTS    | 0x000002,
  /*576*/ COUNT_OF_PHRASES | 0x000003,
  /*577*/ PHRASE_TYPE      | G_FPSEP,
  /*578*/ PHRASE_TYPE      | G_ACTUAL_PARAMETER,
  /*579*/ PHRASE_TYPE      | G_MORE_ACTUAL_PARAMETERS,
  /*580*/ COUNT_OF_PHRASES | 0x000000,

// P<FPSEP> = ...;
  /*581*/ COUNT_OF_ALTS    | 0x000002,
  /*582*/ COUNT_OF_PHRASES | 0x000001,
  /*583*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000d,  /* , */
  /*584*/ COUNT_OF_PHRASES | 0x000004,
  /*585*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000b,  /* ) */
  /*586*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000001,  /* ^[ ]*[A-Za-z][A-Za-z ]* */
  /*587*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000f,  /* : */
  /*588*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000a,  /* ( */

// P<ACTUAL-PARAMETER> = ...;
  /*589*/ COUNT_OF_ALTS    | 0x000003,
  /*590*/ COUNT_OF_PHRASES | 0x000002,
  /*591*/ PHRASE_TYPE      | G_Boolean_expression,
  /*592*/ PHRASE_TYPE      | GUARD_PHRASE       | G_closer,
  /*593*/ COUNT_OF_PHRASES | 0x000002,
  /*594*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*595*/ PHRASE_TYPE      | GUARD_PHRASE       | G_closer,
  /*596*/ COUNT_OF_PHRASES | 0x000001,
  /*597*/ PHRASE_TYPE      | G_string_literal,

// P<OPERAND> = ...;
  /*598*/ COUNT_OF_ALTS    | 0x000005,
  /*599*/ COUNT_OF_PHRASES | 0x000005,
  /*600*/ PHRASE_TYPE      | G_NAME,
  /*601*/ PHRASE_TYPE      | G_ARRAY_LB,
  /*602*/ PHRASE_TYPE      | G_ARRAY_INDEX,
  /*603*/ PHRASE_TYPE      | G_ARRAY_INDICES,
  /*604*/ PHRASE_TYPE      | G_ARRAY_RB,
  /*605*/ COUNT_OF_PHRASES | 0x000001,
  /*606*/ PHRASE_TYPE      | G_function_designator,
  /*607*/ COUNT_OF_PHRASES | 0x000001,
  /*608*/ PHRASE_TYPE      | G_NAME,
  /*609*/ COUNT_OF_PHRASES | 0x000001,
  /*610*/ PHRASE_TYPE      | G_REAL_CONSTANT,
  /*611*/ COUNT_OF_PHRASES | 0x000003,
  /*612*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000a,  /* ( */
  /*613*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*614*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000b,  /* ) */

// P<ARRAY-INDEX> = ...;
  /*615*/ COUNT_OF_ALTS    | 0x000001,
  /*616*/ COUNT_OF_PHRASES | 0x000001,
  /*617*/ PHRASE_TYPE      | G_arithmetic_expression,

// P<ARRAY-INDICES> = ...;
  /*618*/ COUNT_OF_ALTS    | 0x000002,
  /*619*/ COUNT_OF_PHRASES | 0x000003,
  /*620*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00002c,  /* ',' */
  /*621*/ PHRASE_TYPE      | G_ARRAY_INDEX,
  /*622*/ PHRASE_TYPE      | G_ARRAY_INDICES,
  /*623*/ COUNT_OF_PHRASES | 0x000000,

// P<primary> = ...;
  /*624*/ COUNT_OF_ALTS    | 0x000001,
  /*625*/ COUNT_OF_PHRASES | 0x000002,
  /*626*/ PHRASE_TYPE      | G_PLUS_MINUS_opt,
  /*627*/ PHRASE_TYPE      | G_OPERAND,

// P<exp-op> = ...;
  /*628*/ COUNT_OF_ALTS    | 0x000005,
  /*629*/ COUNT_OF_PHRASES | 0x000001,
  /*630*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000026,  /* ^ */
  /*631*/ COUNT_OF_PHRASES | 0x000001,
  /*632*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000027,  /* ** */
  /*633*/ COUNT_OF_PHRASES | 0x000001,
  /*634*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000028,  /* ⭡ */
  /*635*/ COUNT_OF_PHRASES | 0x000001,
  /*636*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000029,  /* |^ */
  /*637*/ COUNT_OF_PHRASES | 0x000001,
  /*638*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00002a,  /* p̲o̲w̲e̲r̲ */

// P<exp-factor> = ...;
  /*639*/ COUNT_OF_ALTS    | 0x000002,
  /*640*/ COUNT_OF_PHRASES | 0x000002,
  /*641*/ PHRASE_TYPE      | G_exp_op,
  /*642*/ PHRASE_TYPE      | G_factor,
  /*643*/ COUNT_OF_PHRASES | 0x000000,

// P<factor> = ...;
  /*644*/ COUNT_OF_ALTS    | 0x000001,
  /*645*/ COUNT_OF_PHRASES | 0x000002,
  /*646*/ PHRASE_TYPE      | G_primary,
  /*647*/ PHRASE_TYPE      | G_exp_factor,

// P<mul-op> = ...;
  /*648*/ COUNT_OF_ALTS    | 0x000002,
  /*649*/ COUNT_OF_PHRASES | 0x000001,
  /*650*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00002b,  /* * */
  /*651*/ COUNT_OF_PHRASES | 0x000001,
  /*652*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00002c,  /* × */

// P<rdiv-op> = ...;
  /*653*/ COUNT_OF_ALTS    | 0x000001,
  /*654*/ COUNT_OF_PHRASES | 0x000001,
  /*655*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00002d,  /* / */

// P<idiv-op> = ...;
  /*656*/ COUNT_OF_ALTS    | 0x000005,
  /*657*/ COUNT_OF_PHRASES | 0x000001,
  /*658*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00002e,  /* // */
  /*659*/ COUNT_OF_PHRASES | 0x000001,
  /*660*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00002f,  /* ÷ */
  /*661*/ COUNT_OF_PHRASES | 0x000001,
  /*662*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000030,  /* % */
  /*663*/ COUNT_OF_PHRASES | 0x000001,
  /*664*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000031,  /* d̲i̲v̲ */
  /*665*/ COUNT_OF_PHRASES | 0x000001,
  /*666*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000032,  /* '/' */

// P<div-op> = ...;
  /*667*/ COUNT_OF_ALTS    | 0x000002,
  /*668*/ COUNT_OF_PHRASES | 0x000001,
  /*669*/ PHRASE_TYPE      | G_idiv_op,
  /*670*/ COUNT_OF_PHRASES | 0x000001,
  /*671*/ PHRASE_TYPE      | G_rdiv_op,

// P<muldiv-op> = ...;
  /*672*/ COUNT_OF_ALTS    | 0x000002,
  /*673*/ COUNT_OF_PHRASES | 0x000001,
  /*674*/ PHRASE_TYPE      | G_mul_op,
  /*675*/ COUNT_OF_PHRASES | 0x000001,
  /*676*/ PHRASE_TYPE      | G_div_op,

// P<mul-factor> = ...;
  /*677*/ COUNT_OF_ALTS    | 0x000002,
  /*678*/ COUNT_OF_PHRASES | 0x000002,
  /*679*/ PHRASE_TYPE      | G_muldiv_op,
  /*680*/ PHRASE_TYPE      | G_term,
  /*681*/ COUNT_OF_PHRASES | 0x000000,

// P<term> = ...;
  /*682*/ COUNT_OF_ALTS    | 0x000001,
  /*683*/ COUNT_OF_PHRASES | 0x000002,
  /*684*/ PHRASE_TYPE      | G_factor,
  /*685*/ PHRASE_TYPE      | G_mul_factor,

// P<add-op> = ...;
  /*686*/ COUNT_OF_ALTS    | 0x000001,
  /*687*/ COUNT_OF_PHRASES | 0x000001,
  /*688*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000033,  /* + */

// P<sub-op> = ...;
  /*689*/ COUNT_OF_ALTS    | 0x000001,
  /*690*/ COUNT_OF_PHRASES | 0x000001,
  /*691*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000034,  /* - */

// P<addsub-op> = ...;
  /*692*/ COUNT_OF_ALTS    | 0x000002,
  /*693*/ COUNT_OF_PHRASES | 0x000001,
  /*694*/ PHRASE_TYPE      | G_add_op,
  /*695*/ COUNT_OF_PHRASES | 0x000001,
  /*696*/ PHRASE_TYPE      | G_sub_op,

// P<add-term> = ...;
  /*697*/ COUNT_OF_ALTS    | 0x000002,
  /*698*/ COUNT_OF_PHRASES | 0x000002,
  /*699*/ PHRASE_TYPE      | G_addsub_op,
  /*700*/ PHRASE_TYPE      | G_simple_arithmetic_expression,
  /*701*/ COUNT_OF_PHRASES | 0x000000,

// P<simple_arithmetic_expression> = ...;
  /*702*/ COUNT_OF_ALTS    | 0x000001,
  /*703*/ COUNT_OF_PHRASES | 0x000002,
  /*704*/ PHRASE_TYPE      | G_term,
  /*705*/ PHRASE_TYPE      | G_add_term,

// P<arithmetic_expression> = ...;
  /*706*/ COUNT_OF_ALTS    | 0x000002,
  /*707*/ COUNT_OF_PHRASES | 0x000006,
  /*708*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000015,  /* i̲f̲ */
  /*709*/ PHRASE_TYPE      | G_Boolean_expression,
  /*710*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000016,  /* t̲h̲e̲n̲ */
  /*711*/ PHRASE_TYPE      | G_simple_arithmetic_expression,
  /*712*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000017,  /* e̲l̲s̲e̲ */
  /*713*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*714*/ COUNT_OF_PHRASES | 0x000001,
  /*715*/ PHRASE_TYPE      | G_simple_arithmetic_expression,

// P<INTEGER-CONSTANT> = ...;
  /*716*/ COUNT_OF_ALTS    | 0x000001,
  /*717*/ COUNT_OF_PHRASES | 0x000002,
  /*718*/ PHRASE_TYPE      | G_PLUS_MINUS_opt,
  /*719*/ PHRASE_TYPE      | G_DIGITS,

// P<REAL-CONSTANT> = ...;
  /*720*/ COUNT_OF_ALTS    | 0x000001,
  /*721*/ COUNT_OF_PHRASES | 0x000002,
  /*722*/ PHRASE_TYPE      | G_PLUS_MINUS_opt,
  /*723*/ PHRASE_TYPE      | G_unsigned,

// P<unsigned> = ...;
  /*724*/ COUNT_OF_ALTS    | 0x000003,
  /*725*/ COUNT_OF_PHRASES | 0x000002,
  /*726*/ PHRASE_TYPE      | G_decnum,
  /*727*/ PHRASE_TYPE      | G_expart,
  /*728*/ COUNT_OF_PHRASES | 0x000001,
  /*729*/ PHRASE_TYPE      | G_expart,
  /*730*/ COUNT_OF_PHRASES | 0x000001,
  /*731*/ PHRASE_TYPE      | G_decnum,

// P<decfract> = ...;
  /*732*/ COUNT_OF_ALTS    | 0x000001,
  /*733*/ COUNT_OF_PHRASES | 0x000002,
  /*734*/ PHRASE_TYPE      | G_decimalpoint,
  /*735*/ PHRASE_TYPE      | G_DIGITS,

// P<decimalpoint> = ...;
  /*736*/ COUNT_OF_ALTS    | 0x000002,
  /*737*/ COUNT_OF_PHRASES | 0x000001,
  /*738*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000035,  /* . */
  /*739*/ COUNT_OF_PHRASES | 0x000001,
  /*740*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000036,  /* · */

// P<expart> = ...;
  /*741*/ COUNT_OF_ALTS    | 0x000001,
  /*742*/ COUNT_OF_PHRASES | 0x000002,
  /*743*/ PHRASE_TYPE      | G_subten,
  /*744*/ PHRASE_TYPE      | G_INTEGER_CONSTANT,

// P<decnum> = ...;
  /*745*/ COUNT_OF_ALTS    | 0x000003,
  /*746*/ COUNT_OF_PHRASES | 0x000002,
  /*747*/ PHRASE_TYPE      | G_DIGITS,
  /*748*/ PHRASE_TYPE      | G_decfract,
  /*749*/ COUNT_OF_PHRASES | 0x000001,
  /*750*/ PHRASE_TYPE      | G_decfract,
  /*751*/ COUNT_OF_PHRASES | 0x000001,
  /*752*/ PHRASE_TYPE      | G_DIGITS,

// P<subten> = ...;
  /*753*/ COUNT_OF_ALTS    | 0x000006,
  /*754*/ COUNT_OF_PHRASES | 0x000001,
  /*755*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000037,  /* @ */
  /*756*/ COUNT_OF_PHRASES | 0x000001,
  /*757*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000038,  /* & */
  /*758*/ COUNT_OF_PHRASES | 0x000001,
  /*759*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000039,  /* ⏨ */
  /*760*/ COUNT_OF_PHRASES | 0x000001,
  /*761*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00003a,  /* \u23E8 */
  /*762*/ COUNT_OF_PHRASES | 0x000001,
  /*763*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00003b,  /* \u2081\u2080 */
  /*764*/ COUNT_OF_PHRASES | 0x000001,
  /*765*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00003c,  /* '10' */

// P<PLUS-MINUS-opt> = ...;
  /*766*/ COUNT_OF_ALTS    | 0x000003,
  /*767*/ COUNT_OF_PHRASES | 0x000002,
  /*768*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000033,  /* + */
  /*769*/ PHRASE_TYPE      | G_PLUS_MINUS_opt,
  /*770*/ COUNT_OF_PHRASES | 0x000002,
  /*771*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000034,  /* - */
  /*772*/ PHRASE_TYPE      | G_PLUS_MINUS_opt,
  /*773*/ COUNT_OF_PHRASES | 0x000000,

// P<logical_value> = ...;
  /*774*/ COUNT_OF_ALTS    | 0x000002,
  /*775*/ COUNT_OF_PHRASES | 0x000001,
  /*776*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00003d,  /* t̲r̲u̲e̲ */
  /*777*/ COUNT_OF_PHRASES | 0x000001,
  /*778*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00003e,  /* f̲a̲l̲s̲e̲ */

// P<relational_operator> = ...;
  /*779*/ COUNT_OF_ALTS    | 0x00001d,
  /*780*/ COUNT_OF_PHRASES | 0x000001,
  /*781*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00003f,  /* = */
  /*782*/ COUNT_OF_PHRASES | 0x000001,
  /*783*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000040,  /* e̲q̲u̲a̲l̲ */
  /*784*/ COUNT_OF_PHRASES | 0x000001,
  /*785*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000041,  /* e̲q̲ */
  /*786*/ COUNT_OF_PHRASES | 0x000001,
  /*787*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000042,  /* >= */
  /*788*/ COUNT_OF_PHRASES | 0x000001,
  /*789*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000043,  /* ≥ */
  /*790*/ COUNT_OF_PHRASES | 0x000001,
  /*791*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000044,  /* g̲e̲ */
  /*792*/ COUNT_OF_PHRASES | 0x000001,
  /*793*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000045,  /* n̲o̲t̲l̲e̲s̲s̲ */
  /*794*/ COUNT_OF_PHRASES | 0x000001,
  /*795*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000046,  /* g̲r̲e̲q̲ */
  /*796*/ COUNT_OF_PHRASES | 0x000001,
  /*797*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000047,  /* > */
  /*798*/ COUNT_OF_PHRASES | 0x000001,
  /*799*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000048,  /* g̲t̲ */
  /*800*/ COUNT_OF_PHRASES | 0x000001,
  /*801*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000049,  /* g̲r̲e̲a̲t̲e̲r̲ */
  /*802*/ COUNT_OF_PHRASES | 0x000001,
  /*803*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00004a,  /* <> */
  /*804*/ COUNT_OF_PHRASES | 0x000001,
  /*805*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00004b,  /* # */
  /*806*/ COUNT_OF_PHRASES | 0x000001,
  /*807*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00004c,  /* ≠ */
  /*808*/ COUNT_OF_PHRASES | 0x000001,
  /*809*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00004d,  /* n̲e̲ */
  /*810*/ COUNT_OF_PHRASES | 0x000001,
  /*811*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00004e,  /* n̲o̲t̲e̲q̲u̲a̲l̲ */
  /*812*/ COUNT_OF_PHRASES | 0x000001,
  /*813*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00004f,  /* \= */
  /*814*/ COUNT_OF_PHRASES | 0x000001,
  /*815*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000050,  /* ¬= */
  /*816*/ COUNT_OF_PHRASES | 0x000001,
  /*817*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000051,  /* != */
  /*818*/ COUNT_OF_PHRASES | 0x000001,
  /*819*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000052,  /* ^= */
  /*820*/ COUNT_OF_PHRASES | 0x000001,
  /*821*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000053,  /* |= */
  /*822*/ COUNT_OF_PHRASES | 0x000001,
  /*823*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000054,  /* <= */
  /*824*/ COUNT_OF_PHRASES | 0x000001,
  /*825*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000055,  /* ≤ */
  /*826*/ COUNT_OF_PHRASES | 0x000001,
  /*827*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000056,  /* l̲e̲s̲s̲e̲q̲ */
  /*828*/ COUNT_OF_PHRASES | 0x000001,
  /*829*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000057,  /* n̲o̲t̲g̲r̲e̲a̲t̲e̲r̲ */
  /*830*/ COUNT_OF_PHRASES | 0x000001,
  /*831*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000058,  /* < */
  /*832*/ COUNT_OF_PHRASES | 0x000001,
  /*833*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000059,  /* l̲t̲ */
  /*834*/ COUNT_OF_PHRASES | 0x000001,
  /*835*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00005a,  /* l̲e̲s̲s̲ */
  /*836*/ COUNT_OF_PHRASES | 0x000001,
  /*837*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00005b,  /* l̲e̲ */

// P<ARRAY-LB> = ...;
  /*838*/ COUNT_OF_ALTS    | 0x000002,
  /*839*/ COUNT_OF_PHRASES | 0x000001,
  /*840*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00005b,  /* '[' */
  /*841*/ COUNT_OF_PHRASES | 0x000001,
  /*842*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00005c,  /* (/ */

// P<ARRAY-RB> = ...;
  /*843*/ COUNT_OF_ALTS    | 0x000002,
  /*844*/ COUNT_OF_PHRASES | 0x000001,
  /*845*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00005d,  /* ']' */
  /*846*/ COUNT_OF_PHRASES | 0x000001,
  /*847*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00005d,  /* /) */

// P<relation> = ...;
  /*848*/ COUNT_OF_ALTS    | 0x000001,
  /*849*/ COUNT_OF_PHRASES | 0x000003,
  /*850*/ PHRASE_TYPE      | G_arithmetic_expression,
  /*851*/ PHRASE_TYPE      | G_relational_operator,
  /*852*/ PHRASE_TYPE      | G_arithmetic_expression,

// P<Boolean_primary> = ...;
  /*853*/ COUNT_OF_ALTS    | 0x000006,
  /*854*/ COUNT_OF_PHRASES | 0x000001,
  /*855*/ PHRASE_TYPE      | G_relation,
  /*856*/ COUNT_OF_PHRASES | 0x000005,
  /*857*/ PHRASE_TYPE      | G_NAME,
  /*858*/ PHRASE_TYPE      | G_ARRAY_LB,
  /*859*/ PHRASE_TYPE      | G_ARRAY_INDEX,
  /*860*/ PHRASE_TYPE      | G_ARRAY_INDICES,
  /*861*/ PHRASE_TYPE      | G_ARRAY_RB,
  /*862*/ COUNT_OF_PHRASES | 0x000001,
  /*863*/ PHRASE_TYPE      | G_function_designator,
  /*864*/ COUNT_OF_PHRASES | 0x000001,
  /*865*/ PHRASE_TYPE      | G_NAME,
  /*866*/ COUNT_OF_PHRASES | 0x000001,
  /*867*/ PHRASE_TYPE      | G_logical_value,
  /*868*/ COUNT_OF_PHRASES | 0x000003,
  /*869*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000a,  /* ( */
  /*870*/ PHRASE_TYPE      | G_Boolean_expression,
  /*871*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000b,  /* ) */

// P<not-term> = ...;
  /*872*/ COUNT_OF_ALTS    | 0x000004,
  /*873*/ COUNT_OF_PHRASES | 0x000001,
  /*874*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00005e,  /* n̲o̲t̲ */
  /*875*/ COUNT_OF_PHRASES | 0x000001,
  /*876*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00005f,  /* ¬ */
  /*877*/ COUNT_OF_PHRASES | 0x000001,
  /*878*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000060,  /* ! */
  /*879*/ COUNT_OF_PHRASES | 0x000001,
  /*880*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000061,  /* ~ */

// P<not-terms> = ...;
  /*881*/ COUNT_OF_ALTS    | 0x000002,
  /*882*/ COUNT_OF_PHRASES | 0x000002,
  /*883*/ PHRASE_TYPE      | G_not_term,
  /*884*/ PHRASE_TYPE      | G_not_terms,
  /*885*/ COUNT_OF_PHRASES | 0x000000,

// P<Boolean_secondary> = ...;
  /*886*/ COUNT_OF_ALTS    | 0x000002,
  /*887*/ COUNT_OF_PHRASES | 0x000003,
  /*888*/ PHRASE_TYPE      | G_not_term,
  /*889*/ PHRASE_TYPE      | G_not_terms,
  /*890*/ PHRASE_TYPE      | G_Boolean_primary,
  /*891*/ COUNT_OF_PHRASES | 0x000001,
  /*892*/ PHRASE_TYPE      | G_Boolean_primary,

// P<and-term> = ...;
  /*893*/ COUNT_OF_ALTS    | 0x000003,
  /*894*/ COUNT_OF_PHRASES | 0x000001,
  /*895*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000062,  /* a̲n̲d̲ */
  /*896*/ COUNT_OF_PHRASES | 0x000001,
  /*897*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000063,  /* ∧ */
  /*898*/ COUNT_OF_PHRASES | 0x000001,
  /*899*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000038,  /* & */

// P<and_Boolean_factor> = ...;
  /*900*/ COUNT_OF_ALTS    | 0x000002,
  /*901*/ COUNT_OF_PHRASES | 0x000002,
  /*902*/ PHRASE_TYPE      | G_and_term,
  /*903*/ PHRASE_TYPE      | G_Boolean_factor,
  /*904*/ COUNT_OF_PHRASES | 0x000000,

// P<Boolean_factor> = ...;
  /*905*/ COUNT_OF_ALTS    | 0x000001,
  /*906*/ COUNT_OF_PHRASES | 0x000002,
  /*907*/ PHRASE_TYPE      | G_Boolean_secondary,
  /*908*/ PHRASE_TYPE      | G_and_Boolean_factor,

// P<or-term> = ...;
  /*909*/ COUNT_OF_ALTS    | 0x000002,
  /*910*/ COUNT_OF_PHRASES | 0x000001,
  /*911*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000064,  /* o̲r̲ */
  /*912*/ COUNT_OF_PHRASES | 0x000001,
  /*913*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000065,  /* ∨ */

// P<or_Boolean_term> = ...;
  /*914*/ COUNT_OF_ALTS    | 0x000002,
  /*915*/ COUNT_OF_PHRASES | 0x000002,
  /*916*/ PHRASE_TYPE      | G_or_term,
  /*917*/ PHRASE_TYPE      | G_Boolean_term,
  /*918*/ COUNT_OF_PHRASES | 0x000000,

// P<Boolean_term> = ...;
  /*919*/ COUNT_OF_ALTS    | 0x000001,
  /*920*/ COUNT_OF_PHRASES | 0x000002,
  /*921*/ PHRASE_TYPE      | G_Boolean_factor,
  /*922*/ PHRASE_TYPE      | G_or_Boolean_term,

// P<impl-term> = ...;
  /*923*/ COUNT_OF_ALTS    | 0x000006,
  /*924*/ COUNT_OF_PHRASES | 0x000001,
  /*925*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000066,  /* i̲m̲p̲l̲i̲e̲s̲ */
  /*926*/ COUNT_OF_PHRASES | 0x000001,
  /*927*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000067,  /* i̲m̲p̲l̲ */
  /*928*/ COUNT_OF_PHRASES | 0x000001,
  /*929*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000068,  /* i̲m̲p̲ */
  /*930*/ COUNT_OF_PHRASES | 0x000001,
  /*931*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000069,  /* ⊃ */
  /*932*/ COUNT_OF_PHRASES | 0x000001,
  /*933*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00006a,  /* \u2283 */
  /*934*/ COUNT_OF_PHRASES | 0x000001,
  /*935*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00006b,  /* -> */

// P<more_implication_Boolean> = ...;
  /*936*/ COUNT_OF_ALTS    | 0x000002,
  /*937*/ COUNT_OF_PHRASES | 0x000002,
  /*938*/ PHRASE_TYPE      | G_impl_term,
  /*939*/ PHRASE_TYPE      | G_implication_Boolean,
  /*940*/ COUNT_OF_PHRASES | 0x000000,

// P<implication_Boolean> = ...;
  /*941*/ COUNT_OF_ALTS    | 0x000001,
  /*942*/ COUNT_OF_PHRASES | 0x000002,
  /*943*/ PHRASE_TYPE      | G_Boolean_term,
  /*944*/ PHRASE_TYPE      | G_more_implication_Boolean,

// P<equiv-term> = ...;
  /*945*/ COUNT_OF_ALTS    | 0x000004,
  /*946*/ COUNT_OF_PHRASES | 0x000001,
  /*947*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00006c,  /* e̲q̲u̲i̲v̲ */
  /*948*/ COUNT_OF_PHRASES | 0x000001,
  /*949*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00006d,  /* e̲q̲v̲ */
  /*950*/ COUNT_OF_PHRASES | 0x000001,
  /*951*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00006e,  /* ≡ */
  /*952*/ COUNT_OF_PHRASES | 0x000001,
  /*953*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00006f,  /* == */

// P<equiv_simple_Boolean> = ...;
  /*954*/ COUNT_OF_ALTS    | 0x000002,
  /*955*/ COUNT_OF_PHRASES | 0x000002,
  /*956*/ PHRASE_TYPE      | G_equiv_term,
  /*957*/ PHRASE_TYPE      | G_simple_Boolean,
  /*958*/ COUNT_OF_PHRASES | 0x000000,

// P<simple_Boolean> = ...;
  /*959*/ COUNT_OF_ALTS    | 0x000001,
  /*960*/ COUNT_OF_PHRASES | 0x000002,
  /*961*/ PHRASE_TYPE      | G_implication_Boolean,
  /*962*/ PHRASE_TYPE      | G_equiv_simple_Boolean,

// P<Boolean_expression> = ...;
  /*963*/ COUNT_OF_ALTS    | 0x000002,
  /*964*/ COUNT_OF_PHRASES | 0x000006,
  /*965*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000015,  /* i̲f̲ */
  /*966*/ PHRASE_TYPE      | G_Boolean_expression,
  /*967*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000016,  /* t̲h̲e̲n̲ */
  /*968*/ PHRASE_TYPE      | G_simple_Boolean,
  /*969*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000017,  /* e̲l̲s̲e̲ */
  /*970*/ PHRASE_TYPE      | G_Boolean_expression,
  /*971*/ COUNT_OF_PHRASES | 0x000001,
  /*972*/ PHRASE_TYPE      | G_simple_Boolean,

// P<ch> = ...;
  /*973*/ COUNT_OF_ALTS    | 0x000002,
  /*974*/ COUNT_OF_PHRASES | 0x000001,
  /*975*/ PHRASE_TYPE      | G_stropped,
  /*976*/ COUNT_OF_PHRASES | 0x000001,
  /*977*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000002,  /* ^. */

// P<stropped> = ...;
  /*978*/ COUNT_OF_ALTS    | 0x000001,
  /*979*/ COUNT_OF_PHRASES | 0x000001,
  /*980*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000003,  /* ^(a̲|b̲|c̲|d̲|e̲|f̲|g̲|h̲|i̲|j̲|k̲|l̲|m̲|n̲|o̲|p̲|q̲|r̲|s̲|t̲|u̲|v̲|w̲|x̲|y̲|z̲|A̲|B̲|C̲|D̲|E̲|F̲|G̲|H̲|I̲|J̲|K̲|L̲|M̲|N̲|O̲|P̲|Q̲|R̲|S̲|T̲|U̲|V̲|W̲|X̲|Y̲|Z̲) */

// P<NAME> = ...;
  /*981*/ COUNT_OF_ALTS    | 0x000001,
  /*982*/ COUNT_OF_PHRASES | 0x000002,
  /*983*/ PHRASE_TYPE      | G_ALPHA,
  /*984*/ PHRASE_TYPE      | G_ALPHANUMS,

// P<ALPHANUMS> = ...;
  /*985*/ COUNT_OF_ALTS    | 0x000002,
  /*986*/ COUNT_OF_PHRASES | 0x000002,
  /*987*/ PHRASE_TYPE      | G_ALPHANUM,
  /*988*/ PHRASE_TYPE      | G_ALPHANUMS,
  /*989*/ COUNT_OF_PHRASES | 0x000000,

// P<ALPHA> = ...;
  /*990*/ COUNT_OF_ALTS    | 0x000001,
  /*991*/ COUNT_OF_PHRASES | 0x000002,
  /*992*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_stropped,
  /*993*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000004,  /* ^[A-Za-z] */

// P<ALPHANUM> = ...;
  /*994*/ COUNT_OF_ALTS    | 0x000001,
  /*995*/ COUNT_OF_PHRASES | 0x000002,
  /*996*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_stropped,
  /*997*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000005,  /* ^[A-Za-z0-9 ] */

// P<DIGITS> = ...;
  /*998*/ COUNT_OF_ALTS    | 0x000001,
  /*999*/ COUNT_OF_PHRASES | 0x000002,
  /*1000*/ PHRASE_TYPE      | G_DIGIT,
  /*1001*/ PHRASE_TYPE      | G_MORE_DIGITS,

// P<DIGIT> = ...;
  /*1002*/ COUNT_OF_ALTS    | 0x000001,
  /*1003*/ COUNT_OF_PHRASES | 0x000001,
  /*1004*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000006,  /* ^[0-9] */

// P<MORE-DIGITS> = ...;
  /*1005*/ COUNT_OF_ALTS    | 0x000002,
  /*1006*/ COUNT_OF_PHRASES | 0x000002,
  /*1007*/ PHRASE_TYPE      | G_DIGIT,
  /*1008*/ PHRASE_TYPE      | G_MORE_DIGITS,
  /*1009*/ COUNT_OF_PHRASES | 0x000000,

// P<string_literal> = ...;
  /*1010*/ COUNT_OF_ALTS    | 0x000002,
  /*1011*/ COUNT_OF_PHRASES | 0x000001,
  /*1012*/ PHRASE_TYPE      | G_BALANCED_STRING,
  /*1013*/ COUNT_OF_PHRASES | 0x000001,
  /*1014*/ PHRASE_TYPE      | G_C_STRING,

// P<dchs> = ...;
  /*1015*/ COUNT_OF_ALTS    | 0x000002,
  /*1016*/ COUNT_OF_PHRASES | 0x000002,
  /*1017*/ PHRASE_TYPE      | G_dch,
  /*1018*/ PHRASE_TYPE      | G_dchs,
  /*1019*/ COUNT_OF_PHRASES | 0x000000,

// P<dch> = ...;
  /*1020*/ COUNT_OF_ALTS    | 0x000001,
  /*1021*/ COUNT_OF_PHRASES | 0x000002,
  /*1022*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_rdquo,
  /*1023*/ PHRASE_TYPE      | G_ch,

// P<ldquo> = ...;
  /*1024*/ COUNT_OF_ALTS    | 0x000008,
  /*1025*/ COUNT_OF_PHRASES | 0x000001,
  /*1026*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000070,  /* “ */
  /*1027*/ COUNT_OF_PHRASES | 0x000001,
  /*1028*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00007b,  /* '{' */
  /*1029*/ COUNT_OF_PHRASES | 0x000001,
  /*1030*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000071,  /* ‘ */
  /*1031*/ COUNT_OF_PHRASES | 0x000001,
  /*1032*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000072,  /* '(' */
  /*1033*/ COUNT_OF_PHRASES | 0x000001,
  /*1034*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000073,  /* « */
  /*1035*/ COUNT_OF_PHRASES | 0x000001,
  /*1036*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000074,  /* |< */
  /*1037*/ COUNT_OF_PHRASES | 0x000001,
  /*1038*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000058,  /* < */
  /*1039*/ COUNT_OF_PHRASES | 0x000001,
  /*1040*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000073,  /* « */

// P<rdquo> = ...;
  /*1041*/ COUNT_OF_ALTS    | 0x000008,
  /*1042*/ COUNT_OF_PHRASES | 0x000001,
  /*1043*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000075,  /* ” */
  /*1044*/ COUNT_OF_PHRASES | 0x000001,
  /*1045*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00007d,  /* '}' */
  /*1046*/ COUNT_OF_PHRASES | 0x000001,
  /*1047*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000076,  /* ’ */
  /*1048*/ COUNT_OF_PHRASES | 0x000001,
  /*1049*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000077,  /* ')' */
  /*1050*/ COUNT_OF_PHRASES | 0x000001,
  /*1051*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000078,  /* » */
  /*1052*/ COUNT_OF_PHRASES | 0x000001,
  /*1053*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000079,  /* |> */
  /*1054*/ COUNT_OF_PHRASES | 0x000001,
  /*1055*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000047,  /* > */
  /*1056*/ COUNT_OF_PHRASES | 0x000001,
  /*1057*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000078,  /* » */

// P<BALANCED-STRING> = ...;
  /*1058*/ COUNT_OF_ALTS    | 0x000001,
  /*1059*/ COUNT_OF_PHRASES | 0x000003,
  /*1060*/ PHRASE_TYPE      | G_ldquo,
  /*1061*/ PHRASE_TYPE      | G_BALANCED_CHAR_SEQUENCE,
  /*1062*/ PHRASE_TYPE      | G_rdquo,

// P<BALANCED-CHAR-SEQUENCE> = ...;
  /*1063*/ COUNT_OF_ALTS    | 0x000002,
  /*1064*/ COUNT_OF_PHRASES | 0x000002,
  /*1065*/ PHRASE_TYPE      | G_BALANCED_CHAR,
  /*1066*/ PHRASE_TYPE      | G_BALANCED_CHAR_SEQUENCE,
  /*1067*/ COUNT_OF_PHRASES | 0x000000,

// P<BALANCED-CHAR> = ...;
  /*1068*/ COUNT_OF_ALTS    | 0x000002,
  /*1069*/ COUNT_OF_PHRASES | 0x000001,
  /*1070*/ PHRASE_TYPE      | G_BALANCED_STRING,
  /*1071*/ COUNT_OF_PHRASES | 0x000002,
  /*1072*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_rdquo,
  /*1073*/ PHRASE_TYPE      | G_ch,

// P<RB> = ...;
  /*1074*/ COUNT_OF_ALTS    | 0x000001,
  /*1075*/ COUNT_OF_PHRASES | 0x000001,
  /*1076*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00003e,  /* '>' */

// P<C-STRING> = ...;
  /*1077*/ COUNT_OF_ALTS    | 0x000003,
  /*1078*/ COUNT_OF_PHRASES | 0x000003,
  /*1079*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000022,  /* '"' */
  /*1080*/ PHRASE_TYPE      | G_C_CHARS,
  /*1081*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000022,  /* '"' */
  /*1082*/ COUNT_OF_PHRASES | 0x000003,
  /*1083*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00007a,  /* `` */
  /*1084*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000007,  /* ^[^']* */
  /*1085*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00007b,  /* '' */
  /*1086*/ COUNT_OF_PHRASES | 0x000003,
  /*1087*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00007c,  /* ` */
  /*1088*/ REGEXP_TYPE      | WHITESPACE_ALLOWED | 0x000007,  /* ^[^']* */
  /*1089*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00007d,  /* ' */

// P<C-CHARS> = ...;
  /*1090*/ COUNT_OF_ALTS    | 0x000005,
  /*1091*/ COUNT_OF_PHRASES | 0x000002,
  /*1092*/ PHRASE_TYPE      | G_stropped,
  /*1093*/ PHRASE_TYPE      | G_C_CHARS,
  /*1094*/ COUNT_OF_PHRASES | 0x000003,
  /*1095*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_dquote,
  /*1096*/ PHRASE_TYPE      | G_ch,
  /*1097*/ PHRASE_TYPE      | G_C_CHARS,
  /*1098*/ COUNT_OF_PHRASES | 0x000003,
  /*1099*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000022,  /* '"' */
  /*1100*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000022,  /* '"' */
  /*1101*/ PHRASE_TYPE      | G_C_CHARS,
  /*1102*/ COUNT_OF_PHRASES | 0x000003,
  /*1103*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x00005c,  /* '\' */
  /*1104*/ PHRASE_TYPE      | G_ch,
  /*1105*/ PHRASE_TYPE      | G_C_CHARS,
  /*1106*/ COUNT_OF_PHRASES | 0x000000,

// P<dquote> = ...;
  /*1107*/ COUNT_OF_ALTS    | 0x000001,
  /*1108*/ COUNT_OF_PHRASES | 0x000001,
  /*1109*/ CHAR_TYPE        | WHITESPACE_ALLOWED | 0x000022,  /* '"' */

// P<closer> = ...;
  /*1110*/ COUNT_OF_ALTS    | 0x000006,
  /*1111*/ COUNT_OF_PHRASES | 0x000001,
  /*1112*/ PHRASE_TYPE      | G_semi,
  /*1113*/ COUNT_OF_PHRASES | 0x000001,
  /*1114*/ PHRASE_TYPE      | G_comma,
  /*1115*/ COUNT_OF_PHRASES | 0x000001,
  /*1116*/ PHRASE_TYPE      | G_rb,
  /*1117*/ COUNT_OF_PHRASES | 0x000001,
  /*1118*/ PHRASE_TYPE      | G_end,
  /*1119*/ COUNT_OF_PHRASES | 0x000001,
  /*1120*/ PHRASE_TYPE      | G_else,
  /*1121*/ COUNT_OF_PHRASES | 0x000001,
  /*1122*/ PHRASE_TYPE      | G_then,

// P<semi> = ...;
  /*1123*/ COUNT_OF_ALTS    | 0x000001,
  /*1124*/ COUNT_OF_PHRASES | 0x000001,
  /*1125*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00007e,  /* ; */

// P<comma> = ...;
  /*1126*/ COUNT_OF_ALTS    | 0x000001,
  /*1127*/ COUNT_OF_PHRASES | 0x000001,
  /*1128*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000d,  /* , */

// P<rb> = ...;
  /*1129*/ COUNT_OF_ALTS    | 0x000001,
  /*1130*/ COUNT_OF_PHRASES | 0x000001,
  /*1131*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00000b,  /* ) */

// P<end> = ...;
  /*1132*/ COUNT_OF_ALTS    | 0x000001,
  /*1133*/ COUNT_OF_PHRASES | 0x000001,
  /*1134*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000001,  /* e̲n̲d̲ */

// P<else> = ...;
  /*1135*/ COUNT_OF_ALTS    | 0x000001,
  /*1136*/ COUNT_OF_PHRASES | 0x000001,
  /*1137*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000017,  /* e̲l̲s̲e̲ */

// P<then> = ...;
  /*1138*/ COUNT_OF_ALTS    | 0x000001,
  /*1139*/ COUNT_OF_PHRASES | 0x000001,
  /*1140*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x000016,  /* t̲h̲e̲n̲ */

// P<ENDTEXT> = ...;
  /*1141*/ COUNT_OF_ALTS    | 0x000002,
  /*1142*/ COUNT_OF_PHRASES | 0x000005,
  /*1143*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_semi,
  /*1144*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_end,
  /*1145*/ PHRASE_TYPE      | NEGATED_PHRASE     | G_else,
  /*1146*/ PHRASE_TYPE      | G_ch,
  /*1147*/ PHRASE_TYPE      | G_ENDTEXT,
  /*1148*/ COUNT_OF_PHRASES | 0x000000,

// P<stropped-keywords> = ...;
  /*1149*/ COUNT_OF_ALTS    | 0x000001,
  /*1150*/ COUNT_OF_PHRASES | 0x000001,
  /*1151*/ KEYWORD_TYPE     | WHITESPACE_ALLOWED | 0x00007d,  /* ' */

// P<optional-stropping-conversion> = ...;
  /*1152*/ COUNT_OF_ALTS    | 0x000002,
  /*1153*/ COUNT_OF_PHRASES | 0x000002,
  /*1154*/ PHRASE_TYPE      | GUARD_PHRASE       | G_stropped_keywords,
  /*1155*/ SEMANTIC_TYPE    | S_convert_keywords,
  /*1156*/ COUNT_OF_PHRASES | 0x000000,
};


int parse_init(void)
{
  // peform any initialisation required by the parse-time semantic routines.
  // Note that for now, we have no way of declaring data outside of
  // those procedures.  Obviously this will have to change.
  return TRUE;
}
int parse_terminate(void)
{
  // perform any final tidy-up required by the parse-time semantic routines.
  return TRUE;
}
int parse_convert_keywords(void)
{
#ifdef IN_PARSER
  int debug_stropping = 0;

  // Loop through the source() array and convert 'stropped' keywords into u̲n̲d̲e̲r̲l̲i̲n̲e̲d̲ keywords.
  // This draft version unfortunately *will* convert stropped words in strings and comments.
  // - see tests/cacm/101.a60 for examples...
  // Will try to fix later although the syntax of comments at the end of a procedure block
  // means that a simple lexical filter may just not be possible.

  int FP = 0, PP = 0;

  // AN EXTRA ARRAY IS NEEDED HERE BECAUSE THE STROPPING ADDS AN EXTRA
  // CHARACTER *PER LETTER* AND OVERWRITES THE INPUT AT FP!  These extra
  // characters are not compensated for by the removal of the two quotes.
  // It would be so much nicer if we had a single Unicode character representing
  // a stropped letter.  Would solve a nasty lexing problem as well as this.

  DECLARE(stropped_source, wint_t, 600000); 
  #define _stropped_source(x) WRITE(x,stropped_source,wint_t)
  #define  stropped_source(x) READ(x,stropped_source,wint_t)

  for (;;) {
    wint_t WC = source(FP++);
    if (WC == '\'') {
      int Peek = FP;
      while (isalpha(source(Peek))) { Peek += 1; };
      if (source(Peek) == '\'') {
        // We have 'KEYWORD'
        // opening ' skipped already
        while (isalpha(source(FP))) {
          WC = source(FP++);
          if (isupper(WC)) WC = tolower(WC);
          _stropped_source(PP++) = WC; _stropped_source(PP++) = 818 /* Unicode COMBINING LOW LINE */;
          if (debug_stropping) fwprintf(stderr, L"%lc%lc", WC, (wchar_t)818);
        }
        FP++; // skip closing '
      } else {
        // Doesn't fit the pattern, so don't convert
        // But first, check for character constants, eg '('
        Peek = FP; WC = source(Peek);
        if (WC != 0 && source(Peek+1) == '\'') {
          // Single character constant.  We'll worry about strings later.
          _stropped_source(PP++) = '\'';
          _stropped_source(PP++) = WC;    FP += 1;
          _stropped_source(PP++) = '\'';  FP += 1;
          if (debug_stropping) fwprintf(stderr, L"'%lc'", WC);
        } else {
          _stropped_source(PP++) = '\'';
          if (debug_stropping) fwprintf(stderr, L"'");
        }
      }
      continue;
    }
    _stropped_source(PP++) = WC;
    if (debug_stropping) if (WC) fwprintf(stderr, L"%lc", WC);
    if (WC == 0) break; // convert up to end of file.
  }

  // copy back from stropped_source to source
  for (FP = 0; FP < PP; FP++) {
    _source(FP) = stropped_source(FP);
  }
  // free stropped_source
  FREE_FLEX(stropped_source);

#endif
  return TRUE;
}

// B<EOF> = 0;

// B<nl> = 2;

// E
#endif  // SUPPRESS_DATA
#endif  // _GRAMMAR_H_
