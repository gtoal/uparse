'CODE' 34414;
   'PROCEDURE' LNGTAMMAT(L, U, I, J, A, B, C, CC, D, DD);
   'VALUE' L, U, I, J, C, CC; 'INTEGER' L, U, I, J;
   'REAL' C, CC, D, DD; 'ARRAY' A, B;
   'BEGIN' 'REAL' E, EE;
      'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
      'BEGIN' DPMUL(A[L,I], B[L,J], E, EE); LNGADD(C, CC, E, EE, C, CC)
      'END';
      D:= C; DD:= CC
   'END' LNGTAMMAT;
        'EOP'
