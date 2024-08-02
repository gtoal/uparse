'CODE' 34600;
'PROCEDURE' QZIVAL(N,A,B,ALFR,ALFI,BETA,ITER,EM);
'VALUE' N;'INTEGER' N;'ARRAY' A,B,ALFR,ALFI,BETA,EM;
'INTEGER' 'ARRAY' ITER;
'BEGIN' 'REAL' DWARF,EPS,EPSA,EPSB;
'PROCEDURE' QZIT(N,A,B,EPS,EPSA,EPSB,ITER);'VALUE'N,EPS;
'REAL' EPS,EPSA,EPSB;'INTEGER' N;'INTEGER' 'ARRAY' ITER;'ARRAY' A,B;
'BEGIN' 'REAL' ANORM,BNORM,ANI,BNI,CONST,A10,A20,A30,B11,
    B22,B33,B44,A11,A12,A21,A22,A33,A34,A43,A44,B12,B34,OLD1,OLD2;
    'INTEGER' I,Q,M,M1,Q1,J,K,K1,K2,K3,KM1;'BOOLEAN' STATIONARY;
    ANORM:=BNORM:=0;'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' BNI:=0;ITER[I]:=0;ANI:='IF' I>1'THEN'ABS(A[I,I-1])'ELSE' 0;
        'FOR' J:=I 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' ANI:=ANI+ABS(A[I,J]);BNI:=BNI+ABS(B[I,J])
        'END';'IF' ANI>ANORM 'THEN' ANORM:=ANI;'IF' BNI>BNORM'THEN'
        BNORM:=BNI
    'END';'IF' ANORM=0 'THEN' ANORM:=EPS;'IF'BNORM=0 'THEN' BNORM:=EPS;
    EPSA:=EPS*ANORM;EPSB:=EPS*BNORM;
    'FOR' M:=N,M 'WHILE' M>=3 'DO'
  'BEGIN'
    'FOR' I:=M+1,I-1 'WHILE'('IF' I>1 'THEN'ABS(A[I,I-1])>EPSA 'ELSE'
    'FALSE') 'DO' Q:=I-1;
    'IF' Q>1 'THEN' A[Q,Q-1]:=0;
 L: 'IF' Q>=M-1 'THEN' M:=Q-1 'ELSE'
    'BEGIN'
        'IF' ABS(B[Q,Q])<=EPSB 'THEN'
        'BEGIN' B[Q,Q]:=0;Q1:=Q+1;
            HSH2COL(Q,Q,M,Q,A[Q,Q],A[Q1,Q],A,B);A[Q1,Q]:=0;
            Q:=Q1;'GOTO' L
        'END' 'ELSE' M1:=M-1;Q1:=Q+1;CONST:=0.75;ITER[M]:=ITER[M]+1;
        STATIONARY:='IF' ITER[M]=1 'THEN' 'TRUE' 'ELSE'
        ABS(A[M,M-1])>=CONST*OLD1'AND'ABS(A[M-1,M-2])>=CONST*OLD2;
        'IF' ITER[M]>30'AND'STATIONARY 'THEN'
        'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO' ITER[I]:=-1;
            'GOTO' OUT
        'END';
        'IF' ITER[M]=10'AND'STATIONARY 'THEN'
        'BEGIN' A10:=0;A20:=1;A30:=1.1605
        'END' 'ELSE'
        'BEGIN' B11:=B[Q,Q];B22:='IF' ABS(B[Q1,Q1])<EPSB 'THEN'EPSB
            'ELSE' B[Q1,Q1];
            B33:='IF' ABS(B[M1,M1])<EPSB 'THEN' EPSB 'ELSE'B[M1,M1];
            B44:='IF' ABS(B[M,M])<EPSB 'THEN' EPSB 'ELSE' B[M,M] ;
            A11:=A[Q,Q]/B11;A12:=A[Q,Q1]/B22;A21:=A[Q1,Q]/B11;
            A22:=A[Q1,Q1]/B22;A33:=A[M1,M1]/B33;A34:=A[M1,M]/B44;
            A43:=A[M,M1]/B33;A44:=A[M,M]/B44;B12:=B[Q,Q1]/B22;
            B34:=B[M1,M]/B44;
            A10:=((A33-A11)*(A44-A11)-A34*A43+A43*B34*A11)/A21
                 +A12-A11*B12;
            A20:=(A22-A11-A21*B12)-(A33-A11)-(A44-A11)+A43*B34;
            A30:=A[Q+2,Q1]/B22
        'END';OLD1:=ABS(A[M,M-1]);OLD2:=ABS(A[M-1,M-2]);
        'FOR' K:=Q 'STEP' 1 'UNTIL' M1 'DO'
        'BEGIN' K1:=K+1;K2:=K+2;K3:='IF' K+3>M 'THEN' M 'ELSE' K+3;
            KM1:='IF' K-1<Q 'THEN' Q 'ELSE' K-1;
            'IF' K^=M1 'THEN'
            'BEGIN' 'IF' K=Q 'THEN'
                HSH3COL(KM1,KM1,M,K,A10,A20,A30,A,B) 'ELSE'
                'BEGIN'
                 HSH3COL(KM1,KM1,M,K,A[K,KM1],A[K1,KM1],A[K2,KM1],A,B);
                  A[K1,KM1]:=A[K2,KM1]:=0
                'END';
                HSH3ROW2(Q,Q,K3,K,B[K2,K2],B[K2,K1],B[K2,K],A,B);
                B[K2,K]:=B[K2,K1]:=0 ;
            'END' 'ELSE'
            'BEGIN' HSH2COL(KM1,KM1,M,K,A[K,KM1],A[K1,KM1],A,B);
                A[K1,KM1]:=0
            'END';
            HSH2ROW2(Q,Q,K3,K3,K,B[K1,K1],B[K1,K],A,B);B[K1,K]:=0
        'END'
      'END'
    'END';
    OUT:
'END' QZIT;

'PROCEDURE' QZVAL(N,A,B,EPSA,EPSB,ALFR,ALFI,BETA);'VALUE' N;
'REAL' EPSA,EPSB;'INTEGER' N;'ARRAY' ALFR,ALFI,BETA,A,B;
'BEGIN' 'INTEGER' M,L,J;'REAL' AN,BN,A11,A12,A21,A22,B11,B12,B22,E,C,D,
    ER,EI,A11R,A11I,A12R,A12I,A21R,A21I,A22R,A22I,CZ,SZR,SZI,
    CQ,SQR,SQI,SSR,SSI,TR,TI,BDR,BDI,R;
    'FOR' M:=N,M 'WHILE' M>0 'DO'
    'IF'('IF' M>1 'THEN' A[M,M-1]=0 'ELSE' 'TRUE') 'THEN'
    'BEGIN' ALFR[M]:=A[M,M];BETA[M]:=B[M,M];ALFI[M]:=0;M:=M-1
    'END' 'ELSE'
    'BEGIN' L:=M-1;'IF' ABS(B[L,L])<=EPSB 'THEN'
        'BEGIN' B[L,L]:=0;HSH2COL(L,L,N,L,A[L,L],A[M,L],A,B);
            A[M,L]:=B[M,L]:=0;ALFR[L]:=A[L,L];ALFR[M]:=A[M,M];
            BETA[L]:=B[L,L];BETA[M]:=B[M,M];ALFI[M]:=ALFI[L]:=0;
        'END' 'ELSE' 'IF' ABS(B[M,M])<=EPSB 'THEN'
        'BEGIN'B[M,M]:=0;HSH2ROW2(1,1,M,M,L,A[M,M],A[M,L],A,B);
            A[M,L]:=B[M,L]:=0;ALFR[L]:=A[L,L];ALFR[M]:=A[M,M];
            BETA[L]:=B[L,L];BETA[M]:=B[M,M];ALFI[M]:=ALFI[L]:=0;
        'END''ELSE'
      'BEGIN'
        AN:=ABS(A[L,L])+ABS(A[L,M])+ABS(A[M,L])+ABS(A[M,M]);
        BN:=ABS(B[L,L])+ABS(B[L,M])+ABS(B[M,M]);
        A11:=A[L,L]/AN;A12:=A[L,M]/AN;A21:=A[M,L]/AN;A22:=A[M,M]/AN;
        B11:=B[L,L]/BN;B12:=B[L,M]/BN;B22:=B[M,M]/BN;
        E:=A11/B11;
        C:=((A22-E*B22)/B22-(A21*B12)/(B11*B22))/2;
        D:=C*C+(A21*(A12-E*B12))/(B11*B22);
        'IF' D>=0 'THEN'
        'BEGIN'E:=E+('IF'C<0'THEN'C-SQRT(D)'ELSE'C+SQRT(D));
            A11:=A11-E*B11;A12:=A12-E*B12;A22:=A22-E*B22;
            'IF' ABS(A11)+ABS(A12)>=ABS(A21)+ABS(A22) 'THEN'
            HSH2ROW2(1,1,M,M,L,A12,A11,A,B)'ELSE'
            HSH2ROW2(1,1,M,M,L,A22,A21,A,B);
            'IF'AN>=ABS(E)*BN'THEN'
            HSH2COL(L,L,N,L,B[L,L],B[M,L],A,B) 'ELSE'
            HSH2COL(L,L,N,L,A[L,L],A[M,L],A,B);
            A[M,L]:=B[M,L]:=0;
            ALFR[L]:=A[L,L];ALFR[M]:=A[M,M];BETA[L]:=B[L,L];
            BETA[M]:=B[M,M];ALFI[M]:=ALFI[L]:=0;
        'END''ELSE'
        'BEGIN'
            ER:=E+C;EI:=SQRT(-D);A11R:=A11-ER*B11;A11I:=EI*B11;
            A12R:=A12-ER*B12;A12I:=EI*B12;A21R:=A21;A21I:=0;
            A22R:=A22-ER*B22;A22I:=EI*B22;
            'IF'ABS(A11R)+ABS(A11I)+ABS(A12R)+ABS(A12I)>=
            ABS(A21R)+ABS(A22R)+ABS(A22I)'THEN'
            CHSH2(A12R,A12I,-A11R,-A11I,CZ,SZR,SZI)'ELSE'
            CHSH2(A22R,A22I,-A21R,-A21I,CZ,SZR,SZI);
            'IF'AN>=(ABS(ER)+ABS(EI))*BN'THEN'
            CHSH2(CZ*B11+SZR*B12,SZI*B12,SZR*B22,SZI*B22,CQ,SQR,SQI)
            'ELSE'CHSH2(CZ*A11+SZR*A12,SZI*A12,CZ*A21+SZR*A22,SZI*A22,
            CQ,SQR,SQI);SSR:=SQR*SZR+SQI*SZI;SSI:=SQR*SZI-SQI*SZR;
            TR:=CQ*CZ*A11+CQ*SZR*A12+SQR*CZ*A21+SSR*A22;
            TI:=CQ*SZI*A12-SQI*CZ*A21+SSI*A22;
            BDR:=CQ*CZ*B11+CQ*SZR*B12+SSR*B22;
            BDI:=CQ*SZI*B12+SSI*B22;
            R:=SQRT(BDR*BDR+BDI*BDI);BETA[L]:=BN*R;
            ALFR[L]:=AN*(TR*BDR+TI*BDI)/R;
            ALFI[L]:=AN*(TR*BDI-TI*BDR)/R;
            TR:=SSR*A11-SQR*CZ*A12-CQ*SZR*A21+CQ*CZ*A22;
            TI:=-SSI*A11-SQI*CZ*A12+CQ*SZI*A21;
            BDR:=SSR*B11-SQR*CZ*B12+CQ*CZ*B22;
            BDI:=-SSI*B11-SQI*CZ*B12;
            R:=SQRT(BDR*BDR+BDI*BDI);BETA[M]:=BN*R;
            ALFR[M]:=AN*(TR*BDR+TI*BDI)/R;
            ALFI[M]:=AN*(TR*BDI-TI*BDR)/R;
        'END'
      'END';M:=M-2
    'END'
'END' QZVAL;
DWARF:=EM[0];EPS:=EM[1];
HSHDECMUL(N,A,B,DWARF);
HESTGL2(N,A,B);
QZIT(N,A,B,EPS,EPSA,EPSB,ITER);
QZVAL(N,A,B,EPSA,EPSB,ALFR,ALFI,BETA);
'END' QZIVAL

        ;'EOP'
