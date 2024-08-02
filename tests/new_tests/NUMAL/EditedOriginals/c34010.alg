'CODE' 34010;
   'REAL' 'PROCEDURE' VECVEC(L, U, SHIFT, A, B); 'VALUE' L,U,SHIFT;
   'INTEGER' L,U,SHIFT; 'ARRAY' A,B;
   'BEGIN' 'INTEGER' K; 'REAL' S;
       S:= 0;
       'FOR' K:=L 'STEP' 1 'UNTIL' U 'DO' S:= A[K] * B[SHIFT + K] + S;
       VECVEC:= S
   'END' VECVEC;
       'EOP'
