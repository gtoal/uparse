// TAKEON: Version 2.  This is a rewrite of the original takeon.

// If B<name> clashes with P<name> no warning is given other than <name> Unused.

// Convert a grammar into tables.

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <ctype.h>
#include <assert.h>

#include <wchar.h>
#include <locale.h>

#ifndef FALSE
#define FALSE (0!=0)
#endif
#ifndef TRUE
#define TRUE (0==0)
#endif

#define CHECK_FOR_LOOPS

static char *grammarfn = NULL;
// Also source_line, source_column

#include "takeon-output.c"

static void takeon(FILE *f) {

  // State variables:
  static int def_phrase = FALSE;    // Are we defining a P<...> phrase at the moment?
                                    // I.e. have we already seen the 'P' part of
                                    // "P<...> = " but not the '='?
  static int def_alts = FALSE;      // Are we defining a alt at the moment?
                                    // I.e. have we already seen the '=' part of
                                    // "P<...> = "?
  static int def_type = 0;          // The type of the current phrase definition,
                                    // i.e. P<>, C<>, O<>, or B<>.
  
  static int sym = unassigned;

  // Describing the structure of a phrase:
  static int specialbit = 0; // '?' or '!' in a term, eg <?guard> or <!guard>.
                             // Only allowed in phrase names, not literals.

  static int alt_count = 1;
  static int alt_count_index = 0;

  static int phrase_count = 0;
  static int phrase_count_index = 0;

  _initcode(initcode_nextfree = 0) = '\0';
  
  for (;;) {
    sym = nonspace();

    switch (sym) {  // almost all reads are done here (excepting calls to 'upto')
                    // The structure of this code approximates a state machine.

    case '{': // Global Declarations, copied over to the .h file.
      { // There is only one anonymous initcode block.  Multiple {} sections are
        // simply appended to it.
        int level = 0;
        for (;;) {
          sym = next_wide_char();
          if (sym == '{') level += 1;
          if ((sym == '}') && (level == 0)) break;
          if (sym == '}') level -= 1;
          _initcode(initcode_nextfree++) = sym;
        }
        _initcode(initcode_nextfree) = '\0';
      }
      break;
      
    case 'O': // OPTION DEFINITION (output on the fly, no need to store in a data structure)
    case 'B': // BIP DEFINITION    (requires matching code manually added to the parser)
    case 'P': // PHRASE DEFINITION (regular phrase consisting of terms and recursive phrase calls)
    case 'C': // CODE DEFINITION   (in-line code for parse-time actions. Use very carefully)

      if (def_alts || def_phrase) {
        fprintf(stderr,
                "ERROR: Phrase <%ls> was not finalised before starting a new one."
                "  Missing semi-colon!\n", String(current_def_phrasename));
        exit(EXIT_FAILURE);
      }
      
      def_phrase = TRUE; def_alts = FALSE; def_type = sym;

      // We'll wait until we get the name before we do anything else. ('<' is next)

      break;

      
    case '<': // This occurs either at the point of a phrase definition
              // (P<...> =) *or* as a term within an alt (= <term1> <term2>;).
      if (def_phrase) {
        // We're looking at the definition of a phrase:
        phrase_count = 0;
        current_def_phrasename = upto(L'>');
        switch (def_type) {
        case 'O': // 'O<>' will be added later.
                  break;
        case 'B': _bip_phrasename(current_def_bipno = NEXT_FREE_BIPNO++) = current_def_phrasename;
                  if (NEXT_FREE_BIPNO >= NUM_BIPS) NUM_BIPS = NEXT_FREE_BIPNO;
                  break;
        case 'P': _phrasename(current_def_simple_phraseno = NEXT_FREE_SIMPLE_PHRASENO++) = current_def_phrasename;
                  if (NEXT_FREE_SIMPLE_PHRASENO >= NUM_SIMPLE_PHRASES) NUM_SIMPLE_PHRASES = NEXT_FREE_SIMPLE_PHRASENO;
                  break;
        case 'C': _semantic_phrasename(current_def_semantic_phraseno = NEXT_FREE_SEMANTIC_PHRASENO++) = current_def_phrasename;
                  if (NEXT_FREE_SEMANTIC_PHRASENO >= NUM_SEMANTIC_PHRASES) NUM_SEMANTIC_PHRASES = NEXT_FREE_SEMANTIC_PHRASENO;
                  break;
        }
        break;
        // Next state is '='
      } else {
        // We're looking at an instance of a phrase within an alt:
        int i;
        
        phrase_count += 1; // number of phrases seen in this alt.
        _gram(phrase_count_index) = phrase_count | COUNT_OF_PHRASES;
        if (phrase_count > LARGEST_ALT) LARGEST_ALT = phrase_count;

        sym = next_wide_char();  // <?...> or <!...> or just <...> ?
        if (sym == '?') {
          specialbit = GUARD_PHRASE;
          // parse and assign but do not step the pointer past this location (NOTE/POP-POINTER)
	} else if (sym == '!') { // or use '~' or '\' ???
          // parse & invert.  return NULL on a failed parse, don't step
          // the pointer, and continue parsing this alt.
          specialbit = NEGATED_PHRASE;
	} else {
	  unget_wide_char(sym, grammar);
          specialbit = 0;
	}

        current_use_phrasename = upto(L'>'); //fprintf(stderr, "{name=%ls}\n",name);
        // The phrase name may be a forward reference, at least during the first pass...
        if (pass == 0) {
          _gram(NEXT_FREE_GRAMMAR_SLOTNO++) = 0; // This hole will be filled in on the next pass.
          break;
        }

        // Now on a pass where tables are complete...
        for (i = 0; i < NUM_BIPS; i++) {
          if (wcscmp(String(bip_phrasename(i)), String(current_use_phrasename)) == 0) {
            _gram(NEXT_FREE_GRAMMAR_SLOTNO++) = i
                                              | specialbit /*GUARD_PHRASE or NEGATED_PHRASE*/
                                              | BIP_TYPE;
            break;
          }
        }
        if (i < NUM_BIPS) break;
        
        for (i = 0; i < NUM_SIMPLE_PHRASES; i++) {
          if (wcscmp(String(phrasename(i)), String(current_use_phrasename)) == 0) {
            _gram(NEXT_FREE_GRAMMAR_SLOTNO++) = i
                                              | specialbit /*GUARD_PHRASE or NEGATED_PHRASE*/
                                              | PHRASE_TYPE;
            break;
          }
        }
        if (i < NUM_SIMPLE_PHRASES) break;
        
        for (i = 0; i < NUM_SEMANTIC_PHRASES; i++) {
          if (wcscmp(String(semantic_phrasename(i)), String(current_use_phrasename)) == 0) {
            _gram(NEXT_FREE_GRAMMAR_SLOTNO++) = i
                                              | specialbit /*GUARD_PHRASE or NEGATED_PHRASE*/
                                              | SEMANTIC_TYPE;
            break;
          }
        }
        if (i < NUM_SEMANTIC_PHRASES) break;

        fprintf(stderr, "* Error: P<%ls> not defined.\n", String(current_use_phrasename));
        exit(EXIT_FAILURE);
        
      }
      // Next state is '='
      break;

    case '=': // start of a phrase alternative or a BIP defn
      // current_def_phrasename should be valid at this point
      // 'B' and 'P' phrases get added to table.
      // 'C' and 'O' phrases go in their own arrays.
      
      // TO DO: check for duplicate name definition!  (regardless of type,
      // i.e. P<fred> must clash with C<fred> etc))
      // At the moment, a duplicated name is only caught when trying to compile
      // any C file which includes the .h file.

      if (!def_phrase) {
        fatal(0); // We have an '=' that doesn't follow any sort of phrase definition start.
      }
      switch (def_type) {

      case 'O': // OPTION DEFINITION (output on the fly, no need to store in a data structure)
        {
          int number;
          sym = nonspace();
          if (!isdigit(sym)) fatal('0');
          number = sym-'0';
          sym = get_wide_char(grammar);
          if (isdigit(sym)) {
            number = number*10 + (sym-'0');
          } else {
            unget_wide_char(sym, grammar);
          }
          if (pass == 1) {
            // This needs to migrate to an internal array.
            fprintf(stderr, "#define OPTION_%ls %d\n",
                             CString(current_def_phrasename),
                             number); // check that - -> _ conversion has been done
          }
          break;
        }
        
      case 'B': // BIP DEFINITION    (requires matching code manually added to the parser)
        {
          // The entire O<> or B<> definition is handled here immediately.

          // expect a number and a ';'.
          // PLANNED UPGRADE: don't allow '0' as an explicit number,
          // and always preload B<WEOF>=0; because *all* parsers require a B_WEOF BIP.
          // Ditto for B_char, however NL and various strings etc are entirely optional
          // and could be built with P<> rules rather than BIPs.
          int c, number = nonspace();
          if (!isdigit(number)) fatal('0');
          number -= '0';
          c = get_wide_char(grammar);
          if (isdigit(c)) {
            number = number*10 + (c-'0');
          } else {
            unget_wide_char(c, grammar);
          }
  
          _bip_phrasename(current_def_bipno) = current_def_phrasename;
          _bip_map(current_def_bipno) = number;
          if (nonspace() != ';') fatal(';'); //
          def_phrase = FALSE;
  
          // Current comment is saved here for BIPS and Options.
          //_xcomment(this_phrase) = current_comment;
          //fprintf(stderr, "A: Setting xcomment(%d) = \"%ls\"\n", this_phrase, String(current_comment));
          //current_comment = Str_nextfree++; _StringPool(current_comment) = '\0';
          break;    
        }

      case 'C': // CODE DEFINITION   (in-line code for parse-time actions. Use very carefully)
        {

          // The entire C<> definition is handled here immediately.
          if (nonspace() != '{') {
            fatal('{'); // bracketed C code missing.
          }

          // _semantic_phrasename(current_def_semantic_phraseno) already filled in
          _semantic_code(current_def_semantic_phraseno) = c_code_block();

          if (nonspace() != ';') fatal(';'); //
          def_phrase = FALSE;

          // No comments saved for C<> definition blocks.
          //current_comment = Str_nextfree++; _StringPool(current_comment) = '\0';
          break;  
        }

      case 'P': // PHRASE DEFINITION (regular phrase consisting of terms and recursive phrase calls)
        { //  P<...> = ... ;

          _sequential_phrase_no_to_grammar_index(current_def_simple_phraseno) = NEXT_FREE_GRAMMAR_SLOTNO;  
          // _phrasename(current_def_simple_phraseno) = current_def_phrasename; already assigned
          _grammar_index_to_sequential_phrase_number(NEXT_FREE_GRAMMAR_SLOTNO) = current_def_simple_phraseno;

          def_phrase = FALSE; def_alts = TRUE;

          alt_count = 1;
          alt_count_index = NEXT_FREE_GRAMMAR_SLOTNO++;    // Hole for number of alternatives
          _gram(alt_count_index) = alt_count | COUNT_OF_ALTS;

          //phrase_count = 0;
          phrase_count_index = NEXT_FREE_GRAMMAR_SLOTNO++; // hole for number of items in first alt.
          _gram(phrase_count_index) = phrase_count | COUNT_OF_PHRASES;          
          //if (phrase_count > LARGEST_ALT) LARGEST_ALT = phrase_count;
          
          // Next state is a term of some description.
          break;  
        }
        
      } // end of the inner switch
      break; // from the outer switch, back to the main loop.

    case '\'': // string literal currently implemented as a sequence of single chars
      if (def_phrase) {
        fprintf(stderr, "Line %d: P'...' is not allowed.  'Literals' are"
                " only allowed on the RHS of the '='.\n", source_line);
        exit(EXIT_FAILURE);
      } else {
        STRINGINDEX string = upto(L'\'');
      
        // TO DO: a string literal or a keyword literal can contain
        // C-style '\' escapes such as \n or \u2345

        // Should we allow whitespace only before the string or also between each character?
        // - depends on whether it is a keyword and what kind of stropping.
      
        {
          wchar_t *s = String(string);
          while (*s != '\0') {
            if ((((*s)&~255) != 0) && (((*s)&~255) != 0xFFFFFF00)) {
              // TO DO: UPGRADE THIS CONSTRUCT TO USE STRING_TYPE RATHER THAN CHAR_TYPE.  THEN DELETE CHAR_TYPE.
              // phrase_count += wcslen(String(string)); // Each char counts as a phrase, albeit a short one... Moved to loop.
              fprintf(stderr, "Warning: Unicode char constant truncated: %lc\n", (wint_t)(*s));
            }
            _gram(NEXT_FREE_GRAMMAR_SLOTNO++) = CHAR_TYPE | WHITESPACE_ALLOWED | ((*s++)&255); // 8-bit only - hence why deprecating
            phrase_count += 1;
          }
        }
        _gram(phrase_count_index) = phrase_count | COUNT_OF_PHRASES;
        if (phrase_count > LARGEST_ALT) LARGEST_ALT = phrase_count;
        break;
      }
      
    case '"': // keyword literal
      if (def_phrase) {
        fprintf(stderr, "Line %d: P\"...\" is not allowed.  \"Keywords\" are only allowed on the RHS of the '='.\n", source_line);
        exit(EXIT_FAILURE);
      } else {
        STRINGINDEX keyword = upto(L'"');

        phrase_count += 1;
        _gram(phrase_count_index) = phrase_count;
        if (phrase_count > LARGEST_ALT) LARGEST_ALT = phrase_count;
        
        // TO DO: a string literal or a keyword literal can contain C-style '\' escapes such as \n or \u2345
        _gram(NEXT_FREE_GRAMMAR_SLOTNO++) = WHITESPACE_ALLOWED | keyword_code(keyword) /* TYPE already inserted by *_code() */;

        break;
      }
      
    case L'«': // regexp literal
      if (def_phrase) {
        fprintf(stderr, "Line %d: P«...» is not allowed.  Regular «expressions» are"
                        " only allowed on the RHS of the '='\n", source_line);
        exit(EXIT_FAILURE);
      } else {
        // regexp literal
        STRINGINDEX regex, anchored_regexp = Str_nextfree++;
        _StringPool(anchored_regexp) = '^';
        regex = upto(L'»'); // a little hacky. Relies on storing at Str_nextfree.
        assert(regex == anchored_regexp+1);
        
        phrase_count += 1;
        _gram(phrase_count_index) = phrase_count | COUNT_OF_PHRASES;
        if (phrase_count > LARGEST_ALT) LARGEST_ALT = phrase_count;
        
        _gram(NEXT_FREE_GRAMMAR_SLOTNO++) = regexp_code(anchored_regexp) | WHITESPACE_ALLOWED;
      }
      break;
      
    case '|': // next alternative
    case ',': // next alternative
      // previous phrase:
      _gram(phrase_count_index) = phrase_count | COUNT_OF_PHRASES; // should have already been done
      if (phrase_count > LARGEST_ALT) LARGEST_ALT = phrase_count;

      // Next alt:
      alt_count += 1;
      _gram(alt_count_index) = alt_count | COUNT_OF_ALTS;

      phrase_count = 0;
      phrase_count_index = NEXT_FREE_GRAMMAR_SLOTNO++;
      _gram(phrase_count_index) = phrase_count;

      break;

    case ';': // end of alternatives.   No warning for not being in a definition? (use def_alts ?)

      // def_type must be 'P'; 'C', 'O' and 'B' were handled earlier.
      
      //_xcomment(this_phrase) = current_comment;
      //fprintf(stderr, "B: Setting xcomment(%d) = \"%ls\"\n", this_phrase, String(current_comment));
      //current_comment = Str_nextfree++; _StringPool(current_comment) = '\0';

      // We could tell whether the last alt was null by
      // checking lastsym == ',', should we ever need to know

      // Don't need to assign the other ones on the fly as long as we assign here.
      _gram(alt_count_index)    = alt_count    | COUNT_OF_ALTS;
      _gram(phrase_count_index) = phrase_count | COUNT_OF_PHRASES;
      
      //if (phrase_count > LARGEST_ALT) LARGEST_ALT = phrase_count;
      alt_count = 0; phrase_count = 0;
      def_phrase = FALSE; def_alts = FALSE;
      current_def_phrasename = unassigned;

      if (NEXT_FREE_GRAMMAR_SLOTNO >= NUM_GRAMMAR) NUM_GRAMMAR = NEXT_FREE_GRAMMAR_SLOTNO;
        
      break;

    case 'E': // END OF GRAMMAR
      return;

    case '#': //  comment to end of line.  Do these only work between phrases? (No)
      {       //  We need to modify nonspace() to handle these too. Or instead.
        //current_comment = Str_nextfree;   // comment handling is currently disabled.
        for (;;) {
          sym = next_wide_char();
          _StringPool(Str_nextfree++) = sym;
          if (sym == '\n') break;
        }
        _StringPool(Str_nextfree++) = '\0';
      }
      break;

    default:
      fatal(0);
      
    } // end of the main switch in the for loop

  } // end of the for loop reading the grammar file


}

int main(int argc, char **argv) {
  /* char *locale = */ (void) setlocale(LC_ALL, "");
  FILE *sink = fopen("/dev/null", "w");

  flexdebug = 0;

  if ((sizeof(wchar_t) < 4) || (sizeof(wint_t) < 4)) {
    fprintf(stderr, "takeon: wchar_t or wint_t size is %d bytes "
                    "- please recompile with a real compiler.\n",
            MinINT(sizeof(wchar_t),sizeof(wint_t)));
    exit(EXIT_FAILURE);
  }
  
  if ((argc >= 2) && (strcmp(argv[1], "-v")==0)) {
    argc -= 1; argv += 1; verbose = TRUE;
  }

  if (argc != 2) {
    fprintf(stderr, "syntax: takeon [-v] compiler.g\n");
    exit(EXIT_FAILURE);
  }

  // Multi-pass in order to determine how many phrases occur
  // in each phrase definition. Should just be 2-pass, last
  // effort was 3.
  for (pass = 0; pass <= 1; pass++) {

    grammar = fopen(grammarfn=argv[1], "r");
    if (grammar == NULL) {
      int err = errno;
      fprintf(stderr, "takeon: %s - %s\n", strerror(err), argv[1]);
      exit(err); // caller may need to use WEXITSTATUS to get this value.
    }

    // We make critical operations idempotent so that
    // executing them twice won't have any ill effects,
    // but some variables do have to be reset for each pass.
    
    NEXT_FREE_BIPNO = 0;
    NEXT_FREE_SIMPLE_PHRASENO = 0;
    NEXT_FREE_SEMANTIC_PHRASENO = 0;

    NEXT_FREE_GRAMMAR_SLOTNO = 0;
    
    // We don't reset NUM_* - preserve completed tables between passes.
    
    LARGEST_ALT = 0;
    BIP_BASE = 0;
    PHRASE_BASE = 0;
    SEMANTIC_BASE = 0;
    AST_BASE = 0;
    
    takeon(stderr); // forward references only work on second pass.

    fclose(grammar); grammar = NULL; // easier to close and reopen than to rewind.
  }

  dump_tables(stdout/*sink*/); fflush(stdout);
   
#ifdef CHECK_FOR_LOOPS  // This code is entirely optional.  The converter will work without it.
  #include "takeon-checks.c"
    
  check_all_phrases();  // Report any detectable issues in the structure of the grammar.

#endif

  fclose(sink);
  exit(EXIT_SUCCESS); return(EXIT_FAILURE);
}

// Will add error checks later.
