#
# This is an ALGOL 60 grammar that I am using to test my latest parser generator.
# Significantly, the parser supports the use of Unicode, and the test ALGOL 60
# files (in *.a60 in the tests/ subdirectory) are written using Unicode and attempt
# to duplicate the preferred syntax of the ALGOL 60 report as closely as the current
# technology allows.  View a typical source file at:
#    http://gtoal.com/languages/algol60/TESTS/NUMAL/StatalI.a60.html
#
# Read more about this parser (and download it) at:
#    http://gtoal.com/languages/algol60/new-unicode-parser/README.html
#

# Originally I used the Edinburgh style of grammar where all the operators
# were gathered under one <OP> phrase, and precedence was applied afterwards
# using the shunting-yard algorithm or similar.  However my previous experience
# with other compilers where the precedence was built in to the grammar
# rules has convinced me to do it that way here too, as the slight
# overhead of a little extra backtracking really isn't noticeable and
# the simplicity in extracting the AST is far greater.

# Built-in phrases for code implemented within the parser.

B<EOF> = 0; # end of file
B<nl> = 2;  # we use a built-in phrase for \n because regular expressions don't handle newlines
            # well, and I haven't yet fully tested escaped characters in literal strings!

# semantic rules - C<fred> maps to int parse_fred(void) ...
# These temporarily have to be defined before they are used.

C<init> = {
  // peform any initialisation required by the parse-time semantic routines.
  // Note that for now, we have no way of declaring data outside of
  // those procedures.  Obviously this will have to change.
  return TRUE;
};

C<terminate> = {
  // perform any final tidy-up required by the parse-time semantic routines.
  return TRUE;
};

C<convert-keywords> = {
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
};

# regular rules.

# P<SS> IS THE MAIN ENTRY POINT!:

P<SS> = <init> <optional-stropping-conversion> <SOURCE> <terminate>;

P<SOURCE> = <MAIN-PROGRAM> <semi_opt> <EOF>, <EXTERNAL-LEVEL-OBJECTS> <EOF> ;

P<semi_opt> = ';', ;

P<MAIN-PROGRAM> = <PROGRAM_opt> <COMMENTS_opt> "b̲e̲g̲i̲n̲" <LOCAL-BLOCK> "e̲n̲d̲" <ENDTEXT>;

P<PROGRAM_opt> = "p̲r̲o̲g̲r̲a̲m̲" <NAME> ';', ;
    
P<EXTERNAL-LEVEL-OBJECTS> = <EXTERNAL-LEVEL> <EXTERNAL-LEVEL-OBJECTS>, ;

P<EXTERNAL-LEVEL> =
   "e̲o̲p̲",
   "c̲o̲d̲e̲" <DIGITS> ';',
   <COMMENT>,
   <PROCEDURE> ';',
   <OWN-DECLARATION> ';';

# we can have top-level declarations in Algol but they are 'own' by
# default, unless we allow external data as an extension.  Own arrays
# cannot have dynamic bounds.

P<PROCTYPE_opt> =
   "i̲n̲t̲e̲g̲e̲r̲",
   "r̲e̲a̲l̲",
   <BOOLEAN>,
   ;

P<BOOLEAN> = "B̲o̲o̲l̲e̲a̲n̲", "b̲o̲o̲l̲e̲a̲n̲";
    
# declaration of procedure parameters must be values first, then type.
# body is either a begin/end block or a single statement (which must
# be an assignment in the case of a function).
P<PROCEDURE> = <PROCTYPE_opt> "p̲r̲o̲c̲e̲d̲u̲r̲e̲" <NAME> <FORMAL_PARAMS_opt> ';'
               <COMMENTS_opt>
               <VALUE_opt>
               <PARAMETER-TYPES_opt>
               <LABELS_opt>
               <PROCBODY>;

# just the names and whether param is call-by-value or call-by-name.
# type of each param must come later if not default.
P<FORMAL_PARAMS_opt> = 
   "(" <NAME> <MORE-FP-LIST> ")",
  ;
P<MORE-FP-LIST> =
   <FPSEP> <FORMAL-PARAMETER> <MORE-FP-LIST>,
  ;
P<FORMAL-PARAMETER> =
   <NAME>;
# (see the <ACTUAL-PARAMETER> definition later for FPSEP)

P<VALUE_opt> =
   "v̲a̲l̲u̲e̲" <VALUE-NAMELIST> ';',
  ;
P<VALUE-NAMELIST> =
   <VALUE-NAME> <MORE-VALUE-NAMELIST>;
P<MORE-VALUE-NAMELIST> =
   "," <VALUE-NAMELIST>,
  ;
P<VALUE-NAME> =
   <NAME>;

P<COMMENT-NO-SEMI> = "c̲o̲m̲m̲e̲n̲t̲" <COMMENTTEXT> ;
P<COMMENT> = <COMMENT-NO-SEMI> ';' ;
#P<COMMENT_opt> = <COMMENT>, ;
P<COMMENTS_opt>  = <COMMENT> <MORE-COMMENTS>, ;
P<MORE-COMMENTS> = ';' <COMMENT> <MORE-COMMENTS>, ;

P<COMMENTTEXT> = <NONSEMITEXT> <OPT-MORELINES> ;

P<NONSEMITEXT> = «[^;]*»;

# the white-space skipping could handle this newline for us.
P<OPT-MORELINES> = <nl> <NONSEMITEXT> <OPT-MORELINES>, ;

# Apparently labels are *not* allowed before comments...
P<LABELS_opt> =
   <NAME> <!assign> ":"  <!comment-keyword> <LABELS_opt>,
  ;
# was:   <NAME> <!assign> ":"  <COMMENTS_opt> <LABELS_opt>,
P<comment-keyword> = "c̲o̲m̲m̲e̲n̲t̲";

P<assign> = ":=";

P<PARAMETER-TYPES_opt> =
   <PARAMETER-TYPE> ';' <PARAMETER-TYPES_opt>, ;

P<PARAMETER-TYPE> =
   "l̲a̲b̲e̲l̲"   <DECLIST>,
   "s̲w̲i̲t̲c̲h̲"  <DECLIST>,
   "s̲t̲r̲i̲n̲g̲"  <DECLIST>,
   "i̲n̲t̲e̲g̲e̲r̲" <PDECLN>,
   "r̲e̲a̲l̲"    <PDECLN>,
   <BOOLEAN> <PDECLN>,
             <PDECLN>,  # parameter may be a procedure
   <COMMENT-NO-SEMI>;

P<PDECLN> =
   "a̲r̲r̲a̲y̲" <DECLIST>,
   "p̲r̲o̲c̲e̲d̲u̲r̲e̲" <DECLIST>, #PARCOM
   <DECLIST>;

P<DECLIST> =
   <NAME> <MORE-DECLIST>;

P<MORE-DECLIST> =
   "," <NAME> <MORE-DECLIST>,
  ;

P<LOCAL-DECLARATION> =
   "i̲n̲t̲e̲g̲e̲r̲" <LOCAL-ARRAY-DECLN>,
   "i̲n̲t̲e̲g̲e̲r̲" <LOCAL-SCALAR-DECLN>,
   "r̲e̲a̲l̲"    <LOCAL-ARRAY-DECLN>,
             <LOCAL-ARRAY-DECLN>,
   "r̲e̲a̲l̲"    <LOCAL-SCALAR-DECLN>,
   <BOOLEAN> <LOCAL-ARRAY-DECLN>,
   <BOOLEAN> <LOCAL-SCALAR-DECLN>,
   "s̲w̲i̲t̲c̲h̲" <NAME> ":=" <SWITCH-DECLS>;

P<SWITCH-DECLS> = <SWITCH-DECL> <MORE-SWITCH-DECLS>;
P<MORE-SWITCH-DECLS> = ',' <SWITCH-DECL> <MORE-SWITCH-DECLS>, ;
# some unnecesary backtracking here to make it easier to group "A,B,C[N],D,E;"
# into "A,B,C[N]" and "D,E", where the former means "A[N],B[N],C[N]"...
P<SWITCH-DECL> = <DECLIST> <ARRAY-LB> <CONST-EXPR> <ARRAY-RB>,
                 <DECLIST>,
                 <LEXPR>;
P<OPT-ARRAY> = <ARRAY-LB> <CONST-EXPR> <ARRAY-RB>, ;
P<JUMP-TARGET> = <LEXPR>;

# 'LEXPR' is short for 'Label expression', which the report calls a 'designational expression'.
P<LEXPR> =
   '(' <LEXPR> ')',
   "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <SLEXPR> "e̲l̲s̲e̲" <LEXPR>,  # if/then must have an else:
   <SLEXPR>;

P<SLEXPR> = <NAME> <OPT-ARRAY>;   # simple label expression

# explicitly declared as 'own'
P<OWN-DECLARATION> =
   "o̲w̲n̲" "i̲n̲t̲e̲g̲e̲r̲" <OWN-ARRAY-DECLN>,
   "o̲w̲n̲" "i̲n̲t̲e̲g̲e̲r̲" <LOCAL-SCALAR-DECLN>,
   "o̲w̲n̲" "r̲e̲a̲l̲"    <OWN-ARRAY-DECLN>,
   "o̲w̲n̲"           <OWN-ARRAY-DECLN>,
   "o̲w̲n̲" "r̲e̲a̲l̲"    <LOCAL-SCALAR-DECLN>,
   "o̲w̲n̲" <BOOLEAN> <OWN-ARRAY-DECLN>,
   "o̲w̲n̲" <BOOLEAN> <LOCAL-SCALAR-DECLN>;

P<OWN-ARRAY-DECLN> = "a̲r̲r̲a̲y̲" <OWN-BOUNDED-DECLIST>;

P<LOCAL-ARRAY-DECLN> = "a̲r̲r̲a̲y̲" <BOUNDED-DECLIST>;
P<LOCAL-SCALAR-DECLN> = <DECLIST>;

P<OWN-BOUNDED-DECLIST> = <DECLIST> <OWN-BOUNDS-DECLARATION> <MORE-OWN-BOUNDED-DECLIST>;

P<BOUNDED-DECLIST> = <DECLIST> <BOUNDS-DECLARATION> <MORE-BOUNDED-DECLIST>;
P<MORE-OWN-BOUNDED-DECLIST> = ',' <DECLIST> <OWN-BOUNDS-DECLARATION> <MORE-OWN-BOUNDED-DECLIST>, ;
P<MORE-BOUNDED-DECLIST> = ',' <DECLIST> <BOUNDS-DECLARATION> <MORE-BOUNDED-DECLIST>, ;

P<OWN-BOUNDS-DECLARATION> = <ARRAY-LB> <OWN-BOUNDS-DECLIST> <ARRAY-RB> ;
P<BOUNDS-DECLARATION> = <ARRAY-LB> <BOUNDS-DECLIST> <ARRAY-RB> ;
P<OWN-BOUNDS-DECLIST> = <OWN-BOUND-DEC> <MORE-OWN-BOUNDS-DECLIST>;
P<BOUNDS-DECLIST> = <BOUND-DEC> <MORE-BOUNDS-DECLIST>;
P<MORE-OWN-BOUNDS-DECLIST> = ',' <OWN-BOUND-DEC> <MORE-OWN-BOUNDS-DECLIST>, ;
P<MORE-BOUNDS-DECLIST> = ',' <BOUND-DEC> <MORE-BOUNDS-DECLIST>, ;

P<OWN-BOUND-DEC> = <CONST-EXPR> <COLON-WARN-COMMA> <CONST-EXPR>;
P<BOUND-DEC> = <arithmetic_expression> <COLON-WARN-COMMA> <arithmetic_expression>;
P<COLON-WARN-COMMA> = ':', ',', "..";

P<CONST-EXPR> = <arithmetic_expression>;
    
# Body can be a single statement, but that statement can be a huge if/then/else chain
# as long as it contains an assignment to the function result (assuming a function
# and not a procedure)
P<PROCBODY> =
   "c̲o̲d̲e̲" <DIGITS>, "a̲l̲g̲o̲l̲", "f̲o̲r̲t̲r̲a̲n̲", "e̲x̲t̲e̲r̲n̲a̲l̲",
   "b̲e̲g̲i̲n̲" <LOCAL-BLOCK> "e̲n̲d̲" <ENDTEXT>,
   <ASSIGNMENT>,
   <function_designator>,
   "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL-STATEMENT>,
   "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL-STATEMENT> <OPT-ELSE>,
   "g̲o̲" "t̲o̲" <JUMP-TARGET>, # surprised that this is allowed, but seems to be.
  ;  # apparently a null body is allowed too.

P<LOCAL-BLOCK> =               <LABELS_opt> <LOCAL-STATEMENT> <MORE-LOCAL-STATEMENTS>, ;
P<MORE-LOCAL-STATEMENTS> = ';' <LABELS_opt> <LOCAL-STATEMENT> <MORE-LOCAL-STATEMENTS>, ;

# easiest way to handle semicolons between declarations and statements
# was to make the declarations into statements.  If an ordering is required
# it can be handled at the next level.
P<LOCAL-STATEMENT> = 
   <COMMENT-NO-SEMI>,
   <ASSIGNMENT>,
   <function_designator>,
   "b̲e̲g̲i̲n̲" <LOCAL-BLOCK> "e̲n̲d̲" <ENDTEXT>,
   "f̲o̲r̲" <LHS> ":=" <FLE> <FORLIST> "d̲o̲" <LABELS_opt> <LOCAL-STATEMENT>,
   "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL-STATEMENT> <OPT-ELSE>,
   "g̲o̲" "t̲o̲" <JUMP-TARGET>,
   <CODE>, 
   <PROCEDURE>,
   <OWN-DECLARATION>,
   <LOCAL-DECLARATION>,
   ;    # an empty statement (and thus an extra ';') should be OK.

P<CODE> = "c̲o̲d̲e̲" <ONOFF>;
P<ONOFF> = "o̲n̲", "o̲f̲f̲";

P<OPT-ELSE> = 
   "e̲l̲s̲e̲" <LABELS_opt> "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <LABELS_opt> <LOCAL-STATEMENT> <OPT-ELSE> ,
   "e̲l̲s̲e̲" <LABELS_opt> <LOCAL-STATEMENT>,
  ;

P<FLE> = <arithmetic_expression> <REST-OF-FLE>;

P<REST-OF-FLE> =
   "s̲t̲e̲p̲" <arithmetic_expression> "u̲n̲t̲i̲l̲" <arithmetic_expression>,
   "w̲h̲i̲l̲e̲" <Boolean_expression>,
  ;

P<FORLIST> =
   "," <FLE> <FORLIST>,
  ;

# C-style multiple assignment A := B := C;
P<MORE-LHS> = <LHS> ':=' <MORE-LHS>, ;

# Note there is a unicode character for :=  (≔ - U+2254) but currently only supported in html, not unicode text files.
P<ASSIGNMENT> = <LHS> ':=' <MORE-LHS> <RHS>;

P<LHS> = <NAME> <ARRAY-LB> <ARRAY-INDEX> <ARRAY-INDICES> <ARRAY-RB>,
         <NAME> ;

# If you think these '<?closer>' guards below are not necessary,
# try taking them out and running the regression tests again! ;-)

# The reason behind them is this: lets say we have a boolean expression
# "a a̲n̲d̲ b" but parse it first as an arithmetic expression.  Well, 'a̲n̲d̲'
# is not valid in an arithmetic expression, but the simple 'a' is ... so
# the arithmetic expression will succeed, but when the parser returns
# from looking at phrase <RHS>, that "a̲n̲d̲" will still be sitting in the
# input stream and will fail to match whatever came after <RHS> (which
# was probably ';').  The parser having returned from <RHS> successfully
# will never go on to check <Boolean_expression> in that context, and
# the parse will fail.  So the guard rejects the <arithmetic_expression>,
# allowing <Boolean_expression> a chance to succeed.

# I may need to extend <RHS> with a designational expression too (ie labels,
# using <LEXPR>) with another guard.  Same thing applies for <ACTUAL-PARAMETER>.

P<RHS> = <arithmetic_expression> <?closer>, <Boolean_expression> <?closer> ;

P<function_designator> = <NAME> <ACTUAL-PARAMETERS> , <NAME>;
P<ACTUAL-PARAMETERS> = '(' <ACTUAL-PARAMETER> <MORE-ACTUAL-PARAMETERS> ')' ;
P<MORE-ACTUAL-PARAMETERS> = <FPSEP> <ACTUAL-PARAMETER> <MORE-ACTUAL-PARAMETERS>, ;

# Note that the letter sequence in a procedure call is Alpha only - no numerics
# and that it is effectively a comment - it is not concatenated with the initial
# procedure name, which is only the <NAME> that comes before the first '('.
P<FPSEP> =
   ",",
   ")" «[ ]*[A-Za-z][A-Za-z ]*» ":" "("; # remove initial [ ]?


# In this Algol 60, string literals are only valid in procedure parameters.
# Should labels (designational expressions - <LEXPR>) be allowed here too?
# Regression test tests/algtests_at23.a60 does actually work but perhaps
# because the label expression is being recognised as either an arithmetic
# expression or a Boolean expression by accident, because we have no type
# checking at parse time.  Potentially a semantic phrase could be used to
# have specific procedure parameters be checked for expressions of the type
# that match the declared type of the formal parameter.

# Note 'string literal' because there is no such thing as a string expression.

P<ACTUAL-PARAMETER> = <Boolean_expression> <?closer>, <arithmetic_expression> <?closer>, <string_literal> ;


# Procedure call can be just <NAME> so order is important here.
P<OPERAND> =
#  <NAME> <APP>,
   <NAME> <ARRAY-LB> <ARRAY-INDEX> <ARRAY-INDICES> <ARRAY-RB>,
   <function_designator>,
   <NAME>,
   <REAL-CONSTANT>,
   "(" <arithmetic_expression> ")";

P<ARRAY-INDEX> = <arithmetic_expression>;

P<ARRAY-INDICES> = ',' <ARRAY-INDEX> <ARRAY-INDICES>, ;

##P<arithmetic_expression> = <PLUS-MINUS-opt> <OPERAND> <MORE-EXPR>;

P<primary> = <PLUS-MINUS-opt> <OPERAND>;
P<exp-op> = "^", "**", "⭡", "|^", "p̲o̲w̲e̲r̲";
P<exp-factor> = <exp-op> <factor>, ;
P<factor> = <primary> <exp-factor>;
P<mul-op> = "*", "×";
P<rdiv-op> = "/";
# non-standard "m̲o̲d̲" missing.
P<idiv-op> = "//",  "÷",  "%",  "d̲i̲v̲", "'/'";
P<div-op> = <idiv-op>, <rdiv-op>;
P<muldiv-op> = <mul-op>, <div-op>;
P<mul-factor> = <muldiv-op> <term> , ;
P<term> = <factor> <mul-factor>;
P<add-op> = "+" ;
P<sub-op> = "-" ;
P<addsub-op> = <add-op>, <sub-op>;
P<add-term> = <addsub-op> <simple_arithmetic_expression> , ;
P<simple_arithmetic_expression> = <term> <add-term>;

P<arithmetic_expression> =
   "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_arithmetic_expression> "e̲l̲s̲e̲" <arithmetic_expression>,
   <simple_arithmetic_expression>;

P<INTEGER-CONSTANT> =
   <PLUS-MINUS-opt> <DIGITS>;

P<REAL-CONSTANT> =
   <PLUS-MINUS-opt> <unsigned>;

P<unsigned> =
   <decnum> <expart>,
   <expart>,
   <decnum>;

P<decfract> =
   "." <DIGITS>;

P<expart> =
   <subten> <INTEGER-CONSTANT>;

P<decnum> =
   <DIGITS> <decfract>,
   <decfract>,
   <DIGITS>;

P<subten> =
   "@", "&", "⏨", "\u23E8", "\u2081\u2080";  # Marst uses # instead of ⏨. Some other Algol uses # for not-equals. Can't have both.

# Could have been expressed as «[+-]?» or «(+|-)?» but code returned by AST would be the same for each.
# I didn't think this was allowed but Brian Wichmann's test 136 seems to say it is:     X := + + 1.0; X := - - X; OUTREAL(99, + - X)

P<PLUS-MINUS-opt> =
   "+" <PLUS-MINUS-opt>,
   "-" <PLUS-MINUS-opt>,
  ;

# CDC Algol: The result of A⭡I is r̲e̲a̲l̲, except where A is i̲n̲t̲e̲g̲e̲r̲ and I is a constant with positive integral value,
# in which case the result is i̲n̲t̲e̲g̲e̲r̲.  This differs from the report only when the base A is integer and the exponent
# I is an integer variable whose value is positive.

# several alternative forms of Algol symbols are temporarily being supported.

#
# Order of priority for arithmetic operators:
#
# first  : ⭡
# second : × / ÷
# third  : + -
#

P<logical_value> =
   "t̲r̲u̲e̲",
   "f̲a̲l̲s̲e̲";

#
# Order of priority for Boolean operators:
#
# first  : arithmetic expressions
# second : < ≤ = ≥ > ≠
# third  : ¬
# fourth : ∧
# fifth  : ∨
# sixth  : ⊃ (i̲m̲p̲l̲)
# seventh: ≡
#
    
P<relational_operator> =
   "=",   "e̲q̲u̲a̲l̲", "e̲q̲",
   ">=",  "≥",   "g̲e̲",  "n̲o̲t̲l̲e̲s̲s̲",  "g̲r̲e̲q̲",
   ">",   "g̲t̲",  "g̲r̲e̲a̲t̲e̲r̲",
   "<>",  "#",   "≠",   "n̲e̲",  "n̲o̲t̲e̲q̲u̲a̲l̲", "\\=", "¬=", "!=",  "^=", "|=",
   "<=",  "≤",   "l̲e̲s̲s̲e̲q̲", "n̲o̲t̲g̲r̲e̲a̲t̲e̲r̲",
   "<",   "l̲t̲",  "l̲e̲s̲s̲",
   "l̲e̲";

# A(x) as an array element is non-standard but has been seen.
# unfortunately it can make a function call look like an array
# access in some sources where () is used correctly, e.g.
# https://gtoal.com/languages/algol60/new-unicode-parser/tests/prim.a60 =>
# https://gtoal.com/languages/algol60/new-unicode-parser/html/prim.a60.html
# A parse-time guard might be useful here.
P<ARRAY-LB> = '[', "(/"; # , "(";
P<ARRAY-RB> = ']', "/)"; # , ")";
    
P<relation> = <arithmetic_expression> <relational_operator> <arithmetic_expression>;

P<Boolean_primary> =
   <relation>,
   <NAME> <ARRAY-LB> <ARRAY-INDEX> <ARRAY-INDICES> <ARRAY-RB>,
   <function_designator>,
   <NAME>,
   <logical_value>,
   "(" <Boolean_expression> ")";

# rather generous here in what we accept.
P<not-term> = "n̲o̲t̲", "¬", "!", "~";
P<not-terms> = <not-term> <not-terms>, ;
P<Boolean_secondary> = <not-term> <not-terms> <Boolean_primary>, <Boolean_primary>;

P<and-term> = "a̲n̲d̲", "∧", "&";
P<and_Boolean_factor> = <and-term> <Boolean_factor>, ;
P<Boolean_factor> = <Boolean_secondary> <and_Boolean_factor>;

P<or-term> = "o̲r̲", "∨";
P<or_Boolean_term> = <or-term> <Boolean_term>, ;
P<Boolean_term> = <Boolean_factor> <or_Boolean_term>;

P<impl-term> = "i̲m̲p̲l̲i̲e̲s̲", "i̲m̲p̲l̲", "i̲m̲p̲", "⊃", "\u2283", "->";
P<more_implication_Boolean> = <impl-term> <implication_Boolean>, ;
P<implication_Boolean> = <Boolean_term> <more_implication_Boolean>;

P<equiv-term> = "e̲q̲u̲i̲v̲", "e̲q̲v̲", "≡", "==";
P<equiv_simple_Boolean> = <equiv-term> <simple_Boolean>, ;
P<simple_Boolean> = <implication_Boolean> <equiv_simple_Boolean>;

P<Boolean_expression> =
   "i̲f̲" <Boolean_expression> "t̲h̲e̲n̲" <simple_Boolean> "e̲l̲s̲e̲" <Boolean_expression>,
   <simple_Boolean>;

P<ch>  = <stropped>, «.»;    # any character. A stropped letter counts as a single character
                             # but parses as two in a regexp. So needs special handling.

# The regexp below would match "VAR i̲f̲" as 'VAR i' because the i̲ is really 'i'
# followed by '_' - this will be hard to work around without breaking the regexp
# into multiple pieces - which then have to be joined up in the user code, thus
# defeating the purpose of using regexps in the first place.  So the rule below
# has been replaced by the less elegant rule above.  If we were not using Unicode
# underlining, this would not be a problem.
##P<NAME> =  <!stropped> «[A-Za-z][A-Za-z0-9 ]*»;

# underlined characters are really two characters so we have to use this construct...
# We need to place this guard in front of <NAME>s because the representation of
# the underlined letter is the letter first followed by the underline modifier,
# so the initial letter would be ambiguous without the guard, which effectively
# looks ahead to check that the letter wasn't followed by the underline modifier.
P<stropped> = «(a̲|b̲|c̲|d̲|e̲|f̲|g̲|h̲|i̲|j̲|k̲|l̲|m̲|n̲|o̲|p̲|q̲|r̲|s̲|t̲|u̲|v̲|w̲|x̲|y̲|z̲|A̲|B̲|C̲|D̲|E̲|F̲|G̲|H̲|I̲|J̲|K̲|L̲|M̲|N̲|O̲|P̲|Q̲|R̲|S̲|T̲|U̲|V̲|W̲|X̲|Y̲|Z̲)»;

# space skipping may be an issue if we wanted the space as part of the name.
P<NAME> = <ALPHA> <ALPHANUMS>;
P<ALPHANUMS> = <ALPHANUM> <ALPHANUMS>, ;
P<ALPHA> = <!stropped> «[A-Za-z]»;
P<ALPHANUM> = <!stropped> «[A-Za-z0-9 ]»;

# P<DIGITS> = «[0-9][0-9 ]*»;
P<DIGITS> = <DIGIT> <MORE-DIGITS>;
P<DIGIT> = «[0-9]»;
P<MORE-DIGITS> = <DIGIT> <MORE-DIGITS>, ;

# The handling of strings in this parser is very much an expedient hack which was
# done to get the specific test files I was using to be accepted.  It allows for
# many different representations of string quotes and contents, and mixes them
# inconsistently.  A proper compiler that was not trying to be all things to all men
# would pick one representation and would implement it properly.  Even the output
# is a hack as directed double quotes (&ldquo; and &rdquo;) were not available
# on any system at the time the Algol report was written.  However I choose them
# here as being more in the spirit of the original design than any of the specific
# machine syntaxes that were actually used.

# Quoted strings:
#P<string_literal> = <BALANCED-STRING>, <ldquo> <dchs> <rdquo>, <C-STRING>;
P<string_literal> = <BALANCED-STRING>, <C-STRING>;

P<dchs> = <dch> <dchs>, ;
P<dch> = <!rdquo> <ch>;

P<ldquo> = "“", '{', "‘", "'('", "«", "|<", "<", "«" ;
P<rdquo> = "”", '}', "’", "')'", "»", "|>", ">", "»" ;

#P<BALANCED-STRING> = '<' <BALANCED-CHAR-SEQUENCE> '>';
#P<BALANCED-CHAR-SEQUENCE> = <BALANCED-CHAR> <BALANCED-CHAR-SEQUENCE> , ;
#P<BALANCED-CHAR> = <BALANCED-STRING>, <!RB> <ch> ;

P<BALANCED-STRING> = <ldquo> <BALANCED-CHAR-SEQUENCE> <rdquo>;
P<BALANCED-CHAR-SEQUENCE> = <BALANCED-CHAR> <BALANCED-CHAR-SEQUENCE> , ;
P<BALANCED-CHAR> = <BALANCED-STRING>, <!rdquo> <ch> ;

#P<LB> = '<';
P<RB> = '>';
P<C-STRING> = '"' <C-CHARS> '"', "``" «[^']*» "''", "`" «[^']*» "'";  # THESE ARE ALL VERY TEMPORARY!!!


P<C-CHARS> = <stropped> <C-CHARS>, <!dquote> <ch> <C-CHARS>, '""' <C-CHARS>, '\\' <ch> <C-CHARS>, ;
P<dquote> = '"';
#P<quote> = "'";
    
# These are not just for quick detection of the end of an expression, they are necessary
# to use in guards, to distinguish arithmetic expressions from Boolean expressions.
# These are all the tokens which can legitimately follow a complete expression.
P<closer> =
   <semi>,
   <comma>,
   <rb>,
   <end>,
   <else>,
   <then>;

P<semi> = ";";
P<comma> = ",";
P<rb> = ")";
P<end> = "e̲n̲d̲";
P<else> = "e̲l̲s̲e̲";
P<then> = "t̲h̲e̲n̲";

# This is the implied comment which comes after a "e̲n̲d̲". An "e̲l̲s̲e̲" or
# another "e̲n̲d̲" following an "e̲n̲d̲" should terminate the comment.
P<ENDTEXT> =
   <!semi> <!end> <!else>
   <ch>
   <ENDTEXT>,
  ;

# We can use the <RECOVER> rule below, which gobbles up a single character at a time
# until it gets to something parsable, to resynchronise after an error, should we want
# to continue parsing after an error.  (It may be an expensive recovery operation however -
# it may be more efficient to consider a semantic phrase to perform error recovery)

# This is not _usually_ wanted for a compiler but may be wanted for a source-to-source
# formatter (like 'indent') in order to to handle the case where the input is malformed.

# The reason this isn't required for a compiler is that our model of compilation 
# is now that we compile from within an editor and move immediately to the first point
# of error, which we fix and then recompile.  With recompilation speed being fast enough,
# there's little advantage in having the compiler handle multiple errors and indeed
# it is often the case that one error causes a cascade of knock-on effects that would
# disappear anyway once that initial error is corrected.

# However it is not reasonable to insist that an input file be error free simply in
# order to re-indent it, especially if you want to be able to format a region within
# a larger file (which is functionality that the Emacs editor supports).

# This form of recovery has been tested in my Imp to C coverter but not yet specifically
# in the algol60 formatter included with the parser as a demonstration.  The rule below
# is not invoked anywhere.  The place to call it would be as the final statement in
# <EXTERNAL-LEVEL> or <LOCAL-STATEMENT>.

#P<eop> = "e̲o̲p̲";
#P<RECOVER> = <ch> <!semi> <!end> <!eop> <!EOF> <RECOVER>, ;

# look ahead and if the first non-space item in the source file starts with a "'", convert
# stropped keywords before continuing with the parse.  Note this may be a useful place to
# determine any initial indentation, and add that indentation to all output - in order to
# support the use of the indenter to reformat blocks within a file when invoked by an
# editor such as Emacs.

# An alternative to doing this at the start of the file would be to do it at the point
# of every keyword, but that would significantly complicate the grammar (unless it was
# added as a hack to the parser which I would like to avoid).  The problem to avoid is
# that scanning through the source to convert 'keyword' to k̲e̲y̲w̲o̲r̲d̲ may accidentally
# pick up quoted string literals and strings in comments.  Unfortunately recognising
# comments requires actual parsing, and a malformed string in a comment that went
# unrecognised would throw a simple lexical-level conversion completely off course.

# Some files use '"' for stropping, and Edinburgh's Algol 60 allowed the leading '%'
# convention like IMP.  Neither has been added here yet.

P<stropped-keywords> = "'";
P<optional-stropping-conversion> = <?stropped-keywords> <convert-keywords>, ;

# 'E' is the end of the grammar.

E

