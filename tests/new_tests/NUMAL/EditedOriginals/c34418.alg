'CODE' 34418;
   'PROCEDURE' LNGSYMMATVEC(L, U, I, A, B, C, CC, D, DD);
   'VALUE' L, U, I, C, CC;
   'INTEGER' L, U, I; 'REAL' C, CC, D, DD; 'ARRAY' A, B;
   'BEGIN' 'INTEGER' K, M;
      M:= 'IF' L > I 'THEN' L 'ELSE' I; K:= M * (M - 1) // 2;
      LNGVECVEC(L, 'IF' I <= U 'THEN' I - 1 'ELSE' U,
      K, B, A, C, CC, C, CC);
      LNGSEQVEC(M, U, K + I, 0, A, B, C, CC, D, DD)
   'END' LNGSYMMATVEC;
        'EOP'
