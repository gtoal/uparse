'CODE' 34444;
'PROCEDURE' PEIDE(N,M,NOBS,NBP,PAR,RES,BP,JTJINV,IN,OUT,DERIV,JAC DFDY,
   JAC DFDP, CALL YSTART,DATA,MONITOR);
   'VALUE' N,M,NOBS; 'INTEGER' N,M,NOBS,NBP;
   'ARRAY' PAR,RES,JTJINV,IN,OUT;
   'INTEGER' 'ARRAY' BP;
   'PROCEDURE'  CALL YSTART,DATA,MONITOR;
   'BOOLEAN' 'PROCEDURE' DERIV,JAC DFDY,JACDFDP;
   'BEGIN' 'INTEGER' I,J,EXTRA,WEIGHT,NCOL,NROW,AWAY,NPAR,II,JJ,MAX,
      NFE,NIS;
      'REAL' EPS,EPS1,XEND,C,X,T,HMIN,HMAX,RES1,IN3,IN4,FAC3,FAC4;
      'ARRAY' AUX[1:3],OBS[1:NOBS],SAVE[-38:6*N],TOBS[0:NOBS],
      YP[1:NBP+NOBS,1:NBP+M],YMAX[1:N],Y[1:6*N*(NBP+M+1)],FY[1:N,1:N],
      FP[1:N,1:M+NBP];
      'INTEGER' 'ARRAY' COBS[1:NOBS];
      'BOOLEAN' FIRST,SEC,CLEAN;

      'REAL' 'PROCEDURE' INTERPOL(STARTINDEX,JUMP,K,TOBSDIF);
         'VALUE' STARTINDEX,JUMP,K,TOBSDIF;
         'INTEGER' STARTINDEX,JUMP,K; 'REAL' TOBSDIF;
         'BEGIN' 'INTEGER' I; 'REAL' S,R; S:=Y[STARTINDEX]; R:=TOBSDIF;
            'FOR' I:=1 'STEP' 1 'UNTIL' K 'DO'
            'BEGIN' STARTINDEX:=STARTINDEX+JUMP;
               S:=S+Y[STARTINDEX]*R; R:=R*TOBSDIF
            'END'; INTERPOL:=S
         'END' INTERPOL;

      'PROCEDURE' JAC DYDP(NROW,NCOL,PAR,RES,JAC,LOCFUNCT);
         'VALUE' NROW,NCOL; 'INTEGER' NROW,NCOL;
         'ARRAY' PAR,RES,JAC; 'PROCEDURE' LOCFUNCT;
         'BEGIN'
            DUPMAT(1,NROW,1,NCOL,JAC,YP)
         'END' JACOBIAN;

      'BOOLEAN' 'PROCEDURE' FUNCT(NROW,NCOL,PAR,RES);
         'VALUE' NROW,NCOL; 'INTEGER' NROW,NCOL; 'ARRAY' PAR,RES;
         'BEGIN' 'INTEGER' L,K,KNEW,FAILS,SAME,KPOLD,N6,NNPAR,J5N,
            COBSII;
            'REAL' XOLD,HOLD,A0,TOLUP,TOL,TOLDWN,TOLCONV,H,CH,CHNEW,
            ERROR,DFI,TOBSDIF;
            'BOOLEAN' EVALUATE,EVALUATED,DECOMPOSE,CONV;
            'ARRAY' A[0:5],DELTA,LAST DELTA,DF,Y0[1:N],JACOB[1:N,1:N];
            'INTEGER' 'ARRAY' P[1:N];

            'REAL' 'PROCEDURE' NORM2(AI); 'REAL' AI;
               'BEGIN' 'REAL' S,A; S:= @-100;
                  'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                  'BEGIN' A:= AI/YMAX[I]; S:= S + A * A 'END';
                NORM2:= S
               'END' NORM2;

            'PROCEDURE' RESET;
               'BEGIN' 'IF' CH < HMIN/HOLD 'THEN' CH:= HMIN/HOLD 'ELSE'
                  'IF' CH > HMAX/HOLD 'THEN' CH:= HMAX/HOLD;
                  X:= XOLD; H:= HOLD * CH; C:= 1;
                  'FOR' J:= 0 'STEP' N 'UNTIL' K*N 'DO'
                  'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                     Y[J+I]:= SAVE[J+I] * C;
                     C:= C * CH
                  'END';
                  DECOMPOSE:='TRUE'
               'END' RESET;

            'PROCEDURE' ORDER;
               'BEGIN' C:= EPS * EPS; J:= (K-1) * (K + 8)/2 - 38;
                  'FOR' I:= 0 'STEP' 1 'UNTIL' K 'DO' A[I]:= SAVE[I+J];
                  J:= J + K + 1;
                  TOLUP  := C * SAVE[J];
                  TOL    := C * SAVE[J + 1];
                  TOLDWN := C * SAVE[J + 2];
                  TOLCONV:= EPS/(2 * N * (K + 2));
                  A0:= A[0];  DECOMPOSE:= 'TRUE';
               'END' ORDER;

            'PROCEDURE' EVALUATE JACOBIAN;
               'BEGIN' EVALUATE:= 'FALSE';
                  DECOMPOSE:= EVALUATED:= 'TRUE';
                  'IF' 'NOT' JAC DFDY(PAR,Y,X,FY) 'THEN'
                  'BEGIN' SAVE[-3]:=4; 'GOTO' RETURN 'END';
               'END' EVALUATE JACOBIAN

            'PROCEDURE' DECOMPOSE JACOBIAN;
               'BEGIN' DECOMPOSE:= 'FALSE';
                  C:= -A0 * H;
                  'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
                  'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                     JACOB[I,J]:= FY[I,J] * C;
                     JACOB[J,J]:= JACOB[J,J] + 1
                  'END';
                  DEC(JACOB,N,AUX,P)
               'END' DECOMPOSE JACOBIAN;

            'PROCEDURE' CALCULATE STEP AND ORDER;
               'BEGIN' 'REAL' A1,A2,A3;
                  A1:= 'IF' K <= 1 'THEN' 0 'ELSE'
                       0.75 * (TOLDWN/NORM2(Y[K*N+I])) ** (0.5/K);
                  A2:= 0.80 * (TOL/ERROR) ** (0.5/(K + 1));
                  A3:= 'IF' K >= 5 'OR' FAILS ^= 0
                       'THEN' 0 'ELSE'
                       0.70 * (TOLUP/NORM2(DELTA[I] - LAST DELTA[I]))**
                       (0.5/(K+2));

                  'IF' A1 > A2 'AND' A1 > A3 'THEN'
                  'BEGIN' KNEW:= K-1; CHNEW:= A1 'END' 'ELSE'
                  'IF' A2 > A3 'THEN'
                  'BEGIN' KNEW:= K  ; CHNEW:= A2 'END' 'ELSE'
                  'BEGIN' KNEW:= K+1; CHNEW:= A3 'END'
               'END' CALCULATE STEP AND ORDER;

            'IF' SEC 'THEN' 'BEGIN' SEC:='FALSE'; 'GOTO' RETURN 'END';
            NPAR:=M; EXTRA:=NIS:=0; II:=1;
            JJ:='IF' NBP=0 'THEN' 0 'ELSE' 1;
            N6:=N*6;
            INIVEC(-3,-1,SAVE,0);
            INIVEC(N6+1,(6+M)*N,Y,0);
            INIMAT(1,NOBS+NBP,1,M+NBP,YP,0);
            T:=TOBS[1]; X:=TOBS[0];
            CALL YSTART(PAR,Y,YMAX);
            HMAX:=TOBS[1]-TOBS[0]; HMIN:=HMAX*IN[1];
            EVALUATE JACOBIAN; NNPAR:=N*NPAR;

         NEW START:
            K:= 1; KPOLD:=0; SAME:= 2; ORDER;
            'IF' 'NOT' DERIV(PAR,Y,X,DF) 'THEN'
            'BEGIN' SAVE[-3]:=3; 'GOTO' RETURN 'END';
            H:=SQRT(2 * EPS/SQRT(NORM2 (MATVEC(1,N,I,FY,DF))));
            'IF' H > HMAX 'THEN' H:= HMAX 'ELSE'
            'IF' H < HMIN 'THEN' H:= HMIN;
            XOLD:= X; HOLD:= H; CH:= 1;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' SAVE[I]:=Y[I]; SAVE[N+I]:=Y[N+I]:=DF[I]*H 'END';
            FAILS:= 0;
            'FOR' L:= 0 'WHILE' X < XEND 'DO'
            'BEGIN' 'IF' X + H <= XEND 'THEN' X:= X + H 'ELSE'
               'BEGIN' H:= XEND-X; X:= XEND; CH:= H/HOLD; C:= 1;
                  'FOR' J:= N 'STEP' N 'UNTIL' K*N 'DO'
                  'BEGIN' C:= C* CH;
                     'FOR' I:= J+1 'STEP' 1 'UNTIL' J+N 'DO'
                     Y[I]:= Y[I] * C
                  'END';
                  SAME:= 'IF' SAME<3 'THEN' 3 'ELSE' SAME+1;
               'END';

               'COMMENT' PREDICTION;
               'FOR' L:= 1 'STEP' 1 'UNTIL' N 'DO'
               'BEGIN' 'FOR' I:= L 'STEP' N 'UNTIL' (K-1)*N+L 'DO'
                  'FOR' J:= (K-1)*N+L 'STEP' -N 'UNTIL' I 'DO'
                  Y[J]:= Y[J] + Y[J+N];
                  DELTA[L]:= 0
               'END';  EVALUATED:= 'FALSE';

               'COMMENT' CORRECTION AND ESTIMATION LOCAL ERROR;
               'FOR' L:= 1,2,3 'DO'
               'BEGIN' 'IF' 'NOT' DERIV(PAR,Y,X,DF) 'THEN'
                  'BEGIN' SAVE[-3]:=3; 'GOTO' RETURN 'END';
                  'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                  DF[I]:= DF[I] * H - Y[N+I];
                  'IF' EVALUATE 'THEN' EVALUATE JACOBIAN;
                  'IF' DECOMPOSE 'THEN' DECOMPOSE JACOBIAN;
                  SOL(JACOB,N,P,DF);

                  CONV:= 'TRUE';
                  'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                  'BEGIN' DFI:= DF[I];
                     Y[  I]:= Y[  I] + A0 * DFI;
                     Y[N+I]:= Y[N+I] +      DFI;
                     DELTA[I]:= DELTA[I] +  DFI;
                     CONV:= CONV 'AND' ABS(DFI) < TOLCONV * YMAX[I]
                  'END';
                  'IF' CONV 'THEN'
                  'BEGIN' ERROR:= NORM2(DELTA[I]);
                     'GOTO' CONVERGENCE
                  'END'
               'END';

               'COMMENT' ACCEPTANCE OR REJECTION;
               'IF' 'NOT' CONV 'THEN'
               'BEGIN' 'IF' 'NOT' EVALUATED 'THEN' EVALUATE:= 'TRUE'
                  'ELSE'
                  'BEGIN' CH:=CH/4; 'IF' H<4*HMIN 'THEN'
                     'BEGIN' SAVE[-1]:= SAVE[-1]+10;
                        HMIN:=HMIN/10;
                        'IF' SAVE[-1]>40 'THEN' 'GOTO' RETURN
                     'END'
                  'END';
                  RESET
               'END' 'ELSE' CONVERGENCE:

               'IF' ERROR > TOL 'THEN'
               'BEGIN' FAILS:= FAILS + 1;
                  'IF' H > 1.1 * HMIN 'THEN'
                  'BEGIN' 'IF' FAILS > 2 'THEN'
                     'BEGIN'  RESET; 'GOTO' NEW START
                     'END' 'ELSE'
                     'BEGIN' CALCULATE STEP AND ORDER;
                        'IF' KNEW ^= K 'THEN'
                        'BEGIN' K:= KNEW; ORDER 'END';
                        CH:= CH * CHNEW; RESET
                     'END'
                  'END' 'ELSE'
                  'BEGIN' 'IF' K = 1 'THEN'
                     'BEGIN' 'COMMENT' VIOLATE EPS CRITERION;
                        SAVE[-2]:= SAVE[-2] + 1;
                        SAME:= 4; 'GOTO' ERROR TEST OK
                     'END';
                     K:=1; RESET; ORDER; SAME:= 2
                  'END'
               'END' 'ELSE' ERROR TEST OK:

               'BEGIN' FAILS:= 0;
                  'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                  'BEGIN' C:= DELTA[I];
                     'FOR' L:= 2 'STEP' 1 'UNTIL' K 'DO'
                     Y[L*N+I]:= Y[L*N+I] + A[L] * C;
                     'IF' ABS(Y[I]) > YMAX[I] 'THEN'
                     YMAX[I]:=  ABS(Y[I])
                  'END';

                  SAME:= SAME-1;
                  'IF' SAME= 1 'THEN'
                  DUPVEC(1,N,0,LAST DELTA,DELTA) 'ELSE'
                  'IF' SAME= 0 'THEN'
                  'BEGIN' CALCULATE STEP AND ORDER;
                     'IF' CHNEW > 1.1 'THEN'
                     'BEGIN'
                        'IF' K ^= KNEW 'THEN'
                        'BEGIN' 'IF' KNEW > K 'THEN'
                           MULVEC(KNEW*N+1,KNEW*N+N,-KNEW*N,Y,DELTA,
                           A[K]/KNEW);
                           K:= KNEW; ORDER
                        'END';
                        SAME:= K+1;
                        'IF' CHNEW * H > HMAX
                        'THEN' CHNEW:= HMAX/H;
                        H:= H * CHNEW; C:= 1;
                        'FOR' J:= N 'STEP' N 'UNTIL' K*N 'DO'
                        'BEGIN' C:= C * CHNEW;
                           MULVEC(J+1,J+N,0,Y,Y,C)
                        'END'; DECOMPOSE:='TRUE'
                     'END'
                     'ELSE' SAME:= 10
                  'END' OF A SINGLE INTEGRATION STEP OF Y;
                  NIS:=NIS+1;

                  'COMMENT' START OF A INTEGRATION STEP OF YP;
                  'IF' CLEAN 'THEN'
                  'BEGIN' HOLD:=H; XOLD:=X; KPOLD:=K; CH:=1;
                     DUPVEC(1,K*N+N,0,SAVE,Y)
                  'END' 'ELSE'
                  'BEGIN' 'IF' H^=HOLD 'THEN'
                     'BEGIN' CH:=H/HOLD; C:=1;
                        'FOR' J:=N6+NNPAR 'STEP' NNPAR 'UNTIL'
                        KPOLD*NNPAR+N6 'DO'
                        'BEGIN' C:=C*CH;
                           'FOR' I:=J+1 'STEP' 1 'UNTIL' J+NNPAR 'DO'
                           Y[I]:=Y[I]*C
                        'END'; HOLD:=H
                     'END';
                     'IF' K>KPOLD 'THEN'
                     INIVEC(N6+K*NNPAR+1,N6+K*NNPAR+NNPAR,Y,0);
                     XOLD:= X; KPOLD:= K; CH:= 1;
                     DUPVEC(1,K*N+N,0,SAVE,Y);
                     EVALUATE JACOBIAN;
                     DECOMPOSE JACOBIAN;
                     'IF' 'NOT' JAC DFDP(PAR,Y,X,FP) 'THEN'
                     'BEGIN' SAVE[-3]:=5; 'GOTO' RETURN 'END';
                     'IF' NPAR>M 'THEN' INIMAT(1,N,M+1,NPAR,FP,0);

                     'COMMENT' PREDICTION;
                     'FOR' L:=0 'STEP' 1 'UNTIL' K-1 'DO'
                     'FOR' J:=K-1 'STEP' -1 'UNTIL' L 'DO'
                     ELMVEC(J*NNPAR+N6+1,J*NNPAR+N6+NNPAR,NNPAR,Y,Y,1);

                     'COMMENT' CORRECTION;
                     'FOR' J:=1 'STEP' 1 'UNTIL' NPAR 'DO'
                     'BEGIN' J5N:=(J+5)*N;
                        DUPVEC(1,N,J5N,Y0,Y);
                        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO' DF[I]:=
                        H*(FP[I,J]+MATVEC(1,N,I,FY,Y0))
                        -Y[NNPAR+J5N+I];
                        SOL(JACOB,N,P,DF);
                        'FOR' L:=0 'STEP' 1 'UNTIL' K 'DO'
                        'BEGIN' I:=L*NNPAR+J5N;
                           ELMVEC(I+1,I+N,-I,Y,DF,A[L])
                        'END'
                     'END'
                  'END';
                  'FOR' L:=0 'WHILE' X>=T 'DO'
                  'BEGIN'
                     'COMMENT' CALCULATION OF A ROW OF THE JACOBIAN
                               MATRIX AND AN ELEMENT OF THE RESIDUAL
                               VECTOR;
                     TOBSDIF:=(TOBS[II]-X)/H; COBSII:=COBS[II];
                     RES[II]:=INTERPOL(COBSII,N,K,TOBSDIF)-OBS[II];
                     'IF' 'NOT' CLEAN 'THEN'
                     'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' NPAR 'DO'
                        YP[II,I]:=INTERPOL(COBSII+(I+5)*N,NNPAR,K,
                                           TOBSDIF);

                        'COMMENT' INTRODUCING OF BREAK-POINTS;
                        'IF' BP[JJ]^=II 'THEN' 'ELSE'
                        'IF' FIRST 'AND' ABS(RES[II])<EPS1 'THEN'
                        'BEGIN' NBP:=NBP-1; 'COMMENT' DUPVEC(BP) ;
                            'FOR' I:= JJ 'STEP' 1 'UNTIL' NBP 'DO'
                            BP[I]:= BP[I + 1]; BP[NBP+1]:=0
                        'END' 'ELSE'
                        'BEGIN' EXTRA:=EXTRA+1;
                           'IF' FIRST 'THEN' PAR[M+JJ]:=OBS[II];
                           'COMMENT' INTRODUCING A JACOBIAN ROW AND A
                                     RESIDUAL VECTOR ELEMENT FOR
                                     CONTINUITY REQUIREMENTS;
                           YP[NOBS+JJ,M+JJ]:=-WEIGHT;
                           MULROW(1,NPAR,NOBS+JJ,II,YP,YP,WEIGHT);
                           RES[NOBS+JJ]:=WEIGHT*(RES[II]+OBS[II]-
                                         PAR[M+JJ])
                        'END'
                     'END';

                     'IF' II=NOBS 'THEN' 'GOTO' RETURN 'ELSE'
                     'BEGIN' T:=TOBS[II+1];
                        'IF' BP[JJ]=II 'AND' JJ<NBP 'THEN' JJ:=JJ+1;
                        HMAX:=T-TOBS[II]; HMIN:=HMAX*IN[1]; II:=II+1
                     'END';
                  'END';

                  'COMMENT' BREAK-POINTS INTRODUCE NEW INITIAL VALUES
                            FOR Y AND YP;
                  'IF' EXTRA>0 'THEN'
                  'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
                     'BEGIN' Y[I]:=INTERPOL(I,N,K,TOBSDIF);
                        'FOR' J:=1 'STEP' 1 'UNTIL' NPAR 'DO'
                        Y[I+(J+5)*N]:=INTERPOL(I+(J+5)*N,NNPAR,K,
                                               TOBSDIF)
                     'END';
                     'FOR' L:=1 'STEP' 1 'UNTIL' EXTRA 'DO'
                     'BEGIN'  COBSII:=COBS[BP[NPAR-M+L]];
                        Y[COBSII]:=PAR[NPAR+L];
                        'FOR' I:=1 'STEP' 1 'UNTIL' NPAR+EXTRA 'DO'
                        Y[COBSII+(5+I)*N]:=0;
                        INIVEC(1+NNPAR+(L+5)*N,NNPAR+(L+6)*N,Y,0);
                        Y[COBSII+(5+NPAR+L)*N]:=1
                     'END';
                     NPAR:=NPAR+EXTRA; EXTRA:=0;
                     X:=TOBS[II-1]; EVALUATE JACOBIAN; NNPAR:=N*NPAR;
                     'GOTO' NEW START
                  'END'
               'END'
            'END' STEP;

          RETURN:
            'IF' SAVE[-2]>MAX 'THEN' MAX:=SAVE[-2];
            FUNCT:=SAVE[-1]<=40 'AND' SAVE[-3]=0;
            'IF' 'NOT' FIRST 'THEN'
            MONITOR(1,NCOL,NROW,PAR,RES,WEIGHT,NIS)
         'END' FUNCT;

      I:= -39;
      'FOR' C:= 1,1,9,4,0,2/3,1,1/3,36,20.25,1,6/11,
                1,6/11,1/11,84.028,53.778,0.25,.48,1,.7,.2,.02,
                156.25, 108.51, .027778, 120/274, 1, 225/274,
                85/274, 15/274, 1/274, 0, 187.69, .0047361
      'DO' 'BEGIN' I:= I + 1; SAVE[I]:= C 'END';

      DATA(NOBS,TOBS,OBS,COBS); WEIGHT:=1;
      FIRST:=SEC:='FALSE'; CLEAN:=NBP>0;
      AUX[2]:=@-12; EPS:=IN[2]; EPS1:=@10;
      XEND:=TOBS[NOBS]; OUT[1]:=0; BP[0]:=MAX:=0;

      'COMMENT' SMOOTH INTEGRATION WITHOUT BREAK-POINTS;
      'IF' 'NOT' FUNCT(NOBS,M,PAR,RES) 'THEN' 'GOTO' ESCAPE;
      RES1:=SQRT(VECVEC(1,NOBS,0,RES,RES)); NFE:=1;
      'IF' IN[5]=1 'THEN'
      'BEGIN' OUT[1]:=1; 'GOTO' ESCAPE 'END';

      'IF' CLEAN 'THEN'
      'BEGIN' FIRST:='TRUE'; CLEAN:='FALSE';
         FAC3:=SQRT(SQRT(IN[3]/RES1)); FAC4:=SQRT(SQRT(IN[4]/RES1));
         EPS1:=RES1*FAC4;
         'IF' 'NOT' FUNCT(NOBS,M,PAR,RES) 'THEN' 'GOTO' ESCAPE;
         FIRST:='FALSE'
      'END' 'ELSE' NFE:=0;

      NCOL:=M+NBP; NROW:=NOBS+NBP;
      SEC:='TRUE';
      IN3:=IN[3]; IN4:=IN[4]; IN[3]:=RES1;

      'BEGIN' 'REAL' W; 'ARRAY' AID[1:NCOL,1:NCOL];
         WEIGHT:=AWAY:=0;
         OUT[4]:=OUT[5]:=W:=0;
         'FOR' WEIGHT:=(SQRT(WEIGHT)+1)**2 'WHILE'
         WEIGHT^=16 'AND' NBP>0 'DO'

         'BEGIN' 'IF' AWAY=0 'AND' W^=0 'THEN'
            'BEGIN' 'COMMENT' IF NO BREAK-POINTS WERE OMITTED THEN ONE
                              FUNCTION EVALUATION IS SAVED;
               W:=WEIGHT/W;
               'FOR' I:=NOBS+1 'STEP' 1 'UNTIL' NROW 'DO'
               'BEGIN' 'FOR' J:=1 'STEP' 1 'UNTIL' NCOL 'DO'
                  YP[I,J]:=W*YP[I,J];
                  RES[I]:=W*RES[I]
               'END'; SEC:='TRUE'; NFE:=NFE-1
            'END';

            IN[3]:=IN[3]*FAC3*WEIGHT; IN[4]:=EPS1;
            MONITOR(2,NCOL,NROW,PAR,RES,WEIGHT,NIS);
            MARQUARDT(NROW,NCOL,PAR,RES,AID,FUNCT,JAC DYDP,IN,OUT);
            'IF' OUT[1]>0 'THEN' 'GOTO' ESCAPE;

            'COMMENT' THE RELATIVE STARTING VALUE OF LAMBDA IS
                      ADJUSTED TO THE LAST VALUE OF LAMBDA USED;
            AWAY:=OUT[4]-OUT[5]-1;
            IN[6]:=IN[6] * 5**AWAY * 2**(AWAY-OUT[5]);

            NFE:=NFE+OUT[4];
            W:=WEIGHT; EPS1:=(SQRT(WEIGHT)+1)**2*IN[4]*FAC4;
            AWAY:=0;

            'COMMENT' USELESS BREAK-POINTS ARE OMITTED;
            J:= 0; 'FOR' J:= J + 1 'WHILE' J 'LE' NBP 'DO'
            'BEGIN' 'IF' ABS(OBS[BP[J]]+RES[BP[J]]-PAR[J+M])<EPS1
               'THEN'
               'BEGIN' NBP:=NBP-1; 'COMMENT' DUPVEC (BP) ;
                  'FOR' I:= J 'STEP' 1 'UNTIL' NBP 'DO'
                  BP[I]:= BP[I + 1];
                  DUPVEC(J+M,NBP+M,1,PAR,PAR);
                  J:=J-1; AWAY:=AWAY+1; BP[NBP+1]:=0
               'END'
            'END';
            NCOL:=NCOL-AWAY; NROW:=NROW-AWAY
         'END';

         IN[3]:=IN3; IN[4]:=IN4; NBP:=0; WEIGHT:=1;
         MONITOR(2,M,NOBS,PAR,RES,WEIGHT,NIS);
         MARQUARDT(NOBS,M,PAR,RES,JTJINV,FUNCT,JAC DYDP,IN,OUT);
         NFE:=OUT[4]+NFE
      'END';
     ESCAPE: 'IF' OUT[1]=3 'THEN' OUT[1]:=2 'ELSE'
             'IF' OUT[1]=4 'THEN' OUT[1]:=6;
             'IF' SAVE[-3]^=0 'THEN' OUT[1]:=SAVE[-3];
             OUT[3]:=RES1;
             OUT[4]:=NFE;
             OUT[5]:=MAX
   'END' PEIDE;
        'EOP'
