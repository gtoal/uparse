'CODE' 31031;
    'PROCEDURE' DUPVECROW(L, U, I, A, B); 'VALUE' L,U,I;
    'INTEGER' L,U,I; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[L]:= B[I,L];
        'EOP'
