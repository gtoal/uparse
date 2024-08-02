'CODE' 31034;
    'PROCEDURE' DUPCOLVEC(L, U, J, A, B); 'VALUE' L,U,J;
    'INTEGER' L,U,J; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L,J]:= B[L];
        'EOP'
