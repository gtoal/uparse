'CODE' 34013;
   'REAL' 'PROCEDURE' MATMAT(L, U, I, J, A, B); 'VALUE' L,U,I,J;
   'INTEGER' L,U,I,J; 'ARRAY' A,B;
   'BEGIN' 'INTEGER' K; 'REAL' S;
       S:= 0;
       'FOR' K:=L 'STEP' 1 'UNTIL' U 'DO' S:= A[I,K] * B[K,J] + S;
       MATMAT:= S
   'END' MATMAT

       ;'EOP'
