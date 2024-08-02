'CODE' 34191;
    'COMMENT' MCA 2421;
    'PROCEDURE' COMVECHES(A, N, LAMBDA, MU, EM, U, V);
    'VALUE' N, LAMBDA, MU;
    'INTEGER' N; 'REAL' LAMBDA, MU; 'ARRAY' A, EM, U, V;
    'BEGIN' 'INTEGER' I, I1, J, COUNT, MAX;
        'REAL' AA, BB, D, M, R, S, W, X, Y, NORM, MACHTOL, TOL;
        'ARRAY' G, F[1:N];
        'BOOLEAN' 'ARRAY' P[1:N];

        NORM:= EM[1]; MACHTOL:= EM[0] * NORM; TOL:= EM[6] * NORM;
        MAX:= EM[8];
        'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' F[I - 1]:= A[I,I - 1]; A[I,1]:= 0 'END';
        AA:= A[1,1] - LAMBDA; BB:= -MU;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' I1:= I + 1; M:= F[I];
            'IF' ABS(M) < MACHTOL 'THEN' M:= MACHTOL;
            A[I,I]:= M; D:= AA ** 2 + BB ** 2; P[I]:= ABS(M) < SQRT(D);
            'IF' P[I] 'THEN'
            'BEGIN' 'COMMENT' A[I,J] * FACTOR AND A[I1,J] - A[I,J];
                F[I]:= R:= M * AA / D; G[I]:= S:= -M * BB / D;
                W:= A[I1,I]; X:= A[I,I1]; A[I1,I]:= Y:= X * S + W * R;
                A[I,I1]:= X:= X * R - W * S;
                AA:= A[I1,I1] - LAMBDA - X; BB:= -(MU + Y);
                'FOR' J:= I + 2 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' W:= A[J,I]; X:= A[I,J];
                    A[J,I]:= Y:= X * S + W * R;
                    A[I,J]:= X:= X * R - W * S; A[J,I1]:= -Y;
                    A[I1,J]:= A[I1,J] - X
                'END'
            'END'
            'ELSE'
            'BEGIN' 'COMMENT' INTERCHANGE A[I1,J] AND
                A[I,J] - A[I1,J] * FACTOR;
                F[I]:= R:= AA / M; G[I]:= S:= BB / M;
                W:= A[I1,I1] - LAMBDA; AA:= A[I,I1] - R * W - S * MU;
                A[I,I1]:= W; BB:= A[I1,I] - S * W + R * MU;
                A[I1,I]:= -MU;
                'FOR' J:= I + 2 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' W:= A[I1,J]; A[I1,J]:= A[I,J] - R * W;
                    A[I,J]:= W;
                    A[J,I1]:= A[J,I] - S * W; A[J,I]:= 0
                'END'
            'END'
        'END'
        P[N]:= 'TRUE'; D:= AA ** 2 + BB ** 2; 'IF' D < MACHTOL ** 2
        'THEN' 'BEGIN' AA:= MACHTOL; BB:= 0; D:= MACHTOL ** 2 'END';
        A[N,N]:= D; F[N]:= AA; G[N]:= -BB;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' U[I]:= 1; V[I]:= 0 'END';
        COUNT:= 0;
     FORWARD: 'IF' COUNT > MAX 'THEN' 'GOTO' OUTM;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' 'IF' P[I] 'THEN'
             'BEGIN' W:= V[I]; V[I]:= G[I] * U[I] + F[I] * W;
                U[I]:= F[I] * U[I] - G[I] * W; 'IF' I < N 'THEN'
                'BEGIN' V[I + 1]:= V[I + 1] - V[I];
                    U[I + 1]:= U[I + 1] - U[I]
                'END'
            'END'
            'ELSE'
            'BEGIN' AA:= U[I + 1]; BB:= V[I + 1];
                U[I + 1]:= U[I] - (F[I] * AA - G[I] * BB); U[I]:= AA;
                V[I + 1]:= V[I] - (G[I] * AA + F[I] * BB); V[I]:= BB
            'END'
        'END' FORWARD;
     BACKWARD: 'FOR' I:= N 'STEP' -1 'UNTIL' 1 'DO'
        'BEGIN' I1:= I + 1;
            U[I]:= (U[I] - MATVEC(I1, N, I, A, U) + ('IF' P[I] 'THEN'
            TAMVEC(I1, N, I, A, V) 'ELSE' A[I1,I] * V[I1])) / A[I,I];
            V[I]:= (V[I] - MATVEC(I1, N, I, A, V) - ('IF' P[I] 'THEN'
            TAMVEC(I1, N, I, A, U) 'ELSE' A[I1,I] * U[I1])) / A[I,I]
        'END' BACKWARD;
     NORMALISE: W:= 1 / SQRT(VECVEC(1, N, 0, U, U) +
        VECVEC(1, N, 0, V, V));
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' U[J]:= U[J] * W; V[J]:= V[J] * W 'END';
        COUNT:= COUNT + 1; 'IF' W > TOL 'THEN' 'GOTO' FORWARD;
     OUTM: EM[7]:= W; EM[9]:= COUNT
    'END' COMVECHES;
        'EOP'
