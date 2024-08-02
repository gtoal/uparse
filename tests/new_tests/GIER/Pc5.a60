

algol<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   https://projecteuler.net/problem=61

   Answer:  28684
   Time:    8030.38s = 2h 13m 50.38s
   Time:        Classic:        7893.65s
   Time:        Turbo:          6974.42s

   No buffer, no index check:

   Time classic:        7938.42
   Time turbo:          7036.65 11.4pct

   Buffer, no index check:

   Time classic:        6655.42
   Time turbo:          6091.44 8.5pct

   No buffer, index check:

   Time classic:        7893.65
   Time turbo:          7045.71 10.7pct

   Buffer, index check:

   Time classic:        8032.21
   Time turbo:          7153.58 10.9pct

   PERM code taken from APL/360 ADVANCEDEX PERM function.

   ;
   r̲e̲a̲l̲ clock;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ triangle(n);
   v̲a̲l̲u̲e̲ n;
   i̲n̲t̲e̲g̲e̲r̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ n2;
      n2:=−0.5+sqrt(0.25+2×n);
      triangle:=i̲f̲ (n2×(n2+1)÷2)=n t̲h̲e̲n̲ n2 e̲l̲s̲e̲ 0
   e̲n̲d̲;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ square(n);
   v̲a̲l̲u̲e̲ n;
   i̲n̲t̲e̲g̲e̲r̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ n2;
      n2:=sqrt(n);
      square := i̲f̲ n2×n2=n t̲h̲e̲n̲ n2 e̲l̲s̲e̲ 0
   e̲n̲d̲ square;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ pentagonal(n);
   v̲a̲l̲u̲e̲ n;
   i̲n̲t̲e̲g̲e̲r̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ n2;
      n2:=(0.5+sqrt(0.25+6×n))/3;
      pentagonal:=i̲f̲ (n2×(3×n2−1)÷2)=n t̲h̲e̲n̲ n2 e̲l̲s̲e̲ 0
   e̲n̲d̲;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ hexagonal(n);
   v̲a̲l̲u̲e̲ n;
   i̲n̲t̲e̲g̲e̲r̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ n2;
      n2 := (1+sqrt(1+8×n))/4;
      hexagonal := i̲f̲ n2×(2×n2−1)=n t̲h̲e̲n̲ n2 e̲l̲s̲e̲ 0
   e̲n̲d̲ hexagonal;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ heptagonal(n);
   v̲a̲l̲u̲e̲ n;
   i̲n̲t̲e̲g̲e̲r̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ n2;
      n2 := (1.5+sqrt(2.25+10×n))/5;
      heptagonal := i̲f̲ n2×(5×n2−3)÷2=n t̲h̲e̲n̲ n2 e̲l̲s̲e̲ 0
   e̲n̲d̲ heptagonal;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ octagonal(n);
   v̲a̲l̲u̲e̲ n;
   i̲n̲t̲e̲g̲e̲r̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ n2;
      n2 := (2+sqrt(4+12×n))/6;
      octagonal := i̲f̲ n2×(3×n2−2)=n t̲h̲e̲n̲ n2 e̲l̲s̲e̲ 0
   e̲n̲d̲ octagonal;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ PERM(Z,a,b);
   v̲a̲l̲u̲e̲ a,b;
   i̲n̲t̲e̲g̲e̲r̲ a,b;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ Z;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ i,j,rem;
      rem:=b−1;
      f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ a d̲o̲
      b̲e̲g̲i̲n̲
         Z[a−i+1]:=1+rem m̲o̲d̲ i;
         rem:=rem÷i
      e̲n̲d̲;
      f̲o̲r̲ i:=a−1 s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ 1 d̲o̲
      f̲o̲r̲ j:=i+1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ a d̲o̲
      i̲f̲ Z[i]≤Z[j] t̲h̲e̲n̲ Z[j]:=Z[j]+1
   e̲n̲d̲ PERM;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ list,Z[1:6];
   i̲n̲t̲e̲g̲e̲r̲ i,j;
   i̲n̲t̲e̲g̲e̲r̲ aa,bb,cc,dd,ee,ff,
      aabb,bbcc,ccdd,ddee,eeff,ffaa;
   clock count;
   f̲o̲r̲ aa:=10 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 99 d̲o̲
   b̲e̲g̲i̲n̲
   f̲o̲r̲ bb:=10 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 99 d̲o̲
   b̲e̲g̲i̲n̲
   i̲f̲ aa=bb t̲h̲e̲n̲ g̲o̲t̲o̲ notbb;
   list[1]:=aabb:=aa×100+bb;
   i̲f̲ octagonal(aabb)=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notbb;
   f̲o̲r̲ cc:=10 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 99 d̲o̲
   b̲e̲g̲i̲n̲
   i̲f̲ aa=cc t̲h̲e̲n̲ g̲o̲t̲o̲ notcc;
   i̲f̲ bb=cc t̲h̲e̲n̲ g̲o̲t̲o̲ notcc;
   list[2]:=bbcc:=bb×100+cc;
   i̲f̲ heptagonal(bbcc)=0 ∧
         hexagonal(bbcc)=0 ∧
         pentagonal(bbcc)=0 ∧
         square(bbcc)=0 ∧
         triangle(bbcc)=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notcc;
   f̲o̲r̲ dd:=10 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 99 d̲o̲
   b̲e̲g̲i̲n̲
      i̲f̲ aa=dd t̲h̲e̲n̲ g̲o̲t̲o̲ notdd;
      i̲f̲ bb=dd t̲h̲e̲n̲ g̲o̲t̲o̲ notdd;
      i̲f̲ cc=dd t̲h̲e̲n̲ g̲o̲t̲o̲ notdd;
      list[3]:=ccdd:=cc×100+dd;
   i̲f̲ heptagonal(ccdd)=0 ∧
         hexagonal(ccdd)=0 ∧
         pentagonal(ccdd)=0 ∧
         square(ccdd)=0 ∧
         triangle(ccdd)=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notdd;
   f̲o̲r̲ ee:=10 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 99 d̲o̲
   b̲e̲g̲i̲n̲
      i̲f̲ aa=ee t̲h̲e̲n̲ g̲o̲t̲o̲ notee;
      i̲f̲ bb=ee t̲h̲e̲n̲ g̲o̲t̲o̲ notee;
      i̲f̲ cc=ee t̲h̲e̲n̲ g̲o̲t̲o̲ notee;
      i̲f̲ dd=ee t̲h̲e̲n̲ g̲o̲t̲o̲ notee;
      list[4]:=ddee:=dd×100+ee;
   i̲f̲ heptagonal(ddee)=0 ∧
         hexagonal(ddee)=0 ∧
         pentagonal(ddee)=0 ∧
         square(ddee)=0 ∧
         triangle(ddee)=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notee;
   f̲o̲r̲ ff:=10 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 99 d̲o̲
   b̲e̲g̲i̲n̲
      i̲f̲ aa=ff t̲h̲e̲n̲ g̲o̲t̲o̲ notff;
      i̲f̲ bb=ff t̲h̲e̲n̲ g̲o̲t̲o̲ notff;
      i̲f̲ cc=ff t̲h̲e̲n̲ g̲o̲t̲o̲ notff;
      i̲f̲ dd=ff t̲h̲e̲n̲ g̲o̲t̲o̲ notff;
      i̲f̲ ee=ff t̲h̲e̲n̲ g̲o̲t̲o̲ notff;
      list[5]:=eeff:=ee×100+ff;
   i̲f̲ heptagonal(eeff)=0 ∧
         hexagonal(eeff)=0 ∧
         pentagonal(eeff)=0 ∧
         square(eeff)=0 ∧
         triangle(eeff)=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notff;
      list[6]:=ffaa:=ff×100+aa;
   i̲f̲ heptagonal(ffaa)=0 ∧
         hexagonal(ffaa)=0 ∧
         pentagonal(ffaa)=0 ∧
         square(ffaa)=0 ∧
         triangle(ffaa)=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notff;
         f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 720 d̲o̲
         b̲e̲g̲i̲n̲
   PERM(Z,6,i);
         i̲f̲ triangle(list[Z[1]])=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notperm;
         i̲f̲ square(list[Z[2]])=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notperm;
         i̲f̲ pentagonal(list[Z[3]])=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notperm;
         i̲f̲ hexagonal(list[Z[4]])=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notperm;
         i̲f̲ heptagonal(list[Z[5]])=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notperm;
         i̲f̲ octagonal(list[Z[6]])=0 t̲h̲e̲n̲ g̲o̲t̲o̲ notperm;
         writecr;
         write(«dddddd»,aabb,bbcc,ccdd,ddee,eeff,ffaa,
                          aabb+bbcc+ccdd+ddee+eeff+ffaa);
notperm: e̲n̲d̲ for i;
notff: e̲n̲d̲ ff;
notee: e̲n̲d̲ ee;
notdd: e̲n̲d̲ dd;
notcc: e̲n̲d̲ cc;
notbb: e̲n̲d̲ bb;
 e̲n̲d̲ aa;
   clock:=clock count;
   writecr;
   write(«dddddddd.dd»,clock)
e̲n̲d̲;
t<
