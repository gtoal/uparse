'CODE' 34215;
    'REAL' 'PROCEDURE' FLEMIN(N, X, G, H, FUNCT, IN, OUT);
    'VALUE' N;
    'INTEGER' N; 'ARRAY' X, G, H, IN, OUT;
    'REAL' 'PROCEDURE' FUNCT;
    'BEGIN' 'INTEGER' I, IT, CNTL, EVL, EVLMAX;
        'REAL' F,F0,FMIN,MU,DG,DG0,NRMDELTA,ALFA,RELTOL,ABSTOL,
        EPS, TOLG, AID;
        'ARRAY' V, DELTA, S[1:N];

        RELTOL:= IN[1]; ABSTOL:= IN[2]; MU:= IN[3];
        TOLG:= IN[4]; FMIN:= IN[5]; ALFA:= IN[6];
        EVLMAX:= IN[7]; OUT[4]:= 0; IT := 0;
        F:= FUNCT(N, X, G); EVL:= 1; CNTL:= 0;'IF' ALFA > 0 'THEN'
        'BEGIN' INIVEC(1, N * (N + 1) // 2, H, 0);
            INISYMD(1, N, 0, H, ALFA)
        'END';
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        DELTA[I]:= - SYMMATVEC(1, N, I, H, G);
        DG:= SQRT(VECVEC(1, N, 0, G, G));
        NRMDELTA:= SQRT(VECVEC(1, N, 0, DELTA, DELTA));
        EPS:= SQRT(VECVEC(1, N, 0, X, X)) * RELTOL + ABSTOL;
        DG0:= VECVEC(1, N, 0, DELTA, G);
        'FOR' IT := IT +1  'WHILE'
        (NRMDELTA > EPS 'OR' DG > TOLG ) 'AND' EVL < EVLMAX 'DO'
        'BEGIN' DUPVEC(1, N, 0, S, X); DUPVEC(1, N, 0, V, G);
            'IF' IT >= N 'THEN' ALFA:= 1 'ELSE'
            'BEGIN' 'IF' IT ^= 1 'THEN' ALFA:= ALFA / NRMDELTA 'ELSE'
                'BEGIN' ALFA:= 2 * (FMIN - F) / DG0;
                    'IF' ALFA > 1 'THEN' ALFA:= 1
                'END'
            'END';
            ELMVEC(1, N, 0, X, DELTA, ALFA);
            F0:= F; F:= FUNCT(N, X, G); EVL:= EVL +1 ;
            DG:= VECVEC(1, N, 0, DELTA, G);
            'IF' IT = 1 'OR' F0 - F < - MU * DG0 * ALFA 'THEN'
            'BEGIN' I:= EVLMAX - EVL; CNTL:= CNTL +1 ;
                LINEMIN(N, S, DELTA, NRMDELTA, ALFA, G, FUNCT, F0, F,
                DG0, DG, I, 'FALSE', IN); EVL:= EVL + I;
                DUPVEC(1, N, 0, X, S);
            'END' LINEMINIMIZATION;
            'IF' ALFA ^= 1 'THEN' MULVEC(1, N, 0, DELTA, DELTA, ALFA);
            MULVEC(1, N, 0, V, V, -1); ELMVEC(1, N, 0, V, G, 1);
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            S[I]:= SYMMATVEC(1, N, I, H, V);
            AID:= VECVEC(1, N, 0, V, S); DG:= (DG - DG0) * ALFA;
            'IF' DG > 0 'THEN'
            'BEGIN' 'IF' DG >= AID 'THEN'
                FLEUPD(H, N, DELTA, S, 1 / DG, (1 + AID / DG) / DG)
                'ELSE' DAVUPD(H, N, DELTA, S, 1 / DG, 1 / AID)
            'END' UPDATING;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            DELTA[I]:= -SYMMATVEC(1, N, I, H, G);
            ALFA:= NRMDELTA * ALFA;
            NRMDELTA:= SQRT(VECVEC(1, N, 0, DELTA, DELTA));
            EPS:= SQRT(VECVEC(1, N, 0, X, X)) * RELTOL + ABSTOL;
            DG:= SQRT(VECVEC(1, N, 0, G, G));
            DG0:= VECVEC(1, N, 0, DELTA, G); 'IF' DG0 > 0 'THEN'
            'BEGIN' OUT[4]:= -1 ; 'GOTO' EXIT 'END'
        'END' ITERATION;
    EXIT: OUT[0]:= NRMDELTA; OUT[1]:= DG; OUT[2]:= EVL;
        OUT[3]:= CNTL; FLEMIN:= F
    'END' FLEMIN;
        'EOP'
