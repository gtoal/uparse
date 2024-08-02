'CODE' 34012;
   'REAL' 'PROCEDURE' TAMVEC(L, U, I, A, B); 'VALUE' L,U,I;
   'INTEGER' L,U,I; 'ARRAY' A,B;
   'BEGIN' 'INTEGER' K; 'REAL' S;
       S:= 0;
       'FOR' K:=L 'STEP' 1 'UNTIL' U 'DO' S:= A[K,I] * B[K] + S;
       TAMVEC:= S
   'END' TAMVEC;
       'EOP'
