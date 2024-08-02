

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   https://projecteuler.net/problem=12

   Answer: 76576500
   Time:   46087.41s = 12h 48m 7.41s

   No buffer:

   Time classic:        38157.34
   Time turbo:          38153.31 0.01pct

   Buffer:

   Time classic:        38154.11
   Time turbo:          38150.08 0.01pct

   ;
   r̲e̲a̲l̲ clock;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   i̲n̲t̲e̲g̲e̲r̲ i,j,triangle,ndivisor,max;
   i:=0;
   select(16);
   triangle:=0;
   f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 1000000000 d̲o̲
   b̲e̲g̲i̲n̲
      triangle:=triangle+i;
      ndivisor:=0;
      max:=sqrt(triangle);
      i̲f̲ max×max=triangle t̲h̲e̲n̲ ndivisor:=−1;
      f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ max d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ triangle m̲o̲d̲ j=0 t̲h̲e̲n̲ ndivisor:=ndivisor+2;
      e̲n̲d̲ f̲o̲r̲;
      i̲f̲ ndivisor>500 t̲h̲e̲n̲ g̲o̲t̲o̲ found
   e̲n̲d̲;
found:
   clock:=clock count;
   writecr;
   writeinteger(«p»,triangle);
   writecr;
   write(«dddddddd.dd»,clock)
e̲n̲d̲;
t<
