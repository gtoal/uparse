'CODE' 34028;
    'PROCEDURE' ELMROWCOL(L, U, I, J, A, B, X); 'VALUE' L,U,I,J,X;
    'INTEGER' L,U,I,J; 'REAL' X; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[I,L]:= A[I,L] + B[L,J] * X;
        'EOP'
