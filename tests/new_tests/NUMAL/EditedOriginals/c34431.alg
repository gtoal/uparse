'CODE' 34431;
    'PROCEDURE' QUANEWBND1(N, LW, RW, X, F, FUNCT, IN, OUT);
    'VALUE' N, LW, RW; 'INTEGER' N, LW, RW; 'ARRAY' X, F, IN, OUT;
    'BOOLEAN' 'PROCEDURE' FUNCT;
    'BEGIN' 'INTEGER' I, K; 'REAL' S;
        'ARRAY' JAC[1:(LW + RW) * (N - 1) + N];
        FUNCT(N, 1, N, X, F); S:= IN[5];
        K:= (LW + RW)*(N - 1) + N*2 - ((LW - 1)*LW + (RW - 1)*RW) // 2;
        IN[4]:= IN[4] - K;
        JACOBNBNDF(N, LW, RW, X, F, JAC, I, S, FUNCT);
        QUANEWBND(N, LW, RW, X, F, JAC, FUNCT, IN, OUT);
        IN[4]:= IN[4] + K; OUT[3]:= OUT[3] + K
    'END' QUANEWBND1;
        'EOP'
