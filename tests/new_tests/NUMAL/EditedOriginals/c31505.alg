'CODE' 31505;
   'PROCEDURE' LNGFULMATVEC(LR, UR, LC, UC, A, B, C);
   'VALUE' LR, UR, LC, UC; 'INTEGER' LR, UR, LC, UC;
   'ARRAY' A, B, C;
   'BEGIN' 'REAL' D, DD;
      'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO'
      'BEGIN' LNGMATVEC(LC, UC, LR, A, B, 0, 0, D, DD); C[LR]:= D + DD
      'END'
   'END' LNGFULMATVEC;
        'EOP'
