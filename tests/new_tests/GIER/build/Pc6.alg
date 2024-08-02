

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   https://projecteuler.net/problem=112

   Answer:  1587000
   Time:    25518.52s = 7h 5m 18.52s

   No buffer, no f̲o̲r̲:

   Time classic:        30380.22
   Time turbo:          28390.72 6.5pct

   Buffer, no f̲o̲r̲:

   Time classic:        30569.63
   Time turbo:          28580.12 6.5pct

   No buffer, f̲o̲r̲:

   Time classic:        25329.12
   Time turbo:          24158.28 4.6pct

   Buffer, f̲o̲r̲:

   Time classic:        25518.52
   Time turbo:          24347.68 4.6pct

   ;
   r̲e̲a̲l̲ clock;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   b̲o̲o̲l̲e̲a̲n̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ bouncy(n);
   v̲a̲l̲u̲e̲ n;
   i̲n̲t̲e̲g̲e̲r̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ d,lastd;
      b̲o̲o̲l̲e̲a̲n̲ up,down;
      bouncy:=up:=down:=f̲a̲l̲s̲e̲;
      lastd:=n m̲o̲d̲ 10;
      n:=n÷10;
      f̲o̲r̲ n:=n w̲h̲i̲l̲e̲ n>0 d̲o̲
      b̲e̲g̲i̲n̲
         d:=n m̲o̲d̲ 10;
         i̲f̲ d>lastd ∨ (d=lastd ∧ up) t̲h̲e̲n̲
            up:=t̲r̲u̲e̲
         e̲l̲s̲e̲
         i̲f̲ d<lastd ∨ (d=lastd ∧ down) t̲h̲e̲n̲
            down:=t̲r̲u̲e̲;
         i̲f̲ up ∧ down t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            bouncy:=t̲r̲u̲e̲;
            g̲o̲t̲o̲ finish
         e̲n̲d̲ bouncy;
         n:=n÷10;
         lastd:=d
      e̲n̲d̲ f̲o̲r̲;
finish:
   e̲n̲d̲ bouncy;
   i̲n̲t̲e̲g̲e̲r̲ i,bcount;
   clock count;
   bcount:=0;
   f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 999999999 d̲o̲
   b̲e̲g̲i̲n̲
      i̲f̲ bouncy(i) t̲h̲e̲n̲ bcount:=bcount+1;
      i̲f̲ bcount×100/i≥99 t̲h̲e̲n̲ g̲o̲t̲o̲ found
   e̲n̲d̲;
   writetext(«bad»);
found:
   clock:=clock count;
   writecr;
   writeinteger(«p»,bcount);
   writecr;
   writeinteger(«p»,i);
   writecr;
   write(«dddddddd.dd»,clock)
e̲n̲d̲;
t<
