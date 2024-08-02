'CODE' 34025;
    'INTEGER' 'PROCEDURE' MAXELMROW(L, U, I, J, A, B, X);
    'VALUE' L,U,I,J,X; 'INTEGER' L,U,I,J; 'REAL' X; 'ARRAY' A,B;
    'BEGIN' 'INTEGER' K; 'REAL' R, S;
        S:= 0;
        'FOR' K:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' R:= A[I,K]:= A[I,K] + B[J,K] * X;'IF' ABS(R) > S 'THEN'
            'BEGIN' S:= ABS(R); L:= K 'END'
        'END';
        MAXELMROW:= L
    'END' MAXELMROW;
        'EOP'
