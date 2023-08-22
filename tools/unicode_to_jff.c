#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <wchar.h>
#include <wctype.h>
#include <locale.h>

#ifndef FALSE
#define FALSE (0!=0)
#endif

#ifndef TRUE
#define TRUE (0==0)
#endif


/*
  This was hacked from an unrelated program so is a bit crufty but
  I think it works.  email gtoal@gtoal.com with any problems that
  need fixing.  There'll be a more structured and better designed
  version turning up eventually.  This is a short term stopgap so
  that I can feed various sources through jff-a2c as a check.
*/

int underlining = FALSE;
int comment = FALSE;

static char kw[128] = { '\0' };
static int kp = 0;

void ascii(wchar_t c) {
  
  wint_t lookahead = fgetwc(stdin);
  if (lookahead == 818) {    // Underline 'c'
    if (iswalpha(c)) {
      if (!underlining) {
        //fwprintf(stdout, L"'"); // start stropping
        kp = 0;
      }
      kw[kp++] = tolower(c); kw[kp] = '\0';  // use toupper if upper case keywords required.
      underlining = TRUE;
    } else {
      underlining = FALSE;
    }
  } else if (lookahead != WEOF) {
    ungetwc(lookahead, stdin);
    if (underlining) {
      // only a ';' can turn off a comment.  So a keyword inside a comment
      // shouldn't do anything.
      kw[kp] = '\0';
      if (!comment) comment = (strcmp(kw, "comment") == 0);
      // OUTPUT KEYWORD HERE.
      if (strcmp(kw, "boolean") == 0) {
        kw[0] = 'B';
      }
      // Other stropping conventions can be applied here.
      fwprintf(stdout, L"'%s'", kw); // end stropping
      underlining = FALSE;
    }
    kp = 0; kw[kp] = '\0';
  } else { // lookahead == WEOF
    if (underlining) { // probably e̲n̲d̲ with no ';' or \n
      kw[kp] = '\0'; if (kp) fwprintf(stdout, L"'%s'", kw);
      fwprintf(stdout, L"%lc\n", c);
      exit(EXIT_SUCCESS);
    }
  }

  if (c == WEOF) {
    if (underlining) { // probably e̲n̲d̲ with no ';' or \n
      kw[kp] = '\0'; if (kp) fwprintf(stdout, L"'%s'", kw);
      fwprintf(stdout, L"\n");
    }
    exit(EXIT_SUCCESS);
  } else if ((c != '\n') && (iswspace(c) || ((' ' < c) && (c < 127))))  {
    if (c == '{') {
      if (comment)
        fwprintf(stdout, L"{");  // or   "
      else
        fwprintf(stdout, L"\"");  // or   "
    } else if (c == '}') {
      if (comment)
        fwprintf(stdout, L"}");  // or   "
      else
        fwprintf(stdout, L"\"");  // or   "
    } else if (c == '/')  {
      //if (comment)
        fwprintf(stdout, L"/"); // or just '/'
      //else
      //  fwprintf(stdout, L"'div'"); // or just '/'
      // fputwc(c, stdout);
    } else if (c == ';') {
      comment = FALSE;
      fwprintf(stdout, L";");
    } else if (iswalpha(c)) {
      if (underlining) {
        //fputwc(c, stdout);
        // Postpone until keyword is complete so that 'Boolean' can be capitalised!!!
      } else {
        fputwc(c, stdout);
      }
    } else if ((unsigned)c >= 127) {
      fwprintf(stdout, L"{ TO DO #1: #%d }", c);
    } else {
      fputwc(c, stdout);
    }
  } else if (c == '\n') {
    fwprintf(stdout, L"\n");
  } else if (c == 247) {
    // Integer Divide
    fwprintf(stdout, L"'div'"); // Does regular Algol60 distinguish between real and integer division?
  } else if (c == 215) {
    // Multiply
    fwprintf(stdout, L"*");
  } else if (c == 172) {
    // NOT
    fwprintf(stdout, L"'not'"); // or '\'
  } else if (c == 8835) {
    // Implies, Superset of
    fwprintf(stdout, L"'implies'"); // alternatively imp, imply, or implies ?
  } else if (c == 8848) {
    // SQUARE ORIGINAL
    fwprintf(stdout, L"'implies'"); // 
  } else if (c == 8800) {
    // Not equals, vertical overstrike
    fwprintf(stdout, L"!="); // Had != but not accepted by algolps9. Possibly |= or ~= might be acceptable.
  } else if ((c == 8743) || (c == L'∧')) {
    // Logical AND
    fwprintf(stdout, L"'and'");
  } else if ((c == 8744) || (c == L'∨')) {
    // Logical OR
    fwprintf(stdout, L"'or'");
  } else if (c == 8804) {
    // <=
    fwprintf(stdout, L"<=");
  } else if (c == 8805) {
    // >=
    fwprintf(stdout, L">=");
  } else if (c == 8514) {
    // Inverted L
    fwprintf(stdout, L"\\");
  } else if (c == 8220) {
    fwprintf(stdout, L"\"");
  } else if (c == 8221) {
    fwprintf(stdout, L"\"");
  } else {
    fwprintf(stdout, L"{ TO DO #2: #%d }", c);
  }
}

int main(int argc, char **argv)
{
  wint_t c, lastc, openquote;
  int p, allalpha, commenting, pendingspace, nocloser;
  static wchar_t atom[128];

  /* If your native locale doesn't use UTF-8 encoding
   * you need to replace the empty string with a
   * locale like "en_US.utf8"
   */
  char *locale = setlocale(LC_ALL, "");
  
  for (;;) {
    c = fgetwc(stdin);
    ascii(c);
  }

  exit(0);
  return 1;
}
