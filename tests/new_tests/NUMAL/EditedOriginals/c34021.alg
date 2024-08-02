'CODE' 34021;
    'PROCEDURE' ELMVECCOL(L, U, I, A, B, X); 'VALUE' L,U,I,X;
    'INTEGER' L,U,I; 'REAL' X; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L]:= A[L] + B[L,I] * X;
        'EOP'
