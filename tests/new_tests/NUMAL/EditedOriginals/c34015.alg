'CODE' 34015;
   'REAL' 'PROCEDURE' MATTAM(L, U, I, J, A, B); 'VALUE' L,U,I,J;
   'INTEGER' L,U,I,J; 'ARRAY' A,B;
   'BEGIN' 'INTEGER' K; 'REAL' S;
       S:= 0;
       'FOR' K:=L 'STEP' 1 'UNTIL' U 'DO' S:= A[I,K] * B[J,K] + S;
       MATTAM:= S
   'END' MATTAM;
       'EOP'
