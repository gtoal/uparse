## A general parser in C

This is a system for building a parser (in C) for any programming
language. It uses a simple but effective parsing algorithm, is
acceptably fast (the ALGOL 60 parser supplied as an example parsed the
largest ALGOL 60 program I've been able to find in under a second on my
10-yr old 686 (when compiled using clang and the 'fast' options), which
included generating a reformatted version of the input file from the
parse tree). The grammars are easy to write and a skeleton compiler
source is built for you. Unicode input is supported in both the user's
programs and in the grammar definition itself.

(If you have previous experience with the unix systems yacc or bison and
their lexers lex and flex, this parser is easier to use: there are no
'shift-reduce' conflicts to resolve, there is arbitrary lookahead, and
lexing is built-in to the parser which is capable of matching terminals
against regular expressions. 'Scannerless parsing' is supported and
old-style 'line reconstruction' can be done if needed.)

The file you are currently reading is
<http://gtoal.com/languages/algol60/new-unicode-parser/README.html> and
the associated files are all available at
<http://gtoal.com/languages/algol60/new-unicode-parser/>

### How to use it - the short version

-   Create a working directory somewhere and `cd` into it.
-   Fetch the code:
    `wget `[`http://www.gtoal.com/languages/algol60/new-unicode-parser/algol60.tar`](http://www.gtoal.com/languages/algol60/new-unicode-parser/algol60.tar)  
    `tar -xvf algol60.tar`
-   Build the executable: `make`
-   run the regression tests for the example supplied: `./REGRESSION.sh`

Then when you want to try a grammar of your own:

-   Create your own *`language`*`.g` grammar and `test.`*`language`*
    input file.
-   Create your new project by using `./build-parser.sh `*`language`*
    once.
-   Build the new project by typing: `make`
-   Test your new project with `./`*`language`*` test.`*`language`*

(Note: the use of specific file extensions in this description is
arbitrary - the utilities are agnostic to the actual extension used.)

The demonstration parser builds an executable, "`algol60`", which will
re-indent an Algol60 source file (such as the examples in `test/*.a60`)
while canonicalizing some of the alternative Algol symbols to something
approaching the *publication syntax* standard, with stropped keywords
having been converted to underlined format. The command-line option "-jff"
will cause the source to be output in plain ascii instead, in a format
suitable for feeding to the `jff-a2c` (or `jff-algol`) command from
[`https://github.com/JvanKatwijk/algol-60-compiler`](https://github.com/JvanKatwijk/algol-60-compiler).
Using the parser in this way should enable Algol 60 source files in almost
any encoding to be compiled with the jff compiler.

### The grammar files

In the description below, I assume the reader is already familiar with
the overall concept of parsing to some extent, and perhaps has
previously used other parsing tools.

The grammar files used by this code are very similar to classic
Backus-Naur Form (BNF). The actual format is [inherited from various
parsers written in Edinburgh in the
70's](https://gtoal.com/history.dcs.ed.ac.uk/archive/languages/ERCC-IMP-grammars/imptocps)
and those in turn were derived from [Tony Brooker's
parsers](https://gtoal.com/history.dcs.ed.ac.uk/archive/languages/atlas-autocode/Phrase_Structure-Brooker-Morris.pdf)
from the 60's, including his Compiler-Compiler system, so the syntax is
not exactly BNF but is very close. The grammar can be written as a
stand-alone `.g` file or it can be embedded in your compiler source code
in the tradition (but not the syntax) of Yacc etc. The embedded version
makes use of comments in the C code: any text found in a line containing
`//\\` is extracted and written to a grammar file by the `Makefile`
before building the parser.

Note: The entire sequence beginning with `P<PHRASE_NAME> =` is called a
*production rule* or more commonly just a *rule*. The components of a
rule are either *phrases* or *terminals* (sometimes abbreviated to
*term* although I try to avoid that word in documentation because TERM
also has another meaning in the context of parsing. Occasionally I may
slip and refer to a *phrase* as a *term* but the reader should consider
either word to be equivalent and to represent a single unit on the
right-hand side of a grammar rule.) All rules must be terminated by a
semi-colon (';'). Names in this system are case sensitive. Both upper
and lower case are allowed in phrase names, and are considered
different. The '-' character is allowed within a phrase name, and is
converted to '\_' internally.

I'll illustrate the different kinds of grammar rule by example:  

            P<EXACT-MATCH> = "string";

This rule, used for literal text and keywords for example, has to match
the text in the source file exactly. (There's more that needs to be said
in the context of keywords for stropped languages, but that will be
added to a later revision of this document. For now we'll handle
stropped languages such as ALGOL 60 by insisting that the keywords are
actually underlined using Unicode characters and that they can be parsed
like ordinary text.)

            P<BOTH> = <TERM> <ANOTHER-TERM>;

For this rule to match text, the source file must contain a `TERM`
followed by an `ANOTHER-TERM`.

            P<EITHER> = <SOME-TERM>, <ALTERNATIVE-TERM>;

The comma between these rules means that the either `SOME-TERM` has to
be present in the source text, or `ALTERNATIVE-TERM` has to be present.
If neither are present, the entire rule for `EITHER` fails.

The list of phrases between commas is referred to as an *Alternative* or
an *Alt* for short.

It is an option that the programmer must specify in their source code as
to whether white space is generally allowed before phrases or terminals.
(At some point this option will likely become something that can be
specified in the grammar file.) If white space is permitted, it is
included in the matched text that is returned to the programmer, though
it is very simple for the programmer to eliminate that white space from
the returned tokens – or canonicalise the text in some other way –
before using the text. Precise details will be added in a later revision
of this document.

Phrases within an alternative must *all* match for the alternative to
match; if one phrase fails (say the 3rd item in an alternative that
consists of 10 phrases or terminals), then that whole alternative fails
and the next alternative is examined instead. If all alternatives fail,
the entire rule fails. Note that this parses a language in a *slightly*
different way from a full backtracking parser in the details of where
the backtracking resumes from. This parsing algorithm is essentially the
same as that used by PEG parsers (PEG = Parsing Expression Grammar)
although it predates it by 45 years. Unlike packrat PEG parsers we don't
memoize the parsing function (although that could trivially be added,
and indeed was done in some experimental parsers in the 90's) because
the programmer normally crafts the grammar so that significant
backtracking is not needed.

            P<REGULAR-EXPRESSION> = «[A-Za-z][A-Za-z0-9]*»;

The text in the source file must match the regular expression contained
between the guillemets. Terminal matching with regular expressions is a
relatively recent addition to Edinburgh-style parsers: historically, the
compiler writers would either construct an equivalent recogniser using
grammar rules, or – more likely – would implement an *ad-hoc* recogniser
using a *built-in phrase*. (The regular expression facility was first
added in my TACC parser in the late 80's while I was working at Acorn.)

            P<EITHER_or_nothing> = <SOME-TERM>,  <ALTERNATIVE-TERM>, ;

Note the ',' just before the ';' at the end of the rule. This denotes a
null rule. (You could specify this as `""` or several other forms of
empty string, but simply leaving a blank alternative is the conventional
way to add a null option.) A null option always parses successfully. It
is helpful but not required to name rules that terminate in a null
option with a consistent suffix, for example `_opt`:

            P<EITHER_opt> = <SOME-TERM>,  <ALTERNATIVE-TERM>, ;

(There are other terminal constructs available such as `'x'` for a
single 8-bit ASCII character, but these are not really necessary and
will likely be removed. It was once believed they were necessary for
performance but that turned out not to be the case.)

Note that due to the combination of rules being tested in order, and
entire alternatives failing if one component of an alternative fails, it
is important to order any rules where one rule may match the prefix of
another rule - the longer rule must be given first, for example, the
following would not work as you might expect:  

            P<BOOL> = <NAME> <COMPARE> <NAME>;
            P<COMPARE> = "==", "!=", "<", ">", "<=", ">=";
          

In this rule, the `<` is tested first, and if the *parent* rule fails
because the `<` was not followed by a variable, then the `<=` terminal
will never be tested. This rule can be made to work by re-writing as
follows:

            P<BOOL> = <NAME> <COMPARE> <NAME>;
            P<COMPARE> = "==", "!=", "<=", ">=", "<", ">";
          

In some circumstances, the problematic matching prefix occurs several
levels distant from the failing grammar rule and knowing where to
correct the problem by reordering rules may prove difficult. In such an
instance we have an alternative fix: we call for a guard.

#### Guards, guards!

There are two modifiers that can be applied to any `<PHRASE>` to modify
the parsing rules. These modifiers are called ‘guards’ because they
guard a rule from being executed if some condition is not met:  

            P<BOTH> = <?GUARD-TERM> <ACTUAL-TERM>;

In this case, the term which will be matched, and cause the text to be
accepted by the parser, is in fact `ACTUAL-TERM`, but before
`ACTUAL-TERM` can be accepted, a test is made for `GUARD-TERM`.
`GUARD-TERM` must match the following input (which may match only the
first few characters of `ACTUAL-TERM` – or it may include `ACTUAL-TERM`
and many characters beyond it) but anything which matches `GUARD-TERM`
is *not* removed from the input.  

            P<BOTH> = <!GUARD-TERM> <ACTUAL-TERM>;

This form of a phrase implements the same concept of a guarding test,
but in this case the parse of `GUARD-TERM` must *fail* for the guard to
allow parsing of this rule to continue. (The '!' symbol should be read
as 'not')  
  
(I added guards to an early parser of mine when I was a student around
1980, after a theory lecture (I can't remember if it was by Les Valiant
or Rod Burstall) explaining P. J. Landin's work on guards in the context
of lambda calculus. All of which I've forgotten but the idea of using
them in a parser managed to stick. Also the concept of negative guards
did come indirectly from Les Valiant who published an article along the
lines of "[Negation can be exponentially
powerful](https://core.ac.uk/download/pdf/82226226.pdf)"… my take-away
from his article – which I am 100% sure was not the point he was making!
– was that if you have a huge list of N options, rather than test for
N-1 of them which you want to match, you just test for the one that you
don't want to match and negate the result of that test. Yes, that's a
*Blinding Flash Of The Obvious* to some extent, but as a general
programming pattern which is often overlooked, that one stuck with me
too!)

#### Built-in phrases

In the old days, simply parsing the `NAME`s or numeric constants in a
language might have taken 25% of all the parsing time (which could be
minutes - who all remembers the routine correlation between kicking off
a build and going to make tea or coffee?!), so a mechanism was added to
allow some rules to be implemented with built-in code rather than
general phrase rules which included a long list of terminals containing
all the letters of the alphabet. (This was before the addition of
regular expression matching, which along with the use of pre-compiled
regular expressions, speeded up the parsing of certain forms of terminal
considerably). In this parser, we do have the *built-in-phrase* (aka
*BIP*) mechanism, but it is not needed nearly as often as was the case
for 1970's compilers. There are a small number of BIPs built-in to the
parser, each one being assigned a fixed ID number. When the programmer
wants to use one of these BIPs he should consult the source code and
determine the appropriate number to use for the specific function, for
example:

            B<nl> = 2;

which is implemented by this code to be found deep in the bowels of the
main parser code:

            case 2: { // nl
              if (source(*TP) == '\n') {
                if (debug_parser) fprintf(stderr, "BIP: nl (Matched)\n");
                (*TP)++;
                return literal_descriptor(InitialTP, *TP);
              } else {
                if (debug_parser) fprintf(stderr, "BIP: nl (No match)\n");
                return 0;
              }
            }
          

The `<nl>` would match against the end of lines in the source file. The
most useful BIP that cannot be implemented more simply using a terminal
is EOF which checks for the end of the source file and fails if there is
more input present – although having just said that, it occurs to me
just now that (as long as I have implemented the regular expression code
correctly!) EOF could be defined by:  

            P<any> = «.»;
            P<EOF> = <!any>;
          

You should consider using either regular expressions, or parse-time code
as described below, as a substitute for BIPs in new code. Any new BIPs
you do create should be added to the base code of the parser to be made
available to other grammars.

#### Parse-time actions

You might think the guard phrases above would allow you to modify the
parse as it happens, for instance by testing whether a variable whose
name had just been parsed was a <u>Boolean</u> or an <u>integer</u>
variable, so that the parser would allow a different set of operators
(e.g. AND and OR) to be used on operations between Booleans as opposed
to arithmetic operations (PLUS, MINUS) on integers. Unfortunately, this
is not the case. Because the entire source is parsed and built into a
tree before the users code ever sees the output from the parser, it is
too late to make parsing decisions based on the results of earlier
syntax recognition in this way. However there *is* a mechanism which
does exactly what you want in these circumstances … but it has to be
used carefully:

Parse-time rules (or phrases) are sometimes called *semantic* rules (or
phrases) because normal rules just check the *syntax* of your text, but
these phrases which execute code as your source is being parsed check
the *semantics* of your text.

Parse-time rules have to be implemented with C code that is embedded
within the grammar file. Here is a very small example which sets a
run-time flag in one part of the parse and tests it in another. Pay
especial attention to the extra rule added to the *following*
alternative which undoes the run-time action in the event of a failed
alternative.  
In this trivial example, we will access a \<NAME\> but set a flag
according to whether the NAME was capitalised or not, then when we use
that name, we'll behave differently depending on whether it was
capitalised or not: we will not allow subtraction in expressions if the
immediately-preceding \<NAME\> was capitalised!

            C<set-flag> = {
              flag = TRUE;
              return TRUE;
            };
            C<clear-flag> = {
              flag = FALSE;
              return TRUE;
            };
            C<flag> = {
              if (flag) return TRUE; else return FALSE;
            }
            P<EXPR> = <NAME> <OP> <NAME>;
            P<OP> = "*", "/", <!flag> "-", "+";
            P<NAME> = <set-flag>«[A-Z][A-Za-z0-9]*», <clear-flag>«[A-Za-z][A-Za-z0-9]*»

Note that it is a current but temporary restriction that `C<…>` phrases
must be defined in the grammar file before they are used.  
I will say this once more just in case your eyes have glazed over
already - the code in parse-time phrases is executed *as the text is
parsed* and if present in a rule will have executed at that time *even
if that rule subsequently fails* due to the following terms in the
alternative. Parse-time code is **not** the same as the code in your
main `.c` file which is executed only after a successful parse of the
entire input. This is a critical distinction that you must appreciate
before writing any semantic phrases using the `C<…>` construct. In fact
it's a construct that should only be used by advanced experts in
parsing, as a mistake in the use of that code will cause extremely
confusing consequences. You have been warned!  
  
Your semantic-phrase code may require some new shared variables to be
created… or some helper procedures. These can be added by simply
including a block of C code in the grammar file, surrounded by {}
brackets. Note that the code will be inserted at the outer level, i.e.
not within any procedure, so the block must consist only of data and
procedure declarations – i.e. no imperative code.

Finally, the grammar file is terminated with an 'E' command:  

            E

#### Embedded grammars

The quickest way to develop a new language using this parser is to
simply create a *`language`*`.g` file and build an executable using the
supplied Makefile. The executable acts as a syntax checker for the given
language. However to do more with the parser, i.e. compile a program in
some language or translate it to another language, you need to start
writing code to act on the Abstract Syntax Tree (AST) generated by the
parser. The easiest way to do this is to embed the grammar in the same
code as the compiler. We do this by marking grammar rules in the source
file with the comment delimiter `//\\`. For example, this code is from
the Imp to C translator:  

          case P_CONST_EXPR: //\\ P<CONST-EXPR> = <const-guard> <EXPR> <cancel-const-guard> ;
          {
            int expr = compile_expression(child(P,2), -1, VALUE_WANTED);
            constval = IntConstant_c(expr);
            if (constval == -1) {
              if (AstOP(expr) != C_CONST_STRING) {
                warn("%s is not an integer constant", SOURCE(P,2));
              }
              return expr;
            }
            return constval;
          }        
        

The entire grammar must be present in the source file, commented in this
fashion. The grammar file can be extracted from these embedded comments
using any convenient utility on the host system such such as:  

          sed -ne 's|\(.*\)//\\\\ \(.*\)|\2|gp' language.g

The precise details of how the programmer's C code accesses the parse
tree and the parsed text attached to that tree will be given in a later
revision of this document. For now I will just mention that the matched
text is returned as a pair of pointers to the start and end of that text
within the source file, rather than as an explicit string. In this way,
two consecutive matches could be concatenated very simply by returning a
pair of start-pointer from the first match and end-pointer from the
second match. The use of a string descriptor like this also allows the
possibility of mapping the source file to a virtual memory address and
accessing the source directly, thus avoiding the need to read the source
and store it in an array. However intermediate storage may still be
required if the language is of the type where keywords are stropped: the
easiest way to support stropping is by having a 'line reconstruction'
phase where stropped text is converted to a different representation on
input. Line reconstruction can also be applied to languages such as C
which do not have stropped keywords (to canonicalise white space for
example, or remove `/* comments */` between tokens) but this is seldom
wanted, especially in source-to-source translators where all text is of
interest and should be preserved in the translated output.

A closely related issue concerning internal text representation is that
the parser stores all characters (or more precisely, Unicode code
points) in 32-bit wint_t variables. In other words, we convert UTF-8
text to UTF-32 format on input (and generate UTF-8 again on output).
This simplifies some of the internal code considerably – for example
matching a single character in a regular expression) but does
unfortunately force us to read the entire source file into an array of
32-bit integers rather than allowing the direct memory-mapped access as
suggested in the paragraph above. For this reason we have not yet
implemented memory-mapped source file access, and the string descriptors
passed around as the result of a successful parse therefore are indexes
into this source\[\] array rather than pointers to the actual characters
in the source file.

#### Efficiency of grammar rules

In the early days of parsers in this style, the parser generator itself
would look for common prefixes in alternatives and attempt to factor
them out at a character level so that the parser would never need to
backtrack unnecessarily. In terms a programmer would recognise, it
formed a trie from the terminals acceptable at any point in the grammar.
For instance if the grammar allowed either the word "<u>comment</u>" or
the word "<u>continue</u>" at some point, it would (invisibly to the
programmer) factor the choice out into "<u>co</u>" followed by a choice
between "<u>mment</u>" and "<u>ntinue</u>". We do not do this. The small
amount of backtracking that this saves is computationally irrelevant.
Similarly the advice used to be that the programmer should explicitly
factor higher level phrases within the grammar in a similar way to
achieve efficient parsing. Unless the backtracking is significant, we do
not recommend factoring out common terms if doing so makes the grammar
harder to understand.

#### EBNF? Nein Danke!

Some parsers support Extended BNF grammars which use syntactic sugar to
write more concise rules. We don't. The basic mechanisms described above
are sufficient to describe any construct we need, albeit slightly more
verbosely, and the syntax for referring to the matched text with one of
these extended rules is not obvious. Whereas with a simple sequential
list of phrases or terminals in an alternative, you can access the
parsed text from your program with simple calls such as Phrase(2) or
Terminal(3), where the number is simply the index of that term within
the sequence for that alternative.

To see how we would describe various grammar items using our simplified
syntax, let's look at an example where we would like to define a
parameter list as a comma-separated list of names.

Typical EBNF extensions could use syntax similar to any of these
examples:

-   `{ … }` for an optional item.  
-   `[ … ]` for an optional item.  
-   `( … )?` for an optional item.  
-   `?` for an optional item.  
-   `{ … }*` for 0 or more items.  
-   `[ … ]*` for 1 or more items.  
-   `( … )+` for 1 or more items.  
-   `*` for repeating the last item.  
-   `*` for repeating the entire preceding alt.  

(reminder: none of the above are supported in our grammars) Let's look
at an example using "( … )\*" to define 0 or more repeats:

           P<PARAM-LIST> = <NAME>  ("," <NAME> )* ;
        

In our grammars, you'll need to expand the rule as follows:

          P<PARAM-LIST> = <NAME> <REST-OF-PARAM-LIST>;
          P<REST-OF-PARAM-LIST> = "," <NAME> <REST-OF-PARAM-LIST>, ;
        

Note that the recursive call `REST-OF-PARAM-LIST` must follow other
non-null phrases otherwise there will be infinite recursion. This type
of grammar is called 'right recursive'. Many other parsers with which
you may be familiar rely on grammars which are written to be 'left
recursive'. Please bear this in mind when converting a grammar
description from some other system to work with this parser generator.
The classic problem you should look out for is something very roughly
along the lines of this left-recursive definition, which would cause an
infinite loop:

          P<EXPR> = <REST-OF-EXPR> <TERM>;
          P<REST-OF-EXPR> = <EXPR> <OP>, ;
        

as opposed to the right-recursive version, which should work:

          P<EXPR> = <TERM> <REST-OF-EXPR>;
          P<REST-OF-EXPR> = <OP> <EXPR>, ;
        

The parser generator actually detects such loops and considers them to
be errors, as well as warning the user about phrases which are never
invoked if starting from P\<SS\>.

There are a small subset of runaway recursions caused by grammar loops
which are not currently detected - those are ones where there is a
terminal in the path of the loop. The code here assumes all terminals
will match some text, but it \*is\* possible (deliberately or in error)
for a terminal to succeed without matching any text. However these
errors will still be detected - only they are detected at runtime, not
while building the tables. It is possible that in the future such hidden
loops can also be warned about by takeon, if takeon compiles the regular
expressions and tries to match them against an empty string. This has
not yet been implemented.

Another common extension is an optional item, e.g.

          P<TERM> = <NAME> "++"?;
        

or sometimes

          P<TERM> = <NAME> {"++"};
        

In our grammars, the optional term should be created as a rule with a
null alternative, i.e.:

          P<TERM> = <NAME> <plusplus_opt>;
          P<plusplus_opt> = "++", ;
        

or if you prefer, a slightly more verbose version to be used if you also
need to use the non-optional version somewhere in your grammar as well:

          P<TERM> = <NAME> <plusplus_opt>;
          P<plusplus> = "++";
          P<plusplus_opt> = <plusplus>, ;
        

People familiar with systems where a '?' suffix denotes an optional item
should take a minute to appreciate the difference between a hypothetical
`<TERM?>` and our `<?TERM>`. The former is an optional item which may
match the given `TERM` phrase or may match an empty string, and the
latter is a guard which must be matched, but which does not advance the
text pointer.

A BNF extension to support 1 or more repeats (as opposed to the example
above of 0 or more repeats) is constructed in a similar fashion. I'll
leave this one as the traditional *exercise for the reader* to give you
a chance to put what you've read into practice. If you can't work out
the equivalent of this construct using basic BNF then you're probably
not ready yet to start writing your own grammars:

          P<TWO-PARAM-LIST> = <NAME>  ["," <NAME> ]* ;
        

or maybe you might be more familiar with syntax like this, with the same
meaning:

          P<TWO-PARAM-LIST> = <NAME>  ("," <NAME> )+ ;
        

If you are having difficulty debugging a new rule set, try running the
generated program with either of these options:  
  
`      -dp`: debug the parse  
`      -dc`: debug the completion stage, i.e. see how far the parse
got.  
  
The `-dc` option simply outputs the source text as it is parsed, to the
diagnostic stream, so that you can see where the parse might be failing.
This is also useful with a working compiler to determine what it is in
your input file is not being accepted. Note that the normal output from
an error while parsing is a line number and column in a format that is
compatible with 'compile mode' in Emacs, so you can use Emacs' "M-x
compile" command to invoke your parser and step to the next error. (We
recommend setting:
`(setq-default compilation-auto-jump-to-first-error 1)` in your ~/.emacs
file)  
The `-dp` option documents in full the attempt to parse, including blind
alleys that were tried and failed. The tracing information can be
somewhat voluminous and we recommend outputting the trace to a file for
easier comprehension, e.g. by `./algol60 badprog.a60 2> badprog.log`

#### Grammar loops and other errors

The table-builder, `takeon`, includes several internal consistency
checks of your grammar. These checks will detect phrase definitions
which would otherwise lead to infinite loops when parsing. Detecting
these is more complex than you might guess, and relies on performing a
transitive closure of the phrases referenced by other phrases and an
understanding by the grammar converter of nullable phrases, i.e. phrases
which can return success without matching any text in the user's input.
Previous parsers in this style from Edinburgh did not include these
checks - the grammar authors were presumed to be smart enough that they
never made that kind of mistake :-) However given that users of this
package may come from prior experience with left-recursive grammars
(usually because their parsers work bottom-up) I thought it wise to
offer these safety features, especially as people frequently start from
someone else's grammar file and if they have to convert a left-recursive
grammar into the right-recursive style that this parser requires, the
chances of a loop happening by accident while developing the grammar are
quite high! It's a lot nicer for the developer to be told of a grammar
loop while working on the grammar than to wait until the product is in
the hands of the users and the loop is only detected at runtime and only
for some specific and obscure input that only one user ever creates!

Here are a sample of the error messages output by `takeon`. I do intend
to report the line number where the error is detected, but that will not
be for a day or two. The error format should be compatible with
*`compile mode`* in Emacs.

    gtoal@linux:~/src/unicode$ ./takeon grammar-tests/unused.g > /dev/null
    ? Warning: P<BBB> UNUSED

    gtoal@linux:~/src/unicode$ ./takeon grammar-tests/undefined.g > /dev/null
    * Error: P<BBB> not defined.

    gtoal@linux:~/src/unicode$ ./takeon grammar-tests/selfloop.g > /dev/null
    * Error: P<Confusing> can fail due to direct left recursion.

    gtoal@linux:~/src/unicode$ ./takeon grammar-tests/broken-loops.g > /dev/null
    * Error: P<AAA> can left-recurse indirectly through <BBB>

    gtoal@linux:~/src/unicode$ ./takeon grammar-tests/chain.g > /dev/null
    * Error: P<nullable7> can left-recurse indirectly through <nullable6>

    gtoal@linux:~/src/unicode$ ./takeon grammar-tests/no-ss.g > /dev/null
    ? Warning: P<SS> is required, as the root of the grammar to be parsed.
               I'll use P<statement> as the root instead.

Here's a real-life example that was found in my grammar for Atlas
Autocode:

    P<plus-opt> =
        '+','-',
        ;

    P<exprn>=
        <operand><rest_of_exprn>;

    P<rest_of_exprn> =
        <operator><operand><rest_of_exprn>,
        ;

    P<operand> =
        <name><actual_parameters>,
        <const>,
        '('<plus-opt><exprn>')',
        <plus-opt><exprn>,
        ;

which was reported as:  

    * Error: P<operand> can left-recurse indirectly through <rest_of_exprn>

… Parsing an \<operand\> resolved into parsing a \<plus-opt\> followed
by an \<exprn\>. The \<plus-opt\> could be null, and the \<exprn\> in
turned called \<operand\> and thus would loop indefinitely without
consuming any characters. The fact that \<operand\> also had an unwanted
null option was just the cherry on the cake :-(

*To be continued…*

------------------------------------------------------------------------

Although this page is here to talk about the general purpose parser I
wrote, I suspect a few people may end up here more for the Algol 60
content. So for you, here are a couple of things that may be of
interest…  
  
I use an old-school command-line editor for any editing that isn't
trivial - it's called Ecce and came from Edinburgh in the 60's - indeed
the same era as Algol 60. However it's now past 2020, and we use screen
editors most of the time. So … I came up with a way to embed the Ecce
command line within Emacs, so that trivial editing is done on-screen but
complex work can be done with an Ecce command line simply by typing
Control-E to invoke it. Also, Emacs allows user-written syntax
highlighting as well as keyboard shortcuts for symbols used in Algol 60
such as '≤', not to mention <u>underlined</u> keywords, so I've written
some e-Lisp to perform syntax highlighting and to assist in keyboarding
characters that would otherwise not be available. You can see some of
this in action at <https://gtoal.com/recordings/algol-editing.html>
(although you may need to shrink the page or just scroll down so that
you can see the Ecce commands being entered at the bottom of the
screen). My ".emacs" file is online here at
<http:/www.gtoal.com/src/DOTemacs.txt>. You may also want Ecce which you
can download at <https://ecce.sourceforge.net/ecce.c> although as of
today (27th Jul 2023) I haven't updated that source with the new 'z'
command (that adds Unicode underlining to letters) which is under
development. I'll do so after the new feature has been extensively
tested - the Ecce release is very stable and I don't want to risk
breaking it. Ecce documentation is at
<https://ecce.sourceforge.net/manual.html> with an online demo and a
very brief introduction at <https://ecce.sourceforge.net/tutorial.html>

I have other Algol 60 related web pages:

-   <https://gtoal.com/languages/algol60/KDF9/>
-   <https://gtoal.com/languages/algol60/x1algol/>
-   <https://gtoal.com/history.dcs.ed.ac.uk/archive/languages/algol60/Edinburgh_ALGOL_Language_Manual.html>
-   <https://gtoal.com/languages/algol60/TESTS/NUMAL/StatalI.a60.html>
-   <https://gtoal.com/languages/algol60/TESTS/NUMAL/NUMAL.a60.html>

------------------------------------------------------------------------

gtoal@gtoal.com
