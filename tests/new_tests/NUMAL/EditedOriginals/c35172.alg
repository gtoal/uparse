'CODE' 35172;
    'PROCEDURE' BESS I(X, N, I);
    'VALUE' X, N; 'INTEGER' N; 'REAL' X; 'ARRAY' I;
    'IF' X = 0 'THEN'
    'BEGIN' I[0]:= 1;
        'FOR' N:= N 'STEP' - 1 'UNTIL' 1 'DO' I[N]:= 0;
    'END' 'ELSE'
    'BEGIN' 'REAL' EXPX;
        EXPX:= EXP(ABS(X)); NONEXP BESS I(X, N, I);
        'FOR' N:= N 'STEP' - 1 'UNTIL' 0 'DO'
        I[N]:= I[N] * EXPX
    'END' BESS I

        ;'EOP'
