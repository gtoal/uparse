'CODE' 34190;
    'COMMENT' MCA 2420;
    'INTEGER' 'PROCEDURE' COMVALQRI(A, N, EM, RE, IM); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, EM, RE, IM;
    'BEGIN' 'INTEGER' I, J, P, Q, MAX, COUNT, N1, P1, P2, IMIN1,
        I1, I2, I3;
        'REAL' DISC, SIGMA, RHO, G1, G2, G3, PSI1, PSI2, AA, E, K,
        S, NORM, MACHTOL2, TOL, W;
        'BOOLEAN' B;

        NORM:= EM[1]; MACHTOL2:= (EM[0] * NORM) ** 2;
        TOL:= EM[2] * NORM; MAX:= EM[4]; COUNT:= 0; W:= 0;
     IN: 'FOR' I:= N, I - 1 'WHILE'
        ('IF' I >= 1 'THEN' ABS(A[I + 1,I]) > TOL 'ELSE' 'FALSE')
        'DO' Q:= I; 'IF' Q > 1 'THEN'
        'BEGIN' 'IF' ABS(A[Q,Q - 1]) > W 'THEN' W:= ABS(A[Q,Q - 1])
        'END';
        'IF' Q >= N - 1 'THEN'
        'BEGIN' N1:= N - 1; 'IF' Q = N 'THEN'
            'BEGIN' RE[N]:= A[N,N]; IM[N]:= 0; N:= N1 'END'
            'ELSE'
            'BEGIN' SIGMA:= A[N,N] - A[N1,N1];
                RHO:= -A[N,N1] * A[N1,N];
                DISC:= SIGMA ** 2 - 4 * RHO; 'IF' DISC > 0 'THEN'
                'BEGIN' DISC:= SQRT(DISC);
                    S:= -2 * RHO / (SIGMA + ('IF' SIGMA >= 0
                    'THEN' DISC 'ELSE' -DISC));
                    RE[N]:= A[N,N] + S;
                    RE[N1]:= A[N1,N1] - S; IM[N]:= IM[N1]:= 0
                'END'
                'ELSE'
                'BEGIN' RE[N]:= RE[N1]:= (A[N1,N1] + A[N,N]) / 2;
                    IM[N1]:= SQRT( -DISC) / 2; IM[N]:= -IM[N1]
                'END';
                N:= N - 2
            'END'
        'END'
        'ELSE'
        'BEGIN' COUNT:= COUNT + 1; 'IF' COUNT > MAX 'THEN'
            'GOTO' OUT; N1:= N - 1;
            SIGMA:= A[N,N] + A[N1,N1] + SQRT(ABS(A[N1,N - 2] * A[N,N1])
            * EM[0]); RHO:= A[N,N] * A[N1,N1] - A[N,N1] * A[N1,N];
            'FOR' I:= N - 1, I - 1 'WHILE'
            ('IF' I - 1 >= Q 'THEN' ABS(A[I,I - 1] *
            A[I1,I] * (ABS(A[I,I] + A[I1,I1] - SIGMA) +
            ABS(A[I + 2,I1]))) > ABS(A[I,I] * ((A[I,I] - SIGMA) +
            A[I,I1] * A[I1,I] + RHO)) * TOL
            'ELSE' 'FALSE') 'DO' P1:= I1:= I; P:= P1 - 1;
            P2:= P + 2;
            'FOR' I:= P 'STEP' 1 'UNTIL' N - 1 'DO'
            'BEGIN' IMIN1:= I - 1; I1:= I + 1; I2:= I + 2;
                'IF' I = P 'THEN'
                'BEGIN' G1:= A[P,P] * (A[P,P] - SIGMA) + A[P,P1] *
                    A[P1,P] + RHO;
                    G2:= A[P1,P] * (A[P,P] + A[P1,P1] - SIGMA);
                    'IF' P1 <= N1 'THEN'
                    'BEGIN' G3:= A[P1,P] * A[P2,P1]; A[P2,P]:= 0 'END'
                    'ELSE' G3:= 0
                'END'
                'ELSE'
                'BEGIN' G1:= A[I,IMIN1]; G2:= A[I1,IMIN1];
                    G3:= 'IF' I2 <= N 'THEN' A[I2,IMIN1] 'ELSE' 0
                'END';
                K:= 'IF' G1 >= 0 'THEN'
                SQRT(G1 ** 2 + G2 ** 2 + G3 ** 2) 'ELSE'
                -SQRT(G1 ** 2 + G2 ** 2 + G3 ** 2);
                B:= ABS(K) > MACHTOL2;
                AA:= 'IF' B 'THEN' G1 / K + 1 'ELSE' 2;
                PSI1:= 'IF' B 'THEN' G2 / (G1 + K) 'ELSE' 0;
                PSI2:= 'IF' B 'THEN' G3 / (G1 + K) 'ELSE' 0;
                'IF' I ^= Q 'THEN' A[I,IMIN1]:= 'IF' I = P 'THEN'
                -A[I,IMIN1] 'ELSE' -K;
                'FOR' J:= I 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' E:= AA * (A[I,J] + PSI1 * A[I1,J] +
                    ('IF' I2 <= N 'THEN' PSI2 * A[I2,J] 'ELSE' 0));
                    A[I,J]:= A[I,J] - E; A[I1,J]:= A[I1,J] - PSI1 * E;
                    'IF' I2 <= N 'THEN' A[I2,J]:= A[I2,J] - PSI2 * E
                'END';
                'FOR' J:= Q 'STEP' 1 'UNTIL'
                ('IF' I2 <= N 'THEN' I2 'ELSE' N) 'DO'
                'BEGIN' E:= AA * (A[J,I] + PSI1 * A[J,I1] +
                    ('IF' I2 <= N 'THEN' PSI2 * A[J,I2] 'ELSE' 0));
                    A[J,I]:= A[J,I] - E; A[J,I1]:= A[J,I1] - PSI1 * E;
                    'IF' I2 <= N 'THEN' A[J,I2]:= A[J,I2] - PSI2 * E
                'END';
                'IF' I2 <= N1 'THEN'
                'BEGIN' I3:= I + 3; E:= AA * PSI2 * A[I3,I2];
                    A[I3,I]:= -E;
                    A[I3,I1]:= -PSI1 * E;
                    A[I3,I2]:= A[I3,I2] - PSI2 * E
                'END'
            'END'
        'END';
        'IF' N > 0 'THEN' 'GOTO' IN;
    OUT: EM[3]:= W; EM[5]:= COUNT; COMVALQRI:= N
    'END' COMVALQRI

        ;'EOP'
