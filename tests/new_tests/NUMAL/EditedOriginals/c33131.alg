'CODE' 33131;
'PROCEDURE' LINIGER2(X,XE,M,Y,SIGMA1,SIGMA2,F,EVALUATE,J,
               JACOBIAN,K,ITMAX,STEP,AETA,RETA,OUTPUT);
'INTEGER' M,K,ITMAX;
'REAL' X,XE,SIGMA1,SIGMA2,STEP,AETA,RETA;
'ARRAY' Y,J;
'BOOLEAN' 'PROCEDURE' EVALUATE;
'REAL' 'PROCEDURE' F;
'PROCEDURE' JACOBIAN,OUTPUT;

'BEGIN' 'INTEGER' I;
    'REAL' H,HL,B1,B2,P,Q,C0,C1,C2,C3,C4;
    'BOOLEAN' LAST;
    'INTEGER' 'ARRAY' PI[1:M];
    'REAL' 'ARRAY' DY,YL,FL[1:M],A[1:M,1:M],AUX[1:3];

    'PROCEDURE' STEPSIZE;
    'BEGIN' H:=STEP;
        'IF' 1.1*H>=XE-X 'THEN'
        'BEGIN' LAST:='TRUE'; H:=XE-X; X:=XE
        'END' 'ELSE' X:=X+H
    'END' STEPSIZE;

    'PROCEDURE' COEFFICIENT;
    'BEGIN' 'REAL' R1,R2,EX,ZETA,ETA,SINL,COSL,SINH,COSH,D;
        'REAL' 'PROCEDURE' R(X); 'VALUE' X; 'REAL' X;
        'IF' X>40 'THEN' R:=X/(X-2) 'ELSE'
        'BEGIN' EX:=EXP(-X); R:=X*(1-EX)/(X-2+(X+2)*EX) 'END';

        B1:=H*SIGMA1;
        B2:=H*SIGMA2;
        'IF' B1<.1 'THEN' 'BEGIN' P:=0; Q:=1/3; 'GOTO' OUT 'END';
        'IF' B2<0 'THEN' 'GOTO' COMPLEX;
        'IF' B1<1 'OR' B2<.1 'THEN' 'GOTO' THIRDORDER;
        'IF' ABS(B1-B2)<B1*B1*@-6 'THEN' 'GOTO' DOUBLEFIT;

        R1:=R(B1)*B1; R2:=R(B2)*B2;
        D:=B2*R1-B1*R2;
        P:=2*(R2-R1)/D;
        Q:=2*(B2-B1)/D;
THIRDORDER: Q:=1/3;
        P:=R(B1)/3-2/B1;
        'GOTO' OUT;
DOUBLEFIT: B1:=.5*(B1+B2);
        R1:=R(B1);
        'IF' B1>40 'THEN' EX:=0;
        R2:=B1/(1-EX); R2:=1-EX*R2*R2;
        Q:=1/(R1*R1*R2);
        P:=R1*Q-2/B1;
        'GOTO' OUT;
COMPLEX: ETA:=ABS(B1*SIN(SIGMA2));
        ZETA:=ABS(B1*COS(SIGMA2));
        'IF' ETA<B1*B1*@-6 'THEN'
        'BEGIN' B1:=B2:=ZETA; 'GOTO' DOUBLEFIT 'END';
        'IF' ZETA>40 'THEN'
        'BEGIN' P:=1-4*ZETA/B1/B1; Q:=4*(1-ZETA)/B1/B1+1 'END' 'ELSE'
        'BEGIN' EX:=EXP(ZETA);
            SINL:=SIN(ETA); COSL:=COS(ETA);
            SINH:=.5*(EX-1/EX); COSH:=.5*(EX+1/EX);
            D:=ETA*(COSH-COSL)-.5*B1*B1*SINL;
            P:=(ZETA*SINL+ETA*SINH-4*ZETA*ETA/B1/B1*(COSH-COSL))/D;
            Q:=ETA*((COSH-COSL-ZETA*SINH-ETA*SINL)*4/B1/B1+COSH+COSL)/D
        'END';
OUT:    C0:=.25*H*H*(P+Q);
        C1:=.5*H*(1+P);
        C2:=H-C1;
        C3:=.25*H*H*(Q-P);
        C4:=.5*H*P;
        ELEMENTS OF MATRIX
    'END' COEFFICIENT;

    'PROCEDURE' ELEMENTS OF MATRIX;
    'BEGIN' 'INTEGER' K;
        'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' 'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO'
            A[I,K]:=C0*MATMAT(1,M,I,K,J,J)-C1*J[I,K];
            A[I,I]:=A[I,I]+1
        'END';
        AUX[2]:=0; DEC(A,M,AUX,PI)
    'END';
    
    'PROCEDURE' NEWTON ITERATION;
    'BEGIN' 'INTEGER' ITNUM; 'REAL' JFL,ETA,DISCR;
        ITNUM:=0;
NEXT:   ITNUM:=ITNUM+1;
        'IF' EVALUATE(ITNUM) 'THEN'
        'BEGIN' JACOBIAN(J,Y); COEFFICIENT 'END'
        'ELSE' 'IF' ITNUM=1 'AND' H^=HL 'THEN' COEFFICIENT;
        'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO' FL[I]:=F(I);
        'IF' ITNUM=1 'THEN'
        'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO'
            'BEGIN' JFL:=MATVEC(1,M,I,J,FL);
                DY[I]:=H*(FL[I]-C4*JFL);
                YL[I]:=Y[I]+C2*FL[I]+C3*JFL
            'END'
        'END' 'ELSE'
        'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO'
        DY[I]:=YL[I]-Y[I]+C1*FL[I]-C0*MATVEC(1,M,I,J,FL);
        SOL(A,M,PI,DY);
        'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO' Y[I]:=Y[I]+DY[I];
        'IF' ITNUM<ITMAX 'THEN'
        'BEGIN' ETA:=SQRT(VECVEC(1,M,0,Y,Y))*RETA+AETA;
            DISCR:=SQRT(VECVEC(1,M,0,DY,DY));
            'IF' ETA<DISCR 'THEN' 'GOTO' NEXT
        'END'
    'END' NEWTON;

    LAST:='FALSE'; K:=0; HL:=0;
NEXT LEVEL:
    K:=K+1;
    STEPSIZE;
    NEWTON ITERATION;
    HL:=H;
    OUTPUT;
    'IF' 'NOT' LAST 'THEN' 'GOTO' NEXT LEVEL
'END' LINIGER2;
        'EOP'
