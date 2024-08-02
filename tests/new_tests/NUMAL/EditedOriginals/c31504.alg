'CODE' 31504;
   'PROCEDURE' SYMRESVEC(LR, UR, LC, UC, A, B, C, X);
   'VALUE' LR, UR, LC, UC, B, X; 'INTEGER' LR, UR, LC, UC;
   'REAL' X; 'ARRAY' A, B, C;
   'BEGIN'
       'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO'
      C[LR]:= SYMMATVEC(LC, UC, LR, A, B) + C[LR] * X
   'END' SYMRESVEC;
        'EOP'
