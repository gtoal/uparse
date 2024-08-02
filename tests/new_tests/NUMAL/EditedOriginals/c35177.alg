'CODE' 35177;
    'PROCEDURE' NONEXP BESS I(X, N, I); 'VALUE' X, N;
    'INTEGER' N; 'REAL' X; 'ARRAY' I;
    'IF' X = 0 'THEN'
    'BEGIN' I[0]:= 1; 'FOR' N:= N 'STEP' - 1 'UNTIL' 1 'DO'
        I[N]:= 0
    'END' 'ELSE'
    'BEGIN' 'INTEGER' K; 'REAL' X2, R, S; 'BOOLEAN' NEGATIVE;
        NEGATIVE:= X < 0; X:= ABS(X);
        R:= S:= 0; X2:= 2/X; K:= START(X,N,1);
        'FOR' K:= K 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' R:= 1 / (R + X2 * K); S:= R * (2 + S);
            'IF' K <= N 'THEN' I[K]:= R
        'END';
        I[0]:= R:= 1 / (1 + S);
        'IF' NEGATIVE 'THEN'
        'BEGIN' 'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
            I[K]:= R:= - R * I[K]
        'END' 'ELSE'
        'FOR' K:=1 'STEP' 1 'UNTIL' N 'DO' I[K]:= R:= R * I[K];
    'END' NONEXP BESS I;
        'EOP'
