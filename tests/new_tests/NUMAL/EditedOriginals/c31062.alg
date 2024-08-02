'CODE' 31062;
 'REAL' 'PROCEDURE' INFNRMROW(L, U, I, K, A); 'VALUE' L, U, I;
 'INTEGER' L, U, I, K; 'ARRAY' A;
 'BEGIN' 'REAL' R, MAX;
    MAX:= 0; K:= L;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
    'BEGIN' R:= ABS(A[I,L]); 'IF' R > MAX 'THEN'
        'BEGIN' MAX:= R; K:= L 'END'
    'END';
    INFNRMROW:= MAX
'END' INFNRMROW;
        'EOP'
