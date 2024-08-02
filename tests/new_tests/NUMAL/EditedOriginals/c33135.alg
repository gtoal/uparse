'CODE' 33135;
'PROCEDURE' IMPEX (N, T0, TEND, Y0, DERIV, AVAILABLE, H0, HMAX,
                  PRESCH, EPS, WEIGHTS, UPDATE, FAIL, CONTROL);
'VALUE' N;
'INTEGER' N;
'REAL' T0,TEND,H0,HMAX,EPS;
'BOOLEAN' PRESCH,FAIL;
'ARRAY' Y0,WEIGHTS;
'BOOLEAN' 'PROCEDURE' AVAILABLE;
'PROCEDURE' DERIV,UPDATE,CONTROL;
'BEGIN' 'INTEGER' I,K,ECI;
    'REAL' T,T1,T2,T3,TP,H,H2,HNEW,ALF,LQ;
    'ARRAY' Y,Z,S1,S2,S3,U1,U3,W1,W2,W3,EHR[1:N],R,RF[1:5,1:N],
            ERR[1:3],A1,A2[1:N,1:N];
    'INTEGER' 'ARRAY' PS1,PS2[1:N];
    'BOOLEAN' START,TWO,HALV;

    'PROCEDURE' DFDY(T,Y,A); 'REAL' T; 'ARRAY' Y,A;
    'BEGIN' 'INTEGER' I,J; 'REAL' SL; 'ARRAY' F1,F2[1:N];
        DERIV(T,Y,F1,N);
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN'
            SL:=@-6*Y[I]; 'IF' ABS(SL)<@-6 'THEN' SL:=@-6;
            Y[I]:=Y[I]+SL; DERIV(T,Y,F2,N);
            'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO'
            A[J,I]:=(F2[J]-F1[J])/SL;
            Y[I]:=Y[I]-SL;
        'END'
    'END' DFDY;

    'PROCEDURE' STARTV(Y,T); 'VALUE' T; 'REAL' T; 'ARRAY' Y;
    'BEGIN' 'REAL' A,B,C;
        A:=(T-T1)/(T1-T2); B:=(T-T2)/(T1-T3);
        C:=(T-T1)/(T2-T3)*B; B:=A*B;
        A:=1+A+B; B:=A+C-1;
        MULVEC(1,N,0,Y,S1,A); ELMVEC(1,N,0,Y,S2,-B);
        ELMVEC(1,N,0,Y,S3,C)
    'END' STARTV;

    'PROCEDURE' ITERATE(Z,Y,A,H,T,WEIGHTS,FAIL,PS);
    'ARRAY' Z,Y,A,WEIGHTS; 'REAL' H,T; 'LABEL' FAIL;
    'INTEGER' 'ARRAY' PS;
    'BEGIN' 'INTEGER' IT,LIT; 'REAL' MAX,MAX1,CONV; 'ARRAY' DZ,F1[1:N];
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO' Z[I]:=(Z[I]+Y[I])/2;
        IT:=LIT:=1; CONV:=1;
    ATER: DERIV(T,Z,F1,N);
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        F1[I]:=DZ[I]:=Z[I]-H*F1[I]/2-Y[I];
        SOL(A,N,PS,DZ);
        ELMVEC(1,N,0,Z,DZ,-1);
        MAX:=0;
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        MAX:=MAX+(WEIGHTS[I]*DZ[I])**2;
        MAX:=SQRT(MAX);
        'IF' MAX*CONV<EPS/10 'THEN' 'GOTO' OUT;
        IT:=IT+1; 'IF' IT=2 'THEN' 'GOTO' ASS;
        CONV:=MAX/MAX1;
        'IF' CONV>.2 'THEN'
        'BEGIN' 'IF' LIT=0 'THEN' 'GOTO' FAIL;
            LIT:=0; CONV:=1; IT:=1;
            RECOMP(A,H,T,Z,FAIL,PS);
        'END';
    ASS: MAX1:=MAX;
        'GOTO' ATER;
    OUT: 'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO' Z[I]:=2*Z[I]-Y[I];
    'END' ITERATE;

    'PROCEDURE' RECOMP(A,H,T,Y,FAIL,PS);
    'REAL' H,T; 'ARRAY' A,Y; 'LABEL' FAIL; 'INTEGER' 'ARRAY' PS;
    'BEGIN' 'REAL' SL; 'ARRAY' AUX[1:3];
        SL:=H/2;
        'IF' 'NOT' AVAILABLE(T,Y,A,N) 'THEN' DFDY(T,Y,A);
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' MULROW(1,N,I,I,A,A,-SL); A[I,I]:=1+A[I,I]
        'END';
        AUX[2]:=@-14;
        DEC(A,N,AUX,PS);
        'IF' AUX[3]<N 'THEN' 'GOTO' FAIL
    'END' RECOMP;

    'PROCEDURE' INITIALIZATION;
    'BEGIN' H2:=HNEW; H:=H2/2;
        DUPVEC(1,N,0,S1,Y0); DUPVEC(1,N,0,S2,Y0); DUPVEC(1,N,0,S3,Y0);
        DUPVEC(1,N,0,W1,Y0); DUPROWVEC(1,N,1,R,Y0);
        INIVEC(1,N,U1,0); INIVEC(1,N,W2,0);
        INIMAT(2,5,1,N,R,0); INIMAT(1,5,1,N,RF,0);
        T:=T1:=T0; T2:=T0-2*H-@6; T3:=2*T2+1;
        RECOMP(A1,H,T,S1,MISS,PS1);RECOMP(A2,H2,T,W1,MISS,PS2);
    'END'

    'PROCEDURE' ONE LARGE STEP;
    'BEGIN' STARTV(Z,T+H);
        ITERATE(Z,S1,A1,H,T+H/2,WEIGHTS,MISS,PS1);
        DUPVEC(1,N,0,Y,Z);
        STARTV(Z,T+H2);
        ITERATE(Z,Y,A1,H,T+3*H/2,WEIGHTS,MISS,PS1);
        DUPVEC(1,N,0,U3,U1); DUPVEC(1,N,0,U1,Y);
        DUPVEC(1,N,0,S3,S2); DUPVEC(1,N,0,S2,S1);
        DUPVEC(1,N,0,S1,Z);
        ELMVEC(1,N,0,Z,W1,1); ELMVEC(1,N,0,Z,S2,-1);
        ITERATE(Z,W1,A2,H2,T+H,WEIGHTS,MISS,PS2);
        T3:=T2; T2:=T1; T1:=T+H2;
        DUPVEC(1,N,0,W3,W2); DUPVEC(1,N,0,W2,W1); DUPVEC(1,N,0,W1,Z);
    'END';

    'PROCEDURE' CHANGE OF INFORMATION;
    'BEGIN' 'REAL' ALF1,C1,C2,C3; 'ARRAY' KOF[2:4,2:4],E,D[1:4];
        'INTEGER' I, K;
        C1:=HNEW/H2; C2:=C1*C1; C3:=C2*C1;
        KOF[2,2]:=C1; KOF[2,3]:=(C1-C2)/2; KOF[2,4]:=C3/6-C2/2+C1/3;
        KOF[3,3]:=C2; KOF[3,4]:=C2-C3; KOF[4,4]:=C3;
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        U1[I]:=R[2,I]+R[3,I]/2+R[4,I]/3;
        ALF1:=MATVEC(1,N,1,RF,U1)/VECVEC(1,N,0,U1,U1);
        ALF:=(ALF+ALF1)*C1;
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN'
            E[1]:=RF[1,I]-ALF1*U1[I];
            E[2]:=RF[2,I]-ALF1*2*R[3,I];
            E[3]:=RF[3,I]-ALF1*4*R[4,I];
            E[4]:=RF[4,I];
            D[1]:=R[1,I]; RF[1,I]:=E[1]:=E[1]*C2;
            'FOR' K:=2 'STEP' 1 'UNTIL' 4 'DO'
            'BEGIN' R[K,I]:=D[K]:=MATMAT(K,4,K,I,KOF,R);
                RF[K,I]:=E[K]:=C2*MATVEC(K,4,K,KOF,E)
            'END' K;
            S1[I]:=D[1]+E[1];W1[I]:=D[1]+4*E[1];
            S2[I]:=S1[I]-(D[2]+E[2]/2);
            S3[I]:=S2[I]-(D[2]+E[2])+(D[3]+E[3]/2);
        'END' I;
        T3:=T-HNEW; T2:=T-HNEW/2; T1:=T;
        H2:=HNEW; H:=H2/2; ERR[1]:=0;
        'IF' HALV 'THEN'
        'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO' PS2[I]:= PS1[I];
            DUPMAT(1,N,1,N,A2,A1) 'END';
        'IF' TWO 'THEN'
        'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO' PS1[I]:= PS2[I];
            DUPMAT(1,N,1,N,A1,A2)
        'END' 'ELSE' RECOMP(A1,HNEW/2,T,S1,MISS,PS1);
        'IF' ^HALV 'THEN' RECOMP(A2,HNEW,T,W1,MISS,PS2);
    'END' HNEW^=H2
    'PROCEDURE' BACKWARD DIFFERENCES;
    'FOR'I:=1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' 'REAL' B0,B1,B2,B3;
        B1:=(U1[I]+2*S2[I]+U3[I])/4;
        B2:=(W1[I]+2*W2[I]+W3[I])/4;
        B3:=(S3[I]+2*U3[I]+S2[I])/4;
        B2:=(B2-B1)/3; B0:=B1-B2;
        B2:=B2-(S1[I]-2*S2[I]+S3[I])/16;
        B1:=2*B3-(B2+RF[1,I])-(B0+R[1,I])/2;
        B3:=0;
        'FOR' K:=1 'STEP' 1 'UNTIL' 4 'DO'
        'BEGIN' B1:=B1-B3; B3:=R[K,I]; R[K,I]:=B0; B0:=B0-B1
        'END'; R[5,I]:=B0;
        'FOR' K:=1 'STEP' 1 'UNTIL' 4 'DO'
        'BEGIN' B3:=RF[K,I]; RF[K,I]:=B2; B2:=B2-B3 'END';
        RF[5,I]:=B2;
    'END';

    'PROCEDURE' ERROR ESTIMATES;
    'BEGIN' 'REAL' C0,C1,C2,C3,B0,B1,B2,B3,W,SL1,SN,LR;
        C0:=C1:=C2:=C3:=0;
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' W:=WEIGHTS[I]**2;
            B0:=RF[4,I]/36; C0:=C0+B0*B0*W; LR:=ABS(B0);
            B1:=RF[1,I]+ALF*R[2,I]; C1:=C1+B1*B1*W;
            B2:=RF[3,I]; C2:=C2+B2*B2*W;
            SL1:=ABS(RF[1,I]-RF[2,I]);
            SN:='IF' SL1<@-10 'THEN'1'ELSE'ABS(RF[1,I]-R[4,I]/6)/SL1;
            'IF' SN>1 'THEN' SN:=1;
            'IF' START 'THEN' 'BEGIN' SN:=SN**4; LR:=LR*4 'END';
            EHR[I]:=B3:=SN*EHR[I]+LR; C3:=C3+B3*B3*W;
        'END' I;
        B0:=ERR[1];
        ERR[1]:=B1:=SQRT(C0); ERR[2]:=SQRT(C1);
        ERR[3]:=SQRT(C3)+SQRT(C2)/2;
        LQ:=EPS/('IF' B0<B1 'THEN' B1'ELSE' B0);
        'IF' B0<B1 'AND' LQ>=80 'THEN' LQ:=10;
    'END';

    'PROCEDURE' REJECT;
    'IF' START 'THEN'
    'BEGIN' HNEW:=LQ**(1/5)*H/2; 'GOTO' INIT
    'END' 'ELSE'
    'BEGIN' 'FOR' K:=1,2,3,4,1,2,3 'DO' ELMROW(1,N,K,K+1,R,R,-1);
        'FOR' K:=1,2,3,4 'DO' ELMROW(1,N,K,K+1,RF,RF,-1);
        T:=T-H2; HALV:='TRUE'; HNEW:=H; 'GOTO' MSTP
    'END'

    'PROCEDURE' STEPSIZE;
    'IF' LQ<2 'THEN'
    'BEGIN' HALV:='TRUE'; HNEW:=H 'END' 'ELSE'
    'BEGIN' 'IF' LQ>80 'THEN'
        HNEW:=('IF' LQ>5120 'THEN' (LQ/5)**(1/5) 'ELSE' 2)*H2;
        'IF' HNEW>HMAX 'THEN' HNEW:=HMAX;
        'IF' TEND>T 'AND' TEND-T<HNEW 'THEN' HNEW:=TEND-T;
        TWO:=HNEW=2*H2;
    'END';

    'IF' PRESCH 'THEN' H:=H0 'ELSE'
    'BEGIN' 'IF' H0>HMAX 'THEN' H:=HMAX 'ELSE' H:=H0;
        'IF' H>(TEND-T0)/4 'THEN' H:=(TEND-T0)/4;
    'END';
    HNEW:=H;
    ALF:=0; T:=TP:=T0;
    INIVEC(1,3,ERR,0); INIVEC(1,N,EHR,0);
    DUPROWVEC(1,N,1,R,Y0); INIMAT(2, 5, 1, N, R, 0.0);
    CONTROL(TP,T,H,HNEW,R,ERR,N);
INIT: INITIALIZATION; START:='TRUE';
    'FOR' ECI:=0,1,2,3 'DO'
    'BEGIN' ONE LARGE STEP; T:=T+H2;
        'IF' ECI>0 'THEN'
        'BEGIN' BACKWARD DIFFERENCES; UPDATE(WEIGHTS,S2,N) 'END'
    'END';
    ECI:=4;
MSTP: 'IF' HNEW^=H2 'THEN'
    'BEGIN' ECI:=1; CHANGE OF INFORMATION;
        ONE LARGE STEP; T:=T+H2; ECI:=2;
    'END';
    ONE LARGE STEP;
    BACKWARD DIFFERENCES;
    UPDATE(WEIGHTS,S2,N);
    ERROR ESTIMATES;
    'IF' ECI<4 'AND' LQ>80 'THEN' LQ:=20;
    HALV:=TWO:='FALSE';
    'IF' PRESCH 'THEN' 'GOTO' TRYCK;
    'IF' LQ<1 'THEN' REJECT 'ELSE' STEPSIZE;
TRYCK: 'IF' TP<=T 'THEN' CONTROL(TP,T,H,HNEW,R,ERR,N);
    'IF' START 'THEN' START:='FALSE';
    'IF' HNEW=H2 'THEN' T:=T+H2; ECI:=ECI+1;
    'IF' T<TEND+H2 'THEN' 'GOTO' MSTP 'ELSE' 'GOTO' END;
MISS: FAIL:=PRESCH;
    'IF' ^ FAIL 'THEN'
    'BEGIN' 'IF' ECI>1 'THEN' T:=T-H2;
        HALV:=TWO:='FALSE'; HNEW:=H2/2;
        'IF' START 'THEN' 'GOTO' INIT 'ELSE' 'GOTO' TRYCK
    'END';
END:
'END' IMPEX;
        'EOP'
