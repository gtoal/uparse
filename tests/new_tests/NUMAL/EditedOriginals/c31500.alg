'CODE' 31500;
   'PROCEDURE' FULMATVEC(LR, UR, LC, UC, A, B, C);
   'VALUE' LR, UR, LC, UC; 'INTEGER' LR, UR, LC, UC;
   'ARRAY' A, B, C;
   'BEGIN'
       'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO'
       C[LR]:= MATVEC(LC, UC, LR, A, B);
   'END' FULMATVEC;
        'EOP'
