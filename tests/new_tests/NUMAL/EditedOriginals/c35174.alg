'CODE' 35174;
    'PROCEDURE' BESS K(X, N, K); 'VALUE' X, N;
    'REAL' X; 'INTEGER' N; 'ARRAY' K;
    'BEGIN'  'INTEGER' I; 'REAL' K0, K1, K2;
        BESS K01(X, K0, K1); K[0]:= K0; 'IF' N > 0 'THEN' K[1]:= K1;
        X:= 2 / X;
        'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' K[I]:= K2:= K0 + X * (I-1)* K1;
            K0:= K1; K1:= K2
        'END'
    'END' BESS K;
        'EOP'
