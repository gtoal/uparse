'CODE' 34020;
    'PROCEDURE' ELMVEC(L, U, SHIFT, A, B, X); 'VALUE' L,U,SHIFT,X;
    'INTEGER' L,U,SHIFT; 'REAL' X; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L]:= A[L] + B[L + SHIFT] * X;
        'EOP'
