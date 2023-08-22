# simple language consists of assignments of expressions to a variable.
# each statement is terminated by a semicolon.

# for example x = a + 3;

# This grammar is going to be a test of using a stack to apply precedence
# to a grammar that parses expressions without using multi-level rules to
# enforce the precedence as is sometimes done in a trade-off of grammar
# complexity and slower parsing times, against more complex code but
# faster parsing.  In the Algol60 parser I decided to take the opposite
# approach of having the precedence encoded in the grammar.

# Because EOF is checked for by <!any>, that means the actual check is
# to see whether the rule <any> fails.  But when a rule fails, it undoes
# the skipped whitespace, so we have to add that "" empty string, just to
# absorb the final trailing whitespace again...
# We could avoid this small hassle by using B<EOF> = 0;
P<any> = «.»;
#P<EOF> = <!any> ""; # remove white space after confirming EOF
B<EOF> = 0;
B<ch>=1;
C<ignored>={
    // trying to find why diags report wrong phrase names in algol60 but not in basic calc
    return 0;
};
P<SS> = <EXPRS> <EOF>;

P<EXPRS> = <SETVAR> "=" <EXPR> ";" <MORE-EXPRS>;
P<MORE-EXPRS> = <EXPRS>, ;
P<EXPR> = <OPT-MONOP> <TERM> <MORE-TERMS> ;
P<MORE-TERMS> = <OP> <EXPR>, ;
P<TERM> = <VAR>, <NUM>, "(" <EXPR> ")";

P<OP> = "*", "/", "+", "-";
P<OPT-MONOP> = "-", ;

P<NUM> = «[1-9][0-9]*»;
#P<VAR> = «[A-Za-z][A-Za-z]*»;
P<VAR> = «[A-Za-z]+»;

# We use an extra level of indirection for the LHS of the assignment
# just to make handling easier in the AST code.

P<SETVAR> = <VAR>;

E
