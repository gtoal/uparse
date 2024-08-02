'CODE' 34032;
    'PROCEDURE' ICHROW(L, U, I, J, A); 'VALUE' L,U,I,J;
    'INTEGER' L,U,I,J; 'ARRAY' A;
    'BEGIN' 'REAL' R;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' R:= A[I,L]; A[I,L]:= A[J,L]; A[J,L]:= R 'END'
    'END' ICHROW

        ;'EOP'
