'CODE' 34040;
    'PROCEDURE' ROTCOL(L, U, I, J, A, C, S); 'VALUE' L,U,I,J,C,S;
    'INTEGER' L,U,I,J; 'REAL' C,S; 'ARRAY' A;
    'BEGIN' 'REAL' X, Y;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' X:= A[L,I]; Y:= A[L,J]; A[L,I]:= X * C + Y * S;
            A[L,J]:= Y * C - X * S
        'END'
    'END' ROTCOL;
        'EOP'
