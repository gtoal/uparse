'CODE' 31131;
    'PROCEDURE' COLCST(L, U, J, A, X); 'VALUE' L,U,J,X;
    'INTEGER' L,U,J; 'REAL' X; 'ARRAY' A;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L,J]:= A[L,J] * X;
        'EOP'
