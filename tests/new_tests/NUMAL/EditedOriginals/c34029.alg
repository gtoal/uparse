'CODE' 34029;
    'PROCEDURE' ELMCOLROW(L, U, I, J, A, B, X); 'VALUE' L,U,I,J,X;
    'INTEGER' L,U,I,J; 'REAL' X; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L,I]:= A[L,I] + B[J,L] * X;
        'EOP'
