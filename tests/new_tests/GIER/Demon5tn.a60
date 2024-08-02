

algol,i̲,n̲<
This program was made by my father, Jørgen Kjær,
while he worked for Haldor Topsøe.

This is Service Pack 1; a few bugs have been corrected:

1: Call of where moved out of show loop.
2: Error in shift code in LONGMULT.
3: Calculation of asize in ASSIGN has been changed.

ASSIGN and SQRT are now called after reading the number with read real.

2011−Jul−27 22.21 / TN: Experimenting with shifting, LONGMULT performance, and LONGDI

Timing (in seconds), 380 decimals, buffer GIER, no index check:

                Classic GA4     Turbo GA4       Save, pct.
sqrt(r):        5331.8          4923.3           7.7
sqrt2(r):       1247.6          1077.9          13.6
sqrt3(r):        389.2           365.0           6.2
sqrt(B):         388.1           363.9           6.2

Timing (in seconds), 380 decimals, no buffer GIER, no index check:

                Classic GA4     Turbo GA4       Save, pct.
sqrt(r):        8195.6          7892.0           3.7
sqrt2(r):       2147.2          2008.1           6.5
sqrt3(r):        379.9           364.9           3.9
sqrt(B):         377.6           361.5           4.3

Program DEMON−5. Calculation of large numbers.
b̲e̲g̲i̲n̲
   b̲o̲o̲l̲e̲a̲n̲ first, empty, show, large;
   b̲o̲o̲l̲e̲a̲n̲ showAll;
   i̲n̲t̲e̲g̲e̲r̲ linerest, lang, decimals, limit, carry, count, MODUL, cell,
   cell2, asize, bsize, csize, type, TYPE, D, E, FREE, ftrack, step, c39;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ NEW PAGE;
   b̲e̲g̲i̲n̲
      f̲o̲r̲ linerest := linerest − 1 w̲h̲i̲l̲e̲ linerest ≥ 0, 69 d̲o̲ writecr;
      writechar(72)
   e̲n̲d̲ NEW PAGE;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ LINE;
   i̲f̲ linerest < 8 t̲h̲e̲n̲ NEW PAGE
   e̲l̲s̲e̲
   b̲e̲g̲i̲n̲
      c̲o̲m̲m̲e̲n̲t̲ linerest := linerest − 1;
      writecr
   e̲n̲d̲ LINE;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ WRITE TEXT(dan, eng, fr, ger);
   s̲t̲r̲i̲n̲g̲ dan, eng, fr, ger;
   writetext(c̲a̲s̲e̲ lang o̲f̲ (dan, eng, fr, ger));
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ SELECT LANGUAGE;
   b̲e̲g̲i̲n̲
      LINE;
      writetext(
      «Select language: d: danish, e: english, f: french, g: german.: »);
      lang := lyn − 51;
      i̲f̲ lang < 1 t̲h̲e̲n̲ lang := 1;
      i̲f̲ lang > 4 t̲h̲e̲n̲ lang := 4;
      LINE;
      WRITE TEXT(
      «Dansk»,
      «English»,
      «Francais»,
      «Deutsch»);
      LINE
   e̲n̲d̲ SELECT LANGUAGE;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ ASK NUMBER(dan, eng, fr, ger);
   s̲t̲r̲i̲n̲g̲ dan, eng, fr, ger;
   b̲e̲g̲i̲n̲
      LINE;
      WRITE TEXT(dan, eng, fr, ger);
      writetext(«: »);
      ASK NUMBER := read integer
   e̲n̲d̲ ASK NUMBER;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ ACCEPT(cond);
   v̲a̲l̲u̲e̲ cond;
   b̲o̲o̲l̲e̲a̲n̲ cond;
   i̲f̲ ¬ cond t̲h̲e̲n̲
   b̲e̲g̲i̲n̲
      LINE;
      WRITE TEXT(
      «Brug flere heltalscifre»,
      «Use more integer digits»,
      «Le nombre de chiffres entiers est trop petit»,
      «Zu wenig Ganzzahlstellen»);
      g̲o̲_t̲o̲ i̲f̲ show t̲h̲e̲n̲ E1 e̲l̲s̲e̲ E2
   e̲n̲d̲ ACCEPT;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ ALARM(text);
   s̲t̲r̲i̲n̲g̲ text;
   b̲e̲g̲i̲n̲
      LINE;
      writetext(«Error in: »);
      writetext(text);
      g̲o̲_t̲o̲ i̲f̲ show t̲h̲e̲n̲ E1 e̲l̲s̲e̲ E2
   e̲n̲d̲ ALARM;
   i̲n̲t̲e̲g̲e̲r̲ stat TO REAL get A;
   i̲n̲t̲e̲g̲e̲r̲ stat COMPARE get A;
   i̲n̲t̲e̲g̲e̲r̲ stat COMPARE get B;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 get A;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 get B;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 get C 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 get C 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 put A;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 put B;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 put C 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 put C 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT2 put C 3;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get A 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get A 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get A 3;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get A 4;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get A 5;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get B 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get B 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 get B 3;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 put A 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 put A 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 put A 3;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 put A 4;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 put A 5;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 put C 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGDIVIDE2 put C 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT get B 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT get B 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT get RES 1;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT get RES 2;
   i̲n̲t̲e̲g̲e̲r̲ stat LONGMULT put RES;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ STATISTICS PROCESS(p);
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ p;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ stat counter;
      p(stat counter, «TO REAL get A », stat TO REAL get A);
      p(stat counter, «COMPARE get A », stat COMPARE get A);
      p(stat counter, «COMPARE get B », stat COMPARE get B);
      p(stat counter, «LONGMULT2 get A », stat LONGMULT2 get A);
      p(stat counter, «LONGMULT2 get B », stat LONGMULT2 get B);
      p(stat counter, «LONGMULT2 get C 1 », stat LONGMULT2 get C 1);
      p(stat counter, «LONGMULT2 get C 2 », stat LONGMULT2 get C 2);
      p(stat counter, «LONGMULT2 put A », stat LONGMULT2 put A);
      p(stat counter, «LONGMULT2 put B », stat LONGMULT2 put B);
      p(stat counter, «LONGMULT2 put C 1 », stat LONGMULT2 put C 1);
      p(stat counter, «LONGMULT2 put C 2 », stat LONGMULT2 put C 2);
      p(stat counter, «LONGMULT2 put C 3 », stat LONGMULT2 put C 3);
      p(stat counter, «LONGDIVIDE2 get A 1», stat LONGDIVIDE2 get A 1);
      p(stat counter, «LONGDIVIDE2 get A 2», stat LONGDIVIDE2 get A 2);
      p(stat counter, «LONGDIVIDE2 get A 3», stat LONGDIVIDE2 get A 3);
      p(stat counter, «LONGDIVIDE2 get A 4», stat LONGDIVIDE2 get A 4);
      p(stat counter, «LONGDIVIDE2 get A 5», stat LONGDIVIDE2 get A 5);
      p(stat counter, «LONGDIVIDE2 get B 1», stat LONGDIVIDE2 get B 1);
      p(stat counter, «LONGDIVIDE2 get B 2», stat LONGDIVIDE2 get B 2);
      p(stat counter, «LONGDIVIDE2 get B 3», stat LONGDIVIDE2 get B 3);
      p(stat counter, «LONGDIVIDE2 put A 1», stat LONGDIVIDE2 put A 1);
      p(stat counter, «LONGDIVIDE2 put A 2», stat LONGDIVIDE2 put A 2);
      p(stat counter, «LONGDIVIDE2 put A 3», stat LONGDIVIDE2 put A 3);
      p(stat counter, «LONGDIVIDE2 put A 4», stat LONGDIVIDE2 put A 4);
      p(stat counter, «LONGDIVIDE2 put A 5», stat LONGDIVIDE2 put A 5);
      p(stat counter, «LONGDIVIDE2 put C 1», stat LONGDIVIDE2 put C 1);
      p(stat counter, «LONGDIVIDE2 put C 2», stat LONGDIVIDE2 put C 2);
      p(stat counter, «LONGMULT get B 1 », stat LONGMULT get B 1);
      p(stat counter, «LONGMULT get B 2 », stat LONGMULT get B 2);
      p(stat counter, «LONGMULT get RES 1», stat LONGMULT get RES 1);
      p(stat counter, «LONGMULT get RES 2», stat LONGMULT get RES 2);
      p(stat counter, «LONGMULT put RES », stat LONGMULT put RES);
   e̲n̲d̲ STATISTICS PROCESS;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ STATISTICS INIT;
   b̲e̲g̲i̲n̲
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ init( c, t, s );
      v̲a̲l̲u̲e̲ c;
      i̲n̲t̲e̲g̲e̲r̲ c, s;
      s̲t̲r̲i̲n̲g̲ t;
      b̲e̲g̲i̲n̲
         s := 0
      e̲n̲d̲ init;
      STATISTICS PROCESS( init )
   e̲n̲d̲ STATISTICS INIT;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ STATISTICS PRINT;
   b̲e̲g̲i̲n̲
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ print( c, t, s );
      v̲a̲l̲u̲e̲ c;
      i̲n̲t̲e̲g̲e̲r̲ c, s;
      s̲t̲r̲i̲n̲g̲ t;
      b̲e̲g̲i̲n̲
         LINE;
         writetext( t );
         writetext( «: » );
         writeinteger( «−dddddd», s )
      e̲n̲d̲ init;
      STATISTICS PROCESS( print )
   e̲n̲d̲ STATISTICS INIT;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ ASSIGN(x, A, asize, na);
   v̲a̲l̲u̲e̲ x, na;
   i̲n̲t̲e̲g̲e̲r̲ asize, na;
   r̲e̲a̲l̲ x;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ c1, c2, t1, t2, cell1, cell2;
      x := abs(x);
      c1 := c39;
      f̲o̲r̲ count := 0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ c1 d̲o̲ A[count] := 0;
      i̲f̲ x = 0 t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         asize := c1 := c2 := cell1 := cell2 := 0;
         g̲o̲_t̲o̲ L1
      e̲n̲d̲ if x = 0;
      c̲o̲m̲m̲e̲n̲t̲ Normalize x so that 1@10 > x ≥ 1;
      asize := 0;
      i̲f̲ x ≥ MODUL t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
  f̲o̲r̲ x := x w̲h̲i̲l̲e̲ x ≥ MODUL d̲o̲
  b̲e̲g̲i̲n̲
     asize := asize+1;
     x := x/MODUL
  e̲n̲d̲
      e̲n̲d̲
      e̲l̲s̲e̲ i̲f̲ x < 1 t̲h̲e̲n̲
      f̲o̲r̲ x := x w̲h̲i̲l̲e̲ x < 1 d̲o̲
      b̲e̲g̲i̲n̲
         asize := asize−1;
  x := x×MODUL
      e̲n̲d̲;
      i̲f̲ asize > limit t̲h̲e̲n̲ ALARM(«ASSIGN»);
      cell1 := entier(x);
      cell2 := (x − cell1)×MODUL;
      c1 := asize − decimals;
      c2 := c1 − 1;
      i̲f̲ c2 < 0 t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         c2 := c1;
         cell2 := cell1
      e̲n̲d̲ if c2 < 0;
      i̲f̲ c1 < 0 t̲h̲e̲n̲ c1 := c2 := cell1 := cell2 := 0;
L1: i̲f̲ large t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         t1 := 1 + c1÷40;
         t2 := 1 + c2÷40;
         c1 := c1 m̲o̲d̲ 40;
         c2 := c2 m̲o̲d̲ 40;
         f̲o̲r̲ count := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ step d̲o̲
         b̲e̲g̲i̲n̲
            i̲f̲ count = t1 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               A[c1] := cell1;
               i̲f̲ t1 ≠ t2 t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  put(A, FREE, na×step + t1);
                  A[c1] := 0;
                  A[c2] := cell2;
                  put(A, FREE, na×step + t2)
               e̲n̲d̲ different track
               e̲l̲s̲e̲
               b̲e̲g̲i̲n̲
                  A[c2] := cell2;
                  put(A, FREE, na×step + t1)
               e̲n̲d̲ same track;
               A[c1] := A[c2] := 0
            e̲n̲d̲ this track
            e̲l̲s̲e̲
            put(A, FREE, na×step + count)
         e̲n̲d̲ for count
      e̲n̲d̲ if large
      e̲l̲s̲e̲
      b̲e̲g̲i̲n̲
         A[c1] := cell1;
         A[c2] := cell2
      e̲n̲d̲ core
   e̲n̲d̲ ASSIGN;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ MULT(A, asize, na, n);
   v̲a̲l̲u̲e̲ na, n;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, n;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ c, ta, c1, asize0;
      asize0 := asize;
      carry := c := 0;
      ta := na×step + 1;
      i̲f̲ large t̲h̲e̲n̲ get(A, FREE, ta);
      c1 := limit − decimals;
      f̲o̲r̲ count := 0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ c1 d̲o̲
      b̲e̲g̲i̲n̲
         cell := i̲f̲ count > asize0 − decimals t̲h̲e̲n̲ 0 e̲l̲s̲e̲ A[c];
         c̲o̲d̲e̲ cell, MODUL, carry, n;
         2, 44;
         2, 44;
         2, 44;
         3, 44;
         arn a3, pm a1 ; R := carry, M := cell
         ml p+a4,dl a2 ; RM := (carry+cell×n)/MODUL
         gr a3, gm a1 ; carry := quotient, cell := rem.
         e̲ ;
         A[c] := cell;
         c := c + 1;
         i̲f̲ large t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            i̲f̲ c = 40 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               c := 0;
               put(A, FREE, ta);
               ta := ta + 1;
               get(A, FREE, ta)
            e̲n̲d̲ if c = 40
         e̲n̲d̲ if large;
         i̲f̲ count = asize − decimals t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            i̲f̲ carry = 0 t̲h̲e̲n̲ g̲o̲_t̲o̲ EX
            e̲l̲s̲e̲
            i̲f̲ count < c1 t̲h̲e̲n̲ asize := asize + 1
            e̲l̲s̲e̲ ALARM(«MULT»)
         e̲n̲d̲ if asize
      e̲n̲d̲ for count;
EX: i̲f̲ large t̲h̲e̲n̲ put(A, FREE, ta)
   e̲n̲d̲ MULT;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ DIVIDE(A, asize, na, n, empty);
   v̲a̲l̲u̲e̲ na, n;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, n;
   b̲o̲o̲l̲e̲a̲n̲ empty;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ c, ta;
      first := t̲r̲u̲e̲;
      carry := 0;
      c := asize − decimals;
      ta := 1 + c÷40 + na×step;
      c := c m̲o̲d̲ 40;
      i̲f̲ large t̲h̲e̲n̲ get(A, FREE, ta);
      f̲o̲r̲ count := asize s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ decimals d̲o̲
      b̲e̲g̲i̲n̲
         cell := A[c];
         c̲o̲d̲e̲ cell, MODUL, carry, n;
         2, 44;
         2, 44;
         2, 44;
         3, 44;
         arn a1, pm a3 ; R := cell, M := carry
         ml a2, dl p+a4; RM := (cell+carry×MODUL)/n
         gr a1, gm a3 ; cell := quotient, carry := rem.
         e̲ ;
         A[c] := cell;
         c := c − 1;
         i̲f̲ large t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            i̲f̲ c < 0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               c := 39;
               put(A, FREE, ta);
               ta := ta − 1;
               get(A, FREE, ta)
            e̲n̲d̲ if c < 0
         e̲n̲d̲ if large;
         i̲f̲ first t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            i̲f̲ cell > 0 t̲h̲e̲n̲ first := f̲a̲l̲s̲e̲
            e̲l̲s̲e̲
            i̲f̲ asize > decimals t̲h̲e̲n̲ asize := asize − 1
         e̲n̲d̲ if first
      e̲n̲d̲ for count;
      i̲f̲ large t̲h̲e̲n̲ put(A, FREE, ta);
      empty := first ∧ cell = 0
   e̲n̲d̲ DIVIDE;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ PRINT(A, asize, na);
   v̲a̲l̲u̲e̲ asize, na;
   i̲n̲t̲e̲g̲e̲r̲ asize, na;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      b̲o̲o̲l̲e̲a̲n̲ first;
      i̲n̲t̲e̲g̲e̲r̲ DIVISOR, digit, i, space, group, ta, c;
      i̲n̲t̲e̲g̲e̲r̲ asize0;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ GROUP(n);
      v̲a̲l̲u̲e̲ n;
      i̲n̲t̲e̲g̲e̲r̲ n;
      b̲e̲g̲i̲n̲
         DIVISOR := MODUL÷10;
         space := i̲f̲ first t̲h̲e̲n̲ 0 e̲l̲s̲e̲ 16;
         f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 10 d̲o̲
         b̲e̲g̲i̲n̲
            digit := n÷DIVISOR;
            n := n m̲o̲d̲ DIVISOR;
            i̲f̲ digit ≠ 0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               writechar(digit);
               first := f̲a̲l̲s̲e̲;
               space := 16
            e̲n̲d̲
            e̲l̲s̲e̲ writechar(space);
            i̲f̲ i = 5 t̲h̲e̲n̲ writechar(0);
            DIVISOR := DIVISOR÷10
         e̲n̲d̲ for i
      e̲n̲d̲ GROUP;
      i̲f̲ kbon ∨ t̲r̲u̲e̲ t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         LINE;
         writetext( «asize: » );
         writeinteger( «−d», asize )
      e̲n̲d̲;
      first := t̲r̲u̲e̲;
      group := 0;
      LINE;
      c̲o̲m̲m̲e̲n̲t̲ i̲f̲ asize < 0 t̲h̲e̲n̲ asize := 0;
      asize0 := i̲f̲ asize < 0 t̲h̲e̲n̲ 0 e̲l̲s̲e̲ asize;
      c := asize0 − decimals;
      ta := 1 + c÷40;
      c := c m̲o̲d̲ 40;
      i̲f̲ large t̲h̲e̲n̲ get(A, FREE, na×step + ta);
      f̲o̲r̲ count := asize0 s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ decimals d̲o̲
      b̲e̲g̲i̲n̲
         GROUP(i̲f̲ count ≤ asize t̲h̲e̲n̲ A[c] e̲l̲s̲e̲ 0);
         i̲f̲ count = 0 ∧ decimals < 0 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            writechar(59);
            first := f̲a̲l̲s̲e̲
         e̲n̲d̲
         e̲l̲s̲e̲ writechar(0);
         group := group + 1;
         i̲f̲ (group m̲o̲d̲ 6 = 0) ∧ count ≠ decimals t̲h̲e̲n̲ LINE;
         c := c − 1;
         i̲f̲ large t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            i̲f̲ c < 0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               c := 39;
               ta := ta − 1;
               get(A, FREE, na×step + ta)
            e̲n̲d̲ if c < 0
         e̲n̲d̲ if large
      e̲n̲d̲ for count
   e̲n̲d̲ PRINT;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ COPY(A, asize, na, B, bsize, nb);
   v̲a̲l̲u̲e̲ na, nb;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ c, c1, t1, t2;
      c1 := c39;
      i̲f̲ large t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         t1 := na×step;
         t2 := nb×step;
         f̲o̲r̲ count := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ step d̲o̲
         b̲e̲g̲i̲n̲
            t1 := t1 + 1;
            t2 := t2 + 1;
            get(A, FREE, t1);
            put(A, FREE, t2)
         e̲n̲d̲ for count
      e̲n̲d̲ if large
      e̲l̲s̲e̲
      f̲o̲r̲ c := 0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ c1 d̲o̲ B[c] := A[c];
      bsize := asize
   e̲n̲d̲ COPY;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ ADD(B, bsize, nb, factor, A, asize, na);
   v̲a̲l̲u̲e̲ bsize, nb, factor, na;
   i̲n̲t̲e̲g̲e̲r̲ bsize, nb, factor, asize, na;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ ta, tb, c;
      i̲f̲ large t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         ta := tb := 1;
         get(A, FREE, na×step + ta);
         get(B, FREE, nb×step + tb)
      e̲n̲d̲ if large;
      c := − 1;
      carry := 0;
      f̲o̲r̲ count := decimals s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ limit d̲o̲
      b̲e̲g̲i̲n̲
         c := c + 1;
         i̲f̲ c = 40 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            c := 0;
            put(A, FREE, na×step + ta);
            ta := tb := ta + 1;
            get(A, FREE, na×step + ta);
            get(B, FREE, nb×step + tb)
         e̲n̲d̲ if c = 40;
         c̲o̲m̲m̲e̲n̲t̲ cell := A[c] + factor×B[c] + carry;
         cell := (i̲f̲ count ≤ asize t̲h̲e̲n̲ A[c] e̲l̲s̲e̲ 0) + (i̲f̲ count ≤ bsize t̲h̲e̲n̲ factor×
         carry := 1;
         f̲o̲r̲ carry := carry −1 w̲h̲i̲l̲e̲ cell < 0 d̲o̲
         cell := cell + MODUL;
         cell2 := cell÷MODUL;
         A[c] := cell − cell2×MODUL;
         carry := carry + cell2;
         i̲f̲ count ≥ bsize ∧ carry = 0 t̲h̲e̲n̲ g̲o̲_t̲o̲ L1
      e̲n̲d̲ for count;
L1: i̲f̲ carry ≠ 0 t̲h̲e̲n̲ ALARM(«ADD»);
      i̲f̲ large t̲h̲e̲n̲ put(A, FREE, na×step + ta);
      asize := limit + 1;
      c := limit − decimals;
      ta := 1 + c÷40;
      c := c m̲o̲d̲ 40;
      i̲f̲ large t̲h̲e̲n̲ get(A, FREE, na×step + ta);
      f̲o̲r̲ asize := asize −1 w̲h̲i̲l̲e̲ asize > decimals d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ A[c] ≠ 0 t̲h̲e̲n̲ g̲o̲_t̲o̲ L2;
         c := c − 1;
         i̲f̲ c < 0 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            c := 39;
            ta := ta − 1;
            get(A, FREE, na×step + ta)
         e̲n̲d̲ if c < 0
      e̲n̲d̲ for asize;
L2:e̲n̲d̲ ADD;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ TO REAL( A, asize, na );
   v̲a̲l̲u̲e̲ asize, na;
   i̲n̲t̲e̲g̲e̲r̲ asize, na;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xa, ca, sa;
      r̲e̲a̲l̲ r, r0;
      r := 0.0;
      sa := −1;
      f̲o̲r̲ xa := asize s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ decimals d̲o̲
      b̲e̲g̲i̲n̲
         b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲h̲e̲n̲ b̲e̲g̲i̲n̲ sa
         r0 := r + A[ca] × MODUL ⭡ xa;
         i̲f̲ r ≠ 0.0 ∧ r = r0 t̲h̲e̲n̲ g̲o̲t̲o̲ TO REAL LOOP END;
         r := r0
      e̲n̲d̲;
      TO REAL LOOP END:
      TO REAL := r
   e̲n̲d̲ TO REAL;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ COMPARE(A, asize, na, B, bsize, nb, size, acell, bcell );
   c̲o̲m̲m̲e̲n̲t̲ Compare A and B. Return:
         size: The index of the most significant differing cell
         acell and bcell: The actual differing cells
      If identical, size = decimals−1 and cells are zero;
   v̲a̲l̲u̲e̲ asize, na, bsize, nb;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, size, acell, bcell;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xa, ca, sa, xb, cb, sb;
      sa := sb := −1;
      f̲o̲r̲ size := i̲f̲ asize > bsize t̲h̲e̲n̲ asize e̲l̲s̲e̲ bsize s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ decimals d̲o̲
      b̲e̲g̲i̲n̲
         xa := size;
         b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲h̲e̲n̲ b̲e̲g̲i̲n̲ sa
         acell := i̲f̲ xa > asize t̲h̲e̲n̲ 0 e̲l̲s̲e̲ A[ca];
         xb := size;
         b̲e̲g̲i̲n̲ cb := xb − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ cb ÷ 40 ≠ sb t̲h̲e̲n̲ b̲e̲g̲i̲n̲ sb
         bcell := i̲f̲ xb > bsize t̲h̲e̲n̲ 0 e̲l̲s̲e̲ B[cb];
         i̲f̲ acell ≠ bcell t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            g̲o̲t̲o̲ COMPARE LOOP END
         e̲n̲d̲
      e̲n̲d̲;
      size := decimals − 1;
      acell := bcell := 0;
      COMPARE LOOP END:
      i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         LINE;
         writetext( «COMPARE: size = » );
         writeinteger( «−d», size );
         writetext( «, acell = » );
         writeinteger( «−d», acell );
         writetext( «, bcell = » );
         writeinteger( «−d», bcell );
         writetext( «, A = » );
         PRINT( A, asize, na );
         LINE;
         writetext( « B = » );
         PRINT( B, bsize, nb )
      e̲n̲d̲
   e̲n̲d̲ COMPARE;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ LONGMULT2(A, asize, na, B, bsize, nb, C, csize, nc);
   v̲a̲l̲u̲e̲ asize, na, bsize, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xa, ca, sa, acell, xb, cb, sb, bcell, xc, cc, sc, ccell, xcmin;
      csize := decimals − 1; c̲o̲m̲m̲e̲n̲t̲ C := 0;
      sa := −1; c̲o̲m̲m̲e̲n̲t̲ No data in A buffer;
      sb := −1;
      sc := −1;
      f̲o̲r̲ xb := decimals s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ bsize d̲o̲
      b̲e̲g̲i̲n̲
         b̲e̲g̲i̲n̲ cb := xb − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ cb ÷ 40 ≠ sb t̲h̲e̲n̲ b̲e̲g̲i̲n̲ sb
         bcell := B[cb];
         c̲o̲m̲m̲e̲n̲t̲ Ready to multiply A by bcell;
         carry := 0;
         i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «B[» );
            writeinteger( «−d», xb );
            writetext( «] = » );
            writeinteger( «−d», bcell );
         e̲n̲d̲;
         f̲o̲r̲ xa := i̲f̲ xb < 0 t̲h̲e̲n̲ decimals − xb − 1 e̲l̲s̲e̲ decimals s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ asize
         b̲e̲g̲i̲n̲
            i̲f̲ xa > asize ∨ xa < decimals t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               acell := 0
            e̲n̲d̲
            e̲l̲s̲e̲
            b̲e̲g̲i̲n̲
               b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲h̲e̲n̲ b̲e̲
               acell := A[ca]
            e̲n̲d̲;
            xc := xa + xb;
            i̲f̲ xc > csize ∨ xc < decimals t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               xcmin := csize + 1;
               ccell := 0;
            e̲n̲d̲
            e̲l̲s̲e̲
            b̲e̲g̲i̲n̲
               xcmin := xc;
               b̲e̲g̲i̲n̲ cc := xc − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ cc ÷ 40 ≠ sc t̲h̲e̲n̲ b̲e̲
               ccell := C[cc]
            e̲n̲d̲;
            i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               LINE;
               writetext( « A[» );
               writeinteger( «−d», xa );
               writetext( «] = » );
               writeinteger( «−d», acell );
               writetext( «, C[» );
               writeinteger( «−d», xc );
               writetext( «] = » );
               writeinteger( «−d», ccell );
            e̲n̲d̲;
            c̲o̲d̲e̲ acell, bcell, carry, ccell, MODUL;
            3, 44;
            3, 44;
            2, 44;
            3, 44;
            2, 44;
            arn a3 , ar p+a4 ; R := carry + ccell;
            pm p+a1, ml p+a2 ; RM := acell×bcell + carry + ccell;
            dl a5 , gr a3 ; RM := RM/MODUL; carry := quotient;
            gm p+a4 ; ccell := remainder
            e̲ ;
            i̲f̲ (ccell ≠ 0 ∨ csize ≥ xc) ∧ xc ≥ decimals t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               i̲f̲ xc > csize t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  csize := xc
               e̲n̲d̲;
               f̲o̲r̲ xc := xcmin s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ xa + xb d̲o̲
               b̲e̲g̲i̲n̲
                  b̲e̲g̲i̲n̲ cc := xc − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ cc ÷ 40 ≠ sc t̲h̲e̲n̲
                  C[cc] := i̲f̲ xc < xa + xb t̲h̲e̲n̲ 0 e̲l̲s̲e̲ ccell;
                  i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
                  b̲e̲g̲i̲n̲
                     LINE;
                     writetext( « C[» );
                     writeinteger( «−d», xc );
                     writetext( «/» );
                     writeinteger( «−d», cc );
                     writetext( «] = » );
                     writeinteger( «−d», C[cc] );
                  e̲n̲d̲
               e̲n̲d̲
            e̲n̲d̲
         e̲n̲d̲;
         i̲f̲ carry ≠ 0 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            ALARM(«LONGMULT2»)
         e̲n̲d̲
      e̲n̲d̲;
      i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ sc ≥ 0 t̲h̲e̲n̲ b̲e̲g̲i̲n̲ put( C, FREE, nc×step + 1 + sc ); stat
   e̲n̲d̲ LONGMULT2;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ LONGDIVIDE(A, asize, na, B, bsize, nb, C, csize, nc);
   c̲o̲m̲m̲e̲n̲t̲ ( C, A ) := ( A ÷ B, A m̲o̲d̲ B );
   v̲a̲l̲u̲e̲ na, bsize, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      LONGDIVIDE2(A, asize, na, B, bsize, nb, C, csize, nc, decimals);
   e̲n̲d̲ LONGDIVIDE;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ LONGDIVIDE2(A, asize, na, B, bsize, nb, C, csize, nc, decs);
   c̲o̲m̲m̲e̲n̲t̲ ( C, A ) := ( A ÷ B, A m̲o̲d̲ B );
   v̲a̲l̲u̲e̲ na, bsize, nb, nc, decs;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc, decs;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xa, ca, sa, xb, cb, sb, xc, cc, sc, bn, bn2, acell, bcell;
      i̲n̲t̲e̲g̲e̲r̲ an1, an, q, q0, digit, carry2, xamin, asize2, normfactor;
      i̲f̲ bsize < decs t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         ALARM(«LONGDIVIDE2 1»)
      e̲n̲d̲;
      normfactor := 1;
      NORMALIZE LOOP START:
         xb := bsize;
         sb := −1;
         b̲e̲g̲i̲n̲ cb := xb − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ cb ÷ 40 ≠ sb t̲h̲e̲n̲ b̲e̲g̲i̲n̲ sb
         bn := B[cb];
         i̲f̲ bn = 0 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            ALARM(«LONGDIVIDE2 2»)
         e̲n̲d̲;
         i̲f̲ kbon t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «LONG DIVIDE: A:» );
            PRINT( A, asize, na );
            LINE;
            writetext( « B:» );
            PRINT( B, bsize, nb );
            LINE;
            writetext( « bn = » );
            writeinteger( «−d», bn )
         e̲n̲d̲;
         i̲f̲ bn ≥ MODUL ÷ 2 t̲h̲e̲n̲ g̲o̲t̲o̲ NORMALIZE LOOP END;
         normfactor := MODUL ÷ (bn + 1);
         i̲f̲ kbon t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «LONG DIVIDE: normfactor = » );
            writeinteger( «−d», normfactor )
         e̲n̲d̲;
         MULT( A, asize, na, normfactor );
         MULT( B, bsize, nb, normfactor );
         g̲o̲t̲o̲ NORMALIZE LOOP START;
      NORMALIZE LOOP END:
      bn2 := bn + 2;
      sa := sc := −1;
      csize := decs − 1;
      f̲o̲r̲ xc := asize − bsize s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ decs d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ kbon t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «LONG DIVIDE: xc = » );
            writeinteger( «−d», xc )
         e̲n̲d̲;
         q := 0;
         c̲o̲m̲m̲e̲n̲t̲ Outline of the loop between QLOOPSTART and QLOOPEND:
            while A[xa..] ≥ B[xb..] do
              q0 := guess at A[xa..]/B[xb..] which is not too large
              A[xa..] := A[xa..] − q0×B[xb..]
              q := q + q0;
         QLOOPSTART:
            xa := xc + bsize + 1;
            i̲f̲ xa > asize t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               an1 := 0
            e̲n̲d̲
            e̲l̲s̲e̲
            b̲e̲g̲i̲n̲
               b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲h̲e̲n̲ b̲e̲
               an1 := A[ca]
            e̲n̲d̲;
            i̲f̲ an1 > 0 t̲h̲e̲n̲ g̲o̲t̲o̲ QMORE;
            i̲f̲ xc + bsize < decs t̲h̲e̲n̲ g̲o̲t̲o̲ QLOOPEND;
            f̲o̲r̲ xa := xc + bsize s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ decs d̲o̲
            b̲e̲g̲i̲n̲
               i̲f̲ xa > asize t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  acell := 0
               e̲n̲d̲
               e̲l̲s̲e̲
               b̲e̲g̲i̲n̲
                  b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲h̲e̲n̲
                  acell := A[ca]
               e̲n̲d̲;
               xb := xa − xc;
               i̲f̲ xb < decs t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  bcell := 0
               e̲n̲d̲
               e̲l̲s̲e̲
               b̲e̲g̲i̲n̲
                  b̲e̲g̲i̲n̲ cb := xb − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ cb ÷ 40 ≠ sb t̲h̲e̲n̲
                  bcell := B[cb]
               e̲n̲d̲;
               i̲f̲ acell > bcell t̲h̲e̲n̲ g̲o̲t̲o̲ QMORE;
               i̲f̲ acell < bcell t̲h̲e̲n̲ g̲o̲t̲o̲ QLOOPEND;
            e̲n̲d̲;
            QMORE:
            xa := xc + bsize;
            i̲f̲ xa > asize ∨ xa < decs t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               an := 0
            e̲n̲d̲
            e̲l̲s̲e̲
            b̲e̲g̲i̲n̲
               b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲h̲e̲n̲ b̲e̲
               an := A[ca]
            e̲n̲d̲;
            c̲o̲d̲e̲ an1, an, bn2, q0, MODUL;
            3, 44;
            3, 44;
            3, 44;
            3, 44;
            2, 44;
            ; arn p+a2, ar p+a3 ; R := an + bn − 1;
            ; sr c42 , pm p+a1 ;
            arn p+a2, pm p+a1 ; R := an; M := an1;
            ml a5 , dl p+a3 ; q0 := (an1×MODUL + an) ÷ bn2;
            gr p+a4 ;
            e̲ ;
            c̲o̲m̲m̲e̲n̲t̲ q0 := q0 − 2;
            i̲f̲ kbon t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               LINE;
               writetext( « QMORE: (» );
               writeinteger( «−d», an1 );
               writetext( «,» );
               writeinteger( «−d», an );
               writetext( «, ... ) ÷ » );
               writeinteger( «−d», bn );
               writetext( « ... estimate: » );
               writeinteger( «−d», q0 );
            e̲n̲d̲;
            i̲f̲ q0 = 0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               q0 := 1;
               i̲f̲ kbon t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  writetext( «, increased to » );
                  writeinteger( «−d», q0 );
               e̲n̲d̲
            e̲n̲d̲;
            i̲f̲ q0 < 0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               ALARM( «LONG DIVIDE 3» )
            e̲n̲d̲;
            i̲f̲ q0 ≥ MODUL t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               q0 := MODUL − 1;
               i̲f̲ kbon t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  writetext( «, reduced to » );
                  writeinteger( «−d», q0 );
               e̲n̲d̲
            e̲n̲d̲;
            carry := digit := carry2 := 0;
            asize2 := decs − 1;
            f̲o̲r̲ xb := i̲f̲ xc < 0 t̲h̲e̲n̲ decs − xc − 1 e̲l̲s̲e̲ decs s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ bsize + 1 d̲
            b̲e̲g̲i̲n̲
               i̲f̲ xb > bsize t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  bcell := 0
               e̲n̲d̲
               e̲l̲s̲e̲
               b̲e̲g̲i̲n̲
                  b̲e̲g̲i̲n̲ cb := xb − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ cb ÷ 40 ≠ sb t̲h̲e̲n̲
                  bcell := B[cb]
               e̲n̲d̲;
               i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  LINE;
                  writetext( « (» );
                  writeinteger( «−d», carry );
                  writetext( «,» );
                  writeinteger( «−d», bcell );
                  writetext( «) × » );
                  writeinteger( «−d», q0 );
               e̲n̲d̲;
               c̲o̲d̲e̲ bcell, q0, carry, digit, MODUL;
               3, 44;
               3, 44;
               2, 44;
               3, 44;
               2, 44;
               arn a3 , pm p+a1 ; R := carry; M := bcell;
               ml p+a2, dl a5 ; (carry,digit) :=
               gr a3 , gm p+a4 ; (bcell×q0 + carry) ÷ / m̲o̲d̲ MODUL;
               e̲ ;
               i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  writetext( « −> (» );
                  writeinteger( «−d», carry );
                  writetext( «,» );
                  writeinteger( «−d», digit );
                  writetext( «)» );
               e̲n̲d̲;
               xa := xc + xb;
               i̲f̲ xa > asize ∨ xa < decs t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  xamin := asize + 1;
                  acell := 0
               e̲n̲d̲
               e̲l̲s̲e̲
               b̲e̲g̲i̲n̲
                  xamin := xa;
                  b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲h̲e̲n̲
                  acell := A[ca]
               e̲n̲d̲;
               acell := acell − digit + carry2 + MODUL;
               carry2 := acell ÷ MODUL − 1;
               acell := acell m̲o̲d̲ MODUL;
               i̲f̲ acell ≠ 0 t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  asize2 := xa
               e̲n̲d̲;
               i̲f̲ (acell ≠ 0 ∨ asize ≥ xa) ∧ xa ≥ decs t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  i̲f̲ xa > asize t̲h̲e̲n̲
                  b̲e̲g̲i̲n̲
                     ALARM( «LONG DIVIDE 4» )
                  e̲n̲d̲;
                  f̲o̲r̲ xa := xamin s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ xc + xb d̲o̲
                  b̲e̲g̲i̲n̲
                     b̲e̲g̲i̲n̲ ca := xa − decimals; i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ ca ÷ 40 ≠ sa t̲
                     A[ca] := i̲f̲ xa < xc + xb t̲h̲e̲n̲ 0 e̲l̲s̲e̲ acell;
                     i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
                     b̲e̲g̲i̲n̲
                        LINE;
                        writetext( « A[» );
                        writeinteger( «−d», xa );
                        writetext( «] := » );
                        writeinteger( «−d», A[ca] );
                     e̲n̲d̲
                  e̲n̲d̲
               e̲n̲d̲
            e̲n̲d̲;
            i̲f̲ carry ≠ 0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               ALARM( «LONG DIVIDE 5» )
            e̲n̲d̲;
            i̲f̲ carry2 ≠ 0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               ALARM( «LONG DIVIDE 6» )
            e̲n̲d̲;
            q := q + q0;
            i̲f̲ kbon t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               LINE;
               writetext( « q += » );
               writeinteger( «−d», q0 );
               writetext( « −> » );
               writeinteger( «−d», q );
               LINE;
               writetext( « asize » );
               writeinteger( «−d», asize );
               writetext( « −> » );
               writeinteger( «−d», asize2 );
            e̲n̲d̲;
            asize := asize2;
            g̲o̲t̲o̲ QLOOPSTART;
         QLOOPEND:
         i̲f̲ q ≠ 0 ∧ csize < xc t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            csize := xc
         e̲n̲d̲;
         i̲f̲ csize ≥ xc t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            cc := xc − decimals;
            i̲f̲ large t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               i̲f̲ cc ÷ 40 ≠ sc t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  i̲f̲ sc ≥ 0 t̲h̲e̲n̲ b̲e̲g̲i̲n̲ put( C, FREE, nc×step + 1 + sc ); stat LONGDIV
                  sc := cc ÷ 40
               e̲n̲d̲;
               cc := cc m̲o̲d̲ 40
            e̲n̲d̲;
            C[cc] := q;
            i̲f̲ kbon t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               LINE;
               writetext( « C[» );
               writeinteger( «−d», xc );
               writetext( «] := » );
               writeinteger( «−d», q );
            e̲n̲d̲;
         e̲n̲d̲
      e̲n̲d̲;
      i̲f̲ large t̲h̲e̲n̲ b̲e̲g̲i̲n̲ i̲f̲ sc ≥ 0 t̲h̲e̲n̲ b̲e̲g̲i̲n̲ put( C, FREE, nc×step + 1 + sc ); stat
      i̲f̲ normfactor ≠ 1 t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         DIVIDE( A, asize, na, normfactor, empty );
         DIVIDE( B, bsize, nb, normfactor, empty )
      e̲n̲d̲
   e̲n̲d̲ LONGDIVIDE2;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ LONGMULT(A, asize, na, B, bsize, nb, C, csize, nc);
   v̲a̲l̲u̲e̲ asize, na, bsize, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ c, factor, rsize, nr, s, shift, cb, tb, c1, t1, c2, t2, s1,
      s2, s3;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ RES[0:c39];
      nr := ftrack;
      ftrack := ftrack + 1;
      i̲f̲ kbon t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         LINE;
         writetext( «LONGMULT: A:» );
         PRINT( A, asize, na );
         LINE;
         writetext( « B:» );
         PRINT( B, bsize, nb );
      e̲n̲d̲ kbon;
      ASSIGN(0, C, csize, nc);
      tb := 1 + nb×step;
      cb := 0;
      i̲f̲ large t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         get(B, FREE, tb);
         stat LONGMULT get B 1 := stat LONGMULT get B 1 + 1
      e̲n̲d̲;
      f̲o̲r̲ c := 0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ bsize − decimals d̲o̲
      b̲e̲g̲i̲n̲
         shift := c + decimals;
         i̲f̲ large t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            factor := B[cb];
            cb := cb + 1;
            i̲f̲ cb = 40 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               cb := 0;
               tb := tb + 1;
               get(B, FREE, tb);
               stat LONGMULT get B 2 := stat LONGMULT get B 2 + 1
            e̲n̲d̲ new B track
         e̲n̲d̲ large
         e̲l̲s̲e̲
         factor := B[c];
         COPY(A, asize, na, RES, rsize, nr);
         MULT(RES, rsize, nr, factor);
         i̲f̲ shift ≠ 0 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            s1 := i̲f̲ shift < 0 t̲h̲e̲n̲ −c e̲l̲s̲e̲ limit − decimals;
            s2 := − sign(shift);
            c̲o̲m̲m̲e̲n̲t̲ MK: Next line changed from limit − decimals − c;
            s3 := i̲f̲ shift < 0 t̲h̲e̲n̲ limit − decimals e̲l̲s̲e̲ − c;
            f̲o̲r̲ s := s1 s̲t̲e̲p̲ s2 u̲n̲t̲i̲l̲ s3 d̲o̲
            b̲e̲g̲i̲n̲
               i̲f̲ s < 0 ∨ s > limit − decimals t̲h̲e̲n̲
               cell := 0
               e̲l̲s̲e̲
               i̲f̲ large t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  t1 := nr×step + 1 + s÷40;
                  c1 := s m̲o̲d̲ 40;
                  get(RES, FREE, t1);
                  stat LONGMULT get RES 1 := stat LONGMULT get RES 1 + 1;
                  cell := RES[c1]
               e̲n̲d̲ large
               e̲l̲s̲e̲
               cell := RES[s];
               c2 := s + shift;
               i̲f̲ c2 > limit − decimals t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                 i̲f̲ cell ≠ 0 t̲h̲e̲n̲ ALARM(«LONGMULT»)
               e̲n̲d̲ if too big
               e̲l̲s̲e̲
               i̲f̲ c2 ≥ 0 t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  i̲f̲ large t̲h̲e̲n̲
                  b̲e̲g̲i̲n̲
                     t2 := nr×step + 1 + c2÷40;
                     c2 := c2 m̲o̲d̲ 40;
                     get(RES, FREE, t2);
                     stat LONGMULT get RES 2 := stat LONGMULT get RES 2 + 1;
                     RES[c2] := cell;
                     put(RES, FREE, t2);
                     stat LONGMULT put RES := stat LONGMULT put RES + 1
                  e̲n̲d̲ if large
                  e̲l̲s̲e̲
                  RES[c2] := cell
               e̲n̲d̲ if not c2 > limit − decimals
            e̲n̲d̲ for s
         e̲n̲d̲ if shift ≠ 0;
         rsize := rsize + shift;
         ADD(RES, rsize, nr, 1, C, csize, nc)
      e̲n̲d̲ for c;
      ftrack := ftrack − 1
   e̲n̲d̲ LONGMULT;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ EXP(X, xsize, nx, A, asize, na, XN, xnsize, nxn);
   v̲a̲l̲u̲e̲ xsize, nx, na, nxn;
   i̲n̲t̲e̲g̲e̲r̲ xsize, nx, asize, na, xnsize, nxn;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ X, A, XN;
   b̲e̲g̲i̲n̲
      b̲o̲o̲l̲e̲a̲n̲ out;
      i̲n̲t̲e̲g̲e̲r̲ tsize, nt, m;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ TERM[0:c39];
      nt := ftrack;
      ftrack := ftrack + 1;
      ASSIGN(1, A, asize, na);
      COPY(X, xsize, nx, TERM, tsize, nt);
      ADD(X, xsize, nx, 1, A, asize, na);
      out := f̲a̲l̲s̲e̲;
      m := 1;
      f̲o̲r̲ m := m + 1 w̲h̲i̲l̲e̲ ¬ out d̲o̲
      b̲e̲g̲i̲n̲
         LONGMULT(X, xsize, nx, TERM, tsize, nt, XN, xnsize, nxn);
         COPY(XN, xnsize, nxn, TERM, tsize, nt);
         DIVIDE(TERM, tsize, nt, m, out);
         ADD(TERM, tsize, nt, 1, A, asize, na)
      e̲n̲d̲ for m;
      ftrack := ftrack − 1
   e̲n̲d̲ EXP;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ PI TO(A, asize, na, T2, t2size, n2, T3, t3size, n3);
   v̲a̲l̲u̲e̲ na, n2, n3;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, t2size, n2, t3size, n3;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, T2, T3;
   b̲e̲g̲i̲n̲
      b̲o̲o̲l̲e̲a̲n̲ out1, out2, out3, out;
      i̲n̲t̲e̲g̲e̲r̲ factor, m, ns, n1, ssize, t1size;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ SUM, T1[0:c39];
      ns := ftrack;
      n1 := ns + 1;
      ftrack := ftrack + 2;
      ASSIGN(0, A, asize, na);
      ASSIGN(3, T1, t1size, n1);
      out1 := f̲a̲l̲s̲e̲;
      ASSIGN(24, T2, t2size, n2);
      DIVIDE(T2, t2size, n2, 171, out2);
      ASSIGN(24, T3, t3size, n3);
      DIVIDE(T3, t3size, n3, 1434, out3);
      factor := m := − 1;
      f̲o̲r̲ m := m + 2 w̲h̲i̲l̲e̲ ¬ out1 d̲o̲
      b̲e̲g̲i̲n̲
         ASSIGN(0, SUM, ssize, ns);
         ADD(T1, t1size, n1, 1, SUM, ssize, ns);
         i̲f̲ ¬ out2 t̲h̲e̲n̲
         ADD(T2, t2size, n2, 1, SUM, ssize, ns);
         i̲f̲ ¬ out3 t̲h̲e̲n̲
         ADD(T3, t3size, n3, 1, SUM, ssize, ns);
         DIVIDE(SUM, ssize, ns, m, out);
         factor := − factor;
         ADD(SUM, ssize, ns, factor, A, asize, na);
         DIVIDE(T1, t1size, n1, 64, out1);
         i̲f̲ ¬ out2 t̲h̲e̲n̲
         DIVIDE(T2, t2size, n2, 3249, out2);
         i̲f̲ ¬ out3 t̲h̲e̲n̲
         DIVIDE(T3, t3size, n3, 57121, out3)
      e̲n̲d̲ for m;
      ftrack := ftrack − 2
   e̲n̲d̲ PI TO;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ SQRT(x, A, asize, na, B, bsize, nb, C, csize, nc);
   v̲a̲l̲u̲e̲ x, na, nb, nc;
   r̲e̲a̲l̲ x;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      b̲o̲o̲l̲e̲a̲n̲ empty;
      i̲n̲t̲e̲g̲e̲r̲ xsize, zsize, nx, nz, i, imax;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ X, Z[0:c39];
      nx := ftrack;
      nz := nx + 1;
      ftrack := ftrack + 2;
      ASSIGN(x, X, xsize, nx);
      ASSIGN(sqrt(x), A, asize, na);
      ASSIGN(1/sqrt(x), Z, zsize, nz);
      imax := i̲f̲ asize > zsize t̲h̲e̲n̲ asize e̲l̲s̲e̲ zsize;
      imax := imax − decimals + 1;
      f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ imax d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ kbon t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «SQRT: i = » );
            writeinteger( «p», i );
            writetext( «, A =» );
            PRINT( A, asize, na )
         e̲n̲d̲;
         LONGMULT(A, asize, na, Z, zsize, nz, B, bsize, nb);
         i̲f̲ kbon t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( « B =» );
            PRINT( B, bsize, nb )
         e̲n̲d̲;
         ASSIGN(2, C, csize, nc);
         ADD(B, bsize, nb, −1, C, csize, nc);
         LONGMULT(Z, zsize, nz, C, csize, nc, B, bsize, nb);
         LONGMULT(B, bsize, nb, X, xsize, nx, C, csize, nc);
         COPY(B, bsize, nb, Z, zsize, nz);
         ADD(C, csize, nc, 1, A, asize, na);
         DIVIDE(A, asize, na, 2, empty);
  i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
  b̲e̲g̲i̲n̲
            LINE;
            writetext(«i: »);
            write integer(«−ddddd», i);
            writetext(«, A: »);
            PRINT(A, asize, na)
  e̲n̲d̲
      e̲n̲d̲ for i;
      i̲f̲ kbon t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         LINE;
         writetext( «SQRT end A = » );
         PRINT( A, asize, na )
      e̲n̲d̲;
      ftrack := ftrack − 2
   e̲n̲d̲ SQRT;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ SQUARE(A, asize, na, B, bsize, nb);
   c̲o̲m̲m̲e̲n̲t̲ B := A×A;
   v̲a̲l̲u̲e̲ na, nb;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xsize, nx;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ X[0:c39];
      nx := ftrack;
      ftrack := ftrack + 1;
      COPY( A, asize, na, X, xsize, nx );
      LONGMULT2( A, asize, na, X, xsize, nx, B, bsize, nb );
      ftrack := ftrack − 1
   e̲n̲d̲ SQUARE;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ SQRT2(x, A, asize, na, B, bsize, nb, C, csize, nc);
   v̲a̲l̲u̲e̲ x, na, nb, nc;
   r̲e̲a̲l̲ x;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      b̲o̲o̲l̲e̲a̲n̲ empty;
      i̲n̲t̲e̲g̲e̲r̲ xsize, zsize, nx, nz, i, imax;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ X, Z[0:c39];
      nx := ftrack;
      nz := nx + 1;
      ftrack := ftrack + 2;
      ASSIGN(x, X, xsize, nx);
      ASSIGN(sqrt(x), A, asize, na);
      ASSIGN(1/sqrt(x), Z, zsize, nz);
      imax := i̲f̲ asize > zsize t̲h̲e̲n̲ asize e̲l̲s̲e̲ zsize;
      imax := imax − decimals + 1;
      f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ imax d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ kbon t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «SQRT2: i = » );
            writeinteger( «p», i );
            writetext( «, A =» );
            PRINT( A, asize, na )
         e̲n̲d̲;
         LONGMULT2(A, asize, na, Z, zsize, nz, B, bsize, nb);
         i̲f̲ kbon t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( « B =» );
            PRINT( B, bsize, nb )
         e̲n̲d̲;
         ASSIGN(2, C, csize, nc);
         ADD(B, bsize, nb, −1, C, csize, nc);
         LONGMULT2(Z, zsize, nz, C, csize, nc, B, bsize, nb);
         LONGMULT2(B, bsize, nb, X, xsize, nx, C, csize, nc);
         COPY(B, bsize, nb, Z, zsize, nz);
         ADD(C, csize, nc, 1, A, asize, na);
         DIVIDE(A, asize, na, 2, empty);
  i̲f̲ kbon ∧ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
  b̲e̲g̲i̲n̲
            LINE;
            writetext(«i: »);
            write integer(«−ddddd», i);
            writetext(«, A: »);
            PRINT(A, asize, na)
  e̲n̲d̲
      e̲n̲d̲ for i;
      i̲f̲ kbon t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         LINE;
         writetext( «SQRT2 end A = » );
         PRINT( A, asize, na )
      e̲n̲d̲;
      ftrack := ftrack − 2
   e̲n̲d̲ SQRT2;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ SQRT3(x, A, asize, na, B, bsize, nb, C, csize, nc);
   v̲a̲l̲u̲e̲ x, na, nb, nc;
   r̲e̲a̲l̲ x;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      ASSIGN( x, B, bsize, nb );
      SQRT4( A, asize, na, B, bsize, nb, C, csize, nc )
   e̲n̲d̲ SQRT3;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ SQRT4(A, asize, na, B, bsize, nb, C, csize, nc);
   c̲o̲m̲m̲e̲n̲t̲ A := sqrt(B);
   v̲a̲l̲u̲e̲ na, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      ASSIGN(sqrt(TO REAL( B, bsize, nb )), A, asize, na);
      SQRT5(A, asize, na, B, bsize, nb, C, csize, nc)
   e̲n̲d̲ SQRT4;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ SQRT5(A, asize, na, B, bsize, nb, C, csize, nc);
   c̲o̲m̲m̲e̲n̲t̲ A := sqrt(B) using A as starting value;
   v̲a̲l̲u̲e̲ na, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xsize, nx, prevsize, size, acell, ccell;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ X[0:c39];
      b̲o̲o̲l̲e̲a̲n̲ empty;
      i̲n̲t̲e̲g̲e̲r̲ i, sd;
      b̲o̲o̲l̲e̲a̲n̲ kbonSQRT5;
      kbonSQRT5 := f̲a̲l̲s̲e̲;
      nx := ftrack;
      ftrack := ftrack + 1;
      sd := 7;
      prevsize := decimals + 1;
      f̲o̲r̲ i := 1, i + 1 w̲h̲i̲l̲e̲ t̲r̲u̲e̲ d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ kbon ∨ kbonSQRT5 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «SQRT5: i = » );
            writeinteger( «p», i );
            writetext( «, sd = » );
            writeinteger( «p», sd );
            writetext( «, A =» );
            PRINT( A, asize, na )
         e̲n̲d̲;
         COPY( B, bsize, nb, X, xsize, nx );
         LONGDIVIDE( X, xsize, nx, A, asize, na, C, csize, nc );
         COMPARE( A, asize, na, C, csize, nc, size, acell, ccell );
         i̲f̲ kbon ∨ kbonSQRT5 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( « prevsize = » );
            writeinteger( «−d», prevsize );
            writetext( «, size = » );
            writeinteger( «−d», size );
            writetext( «, acell = » );
            writeinteger( «−d», acell );
            writetext( «, ccell = » );
            writeinteger( «−d», ccell );
            writetext( «, C =» );
            PRINT( C, csize, nc )
         e̲n̲d̲;
         i̲f̲ prevsize ≤ decimals ∨ size < decimals ∨ size = decimals ∧ a̲b̲s̲ (acell − cc
         b̲e̲g̲i̲n̲
            g̲o̲t̲o̲ SQRT5 LOOP END
         e̲n̲d̲;
         prevsize := size;
         ADD(C, csize, nc, 1, A, asize, na);
         DIVIDE(A, asize, na, 2, empty);
         sd := sd + sd
      e̲n̲d̲ for i;
      SQRT5 LOOP END:
      i̲f̲ kbon t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         LINE;
         writetext( «SQRT5 end A = » );
         PRINT( A, asize, na )
      e̲n̲d̲;
      ftrack := ftrack − 1
   e̲n̲d̲ SQRT5;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ SQRT6(A, asize, na, B, bsize, nb, C, csize, nc);
   c̲o̲m̲m̲e̲n̲t̲ A := sqrt(B) using A as starting value;
   v̲a̲l̲u̲e̲ na, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xsize, nx, prevsize, size, acell, ccell;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ X[0:c39];
      b̲o̲o̲l̲e̲a̲n̲ empty;
      i̲n̲t̲e̲g̲e̲r̲ i, sd, decs;
      b̲o̲o̲l̲e̲a̲n̲ kbonSQRT6;
      kbonSQRT6 := f̲a̲l̲s̲e̲;
      nx := ftrack;
      ftrack := ftrack + 1;
      sd := 7;
      prevsize := decimals + 1;
      decs := decimals;
      f̲o̲r̲ i := 1, i + 1 w̲h̲i̲l̲e̲ t̲r̲u̲e̲ d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ kbon ∨ kbonSQRT6 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «SQRT6: i = » );
            writeinteger( «p», i );
            writetext( «, sd = » );
            writeinteger( «p», sd );
            writetext( «, decs = » );
            writeinteger( «−d», decs );
            writetext( «, A =» );
            PRINT( A, asize, na )
         e̲n̲d̲;
         COPY( B, bsize, nb, X, xsize, nx );
         LONGDIVIDE2( X, xsize, nx, A, asize, na, C, csize, nc, i̲f̲ decs < decimals t̲h̲
         COMPARE( A, asize, na, C, csize, nc, size, acell, ccell );
         i̲f̲ kbon ∨ kbonSQRT6 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( « prevsize = » );
            writeinteger( «−d», prevsize );
            writetext( «, size = » );
            writeinteger( «−d», size );
            writetext( «, acell = » );
            writeinteger( «−d», acell );
            writetext( «, ccell = » );
            writeinteger( «−d», ccell );
            writetext( «, C =» );
            PRINT( C, csize, nc )
         e̲n̲d̲;
         i̲f̲ prevsize ≤ decimals ∨ size < decimals ∨ size = decimals ∧ a̲b̲s̲ (acell − cc
         b̲e̲g̲i̲n̲
            g̲o̲t̲o̲ SQRT6 LOOP END
         e̲n̲d̲;
         prevsize := size;
         ADD(C, csize, nc, 1, A, asize, na);
         DIVIDE(A, asize, na, 2, empty);
         sd := sd + sd;
         decs := i̲f̲ size < 0 t̲h̲e̲n̲ 3×size e̲l̲s̲e̲ decimals
      e̲n̲d̲ for i;
      SQRT6 LOOP END:
      i̲f̲ kbon t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         LINE;
         writetext( «SQRT6 end A = » );
         PRINT( A, asize, na )
      e̲n̲d̲;
      ftrack := ftrack − 1
   e̲n̲d̲ SQRT6;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ AGM( A, asize, na, B, bsize, nb, C, csize, nc );
   c̲o̲m̲m̲e̲n̲t̲ (A,B) := agm(A,B) and C := sum( 2 ⭡ (j+1) × C[j] ). See
         Eugene Salamin,  Computation of pi Using Arithmetic− Geometric Mean ,
         Math. Comp., vol. 30, no 135, July 1976, pp. 565−570;
   v̲a̲l̲u̲e̲ na, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ w1size, nw1, w2size, nw2, twoPower, i, prevw1size, size, acell, bcell,
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ W1, W2[0:c39];
      b̲o̲o̲l̲e̲a̲n̲ kbonAGM;
      kbonAGM := f̲a̲l̲s̲e̲;
      nw1 := ftrack; ftrack := ftrack + 1;
      nw2 := ftrack; ftrack := ftrack + 1;
      ASSIGN( 0, C, csize, nc );
      twoPower := 1;
      prevw1size := decimals + 1;
      c̲o̲m̲m̲e̲n̲t̲ End loop by g̲o̲t̲o̲ AGM LOOP END;
      f̲o̲r̲ i := 1, i + 1 w̲h̲i̲l̲e̲ t̲r̲u̲e̲ d̲o̲
      b̲e̲g̲i̲n̲
         COPY( A, asize, na, W1, w1size, nw1 );
         ADD( B, bsize, nb, −1, W1, w1size, nw1 );
         COMPARE( A, asize, na, B, bsize, nb, size, acell, bcell );
         idcount := (i̲f̲ asize > bsize t̲h̲e̲n̲ asize e̲l̲s̲e̲ bsize) − size;
         i̲f̲ kbon ∨ kbonAGM t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LINE;
            writetext( «AGM: i = » );
            writeinteger( «−d», i );
            writetext( «, twoPower = » );
            writeinteger( «−d», twoPower );
            writetext( «, w1size = » );
            writeinteger( «−d», w1size );
            writetext( «, prevw1size = » );
            writeinteger( «−d», prevw1size );
            writetext( «, A =» );
            PRINT( A, asize, na );
            LINE;
            writetext( « compare size = » );
            writeinteger( «−d», size );
            writetext( «, idcount = » );
            writeinteger( «−d», idcount );
            writetext( «, B =» );
            PRINT( B, bsize, nb )
         e̲n̲d̲;
         i̲f̲ prevw1size ≤ decimals t̲h̲e̲n̲ g̲o̲t̲o̲ AGM LOOP END;
         prevw1size := w1size;
         SQUARE( W1, w1size, nw1, W2, w2size, nw2 );
         MULT( W2, w2size, nw2, twoPower );
         DIVIDE( W2, w2size, nw2, 4, empty );
         ADD( W2, w2size, nw2, 1, C, csize, nc );
         twoPower := twoPower + twoPower;
         COPY( A, asize, na, W1, w1size, nw1 );
         ADD( B, bsize, nb, 1, W1, w1size, nw1 );
         LONGMULT2( A, asize, na, B, bsize, nb, W2, w2size, nw2 );
         COPY( W1, w1size, nw1, A, asize, na );
         DIVIDE( A, asize, na, 2, empty );
         i̲f̲ idcount ≤ 0 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            SQRT4( B, bsize, nb, W2, w2size, nw2, W1, w1size, nw1 )
         e̲n̲d̲
         e̲l̲s̲e̲
         b̲e̲g̲i̲n̲
            COPY( A, asize, na, B, bsize, nb );
            SQRT5( B, bsize, nb, W2, w2size, nw2, W1, w1size, nw1 )
         e̲n̲d̲
      e̲n̲d̲;
      AGM LOOP END:
      ftrack := ftrack − 2
   e̲n̲d̲ EXPISQN;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ PI TO 2( A, asize, na, B, bsize, nb, C, csize, nc );
   c̲o̲m̲m̲e̲n̲t̲ A := pi using AGM;
   v̲a̲l̲u̲e̲ na, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      SQRT3( 0.5, B, bsize, nb, A, asize, na, C, csize, nc );
      ASSIGN( 1.0, A, asize, na );
      AGM( A, asize, na, B, bsize, nb, C, csize, nc );
      MULT( C, csize, nc, 4 );
      ASSIGN( 1.0, B, bsize, nb );
      ADD( C, csize, nc, −1, B, bsize, nb );
      MULT( A, asize, na, 2 );
      SQUARE( A, asize, na, C, csize, nc );
      LONGDIVIDE( C, csize, nc, B, bsize, nb, A, asize, na )
   e̲n̲d̲ PI TO 2;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ EXPISQN(N, A, asize, na, B, bsize, nb, C, csize, nc);
   v̲a̲l̲u̲e̲ N, na, nb, nc;
   i̲n̲t̲e̲g̲e̲r̲ N, asize, na, bsize, nb, csize, nc;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ xsize, nx;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ X[0:c39];
      nx := ftrack;
      ftrack := ftrack + 1;
      PI TO(A, asize, na, B, bsize, nb, C, csize, nc);
      SQRT(N, B, bsize, nb, C, csize, nc, X, xsize, nx);
      LONGMULT(A, asize, na, B, bsize, nb, C, csize, nc);
      EXP(C, csize, nc, A, asize, na, B, bsize, nb);
      ftrack := ftrack − 1
   e̲n̲d̲ EXPISQN;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ FACTAB(from, step, to, A, asize, na);
   v̲a̲l̲u̲e̲ from, step, to, na;
   i̲n̲t̲e̲g̲e̲r̲ from, step, to, asize, na;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ N, n;
      ACCEPT(limit > 1 + 0.05×to×ln(to));
      ASSIGN(1, A, asize, na);
      f̲o̲r̲ N := 2 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ from −1 d̲o̲
      MULT(A, asize, na, N);
      n := step −1;
      f̲o̲r̲ N := from s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ to d̲o̲
      b̲e̲g̲i̲n̲
         MULT(A, asize, na, N);
         n := n + 1;
         i̲f̲ n = step t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            n := 0;
            LINE;
            writetext(«N: »);
            write integer(«−ddddd», N);
            writetext(«, FAC(N): »);
            PRINT(A, asize, na)
         e̲n̲d̲ if n
      e̲n̲d̲ for N
   e̲n̲d̲ FACTAB;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ POWTAB1(from, step, to, a, A, asize, na);
   v̲a̲l̲u̲e̲ from, step, to, a, na;
   i̲n̲t̲e̲g̲e̲r̲ from, step, to, a, asize, na;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ N, n;
      ACCEPT(limit > 1 + 0.05×to×ln(a));
      LINE;
      writetext(«a: »);
      write integer(«−dddddddddd», a);
      ASSIGN(1, A, asize, na);
      f̲o̲r̲ N := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ from −1 d̲o̲
      MULT(A, asize, na, a);
      n := step −1;
      f̲o̲r̲ N := from s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ to d̲o̲
      b̲e̲g̲i̲n̲
         MULT(A, asize, na, a);
         n := n + 1;
         i̲f̲ n = step t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            n := 0;
            LINE;
            writetext(«N : »);
            write integer(«−ddddd», N);
            writetext(«, a⭡N: »);
            PRINT(A, asize, na)
         e̲n̲d̲ if n
      e̲n̲d̲ for N
   e̲n̲d̲ POWTAB1;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ POWTAB2(from, step, to, b, A, asize, na);
   v̲a̲l̲u̲e̲ from, step, to, b, na;
   i̲n̲t̲e̲g̲e̲r̲ from, step, to, b, asize, na;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ N, n;
      ACCEPT(limit > 1 + 0.05×b×ln(to));
      LINE;
      writetext(«b: »);
      write integer(«−dddddddddd», b);
      f̲o̲r̲ N := from s̲t̲e̲p̲ step u̲n̲t̲i̲l̲ to d̲o̲
      b̲e̲g̲i̲n̲
         ASSIGN(1, A, asize, na);
         f̲o̲r̲ n := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ b d̲o̲
         MULT(A, asize, na, N);
         LINE;
         writetext(«N: »);
         write integer(«−dddddddddd», N);
         writetext(«, N⭡b: »);
         PRINT(A, asize, na)
      e̲n̲d̲ for N
   e̲n̲d̲ POWTAB2;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ ISOM(N, PRI, psize, np, SEC, ssize,
   ns, TER, tsize, nt);
   v̲a̲l̲u̲e̲ N, np, ns, nt;
   i̲n̲t̲e̲g̲e̲r̲ N, psize, np, ssize, ns, tsize, nt;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ PRI, SEC, TER;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ sbase, nu, nv, usize, vsize, k, n, m, i, j, si, sj, q, sk, f;
      b̲o̲o̲l̲e̲a̲n̲ empty;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ U, V[0:c39];
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ size(n);
      v̲a̲l̲u̲e̲ n;
      i̲n̲t̲e̲g̲e̲r̲ n;
      b̲e̲g̲i̲n̲
         get(U, FREE, sbase + n÷40);
         size := U[n m̲o̲d̲ 40]
      e̲n̲d̲ size;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ store(n, size);
      v̲a̲l̲u̲e̲ n, size;
      i̲n̲t̲e̲g̲e̲r̲ n, size;
      b̲e̲g̲i̲n̲
         get(U, FREE, sbase + n÷40);
         U[n m̲o̲d̲ 40] := size;
         put(U, FREE, sbase + n÷40)
      e̲n̲d̲ store;
      large := t̲r̲u̲e̲;
      nu := ftrack;
      nv := nu + 1;
      f:=nv+1;
      sbase:=1+step×(1+f+N);
      ftrack:=f+1+N+1+N÷40;
      ASSIGN(1, PRI, psize, f);
      store(0, psize);
      f̲o̲r̲ n := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
      b̲e̲g̲i̲n̲
         ASSIGN(0, SEC, ssize, ns);
         ASSIGN(0, TER, tsize, nt);
         m := (n − 1)÷2;
         f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ m d̲o̲
         b̲e̲g̲i̲n̲
            j := n − 1 − i;
            si := size(i);
            sj := size(j);
            i̲f̲ i < j t̲h̲e̲n̲
            LONGMULT(PRI, si,
            f + i, U, sj, f + j, V, vsize, nv)
            e̲l̲s̲e̲
            b̲e̲g̲i̲n̲
               ASSIGN(1, U, usize, nu);
               ADD(V, sj, f+ j, 1,
               U, usize, nu);
               LONGMULT(PRI, si,
               f + i, U, usize, nu, V, vsize, nv);
               DIVIDE(V, vsize, nv, 2, empty)
            e̲n̲d̲ i ≥ j;
            ADD(V, vsize, nv, 1, SEC, ssize, ns)
         e̲n̲d̲ for i;
         m := (n − 2)÷2;
         f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ m d̲o̲
         b̲e̲g̲i̲n̲
            j := n − 1 − 2×i;
            si := size(i);
            sj := size(j);
            ASSIGN(i̲f̲ i ≠ j t̲h̲e̲n̲ 0 e̲l̲s̲e̲ 2, U, usize, nu);
            ADD(PRI, sj, f + j, 1,
            U, usize, nu);
            LONGMULT(PRI, si,
            f + i, U, usize, nu, V, vsize, nv);
            ADD(U, usize, nu, 1, V, vsize, nv);
            LONGMULT(V, vsize, nv,
            PRI, si, f + i, U, usize, nu);
            DIVIDE(U, usize, nu, i̲f̲ i ≠ j t̲h̲e̲n̲
            2 e̲l̲s̲e̲ 6, empty);
            ADD(U, usize, nu, 1, TER, tsize, nt)
         e̲n̲d̲ for i;
         m := (n − 4)÷3;
         f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ m d̲o̲
         b̲e̲g̲i̲n̲
            q := (n − 2 − i)÷2;
            f̲o̲r̲ j := i + 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ q d̲o̲
            b̲e̲g̲i̲n̲
               k := n − 1 − i − j;
               si := size(i);
               sj := size(j);
               sk := size(k);
               LONGMULT(PRI,
               sj, f + j, U, sk, f + k, V, vsize, nv);
               LONGMULT(V, vsize,
               nv, PRI, si, f + i, U, usize, nu);
               ADD(U, usize, nu, 1, TER, tsize, nt)
            e̲n̲d̲ for j
         e̲n̲d̲ for i;
         LINE;
         writetext(«N: »);
         write integer(«−ddddddd», n);
         LINE;
         writetext(«PRI(N):»);
         PRINT(PRI, size(n − 1), f + n − 1);
         LINE;
         writetext(«SEC(N):»);
         PRINT(SEC, ssize, ns);
         LINE;
         writetext(«TER(N):»);
         PRINT(TER, tsize, nt);
         LINE;
         ADD(TER, tsize, nt, 1, SEC, ssize, ns);
         ADD(PRI, size(n − 1), f + n − 1, 1,
         SEC, ssize, ns);
         COPY(SEC, ssize, ns, U, usize, f + n);
         store(n, usize)
      e̲n̲d̲ for n;
      ftrack := ftrack − (4 + N + N÷40)
   e̲n̲d̲ IOSM;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl , grf p−1 ; RF:=clock count; clock count:=0; stack[p−1]:=RF;
   e̲;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ CALCULATE;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A, B, C[0:c39];
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ next;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ x;
         i̲f̲ show t̲h̲e̲n̲ LINE;
         writetext(«r := »);
         x := read integer;
         i̲f̲ show ∨ showAll t̲h̲e̲n̲ write(«ddddddddd», x);
         next := x
      e̲n̲d̲ next;
      r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ next real;
      b̲e̲g̲i̲n̲
         r̲e̲a̲l̲ x;
         i̲f̲ show t̲h̲e̲n̲ LINE;
         writetext(«r := »);
         x := read real;
         i̲f̲ show ∨ showAll t̲h̲e̲n̲ write(«d.dddddd@−ddd», x);
         next real:= x
      e̲n̲d̲ next real;
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ STOP;
      g̲o̲_t̲o̲ EX;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ ORDER(text, command);
      s̲t̲r̲i̲n̲g̲ text;
      i̲n̲t̲e̲g̲e̲r̲ command;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ dummy;
         type := type + 1;
         i̲f̲ type = TYPE t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            writetext(text);
            clock count;
            dummy := command;
            LINE;
            writetext( «clock count: » );
            write(«ddddddd.d», clock count);
            g̲o̲_t̲o̲ NEW
         e̲n̲d̲ if this type
      e̲n̲d̲ ORDER;
      ftrack := 4;
NEW: LINE;
      LINE;
      writetext(«No: »);
      TYPE := read integer;
      i̲f̲ show ∨ showAll t̲h̲e̲n̲ write («dd», TYPE);
      type := 0;
      ORDER(« A := r;», ASSIGN(next real, A, asize, 1));
      ORDER(« write(A);», PRINT(A, asize, 1));
      ORDER(« B := A;», COPY(A, asize, 1, B, bsize, 2));
      ORDER(« C := A;», COPY(A, asize, 1, C, csize, 3));
      ORDER(« A := B;», COPY(B, bsize, 2, A, asize, 1));
      ORDER(« C := B;», COPY(B, bsize, 2, C, csize, 3));
      ORDER(« A := C;», COPY(C, csize, 3, A, asize, 1));
      ORDER(« B := C;», COPY(C, csize, 3, B, bsize, 2));
      ORDER(« A := A + B;», ADD(B, bsize, 2, 1, A, asize, 1));
      ORDER(« A := A − B;», ADD(B, bsize, 2, −1, A, asize, 1));
      ORDER(« A := A×r;», MULT(A, asize, 1, next));
      ORDER(« A := A/r;», DIVIDE(A, asize, 1, next, empty));
      ORDER(« C := A×B;», LONGMULT(A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« A := PI;», PI TO(A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« A := exp(B);», EXP(B, bsize, 2, A, asize, 1, C, csize, 3));
      ORDER(« A := sqrt(r);», SQRT(next real, A, asize, 1, B, bsize, 2, C, csize, 3)
      ORDER(« A := exp(PI×sqrt(r));»,
      EXPISQN(next, A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« FACTORIAL TABLE(r, r, r);»,
      FACTAB(next, next, next, A, asize, 1));
      ORDER(« POWER TABLE(r, r, r, r⭡variable);»,
      POWTAB1(next, next, next, next, A, asize, 1));
      ORDER(« POWER TABLE(r, r, r, variable⭡r);»,
      POWTAB2(next, next, next, next, A, asize, 1));
      ORDER(« ISOMER TABLE(r);»,
      ISOM(next, A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« stop», STOP);
      ORDER(« PRINT STATISTICS», STATISTICS PRINT);
      ORDER(« C := A<×2>B;», LONGMULT2(A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« (C,A) := (A÷B,A m̲o̲d̲ B);», LONGDIVIDE(A, asize, 1, B, bsize, 2, C, csiz
      ORDER(« A := sqrt2(r);», SQRT2(next real, A, asize, 1, B, bsize, 2, C, csize,
      ORDER(« A := sqrt3(r);», SQRT3(next real, A, asize, 1, B, bsize, 2, C, csize,
      ORDER(« A := TO REAL(A);», ASSIGN(TO REAL( A, asize, 1), A, asize, 1));
      ORDER(« A := sqrt(B);», SQRT4(A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« (A,B,C) := AGM(A,B);», AGM(A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« A := PI 2;», PI TO 2(A, asize, 1, B, bsize, 2, C, csize, 3));
      ORDER(« A := sqrt5(B) starting at A;», SQRT5(A, asize, 1, B, bsize, 2, C, csiz
      ORDER(« (C,A) := (A÷B,A m̲o̲d̲ B) with r decimals;», LONGDIVIDE2(A, asize, 1, B,
      ORDER(« A := sqrt6(B) starting at A;», SQRT6(A, asize, 1, B, bsize, 2, C, csiz
      g̲o̲_t̲o̲ NEW;
EX:e̲n̲d̲ CALCULATE;
   STATISTICS INIT;
   linerest := 69;
   MODUL := 10000000000;
   select(17);
   LINE;
   writetext( «2011−Aug−03 18.09 / TN» );
   SELECT LANGUAGE;
   LINE;
   WRITE TEXT(
   «PROGRAM DEMON−5. Beregning af store tal. Programmet simulerer en maskine med
3 registre, A, B og C, som har D decimaler og E cifre før kommaet.
Der anvendes følgende ordresystem:»,
   «PROGRAM DEMON−5. Calculation of large number. The program simulates a computer
with 3 registers, A, B, and C, with D decimals and E integer digits.
The following command system is used:»,
   «PROGRAMME DEMON−5. Calcul des nombres eleves. Le programme simule une machine a
3 registres, A, B, et C, avec D decimales et E chiffres entiers.
On utilise les commandes suivantes:»,
   «PROGRAMM DEMON−5. Berechnung von grossen Zahlen. Das Programm simuliert eine
Maschine mit 3 Registern, A, B, und C, mit D dezimalstellen und E Ganzzahlstellen.
Man verwendet die folgende Befehle:»);
   linerest := linerest − 2;
   LINE;
   LINE;
   writetext(«
  No:
   1: A := typein; 13: C := A×B;
   2: write(A); 14: A := PI;
   3: B := A; 15: A := exp(B);
   4: C := A; 16: A := sqrt(typein);
   5: A := B; 17: A := exp(PI×sqrt(r));
   6: C := B; 18: A := table of factorial function;
   7: A := C; 19: A := table of a⭡N;
   8: B := C; 20: A := table of N⭡b;
   9: A := A + B; 21: A := table of alcohol isomers;
  10: A := A − B; 22: STOP;
  11: A := A×typein; 23: print statistics
  12: A := A/typein; 24: C := A<×2>B;
                          25: (C,A) := (A÷B,A m̲o̲d̲ B)
                          26: A := sqrt2(typein);
                          27: A := sqrt3(typein);
                          28: A := TO REAL(A);
                          29: A := sqrt(B);
                          30: (A,B,C) := AGM(A,B);
                          31: A := PI 2;
                          32: A := sqrt5(B); starting at A
                          33: (C,A) := (A÷B,A m̲o̲d̲ B) with typein decimals
                          34: A := sqrt6(B); starting at A
»);
   linerest := linerest − 14;
   LINE;
   WRITE TEXT(
   «Vi lader først maskinen demonstrere nogle eksempler:»,
   «We first let the computer show some examples:»,
   «La machine nous donne d abord quelques examples:»,
   «Zuerst zeigt die Maschine einige Beispiele:»);
   show := t̲r̲u̲e̲;
   showAll := t̲r̲u̲e̲;
   c̲o̲m̲m̲e̲n̲t̲ MK: where moved;
   where(«free», FREE);
   i̲f̲ t̲r̲u̲e̲ t̲h̲e̲n̲
   b̲e̲g̲i̲n̲
   select(16);
   f̲o̲r̲ D := read integer w̲h̲i̲l̲e̲ D ≥ 0 d̲o̲
   b̲e̲g̲i̲n̲
      LINE;
      writetext(«D:»);
      writeinteger(«−ddddddd», D);
      decimals := D;
      i̲f̲ decimals > 0 t̲h̲e̲n̲
      decimals := −((decimals−1)÷10+1);
      E := read integer;
      LINE;
      writetext(«E:»);
      writeinteger(«−ddddddd», E);
      limit := (E−1)÷10;
      step := (limit − decimals)÷40 + 1;
      large := step > 1;
      c39 := i̲f̲ large t̲h̲e̲n̲ 39 e̲l̲s̲e̲ limit − decimals;
      CALCULATE;
E1:e̲n̲d̲ for decimals;
   LINE
   e̲n̲d̲;
   LINE;
   show := f̲a̲l̲s̲e̲;
   select(17);
   WRITE TEXT(
   «Nu kan De forsøge:»,
   «Now you may try:»,
   «Maintenant vous pouvez essaier:»,
   «Jetzt koennen Sie versuchen:»);
   f̲o̲r̲ D := ASK NUMBER(
   «Opgiv antal decimaler, D. −1 er stop»,
   «Specify number of decimals, D. −1 is stop»,
   «Specifiez le nombre de decimales, D. −1 est termination»,
   «Bitte, die Anzahl von Dezimalstellen, D, angeben. −1 is Schluss»)
   w̲h̲i̲l̲e̲ D ≥ 0 d̲o̲
   b̲e̲g̲i̲n̲
      i̲f̲ showAll t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         writeinteger( «−d», D )
      e̲n̲d̲;
      decimals := D;
      i̲f̲ decimals > 0 t̲h̲e̲n̲
      decimals := −((decimals−1)÷10 + 1);
      E := ASK NUMBER(
      «Og antallet af heltalscifre, E»,
      «And the number of integer digits, E»,
      «Et le nombre de chiffres entiers, E»,
      «Und die Anzahl der Ganzzahlstellen, E»);
      i̲f̲ showAll t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         writeinteger( «−d», E )
      e̲n̲d̲;
      limit := (E−1)÷10;
      step := (limit − decimals)÷40 + 1;
      large := step > 1;
      c39 := i̲f̲ large t̲h̲e̲n̲ 39 e̲l̲s̲e̲ limit − decimals;
      CALCULATE;
E2:e̲n̲d̲ for decimals
e̲n̲d̲
t<
Ff
380, 20
16, 2, 2
26, 2, 2
27, 2, 2
1, 2
29, 2, 2
22, −1,
