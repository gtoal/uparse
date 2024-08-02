'CODE' 33040;
'PROCEDURE' MODIFIED TAYLOR(T,TE,M0,M,U,SIGMA,TAUMIN,I,DERIVATIVE,K,
                  DATA,ALFA,NORM,AETA,RETA,ETA,RHO,OUT);
'INTEGER' M0,M,I,K,NORM;
'REAL' T,TE,SIGMA,TAUMIN,ALFA,AETA,RETA,ETA,RHO;
'ARRAY' U,DATA;
'PROCEDURE' DERIVATIVE,OUT;

'BEGIN' I:=0;
    'BEGIN' 'INTEGER' N,P,Q;
        'OWN' 'REAL' EC0,EC1,EC2,TAU0,TAU1,TAU2,TAUS,T2;
        'REAL' T0,TAU,TAUI,TAUEC,ECL,BETAN,GAMMA;
        'REAL' 'ARRAY' C[M0:M],BETA,BETHA[1:DATA[-2]];
        'BOOLEAN' START,STEP1,LAST;

        'PROCEDURE' COEFFICIENT;
        'BEGIN' 'INTEGER' J;'REAL' IFAC;
            IFAC:=1; GAMMA:=.5; N:=DATA[-2]; P:=DATA[-1];
            BETAN:=DATA[0]; Q:= 'IF' P<N 'THEN' P+1 'ELSE' N;
            'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' BETA[J]:=DATA[J]; IFAC:=IFAC/J;
                BETHA[J]:=IFAC-BETA[J]
            'END';
            'IF' P=N 'THEN' BETHA[N]:=IFAC
        'END';
        'REAL' 'PROCEDURE' NORMFUNCTION(NORM,W);
        'INTEGER' NORM; 'ARRAY' W;
        'BEGIN' 'INTEGER' J; 'REAL' S,X;
            S:=0;
            'IF' NORM=1 'THEN'
            'BEGIN' 'FOR' J:=M0 'STEP' 1 'UNTIL' M 'DO'
                'BEGIN'  X:=ABS(W[J]); 'IF' X>S 'THEN' S:=X 'END'
            'END' 'ELSE'
            S:=SQRT(VECVEC(M0,M,0,W,W));
            NORMFUNCTION:=S
        'END';

        'PROCEDURE' LOCAL ERROR BOUND;
        ETA:=AETA+RETA * NORMFUNCTION(NORM,U);

        'PROCEDURE' LOCAL ERROR CONSTRUCTION(I);'INTEGER' I;
        'BEGIN' 'IF' I=P 'THEN' 'BEGIN' ECL:=0;TAUEC:=1 'END';
            'IF' I>P+1 'THEN' TAUEC:=TAUEC*TAU;
            ECL:=ECL+ABS(BETHA[I])*TAUEC*NORMFUNCTION(NORM,C);
            'IF' I=N 'THEN'
            'BEGIN' EC0:=EC1;EC1:=EC2;EC2:=ECL;
                RHO:=ECL*TAU**Q
            'END'
        'END';

        'PROCEDURE' STEPSIZE;
        'BEGIN' 'REAL' TAUACC,TAUSTAB,AA,BB,CC,EC;
            LOCAL ERROR BOUND;
            'IF' ETA>0 'THEN'
            'BEGIN' 'IF' START 'THEN'
                'BEGIN' 'IF' K=0 'THEN'
                    'BEGIN' 'INTEGER' J;
                        'FOR' J:=M0 'STEP' 1 'UNTIL' M 'DO' C[J]:=U[J];
                        I:=1; DERIVATIVE(I,C);
                        TAUACC:=ETA/NORMFUNCTION(NORM,C);
                        STEP1:='TRUE'
                    'END' 'ELSE'
                    'IF' STEP1 'THEN'
                    'BEGIN' TAUACC:=(ETA/RHO)**(1/Q)*TAU2;
                        'IF' TAUACC>10*TAU2 'THEN'
                        TAUACC:=10*TAU2 'ELSE' STEP1:='FALSE'
                    'END' 'ELSE'
                    'BEGIN' BB:=(EC2-EC1)/TAU1; CC:=EC2-BB*T2;
                        EC:=BB*T+CC;
                        TAUACC:='IF' EC<0 'THEN' TAU2 'ELSE'
                        (ETA/EC)**(1/Q);
                        START:='FALSE'
                    'END'

                'END' 'ELSE'
                'BEGIN' AA:=((EC0-EC1)/TAU0+(EC2-EC1)/TAU1)/
                            (TAU1+TAU0);
                    BB:=(EC2-EC1)/TAU1-AA*(2*T2-TAU1);
                    CC:=EC2-T2*(BB+AA*T2); EC:=CC+T*(BB+T*AA);
                    TAUACC:='IF' EC<0 'THEN' TAUS
                            'ELSE' (ETA/EC)**(1/Q);
                    'IF' TAUACC>ALFA*TAUS 'THEN' TAUACC:=ALFA*TAUS;
                    'IF' TAUACC<GAMMA*TAUS 'THEN' TAUACC:=GAMMA*TAUS;
                'END'
            'END' 'ELSE' TAUACC:=TE-T;
            'IF' TAUACC<TAUMIN 'THEN' TAUACC:=TAUMIN;
            TAUSTAB:=BETAN/SIGMA;
            'IF' TAUSTAB<@-12 * (T-T0) 'THEN'
            'BEGIN' OUT;'GOTO' END OF MODIFIED TAYLOR 'END';
            TAU:='IF' TAUACC>TAUSTAB 'THEN' TAUSTAB 'ELSE' TAUACC;
            TAUS:=TAU; 'IF' TAU>=TE-T 'THEN'
            'BEGIN' TAU:=TE-T;LAST:= 'TRUE' 'END';
            TAU0:=TAU1;TAU1:=TAU2;TAU2:=TAU
        'END';

        'PROCEDURE' DIFFERENCE SCHEME;
        'BEGIN' 'INTEGER' J; 'REAL' B;
            'FOR' J:=M0 'STEP' 1 'UNTIL' M 'DO' C[J]:=U[J]; TAUI:=1;
          NEXT TERM:
            I:=I+1; DERIVATIVE(I,C); TAUI:=TAUI*TAU;
            B:=BETA[I]*TAUI;
            'IF' ETA>0 'AND' I>=P 'THEN' LOCAL ERROR CONSTRUCTION(I);
            'FOR' J:=M0 'STEP' 1 'UNTIL' M 'DO' U[J]:=U[J]+B*C[J];
            'IF' I<N 'THEN' 'GOTO' NEXT TERM;
            T2:=T; 'IF' LAST 'THEN'
            'BEGIN' LAST:= 'FALSE'; T:= TE 'END'
            'ELSE' T:= T + TAU
        'END';

        START:= K=0; T0:=T;
        COEFFICIENT; LAST:= 'FALSE';
      NEXT LEVEL:
        STEPSIZE; K:=K+1; I:=0; DIFFERENCE SCHEME; OUT;
        'IF' T ^= TE 'THEN' 'GOTO' NEXT LEVEL
    'END';
    END OF MODIFIED TAYLOR:
'END' MODIFIED TAYLOR;
        'EOP'
