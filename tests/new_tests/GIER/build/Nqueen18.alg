

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

      Find a solution for the N queen problem.

      nqueen18.asc

   N    Solutions       Time
   4    2               0.30
   5    10              0.75
   6    4               2.24
   7    40              7.84
   8    92              29.82
   9    352             121.93
   10   724             526.09
   11   2680            2482.02

   No buffer, N=12:

   Time classic:        13968.89
   Time turbo:          12368.89 11.5pct

   Buffer, N=12:

   Time classic:        14069.38
   Time turbo:          12469.37 11.4pct

   ;

   i̲n̲t̲e̲g̲e̲r̲ N, MAXN, nsolutions;
   b̲o̲o̲l̲e̲a̲n̲ empcol;
   b̲o̲o̲l̲e̲a̲n̲ empup;
   b̲o̲o̲l̲e̲a̲n̲ empdo;
   b̲o̲o̲l̲e̲a̲n̲ one,zero;
   i̲n̲t̲e̲g̲e̲r̲ i;
   r̲e̲a̲l̲ clock;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ set(x);
   v̲a̲l̲u̲e̲ x;
   i̲n̲t̲e̲g̲e̲r̲ x;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ y;
      b̲o̲o̲l̲e̲a̲n̲ mask;
      y:=0;
      mask:=empcol ∧ (empdo s̲h̲i̲f̲t̲ x) ∧ (empup s̲h̲i̲f̲t̲ (−x));
      f̲o̲r̲ y := y w̲h̲i̲l̲e̲ 0≠i̲n̲t̲e̲g̲e̲r̲ mask d̲o̲
      b̲e̲g̲i̲n̲
         c̲o̲d̲e̲ mask,y,zero;
         3, 46;
         3, 44;
         2, 46;
         arn pa1,nk re1
         tk 1,mb a3
         gr pa1
         srn re1,ck 10
         ar pa2,ar c42
         gr pa2 V
e1:      qq
         e̲;
         i̲f̲ x = N t̲h̲e̲n̲
            nsolutions:=nsolutions+1
         e̲l̲s̲e̲
         b̲e̲g̲i̲n̲
            empcol := empcol ∧ (zero s̲h̲i̲f̲t̲ (−y));
            empup := empup ∧ (zero s̲h̲i̲f̲t̲ (x−y));
            empdo := empdo ∧ (zero s̲h̲i̲f̲t̲ (−x−y));
            set(x+1);
            empcol := empcol ∨ (one s̲h̲i̲f̲t̲ (−y));
            empup := empup ∨ (one s̲h̲i̲f̲t̲ (x−y));
            empdo := empdo ∨ (one s̲h̲i̲f̲t̲ (−x−y))
         e̲n̲d̲
      e̲n̲d̲
   e̲n̲d̲ set;

   MAXN := 12;    c̲o̲m̲m̲e̲n̲t̲ maximum size;
   one := 1̲ 1 3̲9̲ 0;
   zero := 1̲ 0 3̲9̲ m;
   f̲o̲r̲ N:=4 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ MAXN d̲o̲
   b̲e̲g̲i̲n̲
      nsolutions:=0;
      select(17);
      writecr;
      writetext(«looking onto a »);
      writeinteger(«p»,N);
      writetext(« × »);
      writeinteger(«p»,N);
      writetext(« chessboard...»);
      writecr;
      clock count;
      empcol:=empup:=empdo:=f̲a̲l̲s̲e̲;
      f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
      empcol := empcol ∨ (one s̲h̲i̲f̲t̲ −i);
      f̲o̲r̲ i := −N+1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N−1 d̲o̲
      empup := empup ∨ (one s̲h̲i̲f̲t̲ −i);
      f̲o̲r̲ i := 2 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 2×N d̲o̲
      empdo := empdo ∨ (one s̲h̲i̲f̲t̲ −i);

      set(1);

      i̲f̲ nsolutions=0 t̲h̲e̲n̲
      writetext(«NO SOLUTION.»)
      e̲l̲s̲e̲
      b̲e̲g̲i̲n̲
         clock := clock count;
         writeinteger(«p»,nsolutions);
         writetext(« solutions.»);
         writecr;
         writetext(«Time: »);
         write(«ddddddd.dd»,clock)
      e̲n̲d̲;
      writecr
   e̲n̲d̲;
   writetext(«done.»);
   writecr;
   N:=N;
e̲n̲d̲;
t<
