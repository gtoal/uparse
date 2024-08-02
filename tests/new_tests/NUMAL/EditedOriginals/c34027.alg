'CODE' 34027;
    'PROCEDURE' ELMROWVEC(L, U, I, A, B, X); 'VALUE' L,U,I,X;
    'INTEGER' L,U,I; 'REAL' X; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[I,L]:= A[I,L] + B[L] * X;
        'EOP'
