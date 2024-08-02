'CODE' 31501;
   'PROCEDURE' FULTAMVEC(LR, UR, LC, UC, A, B, C);
   'VALUE' LR, UR, LC, UC; 'INTEGER' LR, UR, LC, UC;
   'ARRAY' A, B, C;
   'BEGIN'
       'FOR' LC:= LC 'STEP' 1 'UNTIL' UC 'DO'
       C[LC]:= TAMVEC(LR, UR, LC, A, B);
   'END' FULTAMVEC;
        'EOP'
