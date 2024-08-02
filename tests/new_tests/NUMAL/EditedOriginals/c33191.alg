'CODE' 33191;
   'PROCEDURE' GMS(X, XE, R, Y, H, HMIN, HMAX, DELTA, DERIVATIVE,
                   JACOBIAN, AETA, RETA, N, JEV, LU, NSJEV,
                   LINEAR, OUT);
   'VALUE' R;
   'REAL' X, XE, H, HMIN, HMAX, DELTA, AETA, RETA;
   'INTEGER' R, N, JEV, NSJEV, LU;
   'BOOLEAN' LINEAR;
   'ARRAY' Y;
   'PROCEDURE' DERIVATIVE, JACOBIAN, OUT;
   'BEGIN'
       'INTEGER' I, J, K, L, NSJEV1, COUNT, COUNT1, KCHANGE;
       'REAL' A, A1, ALFA, E, S1, S2, Z1, X0, XL0, XL1,
       XL2, ETA, H0, H1, Q, Q1, Q2, Q12, Q22, Q1Q2, DISCR;
       'BOOLEAN' UPDATE, CHANGE, REEVAL, STRATEGY;
       'INTEGER' 'ARRAY' RI, CI[1:R];
       'ARRAY' AUX[1:9], BD1, BD2[1:3,1:3], Y1,
       Y0[1:R], HJAC, H2JAC2, RQZ[1:R,1:R], YL, FL[1:3 * R];

       'PROCEDURE' INITIALIZATION;
       'BEGIN' LU:= JEV:= N:= NSJEV1:= KCHANGE:= 0; X0:= X; DISCR:= 0;
           K:=1; H1:= H0:= H; COUNT:= -2; AUX[2]:= @-14; AUX[4]:= 8;
           DUPVEC(1, R, 0, YL, Y); REEVAL:= CHANGE:= 'TRUE';
           STRATEGY:= HMIN ^= HMAX 'AND' ^LINEAR; Q1:= -1; Q2:= -2;
           COUNT1:= 0; XL0:= XL1:= XL2:= 0
       'END' INITIALIZATION;

       'PROCEDURE' COEFFICIENT;
       'BEGIN' XL2:= XL1; XL1:= XL0; XL0:= X0;
           'IF' CHANGE 'THEN'
           'BEGIN' 'IF' N > 2 'THEN'
               'BEGIN' Q1:= (XL1 - XL0) / H1;
                   Q2:= (XL2 - XL0) / H1
               'END';
               Q12:= Q1 * Q1; Q22:= Q2 * Q2; Q1Q2:= Q1 * Q2;
               A:= -(3 * ALFA + 1) / 12;
               BD1[1,3]:= 1 + (1 / 3 - (Q1 + Q2) * .5) / Q1Q2;
               BD1[2,3]:= (1 / 3 - Q2 * .5) / (Q12 - Q1Q2);
               BD1[3,3]:= (1 / 3 - Q1 * .5) / (Q22 - Q1Q2);
               BD2[1,3]:= -ALFA * .5 + A * (1 - Q1 - Q2) / Q1Q2;
               BD2[2,3]:= A * (1 - Q2) / (Q12 - Q1Q2);
               BD2[3,3]:= A * (1 - Q1) / (Q22 - Q1Q2);
               'IF' STRATEGY 'OR' N <= 2 'THEN'
               'BEGIN' BD1[2,2]:= 1 / (2 * Q1);
                   BD1[1,2]:= 1 - BD1[2,2];
                   BD2[2,2]:= -(3 * ALFA + 1) / (12 * Q1);
                   BD2[1,2]:= -BD2[2,2] - ALFA * .5
               'END'
           'END'
       'END' COEFFICIENT;

       'PROCEDURE' OPERATOR CONSTRUCTION;
       'BEGIN' 'IF' REEVAL 'THEN'
           'BEGIN' JACOBIAN(HJAC, Y);
               JEV:= JEV + 1; NSJEV1:= 0;
               'IF' DELTA <= -@15 'THEN' ALFA:= 1 / 3 'ELSE'
               'BEGIN' Z1:= H1 * DELTA;
                   A:= Z1 * Z1 + 12; A1:= 6 * Z1;
                   'IF' ABS(Z1) < .1 'THEN'
                   ALFA:= (Z1 * Z1 / 140 - 1) * Z1 / 30 'ELSE'
                   'IF' Z1 < -33 'THEN'
                   ALFA:= (A + A1) / (3 * Z1 * (2 + Z1)) 'ELSE'
                   'BEGIN' E:= EXP(Z1); ALFA:= ((A - A1) *
                       E - A - A1) / (((2 - Z1) * E - 2 - Z1) *
                       Z1 * 3)
                   'END'
               'END';
               S1:= -(1 + ALFA) * .5; S2:= (ALFA * 3 + 1) / 12
           'END';
           A:= H1 / H0; A1:= A * A;
           'IF' REEVAL 'THEN' A:= H1;
           'IF' A ^= 1 'THEN'
           'FOR' J:= 1 'STEP' 1 'UNTIL' R 'DO'
           COLCST(1, R, J, HJAC, A);
           'FOR' I:= 1 'STEP' 1 'UNTIL' R 'DO'
           'BEGIN' 'FOR' J:= 1 'STEP' 1 'UNTIL' R 'DO'
               'BEGIN' Q:= H2JAC2[I,J]:= 'IF' REEVAL 'THEN'
                   MATMAT(1, R, I, J, HJAC, HJAC)
                   'ELSE' H2JAC2[I,J] * A1;
                   RQZ[I,J]:= S2 * Q
               'END';
               RQZ[I,I]:= RQZ[I,I] + 1;
               ELMROW(1, R, I, I, RQZ, HJAC, S1)
           'END';
           GSSELM(RQZ, R, AUX, RI, CI); LU:= LU + 1;
           REEVAL:= UPDATE:= 'FALSE'
       'END' OPERATOR CONSTRUCTION;

       'PROCEDURE' DIFFERENCE SCHEME;
       'BEGIN' 'IF' COUNT ^= 1 'THEN'
           'BEGIN' DUPVEC(1, R, 0, FL, YL);
               DERIVATIVE(FL); N:= N + 1; NSJEV1:= NSJEV1 + 1
           'END';
           MULVEC(1, R, 0, Y0, YL, (1 - ALFA) / 2 - BD1[1,K]);
           'FOR' L:= 2 'STEP' 1 'UNTIL' K 'DO'
           ELMVEC(1, R, R * (L - 1), Y0, YL, -BD1[L,K]);
           'FOR' L:= 1 'STEP' 1 'UNTIL' K 'DO'
           ELMVEC(1, R, R * (L - 1), Y0, FL, H1 * BD2[L,K]);
           'FOR' I:= 1 'STEP' 1 'UNTIL' R 'DO'
           Y[I]:= MATVEC(1, R, I, HJAC, Y0);
           MULVEC(1, R, 0, Y0, YL, (1 - 3 * ALFA) / 12 - BD2[1,K]);
           'FOR' L:= 2 'STEP' 1 'UNTIL' K 'DO'
           ELMVEC(1, R, R * (L - 1), Y0, YL, -BD2[L,K]);
           'FOR' I:= 1 'STEP' 1 'UNTIL' R 'DO'
           Y[I]:= Y[I] + MATVEC(1, R, I, H2JAC2, Y0);
           DUPVEC(1, R, 0, Y0, YL);
           'FOR' L:= 1 'STEP' 1 'UNTIL' K 'DO'
           ELMVEC(1, R, R * (L - 1), Y0, FL, H1 * BD1[L,K]);
           ELMVEC(1, R, 0, Y, Y0, 1); SOLELM(RQZ, R, RI, CI, Y)
       'END' DIFFERENCE SCHEME;

       'PROCEDURE' NEXT INTEGRATION STEP;
       'BEGIN' 'FOR' L:= 2, 1 'DO'
           'BEGIN' DUPVEC(L * R + 1, (L + 1) * R, -R, YL, YL);
               DUPVEC(L * R + 1, (L + 1) * R, -R, FL, FL)
           'END';
           DUPVEC(1, R, 0, YL, Y)
       'END' NEXT INTEGRATION STEP;

       'PROCEDURE' TEST ACCURACY;
       'BEGIN' K:= 2;
           DUPVEC(1, R, 0, Y1, Y); DIFFERENCE SCHEME; K:= 3;
           ETA:= AETA + RETA * SQRT(VECVEC(1, R, 0, Y1, Y1));
           ELMVEC(1, R, 0, Y, Y1, -1);
           DISCR:= SQRT(VECVEC(1, R, 0, Y, Y));
           DUPVEC(1, R, 0, Y, Y1)
       'END' TEST ACCURACY;

       'PROCEDURE' STEPSIZE;
       'BEGIN' X0:= X; H0:= H1;
           'IF' N <= 2 'AND' ^LINEAR 'THEN' K:= K + 1;
           'IF' COUNT = 1 'THEN'
           'BEGIN' A:= ETA / (.75 * (ETA + DISCR)) + .33;
               H1:= 'IF' A <= .9 'OR' A >= 1.1 'THEN' A * H0
               'ELSE' H0; COUNT:= 0;
               REEVAL:= A <= .9 'AND' NSJEV1 ^= 1;
               COUNT1:= 'IF' A >= 1 'OR' REEVAL 'THEN' 0 'ELSE'
               COUNT1 + 1; 'IF' COUNT1 = 10 'THEN'
               'BEGIN' COUNT1:= 0; REEVAL:= 'TRUE';
                   H1:= A * H0
               'END'
           'END' 'ELSE'
           'BEGIN' H1:= H; REEVAL:= NSJEV = NSJEV1 'AND'
               ^STRATEGY 'AND' ^LINEAR
           'END';
           'IF' STRATEGY 'THEN' H1:= 'IF' H1 > HMAX
           'THEN' HMAX 'ELSE' 'IF' H1 < HMIN 'THEN' HMIN 'ELSE' H1;
           X:= X + H1; 'IF' X >= XE 'THEN'
           'BEGIN' H1:= XE - X0; X:= XE 'END';
           'IF' N <= 2 'AND' ^LINEAR 'THEN' REEVAL:= 'TRUE';
           'IF' H1 ^= H0 'THEN'
           'BEGIN' UPDATE:= 'TRUE'; KCHANGE:= 3 'END';
           'IF' REEVAL 'THEN' UPDATE:= 'TRUE';
           CHANGE:= KCHANGE > 0 'AND' ^LINEAR;
           KCHANGE:= KCHANGE - 1
       'END' STEPSIZE;

       INITIALIZATION; OUT; X:= X + H1;
       OPERATOR CONSTRUCTION;
       BD1[1,1]:= 1; BD2[1,1]:= -ALFA * .5;
       'IF' ^LINEAR 'THEN' COEFFICIENT;
    NEXT STEP: DIFFERENCE SCHEME;
       'IF' STRATEGY 'THEN' COUNT:= COUNT + 1;
       'IF' COUNT = 1 'THEN' TEST ACCURACY;
       OUT; 'IF' X >= XE 'THEN' 'GOTO' END;
       STEPSIZE; 'IF' UPDATE 'THEN' OPERATOR CONSTRUCTION;
       'IF' ^LINEAR 'THEN' COEFFICIENT;
       NEXT INTEGRATION STEP; 'GOTO' NEXT STEP;
    END:
   'END' GMS;
        'EOP'
