'CODE' 34180;
    'COMMENT' MCA 2410;
    'INTEGER' 'PROCEDURE' REAVALQRI(A, N, EM, VAL); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, EM, VAL;
    'BEGIN' 'INTEGER' N1, I, I1, J, Q, MAX, COUNT;
        'REAL' DET, W, SHIFT, KAPPA, NU, MU, R, TOL, DELTA, MACHTOL, S;

        MACHTOL:= EM[0] * EM[1]; TOL:= EM[1] * EM[2]; MAX:= EM[4];
        COUNT:= 0; R:= 0;
     IN: N1:= N - 1;
        'FOR' I:= N, I - 1 'WHILE' ('IF' I >= 1 'THEN'
        ABS(A[I + 1,I]) > TOL 'ELSE' 'FALSE') 'DO' Q:= I;
        'IF' Q > 1 'THEN'
        'BEGIN' 'IF' ABS(A[Q,Q - 1]) > R 'THEN'
            R:= ABS(A[Q,Q - 1])
        'END';
        'IF' Q = N 'THEN'
        'BEGIN' VAL[N]:= A[N,N]; N:= N1 'END'
        'ELSE'
        'BEGIN' DELTA:= A[N,N] - A[N1,N1]; DET:= A[N,N1] * A[N1,N];
            'IF' ABS(DELTA) < MACHTOL 'THEN' S:= SQRT(DET) 'ELSE'
            'BEGIN' W:= 2 / DELTA; S:= W * W * DET + 1;
                S:= 'IF' S <= 0 'THEN' -DELTA * .5 'ELSE'
                W * DET / (SQRT(S) + 1)
            'END';
            'IF' Q = N1 'THEN'
            'BEGIN' VAL[N]:= A[N,N] + S;
                VAL[N1]:= A[N1,N1] - S; N:= N - 2
            'END'
            'ELSE'
            'BEGIN' COUNT:= COUNT + 1;
                'IF' COUNT > MAX 'THEN' 'GOTO' OUT;
                SHIFT:= A[N,N] + S; 'IF' ABS(DELTA) < TOL 'THEN'
                'BEGIN' W:= A[N1,N1] - S;
                    'IF' ABS(W) < ABS(SHIFT) 'THEN' SHIFT:= W
                'END';
                A[Q,Q]:= A[Q,Q] - SHIFT;
                'FOR' I:= Q 'STEP' 1 'UNTIL' N - 1 'DO'
                'BEGIN' I1:= I + 1; A[I1,I1]:= A[I1,I1] - SHIFT;
                    KAPPA:= SQRT(A[I,I] ** 2 + A[I1,I] ** 2);
                    'IF' I > Q 'THEN'
                    'BEGIN' A[I,I - 1]:= KAPPA * NU;
                        W:= KAPPA * MU
                    'END'
                    'ELSE' W:= KAPPA; MU:= A[I,I] / KAPPA;
                    NU:= A[I1,I] / KAPPA; A[I,I]:= W;
                    ROTROW(I1, N, I, I1, A, MU, NU);
                    ROTCOL(Q, I, I, I1, A, MU, NU);
                    A[I,I]:= A[I,I] + SHIFT
                'END';
                A[N,N - 1]:= A[N,N] * NU; A[N,N]:= A[N,N] * MU + SHIFT
            'END'
        'END';
        'IF' N > 0 'THEN' 'GOTO' IN;
     OUT: EM[3]:= R; EM[5]:= COUNT; REAVALQRI:= N
    'END' REAVALQRI

        ;'EOP'
