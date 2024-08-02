'CODE' 34412;
   'PROCEDURE' LNGTAMVEC(L, U, I, A, B, C, CC, D, DD);
   'VALUE' L, U, I, C, CC; 'INTEGER' L, U, I;
   'REAL' C, CC, D, DD; 'ARRAY' A, B;
   'BEGIN' 'REAL' E, EE;
      'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
      'BEGIN' DPMUL(A[L,I], B[L], E, EE); LNGADD(C, CC, E, EE, C, CC)
      'END';
      D:= C; DD:= CC
   'END' LNGTAMVEC;
        'EOP'
