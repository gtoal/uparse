

algol<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   No buffer:

   N    Classic         Turbo           pct
   640   659.797         612.932        7.1
   680   689.896         642.808        6.8
   720   729.221         679.751        6.8
   760  5649.694        5649.645        0.001
   800  5908.468        5895.573        0.2
   ;
   i̲n̲t̲e̲g̲e̲r̲ n,i;
   select(32);
   writetext(«algol<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲
   ;
   i̲n̲t̲e̲g̲e̲r̲ N,i;
   r̲e̲a̲l̲ a,b,time;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   writecr;»);
   f̲o̲r̲ n:=0 s̲t̲e̲p̲ 40 u̲n̲t̲i̲l̲ 800 d̲o̲
   b̲e̲g̲i̲n̲
      writetext(«
   clock count;
   N:=10000;
   f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
   b̲e̲g̲i̲n̲»);
      f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲ writetext(«
      a:=b;»);
      writetext(«
   e̲n̲d̲ for i;
   time:=clock count;
   writecr;
   write(«ddddd.ddd»,»);
   writeinteger(«p»,n);
   writetext(«,time);»);
   e̲n̲d̲ n;
   writetext(«
e̲n̲d̲
t<
»);
e̲n̲d̲;
t<
