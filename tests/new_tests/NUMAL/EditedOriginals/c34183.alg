'CODE' 34183;
    'COMMENT' MCA 2413;
    'PROCEDURE' REASCL(A, N, N1, N2); 'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' A;
    'BEGIN' 'INTEGER' I, J; 'REAL' S;
        'FOR' J:= N1 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN' S:= 0;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'IF' ABS(A[I,J]) > ABS(S) 'THEN' S:= A[I,J];
            'IF' S ^= 0 'THEN'
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' A[I,J]:= A[I,J] / S
        'END'
    'END' REASCL;
        'EOP'
