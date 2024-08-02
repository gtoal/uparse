'CODE' 33061;
'PROCEDURE' ARK (T, TE, M0, M, U, DERIVATIVE, DATA, OUT);
'INTEGER' M0, M;
'REAL' T, TE;
'ARRAY' U, DATA;
'PROCEDURE' DERIVATIVE, OUT;

'BEGIN' 'INTEGER' P, N, Q;
    'OWN' 'REAL' EC0, EC1, EC2, TAU0, TAU1, TAU2, TAUS, T2;
    'REAL' THETANM1, TAU, BETAN, QINV, ETA;
    'ARRAY' MU, LAMBDA[1:DATA[1]], THETHA[0:DATA[1]], RO, R[M0:M];
    'BOOLEAN' START, STEP1, LAST;

    'PROCEDURE' INITIALIZE;
    'BEGIN' 'INTEGER' I, J, K, L, N1; 'REAL' S, THETA0;
        'ARRAY' ALFA[1:8, 1:DATA[1]+1], TH[1:8], AUX[1:3];

        'REAL' 'PROCEDURE' LABDA(I, J); 'VALUE' I, J; 'INTEGER' I, J;
        LABDA:= 'IF' P < 3 'THEN' ('IF' J =I-1 'THEN' MUI(I) 'ELSE' 0)
                'ELSE' 'IF' P =3 'THEN' ('IF' I =N 'THEN' ('IF' J=0
                'THEN' .25 'ELSE' 'IF' J =N - 1 'THEN' .75
                'ELSE' 0) 'ELSE' 'IF' J =0 'THEN' ('IF' I =1
                'THEN' MUI(1) 'ELSE' .25) 'ELSE' 'IF' J =I - 1
                'THEN' LAMBDA[I] 'ELSE' 0) 'ELSE' 0;

        'REAL' 'PROCEDURE' MUI(I); 'VALUE' I; 'INTEGER' I;
        MUI:= 'IF' I =N 'THEN' 1 'ELSE'
              'IF' I < 1 ! I > N 'THEN' 0 'ELSE'
              'IF' P < 3 'THEN' LAMBDA[I] 'ELSE'
              'IF' P =3 'THEN' LAMBDA[I] + .25 'ELSE' 0;

        'REAL' 'PROCEDURE' SUM(I, A, B, X);
        'VALUE' B; 'INTEGER' I, A, B; 'REAL' X;
        'BEGIN' 'REAL' S; S:= 0;
            'FOR' I:= A 'STEP' 1 'UNTIL' B 'DO' S:= S + X;
            SUM:= S
        'END' SUM;
        N:= DATA[1]; P:= DATA[2]; EC1:= EC2 := 0;
        BETAN:= DATA[3];
        THETANM1:= 'IF' P=3 'THEN' .75 'ELSE' 1;
        THETA0:= 1 - THETANM1; S:= 1;
        'FOR' J:= N - 1 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' S:= - S * THETA0 + DATA[N + 10 - J];
            MU[J]:= DATA[N + 11 - J] / S;
            LAMBDA[J]:= MU[J] - THETA0
        'END';
        'FOR' I:= 1 'STEP' 1 'UNTIL' 8 'DO'
        'FOR' J:= 0 'STEP' 1 'UNTIL' N 'DO'
        ALFA[I, J + 1]:= 'IF' I = 1 'THEN' 1 'ELSE'
          'IF' J = 0 'THEN' 0 'ELSE' 'IF' I = 2 ! I = 4 ! I = 8 'THEN'
          MUI(J) ** ENTIER((I + 2) / 3) 'ELSE'
          'IF' (I = 3 ! I = 6) & J > 1 'THEN' SUM(L, 1, J-1,
          LABDA(J, L) * MUI(L) ** ENTIER(I / 3)) 'ELSE'
          'IF' I = 5 & J > 2 'THEN' SUM(L, 2, J - 1, LABDA(J, L) *
          SUM(K, 1, L - 1, LABDA(L, K) * MUI(K))) 'ELSE'
          'IF' I = 7 & J > 1 'THEN' SUM(L, 1, J - 1, LABDA(J, L) *
          MUI(L)) * MUI(J) 'ELSE' 0;
        N1:='IF' N < 4 'THEN' N + 1 'ELSE' 'IF' N < 7 'THEN' 4
          'ELSE' 8;
        I:= 1;
        'FOR' S:= 1, .5, 1 / 6, 1 / 3, 1 / 24, 1 / 12, .125, .25 'DO'
        'BEGIN' TH[I]:= S; I:= I + 1 'END';
        'IF' P = 3 & N < 7 'THEN' TH[1]:= TH[2]:= 0;
        AUX[2]:= @ - 14; DECSOL(ALFA, N1, AUX, TH);
        INIVEC(0, N, THETHA, 0);
        DUPVEC(0, N1 - 1, 1, THETHA, TH);
        'IF' ^ (P = 3 & N < 7) 'THEN'
        'BEGIN' THETHA[0]:= THETHA[0] - THETA0;
            THETHA[N - 1]:= THETHA[N - 1] - THETANM1; Q:= P + 1
        'END' 'ELSE' Q:= 3;
        QINV:= 1 / Q;
        START:= DATA[8] = 0; DATA[10]:= 0; LAST:= 'FALSE';
        DUPVEC(M0, M, 0, R, U); DERIVATIVE(T, R)
    'END' INITIALIZE;

    'PROCEDURE' LOCAL ERROR CONSTRUCTION(I); 'VALUE' I; 'INTEGER' I;
    'BEGIN' 'IF' THETHA[I] ^= 0 'THEN'
        ELMVEC(M0, M, 0, RO, R, THETHA[I]);
        'IF' I = N 'THEN'
        'BEGIN' DATA[9]:= SQRT(VECVEC(M0, M, 0, RO, RO))* TAU;
            EC0:= EC1; EC1:= EC2; EC2:= DATA[9] / TAU ** Q
        'END'
    'END' LEC;

    'PROCEDURE' STEPSIZE;
    'BEGIN' 'REAL' TAUACC, TAUSTAB, AA, BB, CC, EC;
        ETA:= SQRT(VECVEC(M0, M, 0, U, U)) * DATA[7] + DATA[6];
        'IF' ETA > 0 'THEN'
        'BEGIN' 'IF' START 'THEN'
            'BEGIN' 'IF' DATA[8] = 0 'THEN'
                'BEGIN' TAUACC:= DATA[5];
                    STEP1:= 'TRUE'
                'END' 'ELSE' 'IF' STEP1 'THEN'
                'BEGIN' TAUACC:= (ETA / EC2) ** QINV;
                    'IF' TAUACC > 10 * TAU2 'THEN'
                    TAUACC:= 10 * TAU2 'ELSE' STEP1:= 'FALSE'
                'END' 'ELSE'
                'BEGIN' BB:= (EC2 - EC1) / TAU1; CC:= - BB * T2 + EC2;
                    EC:= BB * T + CC;
                    TAUACC:= 'IF' EC < 0 'THEN' TAU2 'ELSE'
                    (ETA / EC) ** QINV;
                    START:= 'FALSE'
                'END'
            'END' 'ELSE'
            'BEGIN' AA:= ((EC0 - EC1) / TAU0 + (EC2 - EC1) / TAU1)
                        / (TAU1 + TAU0);
                BB:= (EC2 - EC1) / TAU1 - (2 * T2 - TAU1) * AA;
                CC:= - (AA * T2 + BB) * T2 + EC2;
                EC:= (AA * T + BB) * T + CC;
                TAUACC:= 'IF' EC < 0 'THEN'
                         TAUS 'ELSE' (ETA / EC) ** QINV;
                'IF' TAUACC > 2 * TAUS 'THEN' TAUACC:= 2 * TAUS;
                'IF' TAUACC < TAUS / 2 'THEN' TAUACC:= TAUS / 2
            'END'
        'END' 'ELSE' TAUACC:= DATA[5];
         'IF' TAUACC < DATA[5] 'THEN' TAUACC:= DATA[5];
        TAUSTAB:= BETAN / DATA[4]; 'IF' TAUSTAB < DATA[5] 'THEN'
        'BEGIN' DATA[10]:= 1; 'GOTO' ENDARK 'END';
        TAU:= 'IF' TAUACC > TAUSTAB 'THEN' TAUSTAB 'ELSE' TAUACC;
        TAUS:= TAU; 'IF' TAU >= TE - T 'THEN'
        'BEGIN' TAU:= TE - T; LAST:= 'TRUE' 'END';
        TAU0:= TAU1; TAU1:= TAU2; TAU2:= TAU
    'END' STEPSIZE

    'PROCEDURE' DIFFERENCE SCHEME;
    'BEGIN' 'INTEGER' I, J;
        'REAL' MT, LT;
        MULVEC(M0, M, 0, RO, R, THETHA[0]);
        'IF' P = 3 'THEN' ELMVEC(M0, M, 0, U, R, .25 * TAU);
        'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' MT:= MU[I] * TAU; LT:= LAMBDA[I] * TAU;
            'FOR' J:= M0 'STEP' 1 'UNTIL' M 'DO'
            R[J]:= LT * R[J] + U[J];
            DERIVATIVE(T + MT, R); LOCAL ERROR CONSTRUCTION(I)
        'END';
        ELMVEC(M0, M, 0, U, R, THETANM1 * TAU);
        DUPVEC(M0, M, 0, R, U); DERIVATIVE(T + TAU, R);
        LOCAL ERROR CONSTRUCTION(N); T2:= T;
        'IF' LAST 'THEN'
        'BEGIN' LAST:= 'FALSE'; T:= TE 'END' 'ELSE' T:= T + TAU;
        DATA[8]:= DATA[8]+1
    'END' DIFSCH;

    INITIALIZE;

  NEXT STEP:
    STEPSIZE; DIFFERENCE SCHEME; OUT;
    'IF' T ^= TE 'THEN' 'GOTO' NEXT STEP;

  ENDARK:
'END' ARK;
        'EOP'
