'CODE' 34023;
    'PROCEDURE' ELMCOL(L, U, I, J, A, B, X); 'VALUE' L,U,I,J,X;
    'INTEGER' L,U,I,J; 'REAL' X; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L,I]:= A[L,I] + B[L,J] * X;
        'EOP'
