'CODE' 34321;
'REAL''PROCEDURE' DETERMBND(A, N, LW, RW, SGNDET);
'VALUE' N, LW, RW, SGNDET; 'INTEGER' N, LW, RW, SGNDET; 'ARRAY' A;
'BEGIN''INTEGER' I, L; 'REAL' P;
        L:= 1; P:= 1; LW:= LW + RW + 1;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' P:= A[L] * P; L:= L + LW 'END';
        DETERMBND:= ABS(P) * SGNDET
    'END' DETERMBND;
        'EOP'
