'CODE' 34186;
    'COMMENT' MCA 2416;
    'INTEGER' 'PROCEDURE' REAQRI(A, N, EM, VAL, VEC); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, EM, VAL, VEC;
    'BEGIN' 'INTEGER' M1, I, I1, M, J, Q, MAX, COUNT;
        'REAL' W, SHIFT, KAPPA, NU, MU, R, TOL, S, MACHTOL,
        ELMAX, T, DELTA, DET;
        'ARRAY' TF[1:N];

        MACHTOL:= EM[0] * EM[1]; TOL:= EM[1] * EM[2]; MAX:= EM[4];
        COUNT:= 0; ELMAX:= 0; M:= N;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' VEC[I,I]:= 1;
            'FOR' J:= I + 1 'STEP' 1 'UNTIL' N 'DO'
            VEC[I,J]:= VEC[J,I]:= 0
        'END';
     IN: M1:= M - 1;
        'FOR' I:= M, I - 1 'WHILE' ('IF' I >= 1 'THEN'
        ABS(A[I + 1,I]) > TOL 'ELSE' 'FALSE') 'DO' Q:= I;
        'IF' Q > 1 'THEN'
        'BEGIN' 'IF' ABS(A[Q,Q - 1]) > ELMAX 'THEN'
            ELMAX:= ABS(A[Q, Q - 1])
        'END';
        'IF' Q = M 'THEN'
        'BEGIN' VAL[M]:= A[M,M]; M:= M1 'END'
        'ELSE'
        'BEGIN' DELTA:= A[M,M] - A[M1,M1]; DET:= A[M,M1] * A[M1,M];
            'IF' ABS(DELTA) < MACHTOL 'THEN' S:= SQRT(DET) 'ELSE'
            'BEGIN' W:= 2 / DELTA; S:= W * W * DET + 1;
                S:= 'IF' S <= 0 'THEN' -DELTA * .5 'ELSE'
                W * DET / (SQRT(S) + 1)
            'END';
            'IF' Q = M1 'THEN'
            'BEGIN' A[M,M]:= VAL[M]:= A[M,M] + S;
                A[Q,Q]:= VAL[Q]:= A[Q,Q] - S;
                T:= 'IF' ABS(S) < MACHTOL 'THEN'
                (S + DELTA) / A[M,Q] 'ELSE' A[Q,M] / S;
                R:= SQRT(T * T + 1); NU:= 1 / R;
                MU:= -T * NU; A[Q,M]:= A[Q,M] - A[M,Q];
                ROTROW(Q + 2, N, Q, M, A, MU, NU);
                ROTCOL(1, Q - 1, Q, M, A, MU, NU);
                ROTCOL(1, N, Q, M, VEC, MU, NU); M:= M - 2
            'END'

            'ELSE'
            'BEGIN' COUNT:= COUNT + 1;
                'IF' COUNT > MAX 'THEN' 'GOTO' END;
                SHIFT:= A[M,M] + S; 'IF' ABS(DELTA) < TOL 'THEN'
                'BEGIN' W:= A[M1,M1] - S;
                    'IF' ABS(W) < ABS(SHIFT) 'THEN' SHIFT:= W
                'END';
                A[Q,Q]:= A[Q,Q] - SHIFT;
                'FOR' I:= Q 'STEP' 1 'UNTIL' M1 'DO'
                'BEGIN' I1:= I + 1; A[I1,I1]:= A[I1,I1] - SHIFT;
                    KAPPA:= SQRT(A[I,I] ** 2 + A[I1,I] ** 2);
                    'IF' I > Q 'THEN'
                    'BEGIN' A[I,I - 1]:= KAPPA * NU;
                        W:= KAPPA * MU
                    'END'
                    'ELSE' W:= KAPPA; MU:= A[I,I] / KAPPA;
                    NU:= A[I1,I] / KAPPA; A[I,I]:= W;
                    ROTROW(I1, N, I, I1, A, MU, NU);
                    ROTCOL(1, I, I, I1, A, MU, NU);
                    A[I,I]:= A[I,I] + SHIFT;
                    ROTCOL(1, N, I, I1, VEC, MU, NU)
                'END';
                A[M,M1]:= A[M,M] * NU; A[M,M]:= A[M,M] * MU + SHIFT
            'END'
        'END';
        'IF' M > 0 'THEN' 'GOTO' IN;
        'FOR' J:= N 'STEP' -1 'UNTIL' 2 'DO'
        'BEGIN' TF[J]:= 1; T:= A[J,J];
            'FOR' I:= J - 1 'STEP' -1 'UNTIL' 1 'DO'
            'BEGIN' DELTA:= T - A[I,I];
                TF[I]:= MATVEC(I + 1, J, I, A, TF) /
                ('IF' ABS(DELTA) < MACHTOL 'THEN' MACHTOL 'ELSE' DELTA)
            'END';
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            VEC[I,J]:= MATVEC(1, J, I, VEC, TF)
        'END';
     END: EM[3]:= ELMAX; EM[5]:= COUNT; REAQRI:= M
    'END' REAQRI

        ;'EOP'
