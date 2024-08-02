'CODE' 31503;
   'PROCEDURE' RESVEC(LR, UR, LC, UC, A, B, C, X);
   'VALUE' LR, UR, LC, UC, X; 'INTEGER' LR, UR, LC, UC;
   'REAL' X; 'ARRAY' A, B, C;
   'BEGIN'
       'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO'
       C[LR]:= MATVEC(LC, UC, LR, A, B) + C[LR] * X
   'END' RESVEC;
        'EOP'
