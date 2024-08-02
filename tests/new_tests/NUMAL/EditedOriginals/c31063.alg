'CODE' 31063;
 'REAL' 'PROCEDURE' INFNRMCOL(L, U, J, K, A); 'VALUE' L, U, J;
 'INTEGER' L, U, J, K; 'ARRAY' A;
 'BEGIN' 'REAL' R, MAX;
    MAX:= 0; K:= L;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
    'BEGIN' R:= ABS(A[L,J]); 'IF' R > MAX 'THEN'
        'BEGIN' MAX:= R; K:= L 'END'
    'END';
    INFNRMCOL:= MAX
'END' INFNRMCOL

        ;'EOP'
