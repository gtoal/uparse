'CODE' 34014;
   'REAL' 'PROCEDURE' TAMMAT(L, U, I, J, A, B); 'VALUE' L,U,I,J;
   'INTEGER' L,U,I,J; 'ARRAY' A,B;
   'BEGIN' 'INTEGER' K; 'REAL' S;
       S:= 0;
       'FOR' K:=L 'STEP' 1 'UNTIL' U 'DO' S:= A[K,I] * B[K,J] + S;
       TAMMAT:= S
   'END' TAMMAT;
       'EOP'
