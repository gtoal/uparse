'CODE' 34410;
   'PROCEDURE' LNGVECVEC(L, U, SHIFT, A, B, C, CC, D, DD);
   'VALUE' L, U, SHIFT, C, CC; 'INTEGER' L,U,SHIFT;
   'REAL' C, CC, D, DD; 'ARRAY' A, B;
   'BEGIN' 'REAL' E, EE;
      'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
      'BEGIN' DPMUL(A[L], B[L + SHIFT], E, EE);
         LNGADD(C, CC, E, EE, C, CC)
      'END';
      D:= C; DD:= CC
   'END' LNGVECVEC

        ;'EOP'
