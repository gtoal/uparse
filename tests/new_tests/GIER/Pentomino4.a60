

algol,n̲<
Program Pentomino
b̲e̲g̲i̲n̲
   c̲o̲m̲m̲e̲n̲t̲

   Time: 280782s = 3d 5h 59m 42s

   No buffer:

   Time classic:        428386
   Time turbo:          408163 4.7pct

   Buffer:

   Time classic:        280782
   Time turbo:          251104 10.6pct

   11 solutions
   ;
   i̲n̲t̲e̲g̲e̲r̲ BOARDX,BOARDY,BOARDX1,BOARDY1,nsolutions;
   B̲o̲o̲l̲e̲a̲n̲ a̲r̲r̲a̲y̲ transformed pieces[1:13,1:8];
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ transformedx[1:12,1:8];
   i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ ntransformed[1:12];
   B̲o̲o̲l̲e̲a̲n̲ a̲r̲r̲a̲y̲ used piece[1:12];
   i̲n̲t̲e̲g̲e̲r̲ ix,iy;
   r̲e̲a̲l̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ clock count;
   c̲o̲d̲e̲ clock count;
   1, 37;
     zl        , grf p−1   ; RF:=clock count; stack[p−1]:=RF;
   e̲;

   BOARDX := 8;
   BOARDY := 9;

   BOARDX1 := BOARDX−1;
   BOARDY1 := BOARDY−1;

   b̲e̲g̲i̲n̲
      B̲o̲o̲l̲e̲a̲n̲ a̲r̲r̲a̲y̲ board[0:BOARDY+4];
      B̲o̲o̲l̲e̲a̲n̲ a̲r̲r̲a̲y̲ mask[0:BOARDY1];
      i̲n̲t̲e̲g̲e̲r̲ a̲r̲r̲a̲y̲ solution board[0:BOARDY1,0:BOARDX1];

      p̲r̲o̲c̲e̲d̲u̲r̲e̲ move up left(itransform);
      v̲a̲l̲u̲e̲ itransform;
      i̲n̲t̲e̲g̲e̲r̲ itransform;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i;
         f̲o̲r̲ i:=i w̲h̲i̲l̲e̲ (i̲n̲t̲e̲g̲e̲r̲ (transformed pieces[13,itransform]∧
            3̲5̲ 0 5̲ m))=0 d̲o̲
         transformed pieces[13,itransform] := transformed pieces[13,itransform]
            s̲h̲i̲f̲t̲ −5;
         f̲o̲r̲ i:=i w̲h̲i̲l̲e̲ (i̲n̲t̲e̲g̲e̲r̲ (transformed pieces[13,itransform]∧
            1̲5̲ 0 5̲ 1 5̲ 1 5̲ 1 5̲ 1 5̲ 1))=0 d̲o̲
         transformed pieces[13,itransform] := transformed pieces[13,itransform]
            s̲h̲i̲f̲t̲ −1;
      e̲n̲d̲ move up left;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ rotate cw(dst, src);
      v̲a̲l̲u̲e̲ dst, src;
      i̲n̲t̲e̲g̲e̲r̲ dst, src;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,j;
         B̲o̲o̲l̲e̲a̲n̲ s;
         s := 4̲0̲ 0;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         b̲e̲g̲i̲n̲
            f̲o̲r̲ j:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
            s := s  ∨ (((transformed pieces[13,src] s̲h̲i̲f̲t̲ −j×5) ∧
               (4̲0̲ 1 s̲h̲i̲f̲t̲ i)) s̲h̲i̲f̲t̲ (4−j−i+i×5))
         e̲n̲d̲;
         transformed pieces[13,dst] := s;
         move up left(dst)
      e̲n̲d̲ rotate cw;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ mirror(dst, src);
      v̲a̲l̲u̲e̲ dst, src;
      i̲n̲t̲e̲g̲e̲r̲ dst, src;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i;
         transformed pieces[13,dst] := 4̲0̲ 0;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         transformed pieces[13,dst] := (transformed pieces[13,dst] s̲h̲i̲f̲t̲ 5)  ∨
            ((transformed pieces[13,src] s̲h̲i̲f̲t̲ −i×5) ∧ 3̲5̲ 0 5̲ m);
         move up left(dst)
      e̲n̲d̲ mirror;
      B̲o̲o̲l̲e̲a̲n̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ compare pieces(ipiece1, itransform1, ipiece2, itransform2);
      v̲a̲l̲u̲e̲ ipiece1, itransform1, ipiece2, itransform2;
      i̲n̲t̲e̲g̲e̲r̲ ipiece1, itransform1, ipiece2, itransform2;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i;
         compare pieces := (i̲n̲t̲e̲g̲e̲r̲ transformed pieces[ipiece1,itransform1]) =
            (i̲n̲t̲e̲g̲e̲r̲ transformed pieces[ipiece2,itransform2]);
      e̲n̲d̲ compare pieces;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ copy piece(dstpiece, dsttransform, srcpiece, srctransform);
      v̲a̲l̲u̲e̲ dstpiece, dsttransform, srcpiece, srctransform;
      i̲n̲t̲e̲g̲e̲r̲ dstpiece, dsttransform, srcpiece, srctransform;
      b̲e̲g̲i̲n̲
         transformed pieces[dstpiece,dsttransform] :=
            transformed pieces[srcpiece,srctransform]
      e̲n̲d̲ copy piece;

      p̲r̲o̲c̲e̲d̲u̲r̲e̲ transform pieces;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,ipiece,irotate,imirror,itransformed;
         B̲o̲o̲l̲e̲a̲n̲ piece;

         f̲o̲r̲ ipiece:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 12 d̲o̲
         b̲e̲g̲i̲n̲
            piece := 4̲0̲ 0;
            f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
            piece := piece  ∨ ((B̲o̲o̲l̲e̲a̲n̲ read integer) s̲h̲i̲f̲t̲ 5×i);
            transformed pieces[13,1] := piece;
            ntransformed[ipiece] := 0;
            f̲o̲r̲ irotate:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 3 d̲o̲
            b̲e̲g̲i̲n̲
               copy piece(13,2,13,1);
               f̲o̲r̲ imirror:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 1 d̲o̲
               b̲e̲g̲i̲n̲
                  i̲f̲ imirror=0 t̲h̲e̲n̲
                  copy piece(13,3,13,2)
                  e̲l̲s̲e̲
                  mirror(3,2);
                  f̲o̲r̲ itransformed:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ ntransformed[ipiece] d̲o̲
                  b̲e̲g̲i̲n̲
                     i̲f̲ compare pieces(ipiece,itransformed,13,3) t̲h̲e̲n̲
                        g̲o̲_t̲o̲ duplicate
                  e̲n̲d̲ check for duplicate;
                  ntransformed[ipiece] := ntransformed[ipiece]+1;
                  f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
                  b̲e̲g̲i̲n̲
                     i̲f̲ transformed pieces[13,3] s̲h̲i̲f̲t̲ (−i−1) t̲h̲e̲n̲
                     b̲e̲g̲i̲n̲
                        transformedx[ipiece,ntransformed[ipiece]] := i;
                        g̲o̲_t̲o̲ found first bit
                     e̲n̲d̲
                  e̲n̲d̲ look for first bit in first row;
found first bit:
                  copy piece(ipiece,ntransformed[ipiece],13,3);
duplicate:
               e̲n̲d̲ imirror;
               rotate cw(2,1);
               copy piece(13,1,13,2)
            e̲n̲d̲ irotate
         e̲n̲d̲ ipiece
      e̲n̲d̲ transform pieces;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ create board;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,j;
         board[0] := 2̲4̲ 0 4̲ m 1̲ 1 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 4̲ m;
         board[1] := 2̲4̲ 0 4̲ m 1̲ 1 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 4̲ m;
         board[2] := 2̲4̲ 0 4̲ m 1̲ 1 1̲ 0 1̲ 1 1̲ 1 1̲ 0 1̲ 0 1̲ 0 1̲ 0 4̲ m;
         board[3] := 2̲4̲ 0 4̲ m 1̲ 0 1̲ 0 1̲ 1 1̲ 0 1̲ 0 1̲ 0 1̲ 1 1̲ 0 4̲ m;
         board[4] := 2̲4̲ 0 4̲ m 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 1 1̲ 0 4̲ m;
         board[5] := 2̲4̲ 0 4̲ m 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 4̲ m;
         board[6] := 2̲4̲ 0 4̲ m 1̲ 1 1̲ 1 1̲ 1 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 4̲ m;
         board[7] := 2̲4̲ 0 4̲ m 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 4̲ m;
         board[8] := 2̲4̲ 0 4̲ m 1̲ 1 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 1̲ 0 4̲ m;
         board[9] := 4̲0̲ m;
         board[10] := 4̲0̲ m;
         board[11] := 4̲0̲ m;
         board[12] := 4̲0̲ m;
         f̲o̲r̲ i := 0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDY1 d̲o̲
         mask[i] := (board[i] s̲h̲i̲f̲t̲ −4) ∧ 3̲2̲ 0 8̲ m;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDY1 d̲o̲
         f̲o̲r̲ j:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDX1 d̲o̲
         solution board[i,j] := −1
      e̲n̲d̲ create board;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ find first free;
      b̲e̲g̲i̲n̲
next:
         i̲f̲ board[iy] s̲h̲i̲f̲t̲ −(ix+5) t̲h̲e̲n̲
         b̲e̲g̲i̲n̲
            ix:=ix+1;
            i̲f̲ ix≥BOARDX t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               ix := 0;
               iy := iy+1
            e̲n̲d̲ next row;
            g̲o̲_t̲o̲ next
         e̲n̲d̲ bit is one
      e̲n̲d̲ find first free;
      B̲o̲o̲l̲e̲a̲n̲ p̲r̲o̲c̲e̲d̲u̲r̲e̲ piece fit(ix,iy,ipiece,itransform);
      v̲a̲l̲u̲e̲ ix,iy,ipiece,itransform;
      i̲n̲t̲e̲g̲e̲r̲ ix,iy,ipiece,itransform;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i;
         piece fit := t̲r̲u̲e̲;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         b̲e̲g̲i̲n̲
            i̲f̲ (i̲n̲t̲e̲g̲e̲r̲(board[iy+i]∧
               (((transformed pieces[ipiece,itransform] s̲h̲i̲f̲t̲ −5×i) ∧
               3̲5̲ 0 5̲ m)s̲h̲i̲f̲t̲ (ix+4))))≠0 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               piece fit := f̲a̲l̲s̲e̲;
               g̲o̲_t̲o̲ not fit
            e̲n̲d̲
         e̲n̲d̲ f̲o̲r̲;
not fit:
      e̲n̲d̲ piece fit;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ print piece(ipiece,itransform);
      v̲a̲l̲u̲e̲ ipiece,itransform;
      i̲n̲t̲e̲g̲e̲r̲ ipiece,itransform;
      b̲e̲g̲i̲n̲
         B̲o̲o̲l̲e̲a̲n̲ s;
         i̲n̲t̲e̲g̲e̲r̲ i,j;
         s:=transformed pieces[ipiece,itransform];
         writecr;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         b̲e̲g̲i̲n̲
            f̲o̲r̲ j:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
            b̲e̲g̲i̲n̲
               s:=s s̲h̲i̲f̲t̲ −1;
               write(«d», i̲f̲ s t̲h̲e̲n̲ 1 e̲l̲s̲e̲ 0)
            e̲n̲d̲;
            writecr
         e̲n̲d̲;
         i:=select(17);
         lyn;
         select(i)
      e̲n̲d̲ print piece;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ print board;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,j;
         writecr;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDY1 d̲o̲
         b̲e̲g̲i̲n̲
            f̲o̲r̲ j:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDX1 d̲o̲
            write(«d», i̲f̲ board[i] s̲h̲i̲f̲t̲ −(j+5) t̲h̲e̲n̲ 1 e̲l̲s̲e̲ 0);
            writecr
         e̲n̲d̲ row;
         lyn
      e̲n̲d̲ print board;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ set piece(ix,iy,ipiece,itransform);
      v̲a̲l̲u̲e̲ ix,iy,ipiece,itransform;
      i̲n̲t̲e̲g̲e̲r̲ ix,iy,ipiece,itransform;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         board[iy+i] := board[iy+i]  ∨
            (((transformed pieces[ipiece,itransform] s̲h̲i̲f̲t̲ −5×i)
            ∧ 3̲5̲ 0 5̲ m) s̲h̲i̲f̲t̲ (ix+4))
      e̲n̲d̲ set piece;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ remove piece(ix,iy,ipiece,itransform);
      v̲a̲l̲u̲e̲ ix,iy,ipiece,itransform;
      i̲n̲t̲e̲g̲e̲r̲ ix,iy,ipiece,itransform;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         board[iy+i] := board[iy+i] ∧
            ¬(((transformed pieces[ipiece,itransform] s̲h̲i̲f̲t̲ −5×i)
            ∧ 3̲5̲ 0 5̲ m) s̲h̲i̲f̲t̲ (ix+4))
      e̲n̲d̲ remove piece;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ set solution(ix,iy,ipiece,itransform);
      v̲a̲l̲u̲e̲ ix,iy,ipiece,itransform;
      i̲n̲t̲e̲g̲e̲r̲ ix,iy,ipiece,itransform;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,j;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         f̲o̲r̲ j:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 4 d̲o̲
         b̲e̲g̲i̲n̲
            i̲f̲ transformed pieces[ipiece,itransform] s̲h̲i̲f̲t̲ −(j+1+5×i) t̲h̲e̲n̲
            solution board[iy+i,ix+j] := ipiece
         e̲n̲d̲
      e̲n̲d̲ set solution;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ print solution;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ i,j,k;
         writecr;
         write text(«Solution: »);
         write(«dddd», nsolutions);
         writecr;
         writetext(«+−−−»);
         f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDX1 d̲o̲
         b̲e̲g̲i̲n̲
            i̲f̲ mask[0] s̲h̲i̲f̲t̲ −j−1 t̲h̲e̲n̲
            writetext(«XXXX»)
            e̲l̲s̲e̲ i̲f̲ solution board[0,j−1]=
               solution board[0,j] t̲h̲e̲n̲
            writetext(«−−−−»)
            e̲l̲s̲e̲
            writetext(«+−−−»)
         e̲n̲d̲ first row;
         i̲f̲ mask[0] s̲h̲i̲f̲t̲ −BOARDX1−1 t̲h̲e̲n̲
         writetext(«X»)
         e̲l̲s̲e̲
         writetext(«+»);
         writecr;
         f̲o̲r̲ i:=0 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDY1 d̲o̲
         b̲e̲g̲i̲n̲
            f̲o̲r̲ k:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 2 d̲o̲
            b̲e̲g̲i̲n̲
               writetext(«I   »);
               f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDX1 d̲o̲
               b̲e̲g̲i̲n̲
                  i̲f̲ mask[i] s̲h̲i̲f̲t̲ −j−1 t̲h̲e̲n̲
                  writetext(«XXXX»)
                  e̲l̲s̲e̲ i̲f̲ solution board[i,j−1]=
                     solution board[i,j] t̲h̲e̲n̲
                  writetext(«    »)
                  e̲l̲s̲e̲
                  i̲f̲ mask[i] s̲h̲i̲f̲t̲ −j t̲h̲e̲n̲
                  writetext(«X   »)
                  e̲l̲s̲e̲
                  writetext(«I   »)
               e̲n̲d̲;
               i̲f̲ mask[i] s̲h̲i̲f̲t̲ −BOARDX1−1 t̲h̲e̲n̲
               writetext(«X»)
               e̲l̲s̲e̲
               writetext(«I»);
               writecr
            e̲n̲d̲;
            i̲f̲ i<BOARDY1 t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               i̲f̲ solution board[i,0]=
                  solution board[i+1,0] t̲h̲e̲n̲
               writetext(«I   »)
               e̲l̲s̲e̲
               writetext(«+−−−»);
               f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDX1 d̲o̲
               b̲e̲g̲i̲n̲
                  i̲f̲ (mask[i] s̲h̲i̲f̲t̲ −j−1)  ∨
                       (mask[i+1] s̲h̲i̲f̲t̲ −j−1) t̲h̲e̲n̲
                  writetext(«XXXX»)
                  e̲l̲s̲e̲ i̲f̲ solution board[i,j]=
                     solution board[i+1,j] t̲h̲e̲n̲
                  b̲e̲g̲i̲n̲
                     i̲f̲ solution board[i,j−1]=
                        solution board[i+1,j−1] t̲h̲e̲n̲
                     b̲e̲g̲i̲n̲
                        i̲f̲ solution board[i,j] ≠
                           solution board[i,j−1]  ∨
                           solution board[i+1,j] ≠
                           solution board[i+1,j−1] t̲h̲e̲n̲
                        b̲e̲g̲i̲n̲
                           i̲f̲ mask[i] s̲h̲i̲f̲t̲ −j t̲h̲e̲n̲
                           writetext(«X   »)
                           e̲l̲s̲e̲
                           writetext(«I   »)
                        e̲n̲d̲
                        e̲l̲s̲e̲
                        writetext(«    »)
                     e̲n̲d̲
                     e̲l̲s̲e̲
                     i̲f̲ (mask[i] s̲h̲i̲f̲t̲ −j)  ∨
                          (mask[i+1] s̲h̲i̲f̲t̲ −j) t̲h̲e̲n̲
                     writetext(«X   »)
                     e̲l̲s̲e̲
                     writetext(«+   »)
                  e̲n̲d̲
                  e̲l̲s̲e̲
                  b̲e̲g̲i̲n̲
                     i̲f̲ solution board[i,j] =
                        solution board[i,j−1] ∧
                        solution board[i+1,j] =
                        solution board[i+1,j−1] t̲h̲e̲n̲
                     writetext(«−−−−»)
                     e̲l̲s̲e̲
                     i̲f̲ (mask[i] s̲h̲i̲f̲t̲ −j)  ∨
                          (mask[i+1] s̲h̲i̲f̲t̲ −j) t̲h̲e̲n̲
                     writetext(«X−−−»)
                     e̲l̲s̲e̲
                     writetext(«+−−−»)
                  e̲n̲d̲
               e̲n̲d̲ first row;
               i̲f̲ (mask[i] s̲h̲i̲f̲t̲ −BOARDX1−1)  ∨
                    (mask[i+1] s̲h̲i̲f̲t̲ −BOARDX1−1) t̲h̲e̲n̲
               writetext(«X»)
               e̲l̲s̲e̲ i̲f̲ solution board[i,BOARDX1]=
                  solution board[i+1,BOARDX1] t̲h̲e̲n̲
               writetext(«I»)
               e̲l̲s̲e̲
               writetext(«+»);
               writecr
            e̲n̲d̲ not last row
         e̲n̲d̲ each row;
         writetext(«+−−−»);
         f̲o̲r̲ j:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ BOARDX1 d̲o̲
         b̲e̲g̲i̲n̲
            i̲f̲ mask[BOARDY1] s̲h̲i̲f̲t̲ −j−1 t̲h̲e̲n̲
            writetext(«XXXX»)
            e̲l̲s̲e̲ i̲f̲ solution board[BOARDY1,j−1]=
               solution board[BOARDY1,j] t̲h̲e̲n̲
            writetext(«−−−−»)
            e̲l̲s̲e̲
            writetext(«+−−−»)
         e̲n̲d̲ first row;
         i̲f̲ mask[BOARDY1] s̲h̲i̲f̲t̲ −BOARDX1−1 t̲h̲e̲n̲
         writetext(«X»)
         e̲l̲s̲e̲
         writetext(«+»);
         writecr;
      e̲n̲d̲ print solution;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ test piece(piece count);
      v̲a̲l̲u̲e̲ piece count;
      i̲n̲t̲e̲g̲e̲r̲ piece count;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ ipiece,itransform,saveix,saveiy;
         f̲o̲r̲ ipiece:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 12 d̲o̲
         b̲e̲g̲i̲n̲
            i̲f̲ ¬ used piece[ipiece] t̲h̲e̲n̲
            b̲e̲g̲i̲n̲
               used piece[ipiece] := t̲r̲u̲e̲;
               f̲o̲r̲ itransform:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ ntransformed[ipiece] d̲o̲
               b̲e̲g̲i̲n̲
                  i̲f̲ piece fit(ix−transformedx[ipiece,itransform],
                     iy,ipiece,itransform) t̲h̲e̲n̲
                  b̲e̲g̲i̲n̲
                     set piece(ix−transformedx[ipiece,itransform],iy,
                        ipiece,itransform);
                     set solution(ix−transformedx[ipiece,itransform],iy,
                        ipiece,itransform);
                     i̲f̲ piece count=11 t̲h̲e̲n̲
                     b̲e̲g̲i̲n̲
                        nsolutions:=nsolutions+1;
                        print solution
                     e̲n̲d̲ solution found
                     e̲l̲s̲e̲
                     b̲e̲g̲i̲n̲
                        saveix := ix;
                        saveiy := iy;
                        find first free;
                        test piece(piece count+1);
                        ix := saveix;
                        iy := saveiy
                     e̲n̲d̲ next piece;
                     remove piece(ix−transformedx[ipiece,itransform],iy,
                        ipiece,itransform)
                  e̲n̲d̲ piece fit
               e̲n̲d̲ itransform;
               used piece[ipiece] := f̲a̲l̲s̲e̲
            e̲n̲d̲ unused piece
         e̲n̲d̲ ipiece
      e̲n̲d̲ test piece;
      p̲r̲o̲c̲e̲d̲u̲r̲e̲ solve;
      b̲e̲g̲i̲n̲
         i̲n̲t̲e̲g̲e̲r̲ ipiece;
         f̲o̲r̲ ipiece:=1 s̲t̲e̲p̲ 1 u̲n̲t̲i̲l̲ 12 d̲o̲
         used piece[ipiece]:=f̲a̲l̲s̲e̲;
         ix:=0;
         iy:=0;
         test piece(0)
      e̲n̲d̲ solve;

      select(16);
      nsolutions:=0;
      transform pieces;
      select(17);
      create board;
      clock count;
      solve;
      writecr;
      write text(«Solutions: »);
      write(«dddd», nsolutions);
      writecr;
      write text(«Time: »);
      write(«dddddd», clock count);
      write text(« sec.»);
      writecr
   e̲n̲d̲
e̲n̲d̲;
t<
