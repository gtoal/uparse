'CODE' 34011;
   'REAL' 'PROCEDURE' MATVEC(L, U, I, A, B); 'VALUE' L,U,I;
   'INTEGER' L,U,I; 'ARRAY' A,B;
   'BEGIN' 'INTEGER' K; 'REAL' S;
       S:= 0;
       'FOR' K:=L 'STEP' 1 'UNTIL' U 'DO' S:= A[I,K] * B[K] + S;
       MATVEC:= S
   'END' MATVEC;
       'EOP'
