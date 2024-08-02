'CODE' 34322;
'PROCEDURE' DECSOLBND(A, N, LW, RW, AUX, B); 'VALUE' N, LW, RW;
'INTEGER' N, LW, RW; 'ARRAY' A, B, AUX;
'BEGIN''INTEGER' I, J, K, KK, KK1, PK, IK, LW1, F, Q, W, W1, W2,IW,
        NRW, SHIFT, SDET;
        'REAL' R, S, EPS, MIN; 'ARRAY' M[0:LW], V[1:N];

        F:= LW; SDET:= 1; W1:= LW + RW; W:= W1 + 1; W2:= W - 2; IW:= 0;
        NRW:= N - RW; LW1:= LW + 1; Q:= LW - 1;
        'FOR' I:= 2 'STEP' 1 'UNTIL' LW 'DO'
        'BEGIN' Q:= Q - 1; IW:= IW + W1;
            'FOR' J:= IW - Q 'STEP' 1 'UNTIL' IW 'DO' A[J]:= 0
        'END';
        IW:= - W2; Q:= - LW;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' IW:= IW + W; 'IF' I <= LW1 'THEN' IW:= IW - 1;
            Q:= Q + W; 'IF' I > NRW 'THEN' Q:= Q - 1;
            V[I]:= SQRT(VECVEC(IW, Q, 0, A, A))
        'END';
        EPS:= AUX[2]; MIN:= 1; KK:= - W1;
        'IF' F > NRW 'THEN' W2:= W2 + NRW - F;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN''IF' F < N 'THEN' F:= F + 1; IK:= KK:= KK + W;
            S:= ABS(A[KK]) / V[K]; PK:= K; KK1:= KK + 1;
            'FOR' I:= K + 1 'STEP' 1 'UNTIL' F 'DO'
            'BEGIN' IK:= IK + W1; M[I - K]:= R:= A[IK]; A[IK]:= 0;
                R:= ABS(R) / V[I]; 'IF' R > S 'THEN'
                'BEGIN' S:= R; PK:= I 'END'
            'END';
            'IF' S < MIN 'THEN' MIN:= S; 'IF' S < EPS 'THEN'
            'BEGIN' AUX[3]:= K - 1; AUX[5]:= S; 'GOTO' END 'END';
            'IF' K + W2 >= N 'THEN' W2:= W2 - 1; 'IF' PK ^= K 'THEN'
            'BEGIN' V[PK]:= V[K];
                PK:= PK - K; ICHVEC(KK1, KK1 + W2, PK * W1, A);
                SDET:= - SDET; R:= B[K]; B[K]:= B[PK + K];
                B[PK + K]:= R; R:= M[PK]; M[PK]:= A[KK]; A[KK]:= R
            'END'
            'ELSE' R:= A[KK]; IW:= KK1; LW1:= F - K;
            'IF' R < 0 'THEN' SDET:= - SDET;
            'FOR' I:= 1 'STEP' 1 'UNTIL' LW1 'DO'
            'BEGIN' M[I]:= S:= M[I] / R; IW:= IW + W1;
                ELMVEC(IW, IW + W2, KK1 - IW, A, A, - S);
                B[K + I]:= B[K + I] - B[K] * S
            'END'
        'END';
        AUX[3]:= N; AUX[5]:= MIN;
        KK:= (N + 1) * W - W1; W2:= - 1; SHIFT:= N * W1;
        'FOR' K:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' KK:= KK - W; SHIFT:= SHIFT - W1;
            'IF' W2 < W1 'THEN' W2:= W2 + 1;
            B[K]:= (B[K] - VECVEC(K + 1, K + W2, SHIFT, B, A)) / A[KK]
        'END';
    END: AUX[1]:= SDET
    'END' DECSOLBND;
        'EOP'
