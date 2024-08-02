'CODE' 34031;
    'PROCEDURE' ICHCOL(L, U, I, J, A); 'VALUE' L,U,I,J;
    'INTEGER' L,U,I,J; 'ARRAY' A;
    'BEGIN' 'REAL' R;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' R:= A[L,I]; A[L,I]:= A[L,J]; A[L,J]:= R 'END'
    'END' ICHCOL;
        'EOP'
