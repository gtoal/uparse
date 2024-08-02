

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲
        Orig GA4:   184.573
        Turbo GA4:  179.735

        No buffer:

        Time classic:   184.573
        Time turbo:     180.017 2.5pct

        Buffer:

        Time classic:   184.588
        Time turbo:     180.031 2.5pct

   ;
   i̲n̲t̲e̲g̲e̲r̲ N,i;
   r̲e̲a̲l̲ a,b,time;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   writecr;
   clock count;
   N:=10000;
   f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
   b̲e̲g̲i̲n̲
      a:=sin(0.1)+exp(0.1)+sqrt(0.1)+arctan(0.1)
   e̲n̲d̲ for i;
   time:=clock count;
   write(«ddddd.ddd»,time);
   writecr
e̲n̲d̲
t<
