// This is the last 'dirty' source file in the parser suite.  It took some
// effort to get it to work embedded within takeon.c rather than as a clean
// separate program working on the generated .h files.  I've only just now
// got it working after about 3 days of effort, and have not dared risk
// cleaning it up in case something breaks.  TO DO.

// NOTE: (5 Aug 2023) cleanup on hold for a week while I recover from
// an RSI injury.  Trying to avoid too much typing!




// This program takes the tables generated from a grammar (which is easier than
// taking the grammar itself) and checks the phrase definitions to see if there
// is any possibility of a parsing loop occurring.

// This will happen when "P<A> = <B>" expands to some other set of phrases where
// one of them in turn expands back to "= <A>"...

// It can also happen for "P<A> = <B> <C>" if there is a way of parsing B which
// matches a null phrase, and <C> eventually expands back to <A>.

// These checks must be made for every alternative to a phrase.

// We will construct a table which marks whether a phrase has a top-level null
// alternative; then we will perform a closure to expand that information to
// mark whether phrase A calls phrase B and phrase B or its descendants have
// a null match, and finally we will add (as in the example above) whether
// phrase C can loop back to phrase A, for all C's that follow preceding phrases
// which themselves allow a null match.

// The predicates we need in order to construct the graph and tables are:
//
// 1) Phrase A is nullable, i.e. it has an alternative which can match an empty string
// 2) Phrase A calls Phrase B first (no terminals before, no phrases before which force a terminal)
// 3) Phrase A calls Phrase C after a series of phrases which can all match an empty string
//     ( 2 & 3 can probably be implemented by the same code )

// With that information we check every phrase and determine whether there is a possibility
// that it can form an infinite loop back to itself.   We'll have to take some liberties
// with C<> and B<> phrases which can't be checked, and guards which will have to be ignored
// although sometimes a guard may be placed in front of a phrase specifically to block
// recursion, which may cause a false result.  But at least we can warn about it.  The
// sort of loop errors we're checking for are more likely to occur in the early development
// of a grammar before we get into adding the fancy stuff.  Most likely due to converting
// a left-recursive grammar to right-recursive form.  It won't be hard to find test examples!

// (An alternative to using graph algorithms to locate loops would be to walk the tree from
// each phrase, but the problem there is that you might check P<SS> but it is P<ELSE> that
// contains the loop.  You'd need an arbitrary depth recursion stopper - you can't just
// trigger on passing through a definition twice, because the same phrase may be used
// more that once in a definition, eg P<EXPR> = <TERM> <OP> <TERM> which is *not* infinite
// recursion.  A dynamic check like this would return on any non-empty terminal.)

// MAJOR GOTCHA!: A regexp that matches a null string such as «[A-Za-z]*» - which this
// code does not recognise as matching an empty string - can still cause infinite recursion,
// though it will still be caught at runtime.  (The expression above should have been
// «[A-Za-z][A-Za-z]*» by the way...)  I guess it could be possible to test for that
// by compiling the regexp and trying to match it against a null string...

#ifndef FALSE
#define FALSE (0!=0)
#endif
#ifndef TRUE
#define TRUE (0==0)
#endif

//-------------------------------------------------------------------------------------------------------------------------

// the code between the '---' lines is basically the same as that in callgraph.c, except with the garrulous comments
// removed and a few names changed to reflect the purpose for which the code is being used here.  And the output
// has been modified to print phrase names rather than the phrase numbers used internally.

#define MAX_UNIQUE_PHRASES 300
static int phraseno[MAX_UNIQUE_PHRASES]; // Maximum possible number of phrases
                                         // in the grammar (file).  We *could*
                                         // make this a re-sizable dynamic array off
                                         // the heap, but that's overkill for now.
                                         // Eventually I'll pick this up from the grammar.h file

int next_free_phraseno = 0;     // Number of vertices in the graph

unsigned char callgraph[MAX_UNIQUE_PHRASES][MAX_UNIQUE_PHRASES];
unsigned char null_option[MAX_UNIQUE_PHRASES];

// In the original version of this code I condensed the range of allowed
// parameters from a potentially sparse range to a contiguous range.  Now
// that the inputs are simple phrase numbers which are already contiguous,
// I could completely do away with this step and use NUM_SIMPLE_PHRASES
// instead of next_free_phraseno.

int map(int sparse) { // alternatively the user's object could be a 'void *' pointer rather than an unconstrained integer.
  int mapped;
  assert(next_free_phraseno+1 < MAX_UNIQUE_PHRASES);
  phraseno[next_free_phraseno] = sparse;
  for (mapped = 0; mapped <= next_free_phraseno; mapped++) {
    if (phraseno[mapped] == sparse) {
      if (mapped == next_free_phraseno) next_free_phraseno++;
      return mapped;
    }
  }
  exit(EXIT_FAILURE);
  return UNASSIGNED;
}

void call(int caller, int callee) {
  // Since we are mapping sparse numbers, it doesn't matter which number we use for a phrase - as long
  // as we're consistent everywhere they're passed to this code: i.e. 'call()' and 'has_null_options()'
  // So... we are going to use the 'simple' PHRASE_TYPE phrasename() option any time
  // we pass around a phrase number - it must be in the range 0:NUM_SIMPLE_PHRASES-1
  int mcr, mce;
  mcr = map(caller);
  mce = map(callee);
  assert(mce < MAX_UNIQUE_PHRASES);
  assert(mcr < MAX_UNIQUE_PHRASES);
  if (verbose) {
    fprintf(stderr, "call(\"%ls\"", String(phrasename(phraseno[mcr])));
    fprintf(stderr, ", \"%ls\")\n",String(phrasename(phraseno[mce]))/*,caller,callee*/);
  }
  callgraph[mce][mcr] = 1; // relationship is transitive
  callgraph[mcr][mcr] = 1; // all phrasess are considered to call themselves for the purposes of this algorithm.
  callgraph[mce][mce] = 1; // i.e. relationship is reflexive
  // to do: note reverse relationship unless anti-symmetric
  // (see https://medium.com/@WindUpDurb/on-partial-ordering-total-ordering-and-the-topological-sort-9f9c0d0d812f )
}

int nullable_inner(int phrase, int line) {
  int phrase_type  = phrase & (GRAMMAR_TYPE_MASK<<GRAMMAR_TYPE_SHIFT);
  int phrase_index = phrase & INDEX_MASK;

  if (phrase_type == PHRASE_TYPE) {
    if (phrase & NEGATED_PHRASE) return TRUE;
    int Result = (null_option[map(phrase_index)] == 1);
    if (verbose) fprintf(stderr, "Line %d: nullable(%d) looking at null_option[map(phrase_index=%d)=%d] -> %s\n",
            line, phrase_index, phrase_index, map(phrase_index),
            Result ? "TRUE" : "FALSE");
    return Result;
  } else {
    // for now we'll assume any terminal or semantic phrase is not nullable
    return FALSE;
  }
}
#define nullable(phrase) nullable_inner(phrase, __LINE__)

void has_null_options(int phrase) {
  int phrase_type  = phrase & (GRAMMAR_TYPE_MASK<<GRAMMAR_TYPE_SHIFT);
  if (phrase_type != 0) {
    if (verbose) fprintf(stderr, "has_null_options(%08x) - not a simple phrase no in the range 0..%d\n", phrase, NUM_SIMPLE_PHRASES-1);
    exit(EXIT_FAILURE);
  }
  phrase = phrase & INDEX_MASK;
  
  if (verbose) fprintf(stderr, "has_null_options(%d)\n",phrase);
  if (verbose) fprintf(stderr, "has_null_options(%ls)\n",
                       String(phrasename(phrase)));
  //                   phrase,
  //                   sequential_phrase_no_to_grammar_index(phrase),
  //                   map(sequential_phrase_no_to_grammar_index(phrase)));
  // null_option[map(sequential_phrase_no_to_grammar_index(phrase))] = 1;
  if (verbose) fprintf(stderr, "has_null_options(%d) setting null_option[map(phrase=%d)=%d] = 1\n",phrase, phrase, map(phrase));
  null_option[map(phrase)] = 1;
  if (!nullable(phrase|PHRASE_TYPE)) {
    fprintf(stderr, "has_null_options(%d) did not mean that nullable(%d) was true!\n",phrase,phrase);
    exit(EXIT_FAILURE);
  }
}

static int warned = 0;
int Toposort(void) {
  int stack[next_free_phraseno]; // stack is used to determine total ordering which is temporarily disabled.
  int used[next_free_phraseno];
  int x, next_free_stackp = 0;

  void dfs(int x) {
    int y;
    used[x] = 1;
    for (y = 0; y < next_free_phraseno; y++) {  // For each element y in S:
      if ((!used[y]) && /*x is less than or equal to y*/ (x!=y) && callgraph[x][y]) dfs(y);
    }
    stack[next_free_stackp++] = x; //       Add x to stack
  }

  //fprintf(stderr, "\n");
  {int i,j;

    for (i = 0; i < next_free_phraseno; i++)
      for (j = 0; j < next_free_phraseno; j++)
        if ((i < j) && ((callgraph[i][j] & callgraph[j][i]) != 0)) {
          fprintf(stderr, "* Error: P<%ls>",
                  String(phrasename(phraseno[i])));
          fprintf(stderr, " can left-recurse indirectly through <%ls>\n",
                  String(
                         phrasename(phraseno[j])));
          exit(EXIT_FAILURE); // warned++;
        }

    //if (warned) fprintf(stderr, "\n");
  }

  for (x = 0; x < next_free_phraseno; x++) used[x] = 0; // Init 'used[]'
  for (x = 0; x < next_free_phraseno; x++) { //   For each element x in S:
    if (!used[x]) dfs(x);
  }

  //#ifdef NOT_NOW
  if (!warned) {
    if (verbose) {
      fprintf(stderr, "One possible total ordering:\n");
      do {

        int p = stack[--next_free_stackp];
        /*fprintf(stderr, " %d", p);*/
        fprintf(stderr, " %d %ls",
                phraseno[p],  // phraseno[] reverses map[]
                String(phrasename(phraseno[p])));

        /*
One possible total ordering:
 232 1128 156 stropped-keywords
 231 1131 157 optional-stropping-conversion
 230 156
"loopcheck.c", Line 199: Reading from grammar_index_to_sequential_phrase_number[156] - Unassigned variable
         */
        
        fprintf(stderr, "\n");

      } while (next_free_stackp);
      fprintf(stderr, "\n");
    }
    //fprintf(stderr, "\nThere were no loops detected.\n");
  }
  //#endif
  
  // REMINDER: check what happens when there is a loop...
  return warned==0;
}

void Warshall(void) {
  int i, j, k;
  for (k = 0; k < next_free_phraseno; k++)
    for (i = 0; i < next_free_phraseno; i++)
      for (j = 0; j < next_free_phraseno; j++)
        callgraph[i][j] |= (callgraph[i][k] & callgraph[k][j]);
}
//-------------------------------------------------------------------------------------------------------------------------

// Although I could avoid the recursion check for phrases which are never used,
// I won't.  Let's check everything.

void find_null_alts(const wchar_t *Pname, int P) {
  int G = sequential_phrase_no_to_grammar_index(P);
  int InitP = P;
  int alts = gram(G) & INDEX_MASK;
  int alt;
  if (verbose) fprintf(stderr, "find_null_alts(\"%ls\", %d [->%d])\n", Pname, P, G);
  G++; // Skip COUNT_OF_ALTS
  for (alt = 0; alt < alts; alt++) {
    int phrases = gram(G) & INDEX_MASK;
    int phrase;
    G++; // skip COUNT_OF_PHRASES
    if (phrases == 0) {
      if (alt + 1 != alts) {
        fprintf(stderr, "* Error: Alt %d of %ls is NULL but it is *not* the final Alt of %d.\n", alt+1, Pname, alts);
        exit(EXIT_FAILURE);
      }
      has_null_options(InitP & INDEX_MASK);
      return;
    } else {
      int all_nullable = TRUE;
      for (phrase = 0; phrase < phrases; phrase++) {
        if ((all_nullable) && (!nullable(gram(G)))) {
          //fprintf(stderr, "*** %ls not nullable because phrase %d of alt %d was not nullable.\n", Pname, phrase, alt+1);
          all_nullable = FALSE;
        }
        G++;
      }
      if (all_nullable) {  // pretty sure gram() below is wring but checking anyway
        if (!nullable(InitP & INDEX_MASK)) {
          if (verbose) fprintf(stderr, "*** %ls must be nullable too because all phrases in alt %d were nullable.\n", Pname, alt+1);
          has_null_options(InitP & INDEX_MASK);
        }
      }
    }
  }
}

void handle_one_alt(const wchar_t *Pname, int P) {
  int G = sequential_phrase_no_to_grammar_index(P);
  int InitP = P;
  int alts = gram(G & INDEX_MASK) & INDEX_MASK;
  int alt;
  int Suppress_rest_of_this_Alt;

  if (verbose) fprintf(stderr, "handle_one_alt(L\"%ls\", P=%d -> %d);\n",Pname,P,G);
  
  G++; // skip count of alts


  // IN THIS REVISION OF THE CODE, THE GRAM[] ENTRIES FOR
  // PHRASE_TYPE IS THE *SIMPLE PHRASE NO*, not the gram index.
  // So no lookup is needed.

  
  //fprintf(stderr, "Phrase:  ############################################################################\n");
  for (alt = 0; alt < alts; alt++) {

    int phrases = gram(G) & INDEX_MASK; // skip count of phrases
    int phrase;
    
    //if (verbose) fprintf(stderr, "G=%d <-- offset of count of phrases"
    //                " (Looking at alt %d of %ls with %d terms.)\n",
    //                    G,         alt+1,  Pname,  phrases);

    Suppress_rest_of_this_Alt = FALSE;

    G++;
    //fprintf(stderr, "Alt %d: ---------------------------------------------------------------------------\n", alt);
    for (phrase = 0; phrase < phrases; phrase++) {
      // Determine type of term within the alt.
      int subphrase_type = (gram(G) & (GRAMMAR_TYPE_MASK<<GRAMMAR_TYPE_SHIFT));
      //if (verbose) fprintf(stderr, "G=%d: should be pointing to phrase %d: gram(G) = %lx (%ld)  TYPE=%02x\n",
      //        G, phrase, gram(G), gram(G&INDEX_MASK)&INDEX_MASK, (subphrase_type>>GRAMMAR_TYPE_SHIFT)&31);
      if (!Suppress_rest_of_this_Alt) {

        
        if (subphrase_type == BIP_TYPE) {
          if (verbose) fprintf(stderr, "subphrase_type == BIP_TYPE\n");
          // We assume BIPs will never match an empty option - that they are always equivalent to matching a
          // terminal. If this is a wrong assumption, I'm not sure how we should handle it other than relying
          // on the runtime runaway-recursion check, as there is no way to detect which call to a BIP
          // will match a null string and which won't.
          Suppress_rest_of_this_Alt = TRUE;
        } else if (subphrase_type == SEMANTIC_TYPE) {
          if (verbose) fprintf(stderr, "subphrase_type == SEMANTIC_TYPE\n");
          // Really not sure what is best with these.
          Suppress_rest_of_this_Alt = TRUE;
        } else if (subphrase_type == PHRASE_TYPE) {
          if (verbose) fprintf(stderr, "subphrase_type == PHRASE_TYPE\n");
          // Only recurse for proper phrases, not terminals
          int subphrase_start = gram(G) & INDEX_MASK;
          int subphrase_phrase_idx = sequential_phrase_no_to_grammar_index(subphrase_start);
          if (verbose) fprintf(stderr,
                  "PHRASE_TYPE: "
                  " gram(P=%08lx)"
                  " gram(P) & INDEX_MASK=%ld;"
                  " subphrase_start=%d"
                  " subphrase_phrase_idx=%d\n",
                  gram(P),
                  gram(P) & INDEX_MASK,
                  subphrase_start, subphrase_phrase_idx);

          if (gram(G) & NEGATED_PHRASE) {
            if (verbose) fprintf(stderr, "Not considering <!%d>\n", subphrase_phrase_idx/*String(phrasename(subphrase_phrase_idx))*/);
          } else {
            if (verbose) fprintf(stderr, "%ls (%d) calls %ls (%d)\n",
                                 Pname,
                                 InitP,
                                 String(phrasename(grammar_index_to_sequential_phrase_number(subphrase_phrase_idx))),
                                 /*String(phrasename(subphrase_phrase_idx)),*/
                                 subphrase_phrase_idx);
            //if (null_option[map(grammar_index_to_sequential_phrase_number(subphrase_phrase_idx))] == 1) {
            if (nullable(grammar_index_to_sequential_phrase_number(subphrase_phrase_idx)|PHRASE_TYPE)) {  // ************* DUBIOUS!
              // has_null_options(InitP); // if a term we call is nullable then so are we...
              //call(sequential_phrase_no_to_grammar_index(InitP), subphrase_phrase_idx);
              call(InitP, grammar_index_to_sequential_phrase_number(subphrase_phrase_idx)); // TESTING A HYPOTHESIS
            } else {
              // As soon as we process an Alt which forces a terminal to be recognised, there is no
              // possibility for recursion in the rest of this Alt.  However the next Alt could be
              // extremely recursive so we need to start checking again as soon as we get to the
              // next alt.
              if (InitP == subphrase_start) {
                // Pull out calling yourself as a special case because
                // our Warshall code relies on setting a table entry to
                // say that every phrase calls itself (which it doesn't)
                fflush(stderr); fprintf(stderr, "* Error: P<%ls> can fail due to direct left recursion.\n", Pname/*, InitP*/);
                exit(EXIT_FAILURE); // warned++;
              } else {
                //call(sequential_phrase_no_to_grammar_index(InitP), subphrase_phrase_idx);
                call(InitP, grammar_index_to_sequential_phrase_number(subphrase_phrase_idx));
              }
              if (verbose) {
                fprintf(stderr,
                        "Exiting this alt because P<%ls> calling <%ls> (%d calling %d) is thought not to allow a null option\n",
                        Pname,
                        String(phrasename(grammar_index_to_sequential_phrase_number(subphrase_phrase_idx))),
                        //String(phrasename(subphrase_phrase_idx)),
                        InitP, subphrase_phrase_idx);
              }
              Suppress_rest_of_this_Alt = TRUE;
            }
          }
        } else if (subphrase_type == KEYWORD_TYPE) {
          if (verbose) fprintf(stderr, "subphrase_type == KEYWORD_TYPE\n");
          Suppress_rest_of_this_Alt = TRUE;
        } else if (subphrase_type == REGEXP_TYPE) {
          if (verbose) fprintf(stderr, "subphrase_type == REGEXP_TYPE\n");
          // At the cost of a little more code and complexity, we *could* add a test here to check
          // if the regular expression could match an empty string.  There are a few possibile cases
          // where a regexp can match "" and give rise to a loop which the code here would not
          // detect.  I've not added that code because it'll be caught by the runtime runaway-recursion
          // check anyway.  It has happened to me *once* which I don't think justifies the extra effort.
          Suppress_rest_of_this_Alt = TRUE;
        } else if (subphrase_type == CHAR_TYPE) {
          if (verbose) fprintf(stderr, "subphrase_type == CHAR_TYPE\n");
          Suppress_rest_of_this_Alt = TRUE;
        } else {
          if (verbose) fprintf(stderr, "subphrase_type == something else...\n");
        }
      } else {
        if (verbose) fprintf(stderr, "subphrase_type == Skipped!\n");
      }
      G++; // move on to each phrase
    }
  }
}


// NEED TO ADJUST THIS CODE TO ACCOUNT FOR THE MIS-MATCH BETWEEN THE .h VERSION
// AND EMBEDDED takeon.c

// ALSO BE WARY OF RECENTLY-ADDED SEMANTIC ROUTINES.

//static int visited[MAX_UNIQUE_PHRASES];
//#define visited(x) BOUNDS_CHECK(visited,x,NUM_PHRASES+NUM_SEMANTIC_PHRASES)
static int visited[2000]; // size in excess of NUM_GRAMMAR.  Use flex array?
#define visited(x) BOUNDS_CHECK(visited,x,NUM_GRAMMAR)

// Tree-walk from the root, remember what we saw, complain about what we didn't see.
void determine_visited(int P, int visited[]) {
  int G = sequential_phrase_no_to_grammar_index(P & INDEX_MASK);
  int alts = gram(G) & INDEX_MASK;
  int alt;

  visited(P) = 1;
  G++; // skip count of alts
  for (alt = 0; alt < alts; alt++) {
    int phrases = gram(G) & INDEX_MASK;
    int phrase;
    G++; // skip count of phrases
    for (phrase = 0; phrase < phrases; phrase++) {
      // G now points to the first phrase in this alt.
      int subphrase_type = gram(G) & (GRAMMAR_TYPE_MASK<<GRAMMAR_TYPE_SHIFT);
      if (subphrase_type == PHRASE_TYPE) {
        int subphrase_P = gram(G) & INDEX_MASK;  // *** REMEMBER *** redesigned internal tables hold raw P phrase number (and with no BIP offset), not a G style index.
        if (!visited(subphrase_P)) {     // recursion stopper
          determine_visited(subphrase_P, visited);
        }
      }
      G++; // skip each phrase
    }
  }
}



void check_all_phrases(void) {
  int P_SS = 0;
  int i, j;

  for (j = 0; j < NUM_SIMPLE_PHRASES /*LARGEST_ALT*/; j++) {
    for (i = 0; i < NUM_SIMPLE_PHRASES; i++) {
      find_null_alts(String(phrasename(i)), i);
    }
  }

  j = FALSE;
  for (i = 0; i < NUM_SIMPLE_PHRASES; i++) {
    //fprintf(stderr, "Compare \"%ls\" vs \"%ls\"\n", L"SS",String(phrasename(i)));
    if (wcscmp(L"SS",String(phrasename(i)))==0) {
      P_SS = i;
      j = TRUE;
      break;
    }
  }
  if (!j) {
    fprintf(stderr, "? Warning: P<SS> is required, as the root of the grammar to be parsed.\n");
    fprintf(stderr, "           I'll use P<%ls> as the root instead.\n", String(phrasename(P_SS)));
    //exit(EXIT_FAILURE);
  }
  
  if (verbose) {
    fprintf(stderr, "\nThe following phrases could all match a null string, whether directly or indirectly:\n\n");
    for (j = 0; j < NUM_SIMPLE_PHRASES; j++) {
      i = map(j);
      if (null_option[i]) {
        // NEED EXTRA CARE BETWEEN COMPRESSED RANGE AND GRAM INDEX RANGE. THIS LOOKS WRONG.
        fprintf(stderr, "P<%ls> (%d)\n", String(phrasename(phraseno[i])), phraseno[i]);
      }
    }
    fprintf(stderr, "\n---------------------------------------------------------------------------------------\n");
  }

  // Now build call graph of calls which are nullable or are the first phrase following all nullable calls.
  for (i = 0; i < NUM_SIMPLE_PHRASES; i++) {
    handle_one_alt(String(phrasename(i)), i); // this creates the call graph
  }

  for (i = 0; i < next_free_phraseno; i++) {
    for (j = 0; j < next_free_phraseno; j++) {
      if (null_option[i]) null_option[j] |= callgraph[i][j];
    }
  }

  if (verbose) {
    fprintf(stderr, "\nThe following phrases could all match a null string, whether directly or indirectly:\n\n");
    for (int j = 0; j < NUM_SIMPLE_PHRASES; j++) {
      i = map(j);
      if (null_option[i]) {
        // NEED EXTRA CARE BETWEEN COMPRESSED RANGE AND GRAM INDEX RANGE. THIS LOOKS WRONG.
        fprintf(stderr, "P<%ls> (%d)\n", String(phrasename(phraseno[i])), phraseno[i]);
      }
    }
    fprintf(stderr, "\n---------------------------------------------------------------------------------------\n");
  }

  for (i = 0; i < next_free_phraseno; i++) {
    for (j = 0; j < next_free_phraseno; j++) {
      if (verbose) fprintf(stderr, "%c", '0'+callgraph[i][j]);
    }
    if (verbose) fprintf(stderr, "\n");
  }
    

  Warshall(); // and perform transitive closure to detect loops
  if (verbose) {
    fprintf(stderr, "\nThe following matrix is the transitive closure of the call graph\n\n          ");
    for (i = 0; i < next_free_phraseno; i++) fprintf(stderr, "%0d ", phraseno[i]);
    fprintf(stderr, "\n");
  }

  if (!Toposort()) { // If there is a loop, an attempt to create an ordering will fail.
                     // Error messages will be output on the fly from within Toposort.
    exit(EXIT_FAILURE);
  }

  // And finally, check to see if any phrases are unreachable from the root <SS>
  int P;
  int phrase_count = NUM_GRAMMAR;

  for (P = 0; P < phrase_count; P++) visited(P) = 0;

  determine_visited(P_SS,visited);

  for (i = 0; i < NUM_SIMPLE_PHRASES; i++) {
    if (!visited(i)) {
      // Exception for root phrase P<SS> (Source Statement) which is usually not referenced within the grammar
      if (i != P_SS) fprintf(stderr, "? Warning: P<%ls> UNUSED\n", String(phrasename(i)));
    }
  }
  
}
