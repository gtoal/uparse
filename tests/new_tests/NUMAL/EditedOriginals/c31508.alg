'CODE' 31508;
   'PROCEDURE' LNGRESVEC(LR, UR, LC, UC, A, B, C, X);
   'VALUE' LR, UR, LC, UC, X; 'INTEGER' LR, UR, LC, UC;
   'REAL' X; 'ARRAY' A, B, C;
   'BEGIN' 'REAL' D, DD, E, EE;
      'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO'
      'BEGIN' DPMUL(C[LR], X, E, EE);
         LNGMATVEC(LC, UC, LR, A, B, E, EE, D, DD); C[LR]:= D + DD
      'END'
   'END' LNGRESVEC;
        'EOP'
