'CODE' 31132;
    'PROCEDURE' ROWCST(L, U, I, A, X); 'VALUE' L,U,I,X;
    'INTEGER' L,U,I; 'REAL' X; 'ARRAY' A;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[I,L]:= A[I,L] * X;
        'EOP'
