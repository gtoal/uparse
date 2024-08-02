'CODE' 33160;
    'PROCEDURE' EFSIRK(X, XE, M, Y, DELTA, DERIVATIVE, JACOBIAN, J,
                       N, AETA, RETA, HMIN, HMAX, LINEAR, OUTPUT);
    'VALUE' M; 'INTEGER' M, N;
    'REAL' X, XE, DELTA, AETA, RETA, HMIN, HMAX;
    'PROCEDURE' DERIVATIVE, JACOBIAN, OUTPUT;
    'BOOLEAN' LINEAR;
    'ARRAY' Y, J;

    'BEGIN' 'INTEGER' K, L;
        'REAL' STEP, H, MU0, MU1, MU2, THETA0, THETA1, NU1, NU2,
        NU3, YK, FK, C1, C2, D;
        'ARRAY' F, K0, LABDA[1 : M], J1[1 : M,1 : M], AUX[1 : 7];
        'INTEGER' 'ARRAY' RI, CI[1 : M];
        'BOOLEAN' LIN;
        'REAL' 'PROCEDURE' STEPSIZE;
        'BEGIN' 'REAL' DISCR, ETA, S;
            'IF' LINEAR 'THEN' S:= H:= HMAX 'ELSE'
            'IF' N = 1 'OR' HMIN = HMAX 'THEN' S:= H:= HMIN 'ELSE'
            'BEGIN' ETA:= AETA + RETA * SQRT(VECVEC(1, M, 0, Y, Y));
                C1:= NU3 * STEP; 'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
                LABDA[K]:= LABDA[K] + C1 * F[K] - Y[K];
                DISCR:= SQRT(VECVEC(1, M, 0, LABDA, LABDA));
                S:= H:= (ETA / (0.75 * (ETA + DISCR)) + 0.33) * H;
                'IF' H < HMIN 'THEN' S:= H:= HMIN 'ELSE'
                'IF' H > HMAX 'THEN' S:= H:= HMAX
            'END';
            'IF' X + S > XE 'THEN' S:= XE - X;
            LIN:= STEP = S 'AND' LINEAR; STEPSIZE:= S
        'END' STEPSIZE;

        'PROCEDURE' COEFFICIENT;
        'BEGIN' 'REAL' Z1, E, ALPHA1, A, B;
            'OWN' 'REAL' Z2;
            Z1:= STEP * DELTA; 'IF' N = 1 'THEN' Z2:= Z1 + Z1;
            'IF' ABS(Z2 - Z1) > @ - 6 * ABS(Z1) 'OR' Z2 > - 1 'THEN'
            'BEGIN' A:= Z1 * Z1 + 12; B:= 6 * Z1;
                'IF' ABS(Z1) < 0.1 'THEN'
                ALPHA1:= (Z1 * Z1 / 140 - 1) * Z1 / 30 'ELSE'
                'IF' Z1 < - @14 'THEN' ALPHA1:= 1 / 3 'ELSE'
                'IF' Z1 < - 33 'THEN'
                ALPHA1:= (A + B) / (3 * Z1 * (2 + Z1)) 'ELSE'
                'BEGIN' E:= 'IF' Z1 < 230 'THEN' EXP(Z1) 'ELSE' @100;
                    ALPHA1:= ((A - B) * E - A - B) /
                             (((2 - Z1) * E - 2 - Z1) * 3 * Z1)
                'END';
                MU2:= (1 / 3 + ALPHA1) * 0.25;
                MU1:= - (1 + ALPHA1) * 0.5;
                MU0:= (6 * MU1 + 2) / 9; THETA0:= 0.25;
                THETA1:= 0.75; A:= 3 * ALPHA1;
                NU3:= (1 + A) / (5 - A) * 0.5; A:= NU3 + NU3;
                NU1:= 0.5 - A; NU2:= (1 + A) * 0.75;
                Z2:= Z1
            'END'
        'END' COEFFICIENT;

        'PROCEDURE' DIFFERENCE SCHEME;
        'BEGIN' DERIVATIVE(F); STEP:= STEPSIZE;
            'IF' 'NOT' LINEAR 'OR' N = 1 'THEN' JACOBIAN(J, Y);
            'IF' 'NOT' LIN 'THEN'
            'BEGIN' COEFFICIENT;
                C1:= STEP * MU1; D:= STEP * STEP * MU2;
                'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
                'BEGIN' 'FOR' L:= 1 'STEP' 1 'UNTIL' M 'DO'
                    J1[K,L]:= D * MATMAT(1, M, K, L, J, J) +
                              C1 * J[K,L];
                    J1[K,K]:= J1[K,K] + 1
                'END';
                GSSELM(J1, M, AUX, RI, CI)
            'END';
            C1:= STEP * STEP * MU0; D:= STEP * 2 / 3;
            'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
            'BEGIN' K0[K]:= FK:= F[K];
                LABDA[K]:= D * FK + C1 * MATVEC(1, M, K, J, F)
            'END';
            SOLELM(J1, M, RI, CI, LABDA);
            'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO' F[K]:= Y[K] + LABDA[K];
            DERIVATIVE(F);
            C1:= THETA0 * STEP; C2:= THETA1 * STEP; D:= NU1 * STEP;
            'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
            'BEGIN' YK:= Y[K]; FK:= F[K];
                LABDA[K]:= YK + D * FK + NU2 * LABDA[K];
                Y[K]:= F[K]:= YK + C1 * K0[K] + C2 * FK
            'END'
        'END' DIFFERENCE SCHEME;

        AUX[2]:= @-14; AUX[4]:= 8;
        'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO' F[K]:= Y[K];
        N:= 0; OUTPUT; STEP:= 0;
    NEXT STEP: N:= N + 1;
        DIFFERENCE SCHEME; X:= X + STEP; OUTPUT;
        'IF' X < XE 'THEN' 'GOTO' NEXT STEP
    'END' EFSIRK;
        'EOP'
