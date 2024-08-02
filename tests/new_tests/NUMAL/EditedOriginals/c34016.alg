'CODE' 34016;
   'REAL' 'PROCEDURE' SEQVEC(L, U, IL, SHIFT, A, B);
   'VALUE' L,U,IL,SHIFT; 'INTEGER' L,U,IL,SHIFT; 'ARRAY' A,B;
   'BEGIN' 'REAL' S;
       S:= 0;
       'FOR' L:=L 'STEP' 1 'UNTIL' U 'DO'
       'BEGIN' S:= A[IL] * B[L + SHIFT] + S; IL:= IL + L 'END';
       SEQVEC:= S
   'END' SEQVEC;
       'EOP'
