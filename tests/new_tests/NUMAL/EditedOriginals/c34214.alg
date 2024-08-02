'CODE' 34214;
    'REAL' 'PROCEDURE' RNK1MIN(N, X, G, H, FUNCT, IN, OUT);
    'VALUE' N;
    'INTEGER' N; 'ARRAY' X, G, H, IN, OUT;
    'REAL' 'PROCEDURE' FUNCT;
    'BEGIN' 'INTEGER' I, IT, N2, CNTL, CNTE, EVL, EVLMAX;
        'BOOLEAN' OK;
        'REAL' F, F0, FMIN, MU, DG, DG0, GHG, GS, NRMDELTA, ALFA,
        MACHEPS, RELTOL, ABSTOL, EPS, TOLG, ORTH, AID;
        'ARRAY' V, DELTA, GAMMA, S, P[1:N];

        MACHEPS:= IN[0]; RELTOL:= IN[1]; ABSTOL:= IN[2];
        MU:= IN[3]; TOLG:= IN[4]; FMIN:= IN[5]; IT := 0;
        ALFA:= IN[6]; EVLMAX:= IN[7]; ORTH:= IN[8];
        N2:= N * (N + 1) // 2; CNTL:= CNTE:= 0; 'IF' ALFA > 0 'THEN'
        'BEGIN' INIVEC(1, N2, H, 0); INISYMD(1, N, 0, H, ALFA) 'END';
        F:= FUNCT(N, X, G); EVL:= 1; DG:= SQRT(VECVEC(1, N, 0, G, G));
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        DELTA[I]:= - SYMMATVEC(1, N, I, H, G);
        NRMDELTA:= SQRT(VECVEC(1, N, 0, DELTA, DELTA));
        DG0:= VECVEC(1, N, 0, DELTA, G); OK:= DG0 < 0;
        EPS:= SQRT(VECVEC(1, N, 0, X, X)) * RELTOL + ABSTOL;
        'FOR' IT:= IT + 1  'WHILE'
        (NRMDELTA > EPS 'OR' DG > TOLG 'OR' 'NOT' OK) 'AND' EVL < EVLMAX
        'DO'
        'BEGIN' 'IF' 'NOT' OK 'THEN'
            'BEGIN' 'ARRAY' VEC[1:N,1:N], TH[1:N2], EM[0:9];
                EM[0]:= MACHEPS; EM[2]:= AID:= SQRT(MACHEPS * RELTOL);
                EM[4]:= ORTH; EM[6]:= AID * N; EM[8]:= 5;
                CNTE:= CNTE + 1; DUPVEC(1, N2, 0, TH, H);
                EIGSYM1(TH,N,N,V,VEC,EM);
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' AID:= - TAMVEC(1, N, I, VEC, G);
                    S[I]:= AID * ABS(V[I]); V[I]:= AID * SIGN(V[I])
                'END';
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' DELTA[I]:= MATVEC(1, N, I, VEC, S);
                    P[I]:= MATVEC(1, N, I, VEC, V)
                'END';
                DG0:= VECVEC(1, N, 0, DELTA, G);
                NRMDELTA:= SQRT(VECVEC(1, N, 0, DELTA, DELTA))
            'END' CALCULATING GREENSTADTS DIRECTION;
            DUPVEC(1, N, 0, S, X); DUPVEC(1, N, 0, V, G);
            'IF' IT > N 'THEN' ALFA:= 1 'ELSE'
            'BEGIN' 'IF' IT ^= 1 'THEN' ALFA:= ALFA / NRMDELTA 'ELSE'
                'BEGIN' ALFA:= 2 * (FMIN - F) / DG0;
                'IF' ALFA > 1 'THEN' ALFA:= 1
                'END'
            'END';
            ELMVEC(1, N, 0, X, DELTA, ALFA);
            F0:= F; F:= FUNCT(N, X, G); EVL:= EVL +1 ;
            DG:= VECVEC(1, N, 0, DELTA, G);
            'IF' IT = 1 'OR' F0 - F < -MU * DG0 * ALFA 'THEN'
            'BEGIN' I:= EVLMAX - EVL; CNTL:= CNTL +1 ;
                LINEMIN(N, S, DELTA, NRMDELTA, ALFA, G, FUNCT, F0, F,
                DG0, DG, I, 'FALSE', IN); EVL:= EVL + I;
                DUPVEC(1, N, 0, X, S);
            'END' LINEMINIMIZATION;
            DUPVEC(1, N, 0, GAMMA, G); ELMVEC(1, N, 0, GAMMA, V, -1);
            'IF' 'NOT' OK 'THEN' MULVEC(1, N, 0, V, P, -1);
            DG:= DG - DG0; 'IF' ALFA ^= 1 'THEN'
            'BEGIN' MULVEC(1, N, 0, DELTA, DELTA, ALFA);
                MULVEC(1, N, 0, V, V, ALFA);
                NRMDELTA:= NRMDELTA * ALFA; DG:= DG * ALFA
            'END';
            DUPVEC(1, N, 0, P, GAMMA); ELMVEC(1, N, 0, P, V, 1);
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            V[I]:= SYMMATVEC(1, N, I, H, GAMMA);
            DUPVEC(1, N, 0, S, DELTA); ELMVEC(1, N, 0, S, V, -1);
            GS:= VECVEC(1, N, 0, GAMMA, S);
            GHG:= VECVEC(1, N, 0, V, GAMMA);
            AID:= DG / GS;
            'IF' VECVEC(1, N, 0, DELTA, P) ** 2 > VECVEC(1, N, 0, P, P)
            * (ORTH * NRMDELTA) ** 2 'THEN' RNK1UPD(H, N, S, 1 / GS)
            'ELSE' 'IF' AID >= 0 'THEN'
            FLEUPD(H, N, DELTA, V, 1 / DG, (1 + GHG / DG) / DG) 'ELSE'
            DAVUPD(H, N, DELTA, V, 1 / DG, 1 / GHG);
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            DELTA[I]:= -SYMMATVEC(1, N, I, H, G);
            ALFA:= NRMDELTA;
            NRMDELTA:= SQRT(VECVEC(1, N, 0, DELTA, DELTA));
            EPS:= SQRT(VECVEC(1, N, 0, X, X)) * RELTOL + ABSTOL;
            DG:= SQRT(VECVEC(1, N, 0, G, G));
            DG0:= VECVEC(1, N, 0, DELTA, G); OK:= DG0 <= 0
        'END' ITERATION;
        OUT[0]:= NRMDELTA; OUT[1]:= DG; OUT[2]:= EVL;
        OUT[3]:= CNTL; OUT[4]:= CNTE; RNK1MIN:= F
    'END' RNK1MIN;

        'EOP'
