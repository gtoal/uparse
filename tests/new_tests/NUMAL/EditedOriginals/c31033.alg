'CODE' 31033;
    'PROCEDURE' DUPVECCOL(L, U, J, A, B); 'VALUE' L,U,J;
    'INTEGER' L,U,J; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L]:= B[L,J];
        'EOP'
