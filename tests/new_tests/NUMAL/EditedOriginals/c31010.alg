'CODE' 31010;
    'PROCEDURE' INIVEC(L, U, A, X); 'VALUE' L,U,X;
    'INTEGER' L,U; 'REAL' X; 'ARRAY' A;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L]:= X;
        'EOP'
