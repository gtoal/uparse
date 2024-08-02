'CODE' 33050;
'PROCEDURE' EXPONENTIALLY FITTED TAYLOR(T,TE,M0,M,U,SIGMA,PHI,DIAMETER,
        DERIVATIVE,I,K,ALFA,NORM,AETA,RETA,ETA,RHO,HMIN,HSTART,OUTPUT);
'INTEGER' M0,M,I,K,NORM;
'REAL' T,TE,SIGMA,PHI,DIAMETER,ALFA,AETA,RETA,ETA,RHO,HMIN,HSTART;
'ARRAY' U;
'PROCEDURE' DERIVATIVE,OUTPUT;
'BEGIN' 'INTEGER' KL;
    'REAL' Q,EC0,EC1,EC2,H,HI,H0,H1,H2,BETAN,T2,SIGMAL,PHIL;
    'REAL' 'ARRAY' C,RO[M0:M],BETA,BETHA[1:3];
    'BOOLEAN' LAST,START;

    'PROCEDURE' COEFFICIENT;
    'BEGIN' 'REAL' B,B1,B2,BB,E,BETA2,BETA3;
        B:=H*SIGMAL; B1:=B*COS(PHIL); BB:=B*B;
        'IF' ABS(B)<@-3 'THEN'
        'BEGIN' BETA2:=.5-BB/24;
            BETA3:=1/6+B1/12;
            BETHA[3]:=.5+B1/3
        'END' 'ELSE'
        'IF' B1<-40 'THEN'
        'BEGIN' BETA2:=(-2*B1-4*B1*B1/BB+1)/BB;
            BETA3:=(1+2*B1/BB)/BB;
            BETHA[3]:=1/BB
        'END' 'ELSE'
        'BEGIN' E:=EXP(B1)/BB; B2:=B*SIN(PHIL);
            BETA2:=(-2*B1-4*B1*B1/BB+1)/BB;
            BETA3:=(1+2*B1/BB)/BB;
            'IF' ABS(B2/B)<@-5 'THEN'
            'BEGIN' BETA2:=BETA2-E*(B1-3);
                BETA3:=BETA3+E*(B1-2)/B1;
                BETHA[3]:=1/BB+E*(B1-1)
            'END' 'ELSE'
            'BEGIN' BETA2:=BETA2-E*SIN(B2-3*PHIL)/B2*B;
                BETA3:=BETA3+E*SIN(B2-2*PHIL)/B2;
                BETHA[3]:=1/BB+E*SIN(B2-PHIL)/B2*B;
            'END'
        'END';
        BETA[1]:=BETHA[1]:=1;
        BETA[2]:=BETA2; BETA[3]:=BETA3;
        BETHA[2]:=1-BB*BETA3; B:=ABS(B);
        Q:='IF' B<1.5 'THEN' 4-2*B/3 'ELSE' 'IF' B<6 'THEN' (30-2*B)/9
        'ELSE' 2;
    'END';

    'REAL' 'PROCEDURE' NORMFUNCTION(NORM,W);
    'INTEGER' NORM; 'ARRAY' W;
    'BEGIN' 'INTEGER' J; 'REAL' S,X;
        S:=0;
        'IF' NORM=1 'THEN'
        'BEGIN' 'FOR' J:=M0 'STEP' 1 'UNTIL' M 'DO'
            'BEGIN' X:=ABS(W[J]); 'IF' X>S 'THEN' S:=X 'END'
        'END' 'ELSE'
        S:=SQRT(VECVEC(M0,M,0,W,W));
        NORMFUNCTION:=S;
    'END';

    'PROCEDURE' LOCAL ERROR BOUND;
    ETA:=AETA+RETA * NORMFUNCTION(NORM,U);

    'PROCEDURE' LOCAL ERROR CONSTRUCTION(I); 'INTEGER' I;
    'BEGIN' 'IF' I=1 'THEN' INIVEC(M0,M,RO,0);
        'IF' I<4 'THEN' ELMVEC(M0,M,0,RO,C,BETHA[I]*HI);
        'IF' I=4 'THEN'
        'BEGIN' ELMVEC(M0,M,0,RO,C,-H);
            RHO:=NORMFUNCTION(NORM,RO);
            EC0:=EC1;EC1:=EC2;EC2:=RHO/H**Q;
        'END'
    'END';

    'PROCEDURE' STEPSIZE;
    'BEGIN' 'REAL' HACC,HSTAB,HCR,HMAX,A,B,C;
        'IF' 'NOT' START 'THEN' LOCAL ERROR BOUND;
        'IF' START 'THEN'
        'BEGIN' H1:=H2:=HACC:=HSTART;
            EC2:=EC1:=1; KL:=1; START:='FALSE'
        'END' 'ELSE'
        'IF' KL<3 'THEN'
        'BEGIN' HACC:=(ETA/RHO)**(1/Q)*H2;
            'IF' HACC>10*H2 'THEN' HACC:=10*H2 'ELSE' KL:=KL+1
        'END' 'ELSE'
        'BEGIN' A:=(H0*(EC2-EC1)-H1*(EC1-EC0))/(H2*H0-H1*H1);
            H:=H2*('IF' ETA<RHO 'THEN' (ETA/RHO)**(1/Q) 'ELSE' ALFA);
            'IF' A>0 'THEN'
            'BEGIN' B:=(EC2-EC1-A*(H2-H1))/H1;
                C:=EC2-A*H2-B*T2; HACC:=0; HMAX:=H;
                'IF' ^ZEROIN(HACC,H,HACC**Q*(A*HACC+B*T+C)-ETA,
                @-3*H2) 'THEN' HACC:=HMAX
            'END' 'ELSE' HACC:=H;
            'IF' HACC<.5*H2 'THEN' HACC:=.5*H2;
        'END';
        'IF' HACC<HMIN 'THEN' HACC:=HMIN; H:=HACC;
        'IF' H*SIGMAL>1 'THEN'
        'BEGIN' A:=ABS(DIAMETER/SIGMAL+@-14)/2; B:=2*ABS(SIN(PHIL));
            BETAN:=('IF' A>B 'THEN' 1/A 'ELSE' 1/B)/A;
            HSTAB:=ABS(BETAN/SIGMAL);
            'IF' HSTAB<@-14*T 'THEN' 'GOTO' ENDOFEFT;
            'IF' H>HSTAB 'THEN' H:=HSTAB
        'END';
        HCR:=H2*H2/H1;
        'IF' KL>2 'AND' ABS(H-HCR)<@-6*HCR 'THEN'
        H:='IF' H<HCR 'THEN' HCR*(1-@-7) 'ELSE' HCR*(1+@-7);
        'IF' T+H>TE 'THEN'
        'BEGIN' LAST:='TRUE'; HSTART:=H; H:=TE-T 'END';
        H0:=H1;H1:=H2;H2:=H;
    'END';

    'PROCEDURE' DIFFERENCE SCHEME;
    'BEGIN' HI:=1; SIGMAL:=SIGMA; PHIL:=PHI;
        STEPSIZE;
        COEFFICIENT;
        'FOR' I:=1,2,3 'DO'
        'BEGIN' HI:=HI*H;
            'IF' I>1 'THEN' DERIVATIVE(I,C);
            LOCALERRORCONSTRUCTION(I);
            ELMVEC(M0,M,0,U,C,BETA[I]*HI)
        'END';
        T2:=T; K:=K+1;
        'IF' LAST 'THEN'
        'BEGIN' LAST:='FALSE'; T:=TE; START:='TRUE'
        'END' 'ELSE' T:=T+H;
        DUPVEC(M0,M,0,C,U);
        DERIVATIVE(1,C);
        LOCALERRORCONSTRUCTION(4);
        OUTPUT;
    'END';

    START:='TRUE'; LAST:='FALSE';
    DUPVEC(M0,M,0,C,U);
    DERIVATIVE(1,C);
    'IF' K=0 'THEN'
    'BEGIN' LOCAL ERROR BOUND; HSTART:=ETA/NORMFUNCTION(NORM,C)
    'END';
NEXT LEVEL:
    DIFFERENCE SCHEME;
    'IF' T^=TE 'THEN' 'GOTO' NEXT LEVEL;
ENDOFEFT:
 'END' EXPONENTIAL FITTED TAYLOR;
        'EOP'
