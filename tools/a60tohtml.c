#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#include <wchar.h>
#include <wctype.h>
#include <locale.h>

#define TRUE (0==0)
#define FALSE (0!=0)

void codehtml(wchar_t c) {
  if (c == '&') fwprintf(stdout, L"&amp;");
  else if (c == '<') fwprintf(stdout, L"&lt;");
  else if (c == '>') fwprintf(stdout, L"&gt;");
  else if (c == L'≤') fwprintf(stdout, L"&LessSlantEqual;");
  else if (c == L'≥') fwprintf(stdout, L"&GreaterSlantEqual;");
  else if (c == L'@') fwprintf(stdout, L"&#9192;"); // decimal exponent symbol aka subten
  else if (c == L'⊃') fwprintf(stdout, L"&sub;"); // implies, uses "subset of" symbol
  // else if (c == L'≡') fwprintf(stdout, L"&equiv;"); // equiv
  // :=  (≔ - U+2254)
  else fputwc(c, stdout);
}
void stringhtml(wchar_t c) {
  if (c == '&') fwprintf(stdout, L"&amp;");
  else if (c == '<') fwprintf(stdout, L"&lt;");
  else if (c == '>') fwprintf(stdout, L"&gt;");
  else if (c == L'≤') fwprintf(stdout, L"&LessSlantEqual;");
  else if (c == L'≥') fwprintf(stdout, L"&GreaterSlantEqual;");
  //else if (c == L'@') fwprintf(stdout, L"&#9192;"); // decimal exponent symbol aka subten
  else if (c == L'⊃') fwprintf(stdout, L"&sub;"); // implies, uses "subset of" symbol
  // else if (c == L'≡') fwprintf(stdout, L"&equiv;"); // equiv
  // :=  (≔ - U+2254)
  else fputwc(c, stdout);
}
void commenthtml(wchar_t c) {
  if (c == '&') fwprintf(stdout, L"&amp;");
  else if (c == '<') fwprintf(stdout, L"&lt;");
  else if (c == '>') fwprintf(stdout, L"&gt;");
  else if (c == L'≤') fwprintf(stdout, L"&LessSlantEqual;");
  else if (c == L'≥') fwprintf(stdout, L"&GreaterSlantEqual;");
  //else if (c == L'@') fwprintf(stdout, L"&#9192;"); // decimal exponent symbol aka subten
  else if (c == L'⊃') fwprintf(stdout, L"&sub;"); // implies, uses "subset of" symbol
  // else if (c == L'≡') fwprintf(stdout, L"&equiv;"); // equiv
  else fputwc(c, stdout);
}

//void wouts(FILE *f, wchar_t *s) {
//  int i, len;
//  len = wcslen(s);
//  for (i = 0; i < len; i++) {
//    fputwc(s[i], f);
//  }
//}

int main(int argc, char **argv) {
  wint_t lastch, c, peekch;
  int kp, commenting;
  wchar_t keyword[128];

  /* If your native locale doesn't use UTF-8 encoding
   * you need to replace the empty string with a
   * locale like "en_US.utf8"
   */
  char *locale = setlocale(LC_ALL, "");
  
  commenting = 0; 
  fwprintf(stdout, L"<html><head><meta charset=\"utf-8\"></head><body><pre>");
  c = fgetwc(stdin);
  if (c != WEOF) peekch = fgetwc(stdin); if (peekch != WEOF) ungetwc(peekch, stdin);
  for (;;) {
    if (c == WEOF) break;
    if (commenting) {
      commenthtml(c);
      commenting = (c != ';');
    } else {
      // start of a keyword
      kp = 0;
      while (isalpha(c) && peekch == 818) {

        keyword[kp++] = c; keyword[kp] = '\0';
        // would be better to compare against RHS of keyword!
        if (commenting && (wcscasecmp(keyword, L"end") == 0)) commenting = FALSE;
        else if (commenting && (wcscasecmp(keyword, L"else") == 0)) commenting = FALSE;
        else if (wcscasecmp(keyword, L"comment") == 0) commenting = TRUE;
        (void)fgetwc(stdin); // _

        c = fgetwc(stdin); if (c == WEOF) break;
        peekch = fgetwc(stdin); if (peekch != WEOF) ungetwc(peekch, stdin);

      }
      if (kp) {
        keyword[kp] = '\0';
        // handle keyword, then c.
        fwprintf(stdout, L"<u>%ls</u>", keyword);
        continue; // with new c ready to be tested at top of loop
      } else switch (c) {

      case '\'':
        codehtml(lastch=c);
        break;
      
      case L'“':
        {
          int level = 0;
          for (;;) {
            if (c == L'“') level += 1;
            else if (c == L'”') level -= 1;
            stringhtml(c);
            if (level == 0 && c == L'”') break;
            c = fgetwc(stdin); if (c == WEOF) break;
          }
        }
        break;

      default:
        if (c == ':' && peekch == '=') {
          c = fgetwc(stdin); peekch = fgetwc(stdin);
          // :=  (≔ - U+2254)
          if (lastch != ' ') codehtml(lastch=0x2009); // thin space
          codehtml(lastch=0x2254); // colon equals
          codehtml(lastch=0x2009); // thin space
        } else {
          codehtml(lastch=c);
        }
        break;
      
      case WEOF:
        break;
      }
    }
    c = fgetwc(stdin); if (c == WEOF) break;
    peekch = fgetwc(stdin); if (peekch != WEOF) ungetwc(peekch, stdin);
  }
  fwprintf(stdout, L"</pre></body></html>\n");

  exit(0);
  return 1;
}
