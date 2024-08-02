

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   GC84BA2

   Time: 9583.05s

   No buffer GIER:

   Time classic:        9439.92
   Time turbo:          8811.91 6.7pct

   Buffer GIER:

   Time classic:        9583.25
   Time turbo:          8912.39 7.0pct

   ;
   i̲n̲t̲e̲g̲e̲r̲ alen,alen1,cipher len;
   i̲n̲t̲e̲g̲e̲r̲ initial shift,shift,plugchar1,plugchar2;
   i̲n̲t̲e̲g̲e̲r̲ i,c1,c2,c3,c4,c5,c6;
   b̲o̲o̲l̲e̲a̲n̲ found;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   select(32);
   clock count;
   alen:=read integer;
   alen1:=alen−1;
   cipher len:=read integer;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ alphabet,rotor,delta1,delta2,reflector[0:alen1];
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ reverse alphabet[0:63];
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ cipher,clear[1:cipher len];
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ read alphabet;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,c;
         i:=0;
again:
         c:=lyn;
         i̲f̲ c=60 ∨ c=58 t̲h̲e̲n̲ g̲o̲t̲o̲ again;
         i̲f̲ c=64 t̲h̲e̲n̲ g̲o̲t̲o̲ exit;
         alphabet[i]:=c;
         reverse alphabet[c]:=i;
         i:=i+1;
         g̲o̲t̲o̲ again;
exit:
      e̲n̲d̲ read alphabet;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ read rotor;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,j,c,c2;
         i:=0;
again:
         c:=lyn;
         i̲f̲ c=60 ∨ c=58 t̲h̲e̲n̲ g̲o̲t̲o̲ again;
         i̲f̲ c=64 t̲h̲e̲n̲ g̲o̲t̲o̲ exit;
         c2:=reverse alphabet[c];
         rotor[i]:=c2;
         i:=i+1;
         g̲o̲t̲o̲ again;
exit:
         f̲o̲r̲ j:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ alen1 d̲o̲
         b̲e̲g̲i̲n̲
            i:=rotor[j];
            delta1[j]:=(i−j+alen)m̲o̲d̲ alen;
            delta2[i]:=(j−i+alen)m̲o̲d̲ alen
         e̲n̲d̲ delta
      e̲n̲d̲ read rotor;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ read reflector;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,c,c2;
         i:=0;
again:
         c:=lyn;
         i̲f̲ c=60 ∨ c=58 t̲h̲e̲n̲ g̲o̲t̲o̲ again;
         i̲f̲ c=64 t̲h̲e̲n̲ g̲o̲t̲o̲ exit;
         c2:=reverse alphabet[c];
         reflector[i]:=c2;
         i:=i+1;
         g̲o̲t̲o̲ again;
exit:
      e̲n̲d̲ read reflector;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ read cipher;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,c,c2;
         i:=0;
again:
         c:=lyn;
         i̲f̲ c=60 ∨ c=58 t̲h̲e̲n̲ g̲o̲t̲o̲ again;
         i̲f̲ c=64 t̲h̲e̲n̲ g̲o̲t̲o̲ exit;
         c2:=reverse alphabet[c];
         i:=i+1;
         cipher[i]:=c2;
         g̲o̲t̲o̲ again;
exit:
      e̲n̲d̲ read cipher;
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ plugboard(c1);
      v̲a̲l̲u̲e̲ c1;
      i̲n̲t̲e̲g̲e̲r̲ c1;
      plugboard := i̲f̲ c1=plugchar1 t̲h̲e̲n̲ plugchar2 e̲l̲s̲e̲
         i̲f̲ c1=plugchar2 t̲h̲e̲n̲ plugchar1 e̲l̲s̲e̲ c1;
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ replace delta(c1,delta);
      v̲a̲l̲u̲e̲ c1;
      i̲n̲t̲e̲g̲e̲r̲ c1;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ delta;
      replace delta:=(c1+delta[(c1−shift+1000×alen)m̲o̲d̲ alen])m̲o̲d̲ alen;
      read alphabet;
      read rotor;
      read reflector;
      read cipher;
      f̲o̲r̲ initial shift:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 3 d̲o̲
      f̲o̲r̲ plugchar1:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ alen1 d̲o̲
      f̲o̲r̲ plugchar2:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ alen1 d̲o̲
      b̲e̲g̲i̲n̲
         shift:=initial shift;
         f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ cipher len d̲o̲
         b̲e̲g̲i̲n̲
            c1:=cipher[i];
            c2:=plugboard(c1);
            shift:=shift+1;
            c3:=replace delta(c2,delta1);
            c4:=reflector[c3];
            c5:=replace delta(c4,delta2);
            c6:=plugboard(c5);
            clear[i]:=c6
         e̲n̲d̲ cipher len;
         found:=f̲a̲l̲s̲e̲;
         f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ cipher len−2 d̲o̲
         b̲e̲g̲i̲n̲
            c̲o̲m̲m̲e̲n̲t̲
                Look for FEM:

                012345678901234567890123456789
                ABCDEFGHIJKLMNOPQRSTUVXYZÆØÅ
                ;
            i̲f̲ clear[i]=5 ∧
               clear[i+1]=4 ∧
               clear[i+2]=12 t̲h̲e̲n̲ found:=t̲r̲u̲e̲
         e̲n̲d̲;
         i̲f̲ found t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            writecr;
            write(«ddd»,initial shift,plugchar1,plugchar2);
            writetext(«  »);
            writechar(60);
            f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ cipher len d̲o̲
            writechar(alphabet[clear[i]]);
            writechar(58)
         e̲n̲d̲
      e̲n̲d̲ for plugchar2 plugchar1 initial shift
   e̲n̲d̲ inner loop;
   writecr;
   writetext(«Time: »);
   write(«ddddddd.dd»,clock count)
e̲n̲d̲;
run<
28
76
ABCDEFGHIJKLMNOPQRSTUVXYZÆØÅ
DBPEMGZALRNKØYTJXÆOÅFUHCQVSI
OHVFMDXBÅNSTEJAUZØKLPCGÆQYRI
ÅLNPSGÅJDRØMYUHÅBXUUOUKVQGLTBÅJVXZISFTØZFHAIELDFLÅKHÅDHIYZZÅXZISFTØVPPVVIQGD
