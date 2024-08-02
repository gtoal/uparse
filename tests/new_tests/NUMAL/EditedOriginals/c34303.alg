'CODE' 34303;
    'REAL' 'PROCEDURE' DETERM(A, N, SIGN); 'VALUE' N, SIGN;
    'INTEGER' N, SIGN; 'ARRAY' A;
    'BEGIN' 'INTEGER' I; 'REAL' DET;
        DET:= 1;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' DET:= A[I, I] * DET;
        DETERM:= SIGN * ABS(DET)
    'END' DETERM;
        'EOP'
