'CODE' 33132;
'PROCEDURE' LINIGER1VS(X,XE,M,Y,SIGMA,DERIVATIVE,J,
   JACOBIAN,ITMAX,HMIN,HMAX,AETA,RETA,INFO,OUTPUT);
'VALUE' M;
'INTEGER' M,ITMAX;
'REAL' X,XE,SIGMA,AETA,RETA,HMIN,HMAX;
'ARRAY' Y,J,INFO;
'PROCEDURE' DERIVATIVE,JACOBIAN,OUTPUT;

'BEGIN' 'INTEGER' I,ST,LASTJAC;
    'REAL' H,HNEW,MU,MU1,BETA,P,E,E1,ETA,ETA1,DISCR;
    'BOOLEAN' LAST,FIRST,EVALJAC,EVALCOEF;
    'INTEGER' 'ARRAY' PI[1:M];
    'REAL' 'ARRAY' DY,YL,YR,F[1:M],A[1:M,1:M],AUX[1:3];

    'REAL' 'PROCEDURE' NORM(A); 'ARRAY' A;
    NORM:=SQRT(VECVEC(1,M,0,A,A));

    'PROCEDURE' COEFFICIENT;
    'BEGIN' 'REAL' B,E; B:=ABS(H*SIGMA);
        'IF' B>40 'THEN'
        'BEGIN' MU:=1/B; BETA:=1; P:=2+2/(B-2)
        'END' 'ELSE'
        'IF' B<.04 'THEN'
        'BEGIN' E:=B*B/30; P:=3-E;
            MU:=.5-B/12*(1-E/2);
            BETA:=.5+B/6*(1-E)
        'END' 'ELSE'
        'BEGIN' E:=EXP(B)-1;
            MU:=1/B-1/E;
            BETA:=(1-B/E)*(1+1/E);
            P:=(BETA-MU)/(.5-MU)
        'END';
        MU1:=H*(1-MU);
        LUDECOMP
    'END';
    'PROCEDURE' LUDECOMP;
    'BEGIN' 'INTEGER' I;
        'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' MULROW(1,M,I,I,A,J,-MU1);
            A[I,I]:=A[I,I]+1
        'END';
        AUX[2]:=0; DEC(A,M,AUX,PI)
    'END' LUDECOMP;

    'PROCEDURE' STEPSIZE;
    'IF' ETA<0 'THEN'
    'BEGIN' 'REAL' HL; HL:=H;
        H:=HNEW:=HMAX; INFO[5]:=INFO[5]+1;
        'IF' 1.1*HNEW>XE-X 'THEN'
        'BEGIN' LAST:='TRUE'; H:=HNEW:=XE-X
        'END';
        EVALCOEF:=H^=HL;
    'END' 'ELSE'
    'IF' FIRST 'THEN'
    'BEGIN' H:=HNEW:=HMIN; FIRST:='FALSE'; INFO[4]:=INFO[4]+1
    'END' 'ELSE'
    'BEGIN' 'REAL' B,HL;
        B:=DISCR/ETA; HL:=H; 'IF' B<.01 'THEN' B:=.01;
        HNEW:= 'IF' B>0 'THEN' H*B**(-1/P) 'ELSE' HMAX;
        'IF' HNEW<HMIN 'THEN'
        'BEGIN' HNEW:=HMIN; INFO[4]:=INFO[4]+1
        'END' 'ELSE'
        'IF' HNEW>HMAX 'THEN'
        'BEGIN' HNEW:=HMAX; INFO[5]:=INFO[5]+1 'END';
        'IF' 1.1*HNEW>=XE-X 'THEN'
        'BEGIN' LAST:='TRUE'; H:=HNEW:=XE-X
        'END' 'ELSE'
        'IF' ABS(H/HNEW-1)>.1 'THEN' H:=HNEW;
        EVALCOEF:=H^=HL
    'END' STEPSIZE;

    'PROCEDURE' LINEARITY(ERROR); 'REAL' ERROR;
    'BEGIN' 'INTEGER' K;
        'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO'
        DY[K]:=Y[K]-MU1*F[K];
        SOL(A,M,PI,DY);
        ELMVEC(1,M,0,DY,Y,-1);
        ERROR:=NORM(DY)
    'END';
    
    'PROCEDURE' ITERATION(I); 'INTEGER' I;
    'IF' RETA<0 'THEN'
    'BEGIN' 'INTEGER' K;
        'IF' I=1 'THEN'
        'BEGIN' MULVEC(1,M,0,DY,F,H);
            'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO' YL[K]:=Y[K]+MU*DY[K];
            SOL(A,M,PI,DY); E:=1;
        'END' 'ELSE'
        'BEGIN' 'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO'
            DY[K]:=YL[K]-Y[K]+MU1*F[K];
            'IF' E*NORM(Y)>E1*E1 'THEN'
            'BEGIN' EVALJAC:=I>=3;
                'IF' I>3 'THEN'
                'BEGIN' INFO[3]:=INFO[3]+1; JACOBIAN(J,Y);
                    LUDECOMP
                'END';
            'END';
            SOL(A,M,PI,DY)
        'END';
        E1:=E; E:=NORM(DY);
        ELMVEC(1,M,0,Y,DY,1);
        ETA:=NORM(Y)*RETA+AETA;
        DISCR:=0;
        DUPVEC(1,M,0,F,Y);
        DERIVATIVE(F);
        INFO[2]:=INFO[2]+1;
    'END' 'ELSE'
    'BEGIN' 'INTEGER' K;
        'IF' I=1 'THEN'
        'BEGIN' LINEARITY(E);
            'IF' E*(ST-LASTJAC)>ETA 'THEN'
            'BEGIN' JACOBIAN(J,Y); LASTJAC:=ST;
                INFO[3]:=INFO[3]+1;
                H:=HNEW; COEFFICIENT;
                LINEARITY(E)
            'END';
            EVALJAC:= E*(ST+1-LASTJAC)>ETA;
            MULVEC(1,M,0,DY,F,H);
            'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO' YL[K]:=Y[K]+MU*DY[K];
            SOL(A,M,PI,DY);
            'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO'
            YR[K]:=H*BETA*MATVEC(1,M,K,J,DY);
            SOL(A,M,PI,YR);
            ELMVEC(1,M,0,YR,DY,1);
        'END' 'ELSE'
        'BEGIN' 'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO'
            DY[K]:=YL[K]-Y[K]+MU1*F[K];
            'IF' E>ETA1 'AND' DISCR>ETA1 'THEN'
            'BEGIN' INFO[3]:=INFO[3]+1; JACOBIAN(J,Y);
                LUDECOMP
            'END';
            SOL(A,M,PI,DY);
            E:=NORM(DY)
        'END';
        ELMVEC(1,M,0,Y,DY,1);
        ETA:=NORM(Y)*RETA+AETA;
        ETA1:=ETA/SQRT(RETA);
        DUPVEC(1,M,0,F,Y);
        DERIVATIVE(F);
        INFO[2]:=INFO[2]+1;
        'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO' DY[K]:=YR[K]-H*F[K];
        DISCR:=NORM(DY)/2
    'END' ITERATION;

    FIRST:=EVALJAC:='TRUE'; LAST:=EVALCOEF:='FALSE';
    INIVEC(1,9,INFO,0);
    ETA:=RETA*NORM(Y)+AETA;
    ETA1:=ETA/SQRT(ABS(RETA));
    DUPVEC(1,M,0,F,Y);
    DERIVATIVE(F);
    INFO[2]:=1;
    'FOR' ST:=1,ST+1 'WHILE' ^LAST 'DO'
    'BEGIN' STEPSIZE; INFO[1]:=INFO[1]+1;
        'IF' EVALJAC 'THEN'
        'BEGIN' JACOBIAN(J,Y);
            INFO[3]:=INFO[3]+1;
            H:=HNEW;
            COEFFICIENT;
            EVALJAC:='FALSE'; LASTJAC:=ST
        'END' 'ELSE'
        'IF' EVALCOEF 'THEN' COEFFICIENT;
        'FOR' I:=1,I+1 'WHILE' E>ABS(ETA) 'AND' DISCR>1.3*ETA
        'AND' I<=ITMAX 'DO'
        'BEGIN' ITERATION(I); 'IF' I>INFO[6] 'THEN' INFO[6]:=I;
        'END'; INFO[7]:=ETA; INFO[8]:=DISCR;
        X:=X+H;
        'IF' DISCR>INFO[9] 'THEN' INFO[9]:=DISCR;
        OUTPUT;
    'END';
'END' LINIGER1VS;
        'EOP'
