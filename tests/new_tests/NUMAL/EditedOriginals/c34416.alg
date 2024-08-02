'CODE' 34416;
   'PROCEDURE' LNGSEQVEC(L, U, IL, SHIFT, A, B, C, CC, D, DD);
   'VALUE' L, U, IL, SHIFT, C, CC; 'INTEGER' L, U, IL, SHIFT;
   'REAL' C, CC, D, DD; 'ARRAY' A, B;
   'BEGIN' 'REAL' E, EE;
      'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
      'BEGIN' DPMUL(A[IL], B[L + SHIFT], E, EE); IL:= IL + L;
         LNGADD(C, CC, E, EE, C, CC)
      'END';
      D:= C; DD:= CC
   'END' LNGSEQVEC

        ;'EOP'
