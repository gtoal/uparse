'CODE'  33080;
 'BOOLEAN' 'PROCEDURE' MULTISTEP(X,XEND,Y,HMIN,HMAX,YMAX,EPS,
            FIRST,SAVE,DERIV,AVAILABLE,JACOBIAN,STIFF,N,OUT);
 'VALUE' HMIN,HMAX,EPS,XEND,N,STIFF;
 'BOOLEAN' FIRST,AVAILABLE,STIFF;
 'INTEGER' N;
 'REAL' X,XEND,HMIN,HMAX,EPS;
 'ARRAY' Y,YMAX,SAVE,JACOBIAN;
 'PROCEDURE' DERIV,OUT;
 'BEGIN' 'OWN' 'BOOLEAN' ADAMS,WITH JACOBIAN;
        'OWN' 'INTEGER' M,SAME,KOLD;
        'OWN' 'REAL' XOLD,HOLD,A0,TOLUP,TOL,TOLDWN,TOLCONV;
        'BOOLEAN' EVALUATE,EVALUATED,DECOMPOSE,DECOMPOSED,CONV;
        'INTEGER' I,J,L,K,KNEW,FAILS;
        'REAL' H, CH, CHNEW,ERROR,DFI,C;
        'ARRAY' A[0:5],DELTA,LAST DELTA,DF[1:N],JAC[1:N, 1:N],AUX[1:3];
        'INTEGER' 'ARRAY' P[1:N];

        'REAL' 'PROCEDURE' NORM2(AI); 'REAL' AI;
        'BEGIN' 'REAL' S,A; S:= 1.0@-100;
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' A:= AI/YMAX[I]; S:= S + A * A 'END';
                NORM2:= S
        'END' NORM2;

        'PROCEDURE' RESET;
        'BEGIN' 'IF' CH < HMIN/HOLD 'THEN' CH:= HMIN/HOLD 'ELSE'
                'IF' CH > HMAX/HOLD 'THEN' CH:= HMAX/HOLD;
                X:= XOLD; H:= HOLD * CH; C:= 1;
                'FOR' J:= 0 'STEP' M 'UNTIL' K*M 'DO'
                'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                        Y[J+I]:= SAVE[J+I] * C;
                        C:= C * CH
                'END';
                DECOMPOSED:= 'FALSE'
        'END';
        
        'PROCEDURE' METHOD;
        'BEGIN' I:= -39;
                'IF' ADAMS 'THEN'
                'BEGIN' 'FOR' C:= 1,1,144,4,0,.5,1,.5,576,144,1,5/12,1,
                              .75,1/6,1436,576,4,.375,1,11/12,1/3,1/24,
                               2844,1436,1,251/720,1,25/24,35/72,
                               5/48,1/120,0,2844,0.1
                        'DO' 'BEGIN' I:= I+ 1; SAVE[I]:= C 'END'
                'END' 'ELSE'

                'BEGIN' 'FOR' C:= 1,1,9,4,0,2/3,1,1/3,36,20.25,1,6/11,
                       1,6/11,1/11,84.028,53.778,0.25,.48,1,.7,.2,.02,
                        156.25, 108.51, .027778, 120/274, 1, 225/274,
                        85/274, 15/274, 1/274, 0, 187.69, .0047361
                        'DO' 'BEGIN' I:= I + 1; SAVE[I]:= C 'END'
                'END'
        'END' METHOD;

        'PROCEDURE' ORDER;
        'BEGIN' C:= EPS * EPS; J:= (K-1) * (K + 8)/2 - 38;
                'FOR' I:= 0 'STEP' 1 'UNTIL' K 'DO' A[I]:= SAVE[I+J];
                TOLUP  := C * SAVE[J + K + 1];
                TOL    := C * SAVE[J + K + 2];
                TOLDWN := C * SAVE[J + K + 3];
                TOLCONV:= EPS/(2 * N * (K + 2));
                A0:= A[0];  DECOMPOSE:= 'TRUE';
        'END' ORDER;

        'PROCEDURE' EVALUATE JACOBIAN;
        'BEGIN' EVALUATE:= 'FALSE';
                DECOMPOSE:= EVALUATED:= 'TRUE';
                'IF' AVAILABLE 'THEN' 'ELSE'
                'BEGIN' 'REAL' D; 'ARRAY' FIXY,FIXDY,DY[1:N];
                        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                        FIXY[I]:= Y[I];
                        DERIV(FIXDY);
                        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
                        'BEGIN' D:= 'IF' EPS > ABS(FIXY[J])
                                'THEN' EPS * EPS
                                'ELSE' EPS * ABS(FIXY[J]);
                                Y[J]:= Y[J] + D; DERIV(DY);
                                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                                JACOBIAN[I,J]:= (DY[I]-FIXDY[I])/D;
                                Y[J]:= FIXY[J]
                        'END'
                'END'
        'END' EVALUATE JACOBIAN;

        'PROCEDURE' DECOMPOSE JACOBIAN;
        'BEGIN' DECOMPOSE:= 'FALSE';
                DECOMPOSED:= 'TRUE'; C:= -A0 * H;
                'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                        JAC[I,J]:= JACOBIAN[I,J] * C;
                        JAC[J,J]:= JAC[J,J] + 1
                'END';
                AUX[2]:=1.0@-12;
                DEC(JAC,N,AUX,P)
        'END' DECOMPOSE JACOBIAN;

        'PROCEDURE' CALCULATE STEP AND ORDER;
        'BEGIN' 'REAL' A1,A2,A3;
                A1:= 'IF' K <= 1 'THEN' 0 'ELSE'
                     0.75 * (TOLDWN/NORM2(Y[K*M+I])) ** (0.5/K);
                A2:= 0.80 * (TOL/ERROR) ** (0.5/(K + 1));
                A3:= 'IF' K >= 5 'OR' FAILS ^= 0
                     'THEN' 0 'ELSE'
                     0.70 * (TOLUP/NORM2(DELTA[I] - LAST DELTA[I])) **
                     (0.5/(K+2));

                'IF' A1 > A2 'AND' A1 > A3 'THEN'
                'BEGIN' KNEW:= K-1; CHNEW:= A1 'END' 'ELSE'
                'IF' A2 > A3 'THEN'
                'BEGIN' KNEW:= K  ; CHNEW:= A2 'END' 'ELSE'
                'BEGIN' KNEW:= K+1; CHNEW:= A3 'END'
        'END' CALCULATE STEP AND ORDER;

        'IF' FIRST 'THEN'
        'BEGIN' FIRST:= 'FALSE'; M:= N;
                'FOR' I:= -1,-2,-3 'DO' SAVE[I]:= 0;
                OUT(0,0);
                ADAMS:= 'NOT' STIFF; WITH JACOBIAN:= 'NOT' ADAMS;
                'IF' WITH JACOBIAN 'THEN' EVALUATE JACOBIAN;
                METHOD;
        NEW START: K:= 1; SAME:= 2; ORDER; DERIV(DF);
                H:= 'IF' 'NOT' WITH JACOBIAN 'THEN' HMIN 'ELSE'
                SQRT(2 * EPS/SQRT(NORM2 (MATVEC(1,N,I,JACOBIAN,DF))));
                'IF' H > HMAX 'THEN' H:= HMAX 'ELSE'
                'IF' H < HMIN 'THEN' H:= HMIN;
                XOLD:= X; HOLD:= H; KOLD:= K; CH:= 1;
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' SAVE[I]:= Y[I]; SAVE[M+I]:= Y[M+I]:= DF[I] * H
                'END';
                OUT(0,0)
        'END' 'ELSE'
        'BEGIN' WITH JACOBIAN:= 'NOT' ADAMS; CH:= 1;
                K:=KOLD; RESET; ORDER;
                DECOMPOSE:= WITH JACOBIAN
        'END';
        'FOR' L:= 0 'WHILE' X < XEND 'DO'
        'BEGIN' 'IF' X + H <= XEND 'THEN' X:= X + H 'ELSE'
                'BEGIN' H:= XEND-X; X:= XEND; CH:= H/HOLD; C:= 1;
                        'FOR' J:= M 'STEP' M 'UNTIL' K*M 'DO'
                        'BEGIN' C:= C* CH;
                                'FOR' I:= J+1 'STEP' 1 'UNTIL' J+N 'DO'
                                Y[I]:= Y[I] * C
                        'END';
                        SAME:= 'IF' SAME<3 'THEN' 3 'ELSE' SAME+1;
                'END';

                'COMMENT' PREDICTION;
                'FOR' L:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' 'FOR' I:= L 'STEP' M 'UNTIL' (K-1)*M+L 'DO'
                        'FOR' J:= (K-1)*M+L 'STEP' -M 'UNTIL' I 'DO'
                        Y[J]:= Y[J] + Y[J+M];
                        DELTA[L]:= 0
                'END';  EVALUATED:= 'FALSE';

        'COMMENT' CORRECTION AND ESTIMATION LOCAL ERROR;
        'FOR' L:= 1,2,3 'DO'
        'BEGIN' DERIV(DF);
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                DF[I]:= DF[I] * H - Y[M+I];
                'IF' WITH JACOBIAN 'THEN'
                'BEGIN' 'IF' EVALUATE 'THEN' EVALUATE JACOBIAN;
                        'IF' DECOMPOSE 'THEN' DECOMPOSE JACOBIAN;
                        SOL(JAC,N,P,DF)
                'END';

                CONV:= 'TRUE';
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' DFI:= DF[I];
                        Y[  I]:= Y[  I] + A0 * DFI;
                        Y[M+I]:= Y[M+I] +      DFI;
                        DELTA[I]:= DELTA[I] +  DFI;
                        CONV:= CONV 'AND' ABS(DFI) < TOLCONV * YMAX[I]
                'END';
                'IF' CONV 'THEN'
                'BEGIN' ERROR:= NORM2(DELTA[I]);
                        'GOTO' CONVERGENCE
                'END'
        'COMMENT' ACCEPTANCE OR REJECTION;
        'IF' 'NOT' CONV 'THEN'
        'BEGIN' 'IF' 'NOT' WITH JACOBIAN 'THEN'
                'BEGIN' EVALUATE:= WITH JACOBIAN:= SAME >= K
                           'OR' H<1.1 * HMIN;
                        'IF' 'NOT' WITH JACOBIAN 'THEN' CH:= CH/4;
                'END' 'ELSE'
                'IF' 'NOT' DECOMPOSED 'THEN' DECOMPOSE:= 'TRUE' 'ELSE'
                'IF' 'NOT' EVALUATED  'THEN' EVALUATE := 'TRUE' 'ELSE'
                'IF' H > 1.1 * HMIN   'THEN' CH:= CH/4 'ELSE'
                'IF' ADAMS            'THEN' 'GOTO' TRY CURTISS 'ELSE'
                'BEGIN' SAVE[-1]:= 1; 'GOTO' RETURN 'END';

                RESET
        'END' 'ELSE' CONVERGENCE:

        'IF' ERROR > TOL 'THEN'
        'BEGIN' FAILS:= FAILS + 1;
                'IF' H > 1.1 * HMIN 'THEN'
                'BEGIN' 'IF' FAILS > 2 'THEN'
                        'BEGIN' 'IF' ADAMS 'THEN'
                                'BEGIN' ADAMS:= 'FALSE'; METHOD 'END';
                                KOLD:= 0; RESET; 'GOTO' NEW START
                        'END' 'ELSE'
                        'BEGIN' CALCULATE STEP AND ORDER;
                                'IF' KNEW ^= K 'THEN'
                                'BEGIN' K:= KNEW; ORDER 'END';
                                CH:= CH * CHNEW; RESET
                        'END'
                'END' 'ELSE'
                'BEGIN' 'IF' ADAMS 'THEN' TRY CURTISS:
                        'BEGIN' ADAMS:= 'FALSE'; METHOD
                        'END' 'ELSE'
                        'IF' K = 1 'THEN'
                        'BEGIN' 'COMMENT' VIOLATE EPS CRITERION;
                                C:= EPS * SQRT(ERROR/TOL);
                                'IF' C > SAVE[-3] 'THEN' SAVE[-3]:= C;
                                SAVE[-2]:= SAVE[-2] + 1;
                                SAME:= 4; 'GOTO' ERROR TEST OK
                        'END';
                        K:= KOLD:= 1; RESET; ORDER; SAME:= 2
                'END'
        'END' 'ELSE' ERROR TEST OK:
                FAILS:= 0;
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' C:= DELTA[I];
                        'FOR' L:= 2 'STEP' 1 'UNTIL' K 'DO'
                        Y[L*M+I]:= Y[L*M+I] + A[L] * C;
                        'IF' ABS(Y[I]) > YMAX[I] 'THEN'
                             YMAX[I]:=  ABS(Y[I])
                'END';

                SAME:= SAME-1;
                'IF' SAME= 1 'THEN'
                'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                        LAST DELTA[I]:= DELTA[I]
                'END' 'ELSE'
                'IF' SAME= 0 'THEN'
                'BEGIN' CALCULATE STEP AND ORDER;
                        'IF' CHNEW > 1.1 'THEN'
                        'BEGIN' DECOMPOSED:= 'FALSE';
                                'IF' K ^= KNEW 'THEN'
                                'BEGIN' 'IF' KNEW > K 'THEN'
                                        'BEGIN' 'FOR' I:= 1 'STEP' 1
                                             'UNTIL' N 'DO' Y[KNEW*M+I]
                                                := DELTA[I] * A[K]/KNEW
                                        'END';
                                        K:= KNEW; ORDER
                                'END';
                                SAME:= K+1;
                                'IF' CHNEW * H > HMAX
                                    'THEN' CHNEW:= HMAX/H;
                                H:= H * CHNEW; C:= 1;
                                'FOR' J:= M 'STEP' M 'UNTIL' K*M 'DO'
                                'BEGIN' C:= C * CHNEW;
                                        'FOR' I:= J+1 'STEP' 1 'UNTIL'
                                        J+N 'DO' Y[I]:= Y[I] * C
                                'END'
                        'END'
                        'ELSE' SAME:= 10
                'END';
                'IF' X ^= XEND 'THEN'
                'BEGIN' XOLD:= X; HOLD:= H; KOLD:= K; CH:= 1;
                        'FOR' I:= K * M + N 'STEP' -1 'UNTIL' 1 'DO'
                        SAVE[I]:= Y[I];
                        OUT(H,K)
                'END'
        'END' CORRECTION AND ESTIMATION LOCAL ERROR;
        'END' STEP;

        RETURN: SAVE[0]:= 'IF' ADAMS 'THEN' 0 'ELSE' 1;
        MULTISTEP:= SAVE[-1]= 0 'AND' SAVE[-2]=0
 'END' MULTISTEP;
        'EOP'
