'CODE' 34018;
   'REAL' 'PROCEDURE' SYMMATVEC(L, U, I, A, B); 'VALUE' L,U,I;
   'INTEGER' L,U,I; 'ARRAY' A,B;
   'BEGIN' 'INTEGER' K, M;
       M:= 'IF' L > I 'THEN' L 'ELSE' I; K:= M * (M - 1) // 2;
       SYMMATVEC:= VECVEC(L, 'IF' I <= U 'THEN' I-1 'ELSE' U, K, B, A)
                   + SEQVEC(M, U, K + I, 0, A, B)
   'END' SYMMATVEC;
       'EOP'
