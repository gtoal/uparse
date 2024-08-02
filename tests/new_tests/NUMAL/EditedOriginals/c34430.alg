'CODE' 34430;
    'PROCEDURE' QUANEWBND(N, LW, RW, X, F, JAC, FUNCT, IN, OUT);
    'VALUE' N, LW, RW; 'INTEGER' N, LW, RW;
    'ARRAY' X, F, JAC, IN, OUT; 'BOOLEAN' 'PROCEDURE' FUNCT;
    'BEGIN' 'INTEGER' L, IT, FCNT, FMAX, ERR, B;
        'REAL' MACHEPS, RELTOL, ABSTOL, TOLRES, ND, MZ, RES;
        'ARRAY' DELTA[1:N];

        'REAL' 'PROCEDURE' EVALUATE(N, X, F); 'VALUE' N;
        'INTEGER' N; 'ARRAY' X, F;
        'BEGIN' FCNT:= FCNT + N; 'IF' 'NOT' FUNCT(N, 1, N, X, F) 'THEN'
            'BEGIN' ERR:= 2; 'GOTO' EXIT 'END';
            'IF' FCNT > FMAX 'THEN' ERR:= 1;
            EVALUATE:= SQRT(VECVEC(1, N, 0, F, F))
        'END' EVAL;

        'BOOLEAN' 'PROCEDURE' DIRECTION;
        'BEGIN' 'ARRAY' LU[1:L], AUX[1:5]; AUX[2]:= MACHEPS;
            MULVEC(1, N, 0, DELTA, F, -1); DUPVEC(1, L, 0, LU, JAC);
            DECSOLBND(LU, N, LW, RW, AUX, DELTA);
            DIRECTION:= AUX[3] = N
        'END' SOLLINSYS;

        'BOOLEAN' 'PROCEDURE' TEST(ND, TOLD, NRES, TOLRES, ERR);
        'VALUE' ND, TOLD; 'INTEGER' ERR; 'REAL' ND, TOLD, NRES, TOLRES;
        TEST:= ERR ^= 0 'OR' (NRES < TOLRES 'AND' ND < TOLD);

        'PROCEDURE' UPDATE JAC;
        'BEGIN' 'INTEGER'  I, J, K, R, M; 'REAL' MUL, CRIT;
            'ARRAY' PP, S[1:N];
            CRIT:= ND * MZ;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' PP[I]:= DELTA[I] ** 2;
            R:= 1; K:= 1; M:= RW + 1;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' MUL:= 0; 'FOR' J:= R 'STEP' 1 'UNTIL' M 'DO'
                MUL:= MUL + PP[J]; J:= R - K;
                'IF' ABS(MUL) > CRIT 'THEN'
                ELMVEC(K, M - J, J, JAC, DELTA, F[I] / MUL); K:= K + B;
                'IF' I > LW 'THEN' R:= R + 1 'ELSE' K:= K - 1;
                'IF' M < N 'THEN' M:= M + 1
            'END'
        'END' UPDATEJAC

        MACHEPS:= IN[0]; RELTOL:= IN[1]; ABSTOL:= IN[2];
        TOLRES:= IN[3]; FMAX:= IN[4]; MZ:= MACHEPS ** 2;
        IT:= FCNT:= 0; B:= LW + RW; L:= (N - 1) * B + N; B:= B + 1;
        RES:= SQRT(VECVEC(1, N, 0, F, F)); ERR:= 0;
    ITERATE: 'IF' ^ TEST(SQRT(ND), SQRT(VECVEC(1, N, 0, X, X)) * RELTOL
        + ABSTOL, RES, TOLRES, ERR) 'THEN'
        'BEGIN' IT:= IT + 1; 'IF' IT ^= 1 'THEN' UPDATEJAC;
            'IF' ^ DIRECTION 'THEN' ERR:= 3 'ELSE'
            'BEGIN' ELMVEC(1, N, 0, X, DELTA, 1);
                ND:= VECVEC(1, N, 0, DELTA, DELTA);
                RES:= EVALUATE(N, X, F); 'GOTO' ITERATE
             'END'
        'END';
    EXIT: OUT[1]:= SQRT(ND); OUT[2]:=RES; OUT[3]:= FCNT;
        OUT[4]:= IT; OUT[5]:= ERR
    'END' QUANEWBND;
        'EOP'
