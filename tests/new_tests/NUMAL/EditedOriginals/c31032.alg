'CODE' 31032;
    'PROCEDURE' DUPROWVEC(L, U, I, A, B); 'VALUE' L,U,I;
    'INTEGER' L,U,I; 'ARRAY' A,B;
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' A[I,L]:= B[L];
        'EOP'
