'CODE' 34033;
    'PROCEDURE' ICHROWCOL(L, U, I, J, A); 'VALUE' L,U,I,J;
    'INTEGER' L,U,I,J; 'ARRAY' A;
    'BEGIN' 'REAL' R;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' R:= A[I,L]; A[I,L]:= A[L,J]; A[L,J]:= R 'END'
    'END' ICHROWCOL;
        'EOP'
