'CODE' 31506;
   'PROCEDURE' LNGFULTAMVEC(LR, UR, LC, UC, A, B, C);
   'VALUE' LR, UR, LC, UC; 'INTEGER' LR, UR, LC, UC;
   'ARRAY' A, B, C;
   'BEGIN' 'REAL' D, DD;
      'FOR' LC:= LC 'STEP' 1 'UNTIL' UC 'DO'
      'BEGIN' LNGTAMVEC(LR, UR, LC, A, B, 0, 0, D, DD); C[LC]:= D + DD
      'END'
   'END' LNGFULTAMVEC

        ;'EOP'
