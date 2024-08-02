'CODE' 34417;
   'PROCEDURE' LNGSCAPRD1(LA, SA, LB, SB, N, A, B, C, CC, D, DD);
   'VALUE' LA, SA, LB, SB, N, C, CC; 'INTEGER' LA, SA, LB, SB,N;
   'REAL' C, CC, D, DD; 'ARRAY' A, B;
   'BEGIN' 'REAL' E, EE; 'INTEGER' K;
      'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' DPMUL(A[LA], B[LB], E, EE); LA:= LA + SA; LB:= LB + SB;
         LNGADD(C, CC, E, EE, C, CC)
      'END';
      D:= C; DD:= CC
   'END';
        'EOP'
