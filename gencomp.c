// I've just finished adding semantic phrases.  I haven't
// tidied the sources up yet, following some major surgery.

#include "parser.h"

#include GRAMMAR

// This program generates the C code that ultimately uses the AST.
// The generated code is just the body of the main switch statement.
// It is included by algol-compile.c which itself is included by uparse.c

// The code is generated based on the grammar, which starts as a ".g"
// file which is itself converted into a C header file by the 'takeon'
// utility.

// This code was based on regen.c

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

// Look up name of a BIP entry.
int BIPnum(int BIPStart) {
  int i = 0, bipsize = sizeof(bip_map)/sizeof(bip_map[0]);
  for (;;) { if ((i >= bipsize) || (bip_map(i) == BIPStart)) break; i++; }
  if (i == bipsize) { fprintf(stderr, "Cannot find a phrase starting at index=%d\n", BIPStart); exit(1); };
  return i;
}

#define MAX(a,b) ({int A=a, B=b; (A>B ? A : B);})

// Look up description of a terminal.
wchar_t *TERM_NAME(int P) {
  #define TMPSIZE 512
  static wchar_t tmp[TMPSIZE+1];
  int type = PhraseType(P);
  if (type == PhraseType(PHRASE_TYPE)) {
    swprintf(tmp, TMPSIZE, L"<%s%s%ls>", P&NEGATED_PHRASE ? "!":"",
             P&GUARD_PHRASE   ? "?":"",
             phrasename[phrasenum(P&INDEX_MASK)]);
  } else if (type == PhraseType(SEMANTIC_TYPE)) {
    swprintf(tmp, TMPSIZE, L"<%s%s%ls>", P&NEGATED_PHRASE ? "!":"",
                                         P&GUARD_PHRASE   ? "?":"",
                                         semantic_phrasename[P&INDEX_MASK]);
  } else if (type == PhraseType(KEYWORD_TYPE)) {
    swprintf(tmp, TMPSIZE, L"\"%ls\"", keyword[P&INDEX_MASK]);
  } else if (type == PhraseType(CHAR_TYPE)) {
    if ((P&255) == '\\') {
      swprintf(tmp, TMPSIZE, L"'\%lc'", P&255);
    } else {
      swprintf(tmp, TMPSIZE, L"'%lc'", P&255);
    }
  } else if (type == PhraseType(REGEXP_TYPE)) {
    swprintf(tmp, TMPSIZE, L"«%ls»", regexps[P&INDEX_MASK]+1);
  } else if (type == PhraseType(BIP_TYPE)) {
    swprintf(tmp, TMPSIZE, L"<%ls>", phrasename[P & INDEX_MASK]);
  } else {
    swprintf(tmp, TMPSIZE, L"{undecoded terminal %d, Type=%d}", P & INDEX_MASK, type);
  }
  return tmp;
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

void evaluate_subphrase(int P, int astidx) {
  //int alts = gram(P & INDEX_MASK) & INDEX_MASK;
  int type = PhraseType(P)<<GRAMMAR_TYPE_SHIFT;

  if (type == PHRASE_TYPE) {
    if (P&NEGATED_PHRASE) {
      printf("/* ignore negative guard */");
    } else {
      if (P&GUARD_PHRASE) {
        printf("/* ignore guard */");
      } else {
        if (phrasenum(P&INDEX_MASK) < PHRASE_BASE) {
          printf("t[%d] = compile(P(%d), depth+1 /* B_%ls */)", astidx, astidx, phrasename_c[phrasenum(P&INDEX_MASK)]);
        } else {
          printf("t[%d] = compile(P(%d), depth+1 /* P_%ls */)", astidx, astidx, phrasename_c[phrasenum(P&INDEX_MASK)]);
        }
      }
    }
  } else if (type == KEYWORD_TYPE) {
    printf("t[%d] = wlit(P(%d))", astidx, astidx);
  } else if (type == CHAR_TYPE) {
    if ((P&255) == '\\') {
      printf("t[%d] = wlit(P(%d) /*, L'\\%lc' */)", astidx, astidx , P&255);
    } else {
      printf("t[%d] = wlit(P(%d) /*, L'%lc' */)", astidx, astidx, P&255);
    }
  } else if (type == REGEXP_TYPE) {
    printf("t[%d] = wlit(P(%d))", astidx, astidx);
  } else if (type == BIP_TYPE) {
    printf("t[%d] = wlit(P(%d) /*, L\"%ls\" */)", astidx, astidx, phrasename[BIPnum(P & INDEX_MASK)]);
  } else if (type == SEMANTIC_TYPE) {
    printf("/* semantic procedure %ls */", semantic_phrasename[P & INDEX_MASK]);
  } else {
    printf("/* undecoded terminal %d */", P & INDEX_MASK);
  }
}

void output_code(int phrase_no, int P) {
  int OP=P;
  int alts = gram(P) & INDEX_MASK;
  int alt;
  printf("   case P_%ls:\n", phrasename_c[phrase_no]);   // NO!  Include '-' not '_'
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
        printf("     {                             ");
    }
    if (phrases == 0) {
      printf(" //\\\\    ;\n");
    } else {
      output_alt(phrase_no, OP, alt);
      if (alt+1==alts) printf(";"); else printf(",");
    }
    printf("\n");
    P++;
    for (phrase = 0; phrase < phrases; phrase++) {
      // loop over phrases:
      if (alts == 1) printf("     "); else printf("       ");
      //printf("T[++phrases] = "/*, phrase+1*/);
      evaluate_subphrase(gram(P), phrase+1);
      printf(";\n");
      P++;
    }
    if (alts==1)  printf("     }\n");
    //printf("       phrases = %d;\n", phrases);
    // if (alt+1 == alts) printf(";"); else printf(",\n//\\\\   ");
  }
  if (alts > 1) printf("     }\n");
  printf("     return t[0];\n\n" /*, phrasename[phrase_no]*/);
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
    printf("//\\\\ P<%ls> =\n", phrasename[i+PHRASE_BASE]);
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

  printf("#error This is not directly used in anything at the moment.\n");
  printf("// It is here for incorporating as the basis of a compile() function to do something useful with an AST.\n");
  printf("// For example this generated the code that was manually converted into algol60-indent.h\n\n");
  determine_visited(G_SS|PHRASE_TYPE,visited);

  fprintf(stdout, "#include <stdio.h>\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "#define AST_idx_mask 0xfFFFFFF\n");
  fprintf(stdout, "#define AST_type_shift 28\n");
  fprintf(stdout, "#define AST_type_mask  15\n");
  fprintf(stdout, "#define AST_BIP     (1 << AST_type_shift)\n");
  fprintf(stdout, "#define AST_PHRASE  (2 << AST_type_shift)\n");
  fprintf(stdout, "#define AST_LITERAL (3 << AST_type_shift)\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "int AST(int idx) {\n");
  fprintf(stdout, "}\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "int wlit(int P) {\n");
  fprintf(stdout, "}\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "int P(int P_) {\n");
  fprintf(stdout, "}\n");

  // fprintf(stdout, "#include \"%s.h\"\n", APPNAME);
  fprintf(stdout, "int compile(int Ph, int depth) {\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "  // AST format not properly designed yet.  These are placeholders:\n");
  fprintf(stdout, "#define P(x) (x) // TEMP\n");
  fprintf(stdout, "#define A(x) (x) // TEMP\n");
  fprintf(stdout, "#define wlit(x) (x)\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "  int AST_index = Ph&AST_idx_mask;\n");
  fprintf(stdout, "  int AST_type  = Ph & (AST_type_mask << AST_type_shift);\n");
  fprintf(stdout, "  int op    = A(AST_index+1);\n");
  fprintf(stdout, "  int alt   = A(AST_index+2);\n");
  fprintf(stdout, "  int count = A(AST_index+3);\n");
  fprintf(stdout, "  int t[LARGEST_ALT];\n");
  fprintf(stdout, "  int r = 0;\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "  fprintf(stderr, \"Ph=%%d AST_type = %%d  AST_index = %%d  op=%%d  alt=%%d  count=%%d\\n\", Ph, AST_type>>AST_type_shift, AST_index, op, alt, count);\n");
  fprintf(stdout, "\n");
  fprintf(stdout, "  switch (op) {\n");
  fprintf(stdout, "    // It is here for incorporating as the basis of a compile() function to do something useful with an AST.\n");
  fprintf(stdout, "    // For example this generated the code that was manually converted into algol60-indent.h\n");
  fprintf(stdout, "\n");

  output_grammar(visited);

  fprintf(stdout, "   default:\n");
  fprintf(stdout, "     return r;\n");
  fprintf(stdout, "  }\n");
  fprintf(stdout, "}\n");
  
  fflush(stdout);
  exit(EXIT_SUCCESS);
  return EXIT_FAILURE;
}

