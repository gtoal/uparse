// I've just finished adding semantic phrases.  I haven't
// tidied the sources up yet, following some major surgery.

#include "parser.h"

#include GRAMMAR

// This program generates the C code that converts the CST to an AST.
// The generated code is just the body of the main switch statement.
// It is included by algol.c which itself is included by uparse.c

// The code is generated based on the grammar, which starts as a ".g"
// file which is itself converted into a C header file by the 'takeon'
// utility.

// This skeleton could be modified to generate other useful utilities
// if needed.

#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include <ctype.h>

#include <wchar.h>
#include <locale.h>


void escape(FILE *out, const wchar_t *s, wchar_t *indent) {
  while (*s != '\0') {
    wint_t c = *s++;
    if (c == '\\') {
      fputc('\\', out);
      fputc('\\', out); // BUGFIX?
    } else if (c == '\"') {
      fputc('\\', out);
      fputc('\"', out);
    } else if (c == '\n') {
      fputc('\\', out);
      fputc('n', out);
      if (indent && (*s != '\0')) {
        fprintf(out, "%ls", indent);
      }
    } else {
      fprintf(out, "%lc", c);
    }
  }
}


#define UNDERLINE 818

static int visited[sizeof(gram)/sizeof(gram[0])];
#define visited(x) BOUNDS_CHECK(visited,x,sizeof(gram)/sizeof(gram[0]))
#define phrase_start(i) BOUNDS_CHECK(sequential_phrase_no_to_grammar_index,i,NUM_SIMPLE_PHRASES)
#define bip_map(i) BOUNDS_CHECK(bip_map,i,sizeof(bip_map)/sizeof(bip_map[0]))
#define gram(x) BOUNDS_CHECK(gram,x,sizeof(gram)/sizeof(gram[0]))

// phrasenum & TERM_NAME are so useful they may be better in a library.
// Look up name of a phrase entry.
int phrasenum_inner(int PhraseStart, char *file, int line) {
  int i = 0;
  for (;;) {
    if (   (i >= NUM_SIMPLE_PHRASES)
        || (sequential_phrase_no_to_grammar_index[i] == PhraseStart)) break;
    i++;
  }
  if (i == NUM_SIMPLE_PHRASES) {
    fprintf(stderr, "%s:%d: Cannot find a phrase starting at index=%d\n",
            file, line, PhraseStart);
    exit(1);
  };
  return i+PHRASE_BASE;
}
int phrasenum(int PhraseStart) {
  return phrasenum_inner(PhraseStart, __FILE__, __LINE__);
}
#define phrasenum(PhraseStart) phrasenum_inner(PhraseStart, __FILE__, __LINE__)

#define MAX(a,b) ({int A=a, B=b; (A>B ? A : B);})

// Look up description of a terminal.
wchar_t *TERM_NAME(int P) {
  #define TMPSIZE 512
  static wchar_t tmp[TMPSIZE+1];
  int type = PhraseType(P)<<GRAMMAR_TYPE_SHIFT;
  if (type == PHRASE_TYPE) {
    swprintf(tmp, TMPSIZE, L"<%s%s%ls>", P&NEGATED_PHRASE ? "!":"",
             P&GUARD_PHRASE   ? "?":"",
             phrasename_c[phrasenum(P&INDEX_MASK)]); // phrasenum adds PHRASE_BASE
  } else if (type == SEMANTIC_TYPE) {
    swprintf(tmp, TMPSIZE, L"<%s%s%ls>", P&NEGATED_PHRASE ? "!":"",
                                         P&GUARD_PHRASE   ? "?":"",
                                         semantic_phrasename[P&INDEX_MASK]);
  } else if (type == KEYWORD_TYPE) {
    swprintf(tmp, TMPSIZE, L"\"%ls\"", keyword[P&INDEX_MASK]);
  } else if (type == CHAR_TYPE) {
    if ((P&255) == '\\') {
      swprintf(tmp, TMPSIZE, L"'\%lc'", P&255);
    } else {
      swprintf(tmp, TMPSIZE, L"'%lc'", P&255);
    }
  } else if (type == REGEXP_TYPE) {
    swprintf(tmp, TMPSIZE, L"«%ls»", regexps[P&INDEX_MASK]+1);
  } else if (type == BIP_TYPE) {
    swprintf(tmp, TMPSIZE, L"<%ls>", phrasename_c[bip_map[P & INDEX_MASK]]);
  } else {
    swprintf(tmp, TMPSIZE, L"{undecoded terminal %d}", P & INDEX_MASK);
  }
  return tmp;
}

void output_rule(int phrase_no, int P) {
  int alts = gram(P) & INDEX_MASK;
  int alt;
  printf("//\\\\ P<%ls> =\n", phrasename[phrase_no]);
  //printf("//\\\\   ");
  P++;
  for (alt = 0; alt < alts; alt++) {
    int phrases = gram(P) & INDEX_MASK;
    int phrase;
    P++;
    for (phrase = 0; phrase < phrases; phrase++) {
      //printf("%ls", TERM_NAME(gram(P))); if (phrase+1 != phrases) printf(" ");
      P++;
    }
    //if (alt+1 == alts) printf(";"); else printf(",\n//\\\\   ");
  }
  //printf("\n//\\\\#\n");
  fflush(stdout);
}

void output_alt(int phrase_no, int P, int altno) {
  int alts = gram(P) & INDEX_MASK;
  int alt;
  P++;
  printf(" //\\\\    ");
  for (alt = 0; alt < alts; alt++) {
    int phrases = gram(P) & INDEX_MASK;
    int phrase;
    P++;
    for (phrase = 0; phrase < phrases; phrase++) {
      if (alt == altno) {
        printf("%ls", TERM_NAME(gram(P))); if (phrase+1 != phrases) printf(" "); // TO DO: Add , or ;
      }
      P++;
    }
  }
  fflush(stdout);
}

void evaluate_subphrase(int P) {
  //printf("-1; // successful semantic call\n");
  //printf("lit(AST__LIT, ':', A[ap+1]);\n");
  //printf("mktuple(AST_LABEL_COLON, alt /*0*/, /*phrases*/ 2, T /*T[1], T[2]*/);\n");
  //   printf("%ls", TERM_NAME(gram(P))); if (phrase+1 != phrases) printf(" ");

  //int alts = gram(P & INDEX_MASK) & INDEX_MASK;
  int type = PhraseType(P)<<GRAMMAR_TYPE_SHIFT;

  if (type == PHRASE_TYPE) {
    if (P&NEGATED_PHRASE) {
      printf("-1 +(0 * P++)");
    } else {
      if (P&GUARD_PHRASE) printf("-");
      if (phrasenum(P&INDEX_MASK) < PHRASE_BASE) {
        printf("build_ast(CST(P++) /* B_%ls */)", phrasename_c[phrasenum(P&INDEX_MASK)]);
      } else {
        printf("build_ast(CST(P++) /* G_%ls */)", phrasename_c[phrasenum(P&INDEX_MASK)]);
      }
    }
  } else if (type == SEMANTIC_TYPE) {
    printf("-1 +(0 * P++) /* S_%ls */ /* semantic call - temp for now. Could theoretically return a string like a terminal. Parser needs to insert something in CST. */", semantic_phrasename[P&INDEX_MASK]);
  } else if (type == KEYWORD_TYPE) {
    printf("kw(CST(P++), \"");
    escape(stdout, keyword[P&INDEX_MASK], NULL);
    printf("\")");
  } else if (type == CHAR_TYPE) {
    if ((P&255) == '\\') {
      printf("ch(CST(P++), '\\%lc')", P&255);
    } else {
      printf("ch(CST(P++), '%lc')", P&255);
    }
  } else if (type == REGEXP_TYPE) {
    printf("reg(CST(P++), \"");
    escape(stdout, regexps[P&INDEX_MASK]+1, NULL);
    printf("\")");
  } else if (type == BIP_TYPE) {
    printf("BIP(CST(P++), B_%ls)", phrasename_c[bip_map[P & INDEX_MASK]]);
  } else {
    printf("-1 /*undecoded terminal %d*/", P & INDEX_MASK);
  }
}

void output_code(int phrase_no, int P) {
  int OP=P;
  int alts = gram(P) & INDEX_MASK;
  int alt;
  printf("   case G_%ls:\n", phrasename_c[phrase_no]);
  P++;
  for (alt = 0; alt < alts; alt++) {
    int phrases = gram(P) & INDEX_MASK;
    int phrase;
    if (alts > 1) {
      if (alt == 0) {
        printf("     if (alt == 0)               { ");
      } else if (alt+1 == alts) {
        printf("     } else                      { ");
      } else {
        printf("     } else if (alt == %d)        { ", alt);
      }
    } else {
      printf("                                   ");
    }
    if (phrases == 0) {
      printf(" //\\\\    ;");
    } else {
      output_alt(phrase_no, OP, alt);
      if (alt+1==alts) printf(";"); else printf(",");
    }
    printf("\n");
    P++;
    for (phrase = 0; phrase < phrases; phrase++) {
      // loop over phrases:
      if (alts == 1) printf("     "); else printf("       ");
      printf("T[++phrases] = "/*, phrase+1*/);
      evaluate_subphrase(gram(P));
      printf(";\n");
      P++;
    }
    //printf("       phrases = %d;\n", phrases);
    // if (alt+1 == alts) printf(";"); else printf(",\n//\\\\   ");
  }
  if (alts > 1) printf("     }\n");
  printf("     return T[0] = mktuple(G_%ls, alt, phrases, T);\n\n", phrasename_c[phrase_no]);
  fflush(stdout);
}

void determine_visited(int P, int visited[]) {
  P = P & INDEX_MASK;
  int alts = gram(P) & INDEX_MASK;
  int alt;
  P++; // skip count of alts
  for (alt = 0; alt < alts; alt++) {
    int phrases = gram(P) & INDEX_MASK;
    int phrase;
    P++; // skip count of phrases
    for (phrase = 0; phrase < phrases; phrase++) {
      int subphrase_type = (gram(P) & (GRAMMAR_TYPE_MASK<<GRAMMAR_TYPE_SHIFT));
      if (subphrase_type == PHRASE_TYPE) {
        // Only recurse for proper phrases, not terminals
        int subphrase_start = gram(P) & INDEX_MASK;
        int subphrase_phrase_idx = phrasenum(gram(P) & INDEX_MASK);
        if (!visited(subphrase_phrase_idx)) {     // recursion stopper
          visited(subphrase_phrase_idx) = 1;
          determine_visited(subphrase_start, visited);
        }
      }
      P++; // skip each phrase
    }
  }
}

void output_grammar(int visited[]) {
  int P = 0;
  int i;
  // First output BIPs,
  for (i = 0; i < PHRASE_BASE; i++) {
    printf("//\\\\ B<%ls> = %d;\n//\\\\#\n", phrasename[i], bip_map[i]);
  }
  // then proper phrases
  for (i = 0; i < NUM_SIMPLE_PHRASES; i++) {
    P = phrase_start(i);
    output_rule(i+PHRASE_BASE, P);
    output_code(i+PHRASE_BASE, P);
    if (!visited(i+PHRASE_BASE)) {
      // Exception for root phrase P<SS> (Source Statement) which is usually not referenced within the grammar
      // Actually the 'unused phrase' test is not very onerous given that we're doing a tree walk anyway.
      //if (wcscmp(phrasename[i+PHRASE_BASE], L"SS") != 0) fprintf(stderr, "? Warning: P<%ls> UNUSED\n", phrasename[i+PHRASE_BASE]);
    }
  }
  printf("//\\\\ E\n");
}

int main(int argc, char **argv) {
  /* If your native locale doesn't use UTF-8 encoding
   * you need to replace the empty string with a
   * locale like "en_US.utf8"
   */
  /* char *locale = */ (void) setlocale(LC_ALL, "");

  int P;
  int phrase_count = sizeof(gram)/sizeof(gram[0]);

  for (P = 0; P < phrase_count; P++) visited(P) = 0;

  determine_visited(G_SS|PHRASE_TYPE,visited);

  output_grammar(visited);
  
  fflush(stdout);
  exit(EXIT_SUCCESS);
  return EXIT_FAILURE;
}

