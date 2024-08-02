'CODE' 34320;
'PROCEDURE' DECBND(A, N, LW, RW, AUX, M, P); 'VALUE' N, LW, RW;
'INTEGER' N, LW, RW; 'INTEGER' 'ARRAY' P; 'ARRAY' A, M, AUX;
'BEGIN' 'INTEGER' I, J, K, KK, KK1, PK, MK, IK, LW1, F, Q, W, W1,
        W2, NRW, IW, SDET;
        'REAL' R, S, EPS, MIN;
        'ARRAY' V[1:N];

        F:= LW; W1:= LW + RW; W:= W1 + 1; W2:= W - 2; IW:= 0; SDET:= 1;
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
        EPS:= AUX[2]; MIN:= 1; KK:= - W1; MK:= - LW;
        'IF' F > NRW 'THEN' W2:= W2 + NRW - F;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN''IF' F < N 'THEN' F:= F + 1; IK:= KK:= KK + W;
            MK:= MK + LW; S:= ABS(A[KK]) / V[K]; PK:= K; KK1:= KK + 1;
            'FOR' I:= K + 1 'STEP' 1 'UNTIL' F 'DO'
            'BEGIN' IK:= IK + W1; M[MK + I - K]:= R:= A[IK]; A[IK]:= 0;
                R:= ABS(R) / V[I]; 'IF' R > S 'THEN'
                'BEGIN' S:= R; PK:= I 'END'
            'END';
            'IF' S < MIN 'THEN' MIN:= S; 'IF' S < EPS 'THEN'
            'BEGIN' AUX[3]:= K - 1; AUX[5]:= S; 'GOTO' END 'END';
            'IF' K + W2 >= N 'THEN' W2:= W2 - 1;
            P[K]:= PK; 'IF' PK ^= K 'THEN'
            'BEGIN' V[PK]:= V[K];
                PK:= PK - K; ICHVEC(KK1, KK1 + W2, PK * W1, A);
                SDET:= - SDET; R:= M[MK + PK]; M[MK + PK]:= A[KK];
                A[KK]:= R
            'END''ELSE' R:= A[KK]; 'IF' R < 0 'THEN' SDET:= - SDET;
            IW:= KK1; LW1:= F - K + MK;
            'FOR' I:= MK + 1 'STEP' 1 'UNTIL' LW1 'DO'
            'BEGIN' M[I]:= S:= M[I] / R; IW:= IW + W1;
                ELMVEC(IW, IW + W2, KK1 - IW, A, A, - S)
            'END'
        'END';
        AUX[3]:= N; AUX[5]:= MIN;
    END: AUX[1]:= SDET
    'END' DECBND;
        'EOP'
