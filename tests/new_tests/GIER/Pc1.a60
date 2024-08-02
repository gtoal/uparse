

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

        no buffer N=20:
        Time classic:   14.112
        Time turbo:     14.004 0.8pct

        buffer N=20:
        Time classic:   12.920
        Time turbo:     12.783 1.1pct

        buffer N=60:
        Time classic:   262.368
        Time turbo:     261.448 0.4pct
   ;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ LEQ1(N, M, A, eps);
   v̲a̲l̲u̲e̲ N, M, eps;
   i̲n̲t̲e̲g̲e̲r̲ N, M;
   a̲r̲r̲a̲y̲ A;
   r̲e̲a̲l̲ eps;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ i, j, k, i1, j1;
      r̲e̲a̲l̲ max, f2, factor;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ p[1:N];
      M := N + M;
      LEQ1 := 0;
      f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
      b̲e̲g̲i̲n̲
         max := 0;
         f̲o̲r̲ j := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
         max := max + A[i,j]⭡2;
         i̲f̲ max > 1 ∨ max < 0.25 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            f2 := 2⭡(−entier(ln(max)/1.3863 + 1));
            f̲o̲r̲ j := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ M d̲o̲
            A[i,j] := A[i,j]×f2
         e̲n̲d̲ if max
      e̲n̲d̲ for i: equilibration;
      f̲o̲r̲ k := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
      b̲e̲g̲i̲n̲
         max := 0;
         f̲o̲r̲ i := k s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
         f̲o̲r̲ j := k s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
         b̲e̲g̲i̲n̲
            factor := abs(A[i,j]);
            i̲f̲ max ≤ factor t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               max := factor;
               i1 := i;
               j1 := j
            e̲n̲d̲ if larger
         e̲n̲d̲ f̲o̲r̲;
         i̲f̲ max < eps t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            LEQ1 := 1;
            g̲o̲_t̲o̲ EX
         e̲n̲d̲ error exit;
         max := A[i1,j1];
         i̲f̲ i1 ≠ k t̲h̲e̲n̲
         f̲o̲r̲ j := k s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ M d̲o̲
         b̲e̲g̲i̲n̲
            factor := A[k,j];
            A[k,j] := A[i1,j];
            A[i1,j] := factor
         e̲n̲d̲ for j: row interchange;
         p[k] := k;
         i̲f̲ j1 ≠ k t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            p[k] := j1;
            f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
            b̲e̲g̲i̲n̲
               factor := A[i,k];
               A[i,k] := A[i,j1];
               A[i,j1] := factor
            e̲n̲d̲ for i
         e̲n̲d̲ interchange of columns;
         f̲o̲r̲ i := k + 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
         b̲e̲g̲i̲n̲
            factor := A[i,k]/max;
            f̲o̲r̲ j := k + 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ M d̲o̲
            A[i,j] := A[i,j] − A[k,j]×factor
         e̲n̲d̲ f̲o̲r̲
      e̲n̲d̲ for k;
      f̲o̲r̲ k := N + 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ M d̲o̲
      f̲o̲r̲ i := N s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ 1 d̲o̲
      b̲e̲g̲i̲n̲
         factor := A[i,k];
         f̲o̲r̲ j := i + 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
         factor := factor − A[i,j]×A[j,k];
         A[i,k] := factor/A[i,i]
      e̲n̲d̲ solving;
      i̲f̲ M ≠ N t̲h̲e̲n̲
      f̲o̲r̲ i := N − 1 s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ 1 d̲o̲
      b̲e̲g̲i̲n̲
         i1 := p[i];
         i̲f̲ i1 ≠ i t̲h̲e̲n̲
         f̲o̲r̲ k := N + 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ M d̲o̲
         b̲e̲g̲i̲n̲
            factor := A[i,k];
            A[i,k] := A[i1,k];
            A[i1,k] := factor
         e̲n̲d̲ for k
      e̲n̲d̲ for i and solution interchange;
EX:e̲n̲d̲ LEQ1;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ RANDOM;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ new,mod;
      mod := 2796203;
      new := 125×oldrand;
      oldrand := new − mod×entier(new/mod);
      RANDOM := oldrand/mod−0.5
   e̲n̲d̲ RANDOM;
   i̲n̲t̲e̲g̲e̲r̲ oldrand,N;
   r̲e̲a̲l̲ time,maxerror;

   select(17);
   oldrand:=100001;
   writecr;
   writetext(«N: »);
   N:=60;
   writeinteger(«p»,N);
   b̲e̲g̲i̲n̲
      a̲r̲r̲a̲y̲ A[1:N,1:N+1];
      i̲n̲t̲e̲g̲e̲r̲ i,j;
      r̲e̲a̲l̲ sum;
      f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
      b̲e̲g̲i̲n̲
         sum:=0;
         f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
         b̲e̲g̲i̲n̲
            A[i,j]:=RANDOM;
            sum:=sum+A[i,j]
         e̲n̲d̲;
         A[i,N+1]:=sum
      e̲n̲d̲;
      writecr;
      clock count;
      i̲f̲ LEQ1(N, 1, A, 1@−12)=1 t̲h̲e̲n̲
      writetext(«Error.»);
      time:=clock count;
      write(«ddddd.ddd»,time);
      writecr;
      maxerror:=0;
      f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
      b̲e̲g̲i̲n̲
         sum:=abs(A[i,N+1]−1);
         i̲f̲ sum>maxerror t̲h̲e̲n̲ maxerror:=sum
      e̲n̲d̲ f̲o̲r̲;
      write(«d.ddddd@−dd»,maxerror)
   e̲n̲d̲ inner block
e̲n̲d̲
t<
