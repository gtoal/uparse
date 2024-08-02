

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

        GC7J6KQ

   Time buffer:     2427.59s = 40m 27.59s
   Time nonbuffer:  2403.38s = 40m 03.38s

   No buffer:

   Time classic:        2402.93
   Time turbo:          2295.14 4.5pct

   Buffer:

   Time classic:        2427.87
   Time turbo:          2274.49 6.3pct

   ;
   c̲o̲m̲m̲e̲n̲t̲ PERM code taken from APL/360 ADVANCEDEX PERM function;
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
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ ord(s);
   s̲t̲r̲i̲n̲g̲ s;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ c1,c2,c3;
      b̲o̲o̲l̲e̲a̲n̲ b;
      b:=b̲o̲o̲l̲e̲a̲n̲ s;
      c1 := i̲n̲t̲e̲g̲e̲r̲ (b∧4̲0̲ 63);
      c2 := i̲n̲t̲e̲g̲e̲r̲ ((b s̲h̲i̲f̲t̲ −6)∧4̲0̲ 63);
      c3 := i̲n̲t̲e̲g̲e̲r̲ ((b s̲h̲i̲f̲t̲ −12)∧4̲0̲ 63);
      ord := i̲f̲ c1=60 t̲h̲e̲n̲ c2+128 e̲l̲s̲e̲ c1
   e̲n̲d̲;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ xor(a,b);
   v̲a̲l̲u̲e̲ a,b;
   i̲n̲t̲e̲g̲e̲r̲ a,b;
   xor:=i̲n̲t̲e̲g̲e̲r̲ (¬((b̲o̲o̲l̲e̲a̲n̲ a) ≡ (b̲o̲o̲l̲e̲a̲n̲ b)));
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ fetch char(A,offset);
   v̲a̲l̲u̲e̲ offset;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
   i̲n̲t̲e̲g̲e̲r̲ offset;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ i,j;
      i:=i̲n̲t̲e̲g̲e̲r̲ (((b̲o̲o̲l̲e̲a̲n̲ offset)s̲h̲i̲f̲t̲ −3)∧3̲ 0 3̲7̲ m);
      j:=(i̲n̲t̲e̲g̲e̲r̲((b̲o̲o̲l̲e̲a̲n̲ offset)∧3̲7̲ 0 3̲ m))×5;
      fetch char := i̲n̲t̲e̲g̲e̲r̲ (((b̲o̲o̲l̲e̲a̲n̲ A[i])s̲h̲i̲f̲t̲ −j)
            ∧ 3̲5̲ 0 5̲ m)
   e̲n̲d̲ fetch char;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ WRITE CHAR(c);
   v̲a̲l̲u̲e̲ c;
   i̲n̲t̲e̲g̲e̲r̲ c;
   b̲e̲g̲i̲n̲
      i̲f̲ ¬((c>127) ≡ (case>127)) t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         case:=128−case;
         writechar(58+case÷64)
      e̲n̲d̲ change case;
      writechar(c m̲o̲d̲ 128)
   e̲n̲d̲ WRITECHAR;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ cipher[0:285];
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ lookfor[0:2];
   i̲n̲t̲e̲g̲e̲r̲ cipherlen,lookforlen;
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ baudot[0:31];
   i̲n̲t̲e̲g̲e̲r̲ case,iperm;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   select(32);
   clock count;
   baudot[0]:=ord(«/»);
   baudot[0]:=ord(«2»);
   baudot[1]:=ord(«T»);
   baudot[2]:=ord(«3»);
   baudot[3]:=ord(«O»);
   baudot[4]:=ord(«9»);
   baudot[5]:=ord(«H»);
   baudot[6]:=ord(«N»);
   baudot[7]:=ord(«M»);
   baudot[8]:=ord(«4»);
   baudot[9]:=ord(«L»);
   baudot[10]:=ord(«R»);
   baudot[11]:=ord(«G»);
   baudot[12]:=ord(«I»);
   baudot[13]:=ord(«P»);
   baudot[14]:=ord(«C»);
   baudot[15]:=ord(«V»);
   baudot[16]:=ord(«E»);
   baudot[17]:=ord(«Z»);
   baudot[18]:=ord(«D»);
   baudot[19]:=ord(«B»);
   baudot[20]:=ord(«S»);
   baudot[21]:=ord(«Y»);
   baudot[22]:=ord(«F»);
   baudot[23]:=ord(«X»);
   baudot[24]:=ord(«A»);
   baudot[25]:=ord(«W»);
   baudot[26]:=ord(«J»);
   baudot[27]:=ord(«+»);
   baudot[27]:=ord(«5»);
   baudot[28]:=ord(«U»);
   baudot[29]:=ord(«Q»);
   baudot[30]:=ord(«K»);
   baudot[31]:=ord(«8»);
   b̲e̲g̲i̲n̲ c̲o̲m̲m̲e̲n̲t̲ read baudot;
      i̲n̲t̲e̲g̲e̲r̲ i;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ revbaudot[0:255];
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ LYN;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ c;
   again:c:=lyn;
         i̲f̲ c=58 ∨ c=60 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            case:=(c−58)×64;
            g̲o̲t̲o̲ again
         e̲n̲d̲;
         LYN:=c+case
      e̲n̲d̲ LYN;
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ read baudot(A);
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ A;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ len,c,i,j;
         len:=0;
again:   c:=LYN;
         i̲f̲ c=64 ∨ c=192 t̲h̲e̲n̲ g̲o̲t̲o̲ out;
         i:=len÷8;
         j:=(len m̲o̲d̲ 8)×5;
         c:=revbaudot[c];
         i̲f̲ c=−1 t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            writecr;
            writetext(«BAD»);
            write(«ddddd»,len);
            g̲o̲t̲o̲ exit
         e̲n̲d̲;
         A[i]:=i̲n̲t̲e̲g̲e̲r̲ (((((b̲o̲o̲l̲e̲a̲n̲ A[i]) s̲h̲i̲f̲t̲ −j)
               ∧ 3̲5̲ m 5̲ 0)
               ∨ b̲o̲o̲l̲e̲a̲n̲ c) s̲h̲i̲f̲t̲ j);
         len:=len+1;
         g̲o̲t̲o̲ again;
out:     read baudot:=len;
         writecr;
         writetext(«Read: »);
         writeinteger(«p»,len);
      e̲n̲d̲;
      f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 255 d̲o̲ revbaudot[i]:=−1;
      f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 31 d̲o̲ revbaudot[baudot[i]]:=i;
      case:=0;
      LYN;
      cipherlen:=read baudot(cipher);
      lookforlen:=read baudot(lookfor)
   e̲n̲d̲;
   f̲o̲r̲ iperm:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 24 d̲o̲
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ wheellen[1:5],perm[1:4];
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ wheel1,wheel2,wheel3,wheel4,wheel5[0:12];
      i̲n̲t̲e̲g̲e̲r̲ offset,i;
      b̲o̲o̲l̲e̲a̲n̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ genwheel(offset,bit,wheel);
      v̲a̲l̲u̲e̲ offset,bit;
      i̲n̲t̲e̲g̲e̲r̲ offset,bit;
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ wheel;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,j,k,c1,c2,b,len;
         b̲o̲o̲l̲e̲a̲n̲ c3,mask;
         genwheel:=f̲a̲l̲s̲e̲;
         mask:=4̲0̲ 1 s̲h̲i̲f̲t̲ (5−bit);
         len:=wheellen[bit];
         k:=offset m̲o̲d̲ len;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ lookforlen−1 d̲o̲
         b̲e̲g̲i̲n̲
            j:=i+offset;
            c1:=fetch char(cipher,j);
            c2:=fetch char(lookfor,i);
            c3:=b̲o̲o̲l̲e̲a̲n̲ xor(c1,c2);
            b:=i̲n̲t̲e̲g̲e̲r̲ ((c3 ∧ mask)s̲h̲i̲f̲t̲ (bit−5));
            i̲f̲ wheel[k]=−1 t̲h̲e̲n̲
               wheel[k] := b
            e̲l̲s̲e̲
               i̲f̲ wheel[k] ≠ b t̲h̲e̲n̲ g̲o̲t̲o̲ bad;
            k:=k+1;
            i̲f̲ k=len t̲h̲e̲n̲ k:=0
         e̲n̲d̲;
         genwheel:=t̲r̲u̲e̲;
bad:
      e̲n̲d̲ genwheel;
      i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ getwheel(offset);
      v̲a̲l̲u̲e̲ offset;
      i̲n̲t̲e̲g̲e̲r̲ offset;
      getwheel:=
         wheel1[offset m̲o̲d̲ wheellen[1]]×16 +
         wheel2[offset m̲o̲d̲ wheellen[2]]× 8 +
         wheel3[offset m̲o̲d̲ wheellen[3]]× 4 +
         wheel4[offset m̲o̲d̲ wheellen[4]]× 2 +
         wheel5[offset m̲o̲d̲ wheellen[5]];
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ printclear;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,c1,c2,c3,ding,pos,c,clast;
         clast:=−1;
         writecr;
         pos:=0;
         ding:=60;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ cipherlen−1 d̲o̲
         b̲e̲g̲i̲n̲
            c1:=fetch char(cipher,i);
            c2:=getwheel(i);
            c3:=xor(c1,c2);
            c:=baudot[c3];
            i̲f̲ clast=−1 t̲h̲e̲n̲ clast:=c
            e̲l̲s̲e̲
            b̲e̲g̲i̲n̲
               i̲f̲ clast≠9 t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  WRITE CHAR(clast);
                  pos:=pos+1;
                  clast:=c
               e̲n̲d̲
               e̲l̲s̲e̲
               b̲e̲g̲i̲n̲
                  i̲f̲ c=9 t̲h̲e̲n̲
                  b̲e̲g̲i̲n̲
                     i̲f̲ pos>ding t̲h̲e̲n̲
                     b̲e̲g̲i̲n̲
                        writecr;
                        pos:=0
                     e̲n̲d̲ CR
                     e̲l̲s̲e̲
                     b̲e̲g̲i̲n̲
                        writechar(0);
                        pos:=pos+1
                     e̲n̲d̲ space;
                     clast:=−1
                  e̲n̲d̲
                  e̲l̲s̲e̲
                  b̲e̲g̲i̲n̲
                     WRITE CHAR(clast);
                     pos:=pos+1;
                     clast:=c
                  e̲n̲d̲
               e̲n̲d̲
            e̲n̲d̲
         e̲n̲d̲ for i;
         i̲f̲ clast≠−1 t̲h̲e̲n̲ WRITE CHAR(clast)
      e̲n̲d̲ printclear;
      PERM(perm,4,iperm);
      wheellen[1]:=3;
      f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
      wheellen[i+1]:=c̲a̲s̲e̲ perm[i] o̲f̲ (5,7,11,13);
      writecr;
      f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 5 d̲o̲
      writeinteger(«ddd»,wheellen[i]);
      f̲o̲r̲ offset:=cipherlen−lookforlen s̲t̲e̲p̲ −1 u̲n̲t̲i̲l̲ 0 d̲o̲
      b̲e̲g̲i̲n̲
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 12 d̲o̲
         wheel1[i]:=wheel2[i]:=wheel3[i]:=wheel4[i]:=wheel5[i]:=−1;
         i̲f̲ genwheel(offset,1,wheel1) t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            i̲f̲ genwheel(offset,2,wheel2) t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               i̲f̲ genwheel(offset,3,wheel3) t̲h̲e̲n̲
               b̲e̲g̲i̲n̲
                  i̲f̲ genwheel(offset,4,wheel4) t̲h̲e̲n̲
                  b̲e̲g̲i̲n̲
                     i̲f̲ genwheel(offset,5,wheel5) t̲h̲e̲n̲
                     b̲e̲g̲i̲n̲
                        writecr;
                        writechar(58);
                        case:=0;
                        write(«ddddd»,wheellen[1],wheellen[2],wheellen[3],wheellen[4]
                        writetext(«  »);
                        printclear;
                        writechar(58);
                        g̲o̲t̲o̲ done
                     e̲n̲d̲ found5
                  e̲n̲d̲ found4
               e̲n̲d̲ found3
            e̲n̲d̲ found2
         e̲n̲d̲ found1
      e̲n̲d̲ offset;
   e̲n̲d̲ inner loop;
done:
   writecr;
   writetext(«Time: »);
   write(«ddddddd.dd»,clock count);
   writecr;
exit:
e̲n̲d̲;
run<
ANBQVWYFLAK2PJ48N5EU3EGGXVSACBGNZ54RSVW5RM5OFSM4R2W3LL5U95PCZDRUEUBPV2TYKG28WJXRPGCUJ
NORTH99FIFTYFIVE99FORTY
