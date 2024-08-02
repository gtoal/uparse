'CODE' 34041;
    'PROCEDURE' ROTROW(L, U, I, J, A, C, S); 'VALUE' L,U,I,J,C,S;
    'INTEGER' L,U,I,J; 'REAL' C,S; 'ARRAY' A;
    'BEGIN' 'REAL' X, Y;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' X:= A[I,L]; Y:= A[J,L]; A[I,L]:= X * C + Y * S;
            A[J,L]:= Y * C - X * S
        'END'
    'END' ROTROW;
        'EOP'
