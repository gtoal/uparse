'CODE' 34332;
'PROCEDURE' CHLSOLBND(A, N, W, B); 'VALUE' N, W; 'INTEGER' N, W;
'ARRAY' A, B;
'BEGIN' 'INTEGER' I, K, IMAX, KK, W1;
        KK:= - W; W1:= W + 1;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' KK:= KK + W1;
            B[K]:= (B[K] - VECVEC('IF' K <= W1 'THEN' 1 'ELSE' K - W,
            K - 1, KK - K, B, A)) / A[KK]
        'END';
        IMAX:= - 1;
        'FOR' K:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN''IF' IMAX < W 'THEN' IMAX:= IMAX + 1;
            B[K]:= (B[K] - SCAPRD1(KK + W, W, K + 1, 1, IMAX, A, B)) /
            A[KK]; KK:= KK - W1
        'END'
    'END' CHLSOLBND;
        'EOP'
