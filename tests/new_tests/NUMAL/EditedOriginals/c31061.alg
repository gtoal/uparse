'CODE' 31061;
 'REAL' 'PROCEDURE' INFNRMVEC(L, U, K, A); 'VALUE' L, U;
 'INTEGER' L, U, K; 'ARRAY' A;
 'BEGIN' 'REAL' R, MAX;
    MAX:= 0; K:= L;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
    'BEGIN' R:= ABS(A[L]); 'IF' R > MAX 'THEN'
        'BEGIN' MAX:= R; K:= L 'END'
    'END';
    INFNRMVEC:= MAX
'END' INFNRMVEC;
        'EOP'
