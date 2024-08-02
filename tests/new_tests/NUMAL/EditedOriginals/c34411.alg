'CODE' 34411;
   'PROCEDURE' LNGMATVEC(L, U, I, A, B, C, CC, D, DD);
   'VALUE' L, U, I, C, CC; 'INTEGER' L, U, I;
   'REAL' C, CC, D, DD; 'ARRAY' A, B;
   'BEGIN' 'REAL' E, EE;
      'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
      'BEGIN' DPMUL(A[I,L], B[L], E, EE); LNGADD(C, CC, E, EE, C, CC)
      'END';
      D:= C; DD:= CC
   'END' LNGMATVEC;
        'EOP'
