

algol,n̲<
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   Sudoku program

   Time1: 5269.1s = 1h 27m 49.1s
   Time4: 6551.3s = 1h 49m 11.3s
   Time4: 4188.7s = 1h 9m 48.7s
   Time5: 5245.2s = 1h 27m 25.2s
   Time6: 17130.0s = 4h 45m 30.0s
   Time6: 123...: 70029.5s = 19h 27m 9.5s
   Time6: 987...: 9803.0s = 2h 43m 23.0s
   Time6: 12651.3s = 3h 30m 51.3s
   Time6: 12142.5s = 3h 22m 22.5s
   Time7: 3388.7s = 56m 28.7s

   No buffer:

   Time classic:        24794.2
   Time turbo:          24784.9 0.04pct
   Tracks transferred:  972876

   Buffer:

   Time classic:        3407.5
   Time turbo:          3097.7 9.1pct
   Tracks transferred:  6255

   ;

   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ board,rows,cols,submatrices[1:81],stack[0:161];
   i̲n̲t̲e̲g̲e̲r̲ n,i,j,k,l,s,p,digit,row1,col1,mat1,best n,best p;
   b̲o̲o̲l̲e̲a̲n̲ m,best m,mask;
   b̲o̲o̲l̲e̲a̲n̲ a̲r̲r̲a̲y̲ possible[1:81];
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ print;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ i,j;
      writecr;
      writetext(«Clock: »);
      write(«−ddddddddd.d», clock count);
      writecr;
      f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 9 d̲o̲
      b̲e̲g̲i̲n̲
         f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 9 d̲o̲
         writeinteger(«dd», board[(i−1)×9+j]);
         writecr
      e̲n̲d̲
   e̲n̲d̲ print;
   p̲r̲o̲c̲e̲d̲u̲r̲e̲ nprint(n);
   v̲a̲l̲u̲e̲ n;
   b̲o̲o̲l̲e̲a̲n̲ n;
   b̲e̲g̲i̲n̲
      i̲n̲t̲e̲g̲e̲r̲ i;
      writecr;
      f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 39 d̲o̲
      b̲e̲g̲i̲n̲
         writechar(i̲f̲ n s̲h̲i̲f̲t̲ i t̲h̲e̲n̲ 1 e̲l̲s̲e̲ 16);
         i̲f̲ i m̲o̲d̲ 10=9 t̲h̲e̲n̲ writechar(0)
      e̲n̲d̲ i
   e̲n̲d̲ nprint;
   i̲n̲t̲e̲g̲e̲r̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ nbits(n);
   v̲a̲l̲u̲e̲ n;
   b̲o̲o̲l̲e̲a̲n̲ n;
   b̲e̲g̲i̲n̲
      n:=n s̲h̲i̲f̲t̲ −30;
      n:=b̲o̲o̲l̲e̲a̲n̲((i̲n̲t̲e̲g̲e̲r̲(n ∧ 2̲4̲04̲54̲54̲54̲5)) + (i̲n̲t̲e̲g̲e̲r̲((n s̲h̲i̲f̲t̲ −1) ∧ 2̲4̲04̲54̲54̲54̲5)));
      n:=b̲o̲o̲l̲e̲a̲n̲((i̲n̲t̲e̲g̲e̲r̲(n ∧ 2̲4̲04̲34̲34̲34̲3)) + (i̲n̲t̲e̲g̲e̲r̲((n s̲h̲i̲f̲t̲ −2) ∧ 2̲4̲04̲34̲34̲34̲3)));
      n:=b̲o̲o̲l̲e̲a̲n̲((i̲n̲t̲e̲g̲e̲r̲(n ∧ 2̲4̲04̲04̲m4̲04̲m)) + (i̲n̲t̲e̲g̲e̲r̲((n s̲h̲i̲f̲t̲ −4) ∧ 2̲4̲04̲04̲m4̲04̲m)));
      nbits:=(i̲n̲t̲e̲g̲e̲r̲(n ∧ 2̲4̲04̲04̲04̲m4̲m)) + (i̲n̲t̲e̲g̲e̲r̲((n s̲h̲i̲f̲t̲ −8) ∧ 2̲4̲04̲04̲04̲m4̲m));
   e̲n̲d̲ nbits;

   select(16);

   n:=0;
   readgeneral(board,3̲ 0 7̲ 27 3̲ 2 7̲ 64 3̲ 1 7̲ 5 3̲ 3 7̲ 0,n);

   f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 9 d̲o̲
   b̲e̲g̲i̲n̲
      f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 9 d̲o̲
      b̲e̲g̲i̲n̲
         rows[(i−1)×9+j] := (i−1)×9+1;
         cols[(i−1)×9+j] := j
      e̲n̲d̲ j
   e̲n̲d̲ i;
   f̲o̲r̲ i:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 3 d̲o̲
   f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 3 d̲o̲
   f̲o̲r̲ k:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 3 d̲o̲
   f̲o̲r̲ l:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 3 d̲o̲
   submatrices[(i−1)×27+(j−1)×3+(k−1)×9+l] := (i−1)×27+(j−1)×3+1;

   clock count;

   print;
   s:=0;
   p:=1;
a1:
a2:
   best p:=0;
   best n:=10;
   best m:=4̲0̲0;
   f̲o̲r̲ p:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 81 d̲o̲
   i̲f̲ board[p]=0 t̲h̲e̲n̲
   b̲e̲g̲i̲n̲
      m:=1̲ 0 9̲ m 3̲0̲ 0;
      row1:=rows[p];
      col1:=cols[p];
      mat1 := submatrices[p];
      mask:=1̲ 0 3̲9̲ m;
      i:= board[row1   ]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 1]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 2]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 3]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 4]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 5]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 6]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 7]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[row1+ 8]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1   ]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+ 9]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+18]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+27]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+36]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+45]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+54]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+63]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[col1+72]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1   ]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+ 1]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+ 2]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+ 9]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+10]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+11]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+18]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+19]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      i:= board[mat1+20]; i̲f̲ i≠0 t̲h̲e̲n̲ m:=m∧(mask s̲h̲i̲f̲t̲ −i);
      n:=nbits(m);
      possible[p]:=m;
      i̲f̲ n<best n t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         best n:=n;
         best p:=p;
         best m:=m
      e̲n̲d̲ better
   e̲n̲d̲ p free
   e̲l̲s̲e̲
   possible[p]:=4̲0̲ 0;
   i̲f̲ best n=10 t̲h̲e̲n̲ g̲o̲t̲o̲ FOUND;
   i̲f̲ best n=0 t̲h̲e̲n̲
   b̲e̲g̲i̲n̲
      s:=s−2;
      i̲f̲ s<0 t̲h̲e̲n̲ g̲o̲t̲o̲ BAD;
      board[stack[s]]:=0;
      g̲o̲t̲o̲ a3
   e̲n̲d̲ dead end;
   i̲f̲ best n>1 t̲h̲e̲n̲
   b̲e̲g̲i̲n̲
      f̲o̲r̲ p:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 81 d̲o̲
      i̲f̲ board[p]=0 t̲h̲e̲n̲
      b̲e̲g̲i̲n̲
         m:=possible[p];
         f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 9 d̲o̲
         i̲f̲ m s̲h̲i̲f̲t̲ j t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            row1:=rows[p];
            col1:=cols[p];
            mat1 := submatrices[p];
            k:=0;
            i̲f̲ possible[row1   ] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 1] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 2] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 3] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 4] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 5] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 6] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 7] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[row1+ 8] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ k=1 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               best p:=p;
               best m:=1̲ 1 3̲9̲ 0 s̲h̲i̲f̲t̲ −j;
               g̲o̲t̲o̲ better
            e̲n̲d̲ only in row;
            k:=0;
            i̲f̲ possible[col1   ] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+ 9] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+18] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+27] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+36] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+45] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+54] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+63] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[col1+72] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ k=1 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               best p:=p;
               best m:=1̲ 1 3̲9̲ 0 s̲h̲i̲f̲t̲ −j;
               g̲o̲t̲o̲ better
            e̲n̲d̲ only in col;
            k:=0;
            i̲f̲ possible[mat1   ] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+ 1] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+ 2] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+ 9] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+10] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+11] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+18] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+19] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ possible[mat1+20] s̲h̲i̲f̲t̲ j t̲h̲e̲n̲ k:=k+1;
            i̲f̲ k=1 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               best p:=p;
               best m:=1̲ 1 3̲9̲ 0 s̲h̲i̲f̲t̲ −j;
               g̲o̲t̲o̲ better
            e̲n̲d̲ only in submatrix
         e̲n̲d̲ j;
      e̲n̲d̲ p;
better:
   e̲n̲d̲;
   stack[s]:=best p;
   stack[s+1]:=i̲n̲t̲e̲g̲e̲r̲ best m;
a3:
   p:=stack[s];
   m:=b̲o̲o̲l̲e̲a̲n̲ stack[s+1];
   i̲f̲ (i̲n̲t̲e̲g̲e̲r̲ m)=0 t̲h̲e̲n̲
   b̲e̲g̲i̲n̲
      s:=s−2;
      i̲f̲ s<0 t̲h̲e̲n̲ g̲o̲t̲o̲ BAD;
      board[stack[s]]:=0;
      g̲o̲t̲o̲ a3
   e̲n̲d̲;
a4:
   f̲o̲r̲ digit:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 9 d̲o̲
   i̲f̲ m s̲h̲i̲f̲t̲ digit t̲h̲e̲n̲ g̲o̲t̲o̲ found digit;
found digit:
   m:=m∧(1̲ 0 3̲9̲ m s̲h̲i̲f̲t̲ −digit);
   board[p]:=digit;
   stack[s+1]:=i̲n̲t̲e̲g̲e̲r̲ m;
   s:=s+2;
   g̲o̲t̲o̲ a1;

FOUND:
   writecr;
   writetext(«Finished clock: »);
   write(«−ddddddddd.d», clock count);
   writecr;
   writetext(«Tracks transferred: »);
   writeinteger(«p»,tracks transferred);
   print;
   g̲o̲t̲o̲ skip;
BAD:
   writecr;
   writetext(«Stack underflow»);
skip:

e̲n̲d̲
t<
8,0,0,0,0,0,0,0,0,
0,0,3,6,0,0,0,0,0,
0,7,0,0,9,0,2,0,0,
0,5,0,0,0,7,0,0,0,
0,0,0,0,4,5,7,0,0,
0,0,0,1,0,0,0,3,0,
0,0,1,0,0,0,0,6,8,
0,0,8,5,0,0,0,1,0,
0,9,0,0,0,0,4,0,0;

0,0,0,0,0,0,0,0,0,
1,3,0,7,0,0,0,5,0,
0,4,0,0,0,0,9,0,7,
0,0,0,0,1,0,0,0,0,
0,0,0,0,0,0,0,4,2,
0,0,9,0,8,0,0,0,6,
0,0,8,0,0,0,0,0,0,
0,0,0,0,0,5,1,3,0,
6,0,0,2,0,0,0,0,0;

0,0,0,0,0,0,0,0,0,
9,7,0,3,0,0,0,5,0,
0,6,0,0,0,0,1,0,3,
0,0,0,0,9,0,0,0,0,
0,0,0,0,0,0,0,6,8,
0,0,1,0,2,0,0,0,4,
0,0,2,0,0,0,0,0,0,
0,0,0,0,0,5,9,7,0,
4,0,0,8,0,0,0,0,0;
