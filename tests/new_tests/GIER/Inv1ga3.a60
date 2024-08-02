

b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   Time, N=21: 60.49s
   ;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ INVERT2(n, a, eps, ERROR);
   v̲a̲l̲u̲e̲ n, eps;
   i̲n̲t̲e̲g̲e̲r̲ n;
   r̲e̲a̲l̲ eps;
   a̲r̲r̲a̲y̲ a;
   l̲a̲b̲e̲l̲ ERROR;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ i, j, k;
      r̲e̲a̲l̲ pivot, z;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ p, q[1:n];
      a̲r̲r̲a̲y̲ b, c[1:n];
      f̲o̲r̲ k := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
      b̲e̲g̲i̲n̲
         pivot := 0;
         f̲o̲r̲ i := k s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         f̲o̲r̲ j := k s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         i̲f̲ abs(a[i,j]) > abs(pivot) t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            pivot := a[i,j];
            p[k] := i;
            q[k] := j
         e̲n̲d̲;
         i̲f̲ abs(pivot) ≤ eps t̲h̲e̲n̲ g̲o̲_t̲o̲ ERROR;
         i̲f̲ p[k] ≠ k t̲h̲e̲n̲
         f̲o̲r̲ j := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         b̲e̲g̲i̲n̲
            z := a[p[k], j];
            a[p[k], j] := a[k,j];
            a[k,j] := z
         e̲n̲d̲ for j;
         i̲f̲ q[k] ≠ k t̲h̲e̲n̲
         f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         b̲e̲g̲i̲n̲
            z := a[i, q[k]];
            a[i, q[k]] := a[i,k];
            a[i,k] := z
         e̲n̲d̲ for i;
         f̲o̲r̲ j := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         b̲e̲g̲i̲n̲
            i̲f̲ j = k t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               b[j] := 1/pivot;
               c[j] := 1
            e̲n̲d̲
            e̲l̲s̲e̲
            b̲e̲g̲i̲n̲
               b[j] := − a[k,j]/pivot;
               c[j] := a[j,k]
            e̲n̲d̲;
            a[k,j] := a[j,k] := 0
         e̲n̲d̲ for j;
         f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         f̲o̲r̲ j := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         a[i,j] := a[i,j] + c[i]×b[j]
      e̲n̲d̲ for k;
      f̲o̲r̲ k := n s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ 1 d̲o̲
      b̲e̲g̲i̲n̲
         i̲f̲ p[k] ≠ k t̲h̲e̲n̲
         f̲o̲r̲ i := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         b̲e̲g̲i̲n̲
            z := a[i, p[k]];
            a[i, p[k]] := a[i,k];
            a[i,k] := z
         e̲n̲d̲;
         i̲f̲ q[k] ≠ k t̲h̲e̲n̲
         f̲o̲r̲ j := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
         b̲e̲g̲i̲n̲
            z := a[q[k], j];
            a[q[k], j] := a[k,j];
            a[k,j] := z
         e̲n̲d̲ j
      e̲n̲d̲ k
   e̲n̲d̲ INVERT2;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   b̲e̲g̲i̲n̲
      r̲e̲a̲l̲ clock;
      b̲o̲o̲l̲e̲a̲n̲ code;
      c̲o̲m̲m̲e̲n̲t̲
      Pack the following instruction into code:

      zl,  hr s1
      62   17
      ;
      pack(code,
            0, 41,  0,
            0,  9,  0,
           10, 19,  1,
           20, 25, 62,
           30, 35, 17,
           39, 39,  1,
           40, 40,  1);
      clock count:=gier(code)
   e̲n̲d̲;
   i̲n̲t̲e̲g̲e̲r̲ Nmin,Nmax;
   i̲n̲t̲e̲g̲e̲r̲ oldrand,N,mod,new;
   Nmin := 19;
   Nmax := 21;
   mod := 2796203;
   writecr;
   writetext(«oldrand: »);
   oldrand:=typein;
   b̲e̲g̲i̲n̲
      r̲e̲a̲l̲ time,maxerror,det;
      a̲r̲r̲a̲y̲ xy[Nmin:Nmax,1:2];

      f̲o̲r̲ N:=Nmin s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ Nmax d̲o̲
      b̲e̲g̲i̲n̲
         a̲r̲r̲a̲y̲ A[1:N,1:N];
         i̲n̲t̲e̲g̲e̲r̲ i,j;
         r̲e̲a̲l̲ sum;
         writecr;
         write(«dd»,N);
         f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
         b̲e̲g̲i̲n̲
            sum:=0;
            f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ N d̲o̲
            b̲e̲g̲i̲n̲
               new := 125×oldrand;
               oldrand := new−new÷mod×mod;
               A[i,j] := oldrand/mod−0.5;
            e̲n̲d̲ f̲o̲r̲;
         e̲n̲d̲;
         clock count;
         INVERT2(N, A, 1@−12, ERROR);
         g̲o̲t̲o̲ OK;
ERROR:   writetext(«Error.»);
OK:      xy[N,2]:=clock count;
         xy[N,1]:=N;
         write(«dddddd.dd»,xy[N,2]);
      e̲n̲d̲ for N;
      b̲e̲g̲i̲n̲
         p̲r̲o̲c̲e̲d̲u̲r̲e̲ FIT1(n, meanerror, a, b, x, y);
         v̲a̲l̲u̲e̲ n;
         i̲n̲t̲e̲g̲e̲r̲ n;
         r̲e̲a̲l̲ meanerror, a, b;
         a̲r̲r̲a̲y̲ x, y;
         b̲e̲g̲i̲n̲
            i̲n̲t̲e̲g̲e̲r̲ j;
            r̲e̲a̲l̲ SX, SX2, SY, SXY, SY2, DEN;
            SX := SX2 := SY := SXY := SY2 := 0;
            f̲o̲r̲ j := 1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ n d̲o̲
            b̲e̲g̲i̲n̲
               SX := SX + x[j];
               SX2 := SX2 + x[j]⭡2;
               SY := SY + y[j];
               SXY := SXY + x[j]×y[j];
               SY2 := SY2 + y[j]⭡2
            e̲n̲d̲;
            DEN := n×SX2 − SX⭡2;
            a := (SX2×SY−SX×SXY)/DEN;
            b := (n×SXY−SX×SY)/DEN;
            meanerror := sqrt((SY2+(2×SX×SY×SXY−n×SXY⭡2−SX2×SY⭡2)/DEN)/(n−1))
         e̲n̲d̲ of FIT−1;
         a̲r̲r̲a̲y̲ X,Y[1:Nmax−Nmin+1];
         r̲e̲a̲l̲ a,b,meanerror,x1,y1,e1,meanerror2;
         i̲n̲t̲e̲g̲e̲r̲ i;
         f̲o̲r̲ i:=Nmax−Nmin+1 s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ 1 d̲o̲
         b̲e̲g̲i̲n̲
            X[i]:=ln(xy[i+Nmin−1,1]);
            Y[i]:=ln(xy[i+Nmin−1,2])
         e̲n̲d̲;
         FIT1(Nmax−Nmin+1, meanerror, a, b, X, Y);
         writecr;
         write(«−nddddd.dddddd»,meanerror,a,b);
         writecr;
         writetext(«Time: »);
         write(«−n.ddd@−d»,exp(a));
         writetext(«×n⭡»);
         write(«n.ddd»,b);
         i̲f̲ f̲a̲l̲s̲e̲ t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            f̲o̲r̲ i:=Nmin s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ Nmax d̲o̲
            b̲e̲g̲i̲n̲
               x1 := xy[i,1];
               y1 := exp(a)×x1⭡b;
               e1 := y1−xy[i,2];
               writecr;
               write(«ndd»,x1);
               write(«−nddddd.ddd»,xy[i,2],y1,e1);
               meanerror2:=meanerror2+e1×e1
            e̲n̲d̲;
            writecr;
            write(«−nddddd.ddd»,sqrt(meanerror2/(Nmax−Nmin)))
         e̲n̲d̲
      e̲n̲d̲ fit
   e̲n̲d̲ Nmin max
e̲n̲d̲;
