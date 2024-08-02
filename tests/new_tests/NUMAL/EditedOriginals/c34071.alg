'CODE' 34071;
'PROCEDURE' SOLBND(A, N, LW, RW, M, P, B); 'VALUE' N, LW, RW;
'INTEGER' N, LW, RW; 'INTEGER' 'ARRAY' P; 'ARRAY' A, B, M;
'BEGIN' 'INTEGER' F, I, K, KK, W, W1, W2, SHIFT;
        'REAL' S;

        F:= LW; SHIFT:= - LW; W1:= LW - 1;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN''IF' F < N 'THEN' F:= F + 1; SHIFT:= SHIFT + W1;
            I:=P[K]; S:= B[I]; 'IF' I ^= K 'THEN'
            'BEGIN' B[I]:= B[K]; B[K]:= S 'END';
            ELMVEC(K + 1, F, SHIFT, B, M, - S)
        'END';
        W1:= LW + RW; W:= W1 + 1; KK:= (N + 1) * W - W1; W2:= - 1;
        SHIFT:= N * W1;
        'FOR' K:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' KK:= KK - W; SHIFT:= SHIFT - W1;
            'IF' W2 < W1 'THEN' W2:= W2 + 1;
            B[K]:= (B[K] - VECVEC(K + 1, K + W2, SHIFT, B, A)) / A[KK]
        'END'
    'END' SOLBND;
        'EOP'
