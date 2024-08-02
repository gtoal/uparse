'CODE' 31509;
   'PROCEDURE' LNGSYMRESVEC(LR, UR, LC, UC, A, B, C, X);
   'VALUE' LR, UR, LC, UC, B, X; 'INTEGER' LR, UR, LC, UC;
   'REAL' X; 'ARRAY' A, B, C;
   'BEGIN' 'REAL' D, DD, E, EE;
      'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO'
      'BEGIN' DPMUL(C[LR], X, E, EE);
         LNGSYMMATVEC(LC, UC, LR, A, B, E, EE, D, DD); C[LR]:= D + DD
      'END'
   'END' LNGSYMRESVEC;
        'EOP'
