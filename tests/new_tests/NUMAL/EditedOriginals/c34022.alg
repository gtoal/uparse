'CODE' 34022;
    'PROCEDURE' ELMCOLVEC(L, U, I, A, B, X); 'VALUE' L,U,I,X;
    'INTEGER' L,U,I; 'REAL' X; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L,I]:= A[L,I] + B[L] * X;
        'EOP'
