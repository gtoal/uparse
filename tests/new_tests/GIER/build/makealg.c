#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <wchar.h>
#include <errno.h>
#include <locale.h>
#include <ctype.h>

int main(int argc, char **qargv)
{
  char *locale = setlocale(LC_ALL, "");
  /*
6.6 x units per character, 12 y units

This should allow a C program to rebuild the indentation correctly.

This data was extracted by using firefox and converting to HTML with the
help of some external site that firefox uses, and extracting the text and
positioning info from the html with ecce...

Should probably also determine blank lines from the y offset, but
remember to reset it as we go from page to page.


36 48 "_"
36 48 "b_"
42.6 48 "e_"
49.2 48 "g_"
55.800000000000004 48 "i_"
62.4 48 "n"
55.800000000000004 60 "_"
55.800000000000004 60 "c_"
62.4 60 "o_"
69 60 "m_"
75.6 60 "m_"
82.19999999999999 60 "e_"
88.79999999999998 60 "n_"
95.39999999999998 60 "t"
88.79999999999998 84 "GC7J6KQ"
55.800000000000004 108 "Time buffer:"
167.99999999999991 108 "3397.02s = 56m"
266.9999999999999 108 "37.02s"

   */

  #define DX 6.6
  #define DY 12
  int rc;
  float x;
  int exitflag = 0;
  int i, ix, y, lasty, lineno, col, colcorrection=0;
  wchar_t *s, *linestart, buff[1024], line[1024];
  float offx = 0.0;
  int offy = 0;
  
  lineno = 0;
  lasty = -1;
  for (rc = 0; rc < 1024; rc++) line[rc] = L' ';

  for (;;) {
    rc = fwscanf(stdin, L"%f %d", &x, &y);
    if (rc != 2) {
      if (rc <= 0) break;
      fprintf(stderr, "rc = %d\n", rc);
      break;
    }
    if (offx == 0.0) offx = x;
    if (offy == 0) offy = y;
    //s = fgetws(buff, 1023, stdin);
    i = 0;
    //fprintf(stderr, "Input line: ");
    wchar_t ch;
    for (;;) {
      if (exitflag) break;
      ch = fgetwc(stdin);
      //if (ch < 32 || ch > 126) fprintf(stderr, "[<%08X>]", (unsigned int)ch); else fprintf(stderr, "%c", (char)ch);
      if (ch == WEOF) ch = fgetc(stdin);
      if (ch == WEOF) {buff[i] = L'\0'; break;}
      if (ch == L'\n') {buff[i] = L'\0'; break;}
      buff[i] = ch;
      i += 1;
      //fprintf(stderr, "%lc", (wint_t)ch);
    }
    //fprintf(stderr, "\n");
    // line ends in "...", tailing spaces already deleted.
    if (i > 0 && buff[i-1] != L'"') {
      fprintf(stderr, "Exit at line %d  Last character was '%lc'  Ch=%ld\n", __LINE__, (wint_t)buff[i-1], ch);
      exit(3);
    }
    buff[i-1] = L'\0';
    s = wcschr(buff, L'"');
    if (!s) {
      fprintf(stderr, "Exit at line %d\n", __LINE__);
      exit(3);
    }
    s += 1;
    linestart = s;
    // linestart is now the text.
    //fprintf(stderr, "%s\n", s);
    if (y != lasty) {
      // flush previous line first

      // TO DO: Need special handling for _10 which in these PDFs is implemented with a
      // smaller font '10' positioned less than a line below everything else on that line.
      // - the rest of the line resumes on the same baseline as the text before the _10
      // so it should be detectable, but currently this code moves down with the baseline.
      // Note: the Unicode character for _10 is not well supported.  Alternatives are:
      // "@", "&", "⏨", "\u23E8", "\u2081\u2080" (The 3rd one is the ideal encoding.)

      /*
         75.6 192 "_"
         75.6 192 "c_"
         82.19999999999999 192 "o_"
         88.79999999999998 192 "m_"
         95.39999999999998 192 "m_"
         101.99999999999997 192 "e_"
         108.59999999999997 192 "n_"
         115.19999999999996 192 "t Normalize x so that"
         260.39999999999986 192 "1"
         267 194 "10"                           <---- 2 pt lower baseline
         273.6 192 "10"
         293.4000000000001 192 ">"
         306.60000000000014 192 "x"
         319.8000000000002 192 "_"
         319.8000000000002 192 ">"
         333.0000000000002 192 "1;"
       */

      if ((y > lasty) && (y-lasty < DY/4)) {
        // Implied subscript - offset is only for this string.
        //fprintf(stderr, "Subscript %ls\n", s);
        if (wcscmp(s, L"10") == 0) {
          line[col++] = L'@';
          continue;
        } else {
          fprintf(stderr, "Exit at line %d  Unhandled subscript text was '%ls'\n", __LINE__, s);
          exit(4);
        }
        y = lasty;
      } else {
        // normal new line
        rc = 1023; while ((rc >= 0) && (line[rc] == L' ')) rc -= 1; line[rc+1] = L'\0';
        fprintf(stdout, "%ls\n", line);
        if (y - lasty > DY) fprintf(stdout, "\n"); // fix this, since we now know a likely line number.
        fflush(stdout);
        // reinitialise line
        for (rc = 0; rc < 1024; rc++) line[rc] = L' ';
        colcorrection = 0;
        lasty = y;
      }
    }
    // append the buffer to the line at the appropriate offset
    col = colcorrection + (int)trunc((x-offx+(DX/2)) / DX);
    lineno = (y-offy+(DY/2))/DY;
    //fprintf(stderr, "line %d, col %d\n", lineno, col);
    if (col >= 0 && col < 1022-wcslen(buff)) {
      s = linestart;
      while (*s != L'\0') {

        if (line[col] == L' ') {
          if (*s == L'_') { // just store prefix underlines and handle them when the next character arrives.
            line[col] = *s++;
            continue;
          }
        }
        if (line[col] != L' ') {
          // make this code inline to ease adding more than one char:
          wint_t a = line[col];
          wint_t b = *s++;

          // if (b == L'−') b = '-'; // Absolutely no good reason why they should use a special 'minus' sign.
          
          // Debugging, not needed now we're working OK...  fprintf(stderr, "'%lc' over '%lc'\n", a, b);
          
          // there is Unicode for underlined alpha but not other symbols
          // which will have to be handled specifically

          // The conversion of 'go to' (where the space is underlined) is problematic...
          /*
              75.6 288 "<<Zu wenig Ganzzahlstellen|"
              247.19999999999985 288 ">);"
              75.6 300 "_"                                    '_g'
              75.6 300 "g_"                                   '_o'
              82.19999999999999 300 "o_ _"                    '_ '
              95.39999999999998 300 "t_"                      '_t'
              101.99999999999997 300 "o _"                    '_o'
              115.19999999999996 300 "i_"
              121.79999999999995 300 "f show _"
              167.99999999999991 300 "t_"
              174.5999999999999 300 "h_"
              181.1999999999999 300 "e_"
              187.7999999999999 300 "n E1 _"
           */


          // 'go to' underlines the space in this implementation.  If we don't want that,
          // substitute line[col++] = L' '; below.
          
          if (a == L'_' && b == L' ')       {line[col++] = L'_'; continue; }

          
          if (a == L'_' && b == L'=')       {line[col++] = L'≡'; continue; }
          if (a == L'_' && b == L'>')       {line[col++] = L'≥'; continue; }
          if (a == L'_' && b == L'<')       {line[col++] = L'≤'; continue; }
          if (a == L'_' && b == L':')       {line[col++] = L'÷'; continue; }
          if (a == L'_' && isalnum(b))    {
            
            // 24 0 4 m 1 1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 4
            // These appear to be bit patterns in a 40-bit word:
            // The first number (which is underlined) is the
            // number of bits and the second number is the bit pattern
            // assigned to each of those bits.
            // I'm not sure what the 'm' is for but one possibility is
            // that it is the position of a decimal point in a fixed-point
            // real?
            // Aha! Doc found at https://datamuseum.dk/w/images/f/fa/Ga4man.pdf p15
            
            line[col++] = b;
            line[col++] = 818;
            colcorrection += 1;
            continue; // combining low-line post-character underline
          }
          
          if (a == L'_')                  {
            fprintf(stdout, "[%lc%lc]", a, b);
            line[col++] = b;
            continue;
          }

          if (a > b) {int tmp = a; a = b; b = tmp;}
          // assert a <= b to order comparisons and avoid 2 tests

       // if (a == L'<' && b == L'|' )    {line[col++] = L'“'; continue; }
          if (a == L'<' && b == L'|' )    {line[col++] = L'«'; continue; }
       // if (a == L'>' && b == L'|' )    {line[col++] = L'”'; continue; }
          if (a == L'>' && b == L'|' )    {line[col++] = L'»'; continue; }
          if (a == L'=' && b == L'|' )    {line[col++] = L'≠'; continue; }
          // [|<00002227>]
          if (b == 0x2227 && a == L'|' )  {line[col++] = L'⭡'; continue; }

          if (b <= 32 || b >= 127) {
            fprintf(stdout, "[%lc<%08X>]", a, (unsigned int)b);
          } else {
            fprintf(stdout, "[%lc%lc]", a, b);
          }
          line[col++] = b;
          exitflag = 1;
     // } else if (*s == '<' && line[col-1] == L'“') {
        } else if (*s == '<' && line[col-1] == L'«') {
          s += 1; // skip redundant '<' in weird '|<<' construct.
          colcorrection -= 1;
        } else if (*s == ',' && (line[col-1] == L'−' || line[col-1] == L'-')) { // unicode minus and ascii minus in that order
          line[col-1] = L'¬'; // BOOL NOT
          s += 1;
          colcorrection -= 1;

        /* TO DO: as per https://datamuseum.dk/w/images/e/e9/Naur6.pdf
          "=>"            BOOLEAN 'IMPLIES'
          underlined '.'  SPACE
          */
          
        } else {
          line[col++] = *s++;
        }
      }
    }
  }
  // flush previous line first
  rc = 1023; while ((rc >= 0) && (line[rc] == L' ')) rc -= 1; line[rc+1] = L'\0';
  fprintf(stdout, "%ls\n", line);  fflush(stdout);

  //fprintf(stderr, "Done\n");
  exit(0); return(0);
}
