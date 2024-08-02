'CODE' 33120;
'PROCEDURE' EFERK(X,XE,M,Y,SIGMA,PHI,DERIVATIVE,J,JACOBIAN,
              K,L,AUT,AETA,RETA,HMIN,HMAX,LINEAR,OUTPUT);
'VALUE' L; 'INTEGER' M,K,L;
'REAL' X,XE,SIGMA,PHI,AETA,RETA,HMIN,HMAX; 'ARRAY' Y,J;
'BOOLEAN' AUT,LINEAR; 'PROCEDURE' DERIVATIVE,JACOBIAN,OUTPUT;
'BEGIN' 'INTEGER' M1,I;
    'REAL' H,B,B0,PHI0,COSPHI,SINPHI,ETA,DISCR,FAC,PI;
    'BOOLEAN' CHANGE,LAST;
    'INTEGER' 'ARRAY' P[1:L];
    'REAL' 'ARRAY' BETA,BETHA[0:L],BETAC[0:L+3],K0,D,D1,D2[1:M],
        A[1:L,1:L],AUX[1:3];
    'REAL' 'PROCEDURE' SUM(I,L,U,T); 'VALUE' L,U; 'INTEGER' I,L,U;
    'REAL' T;
    'BEGIN' 'REAL' S; S:=0;
        'FOR' I:=L 'STEP' 1 'UNTIL' U 'DO' S:=S+T;
        SUM:=S
    'END';
    'PROCEDURE' FORMBETA;
    'IF' L=1 'THEN'
    'BEGIN' BETHA[1]:=(.5-(1-(1-EXP(-B))/B)/B)/B;
        BETA[1]:=(1/6-BETHA[1])/B
    'END' 'ELSE'
    'IF' L=2 'THEN'
    'BEGIN' 'REAL' E,EMIN1; E:=EXP(-B); EMIN1:=E-1;
        BETHA[1]:=(1-(3+E+4*EMIN1/B)/B)/B;
        BETHA[2]:=(.5-(2+E+3*EMIN1/B)/B)/B/B;
        BETA[2]:=(1/6-BETHA[1])/B/B;
        BETA[1]:=(1/3-(1.5-(4+E+5*EMIN1/B)/B)/B)/B
    'END' 'ELSE'
    'BEGIN' 'REAL' B0,B1,B2,A0,A1,A2,A3,C,D;
        BETAC[L-1]:=C:=D:=EXP(-B)/FAC;
        'FOR' I:=L-1 'STEP' -1 'UNTIL' 1 'DO'
        'BEGIN' C:=I*B*C/(L-I); BETAC[I-1]:=D:=D*I+C 'END';
        B2:=.5-BETAC[2];
        B1:=(1-BETAC[1])*(L+1)/B;
        B0:=(1-BETAC[0])*(L+2)*(L+1)*.5/B/B;
        A3:=1/6-BETAC[3];
        A2:=B2*(L+1)/B;
        A1:=B1*(L+2)*.5/B;
        A0:=B0*(L+3)/3/B;
        D:=L/B;
        'FOR' I:=1 'STEP' 1 'UNTIL' L 'DO'
        'BEGIN'BETA[I]:=(A3/I-A2/(I+1)+A1/(I+2)-A0/(I+3))*D+BETAC[I+3];
            BETHA[I]:=(B2/I-B1/(I+1)+B0/(I+2))*D+BETAC[I+2];
            D:=D*(L-I)/I/B;
        'END'
    'END';
    'PROCEDURE' SOLUTIONOFCOMPLEXEQUATIONS;
    'IF' L=2 'THEN'
    'BEGIN' 'REAL' COS2PHI,COSA,SINA,E,ZI;
        PHI0:=PHI; COSPHI:=COS(PHI0); SINPHI:=SIN(PHI0);
        E:=EXP(B*COSPHI); ZI:=B*SINPHI-3*PHI0;
        SINA:=('IF' ABS(SINPHI)<@-6 'THEN' -E*(B+3)
              'ELSE' E*SIN(ZI)/SINPHI);
        COS2PHI:=2*COSPHI*COSPHI-1;
        BETHA[2]:=(.5+(2*COSPHI+(1+2*COS2PHI+SINA)/B)/B)/B/B;
        SINA:=('IF' ABS(SINPHI)<@-6 'THEN' E*(B+4)
              'ELSE' SINA*COSPHI-E*COS(ZI));
        BETHA[1]:=-(COSPHI+(1+2*COS2PHI+(4*COSPHI*COS2PHI+SINA)
                  /B)/B)/B;
        BETA[1]:=BETHA[2]+2*COSPHI*(BETHA[1]-1/6)/B;
        BETA[2]:=(1/6-BETHA[1])/B/B
    'END' 'ELSE'

    'BEGIN' 'INTEGER' J,C1;
        'REAL' C2,E,ZI,COSIPHI,SINIPHI,COSPHIL;
        'REAL' 'ARRAY' D[1:L];
        'PROCEDURE' ELEMENTS OF MATRIX;
        'BEGIN' PHI0:=PHI;
            COSPHI:=COS(PHI0); SINPHI:=SIN(PHI0);
            COSIPHI:=1; SINIPHI:=0;
            'FOR' I:=0 'STEP' 1 'UNTIL' L-1 'DO'
            'BEGIN' C1:=4+I; C2:=1;
                'FOR' J:=L-1 'STEP' -2 'UNTIL' 1 'DO'
                'BEGIN'  A[J,L-I]:=C2*COSIPHI;
                    A[J+1,L-I]:=C2*SINIPHI;
                    C2:=C2*C1; C1:=C1-1
                'END';
                COSPHIL:=COSIPHI*COSPHI-SINIPHI*SINPHI;
                SINIPHI:=COSIPHI*SINPHI+SINIPHI*COSPHI;
                COSIPHI:=COSPHIL
            'END';
            AUX[2]:=0; DEC(A,L,AUX,P)
        'END' EL OF MAT;
        'PROCEDURE' RIGHT HAND SIDE;
        'BEGIN' E:=EXP(B*COSPHI);
            ZI:=B*SINPHI-4*PHI0;
            COSIPHI:=E*COS(ZI); SINIPHI:=E*SIN(ZI);
            ZI:=1/B/B/B;
            'FOR' J:=L 'STEP' -2 'UNTIL' 2 'DO'
            'BEGIN' D[J]:=ZI*SINIPHI;
                D[J-1]:=ZI*COSIPHI;
                COSPHIL:=COSIPHI*COSPHI-SINIPHI*SINPHI;
                SINIPHI:=COSIPHI*SINPHI+SINIPHI*COSPHI;
                COSIPHI:=COSPHIL; ZI:=ZI*B
            'END';
            SINIPHI:=2*SINPHI*COSPHI;
            COSIPHI:=2*COSPHI*COSPHI-1;
            COSPHIL:=COSPHI*(2*COSIPHI-1);
            D[L]:=D[L]+SINPHI*(1/6+(COSPHI+(1+2*COSIPHI*(1+2*COSPHI/B))
                        /B)/B);
            D[L-1]:=D[L-1]-COSPHI/6-(.5*COSIPHI+(COSPHIL+(2*COSIPHI*
                        COSIPHI-1)/B)/B)/B;
            D[L-2]:=D[L-2]+SINPHI*(.5+(2*COSPHI+(2*COSIPHI+1)/B)/B);
            D[L-3]:=D[L-3]-.5*COSPHI-(COSIPHI+COSPHIL/B)/B;
            'IF' L<5 'THEN' 'GOTO' END;
            D[L-4]:=D[L-4]+SINPHI+SINIPHI/B;
            D[L-5]:=D[L-5]-COSPHI-COSIPHI/B;
            'IF' L<7 'THEN' 'GOTO' END;
            D[L-6]:=D[L-6]+SINPHI;
            D[L-7]:=D[L-7]-COSPHI;
        END:
        'END' RHS;
        'IF' PHI0^=PHI 'THEN' ELEMENTS OF MATRIX;
        RIGHT HAND SIDE;
        SOL(A,L,P,D);
        ZI:=1/B;
        'FOR' I:=1 'STEP' 1 'UNTIL' L 'DO'
        'BEGIN' BETA[I]:=D[L+1-I]*ZI;
            BETHA[I]:=(I+3)*BETA[I];
            ZI:=ZI/B
        'END'
    'END' SOLOFEQCOM;

    'PROCEDURE' COEFFICIENT;
    'BEGIN' B0:=B:=ABS(H*SIGMA);
        'IF' B>=.1 'THEN'
        'BEGIN' 'IF' PHI^=PI 'AND' L=2 'OR' ABS(PHI-PI)>.01 'THEN'
            SOLUTION OF COMPLEX EQUATIONS 'ELSE' FORMBETA
        'END' 'ELSE'
        'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' L 'DO'
            'BEGIN' BETHA[I]:=BETA[I-1];
                BETA[I]:=BETA[I-1]/(I+3);
            'END'
        'END'
    'END' COEFFICIENT;

    'PROCEDURE' LOCAL ERROR BOUND;
    ETA:=AETA+RETA*SQRT(VECVEC(1,M1,0,Y,Y));

    'PROCEDURE' STEPSIZE;
    'BEGIN' LOCAL ERROR BOUND;
        'IF' K=0 'THEN'
        'BEGIN' DISCR:=SQRT(VECVEC(1,M1,0,D,D)); H:=ETA/DISCR
        'END' 'ELSE'
        'BEGIN' DISCR:=H*SQRT(SUM(I,1,M1,(D[I]-D2[I])**2))/ETA;
            H:=H*('IF' LINEAR 'THEN' 4/(4+DISCR)+.5
                              'ELSE' 4/(3+DISCR)+1/3)
        'END';
        'IF' H<HMIN 'THEN' H:=HMIN;
        'IF' H>HMAX 'THEN' H:=HMAX;
        B:=ABS(H*SIGMA);
        CHANGE:=ABS(1-B/B0)>.05 'OR' PHI^=PHI0;
        'IF' 1.1*H>=XE-X 'THEN'
        'BEGIN' CHANGE:=LAST:='TRUE'; H:=XE-X 'END';
        'IF' 'NOT' CHANGE 'THEN' H:=H*B0/B
    'END' STEPSIZE;

    'PROCEDURE' DIFFERENCE SCHEME;
    'BEGIN' 'INTEGER' K;
        'REAL' BETAI,BETHAI;
        'IF' M1<M 'THEN'
        'BEGIN' D2[M]:=1; K0[M]:=Y[M]+2*H/3; Y[M]:=Y[M]+.25*H 'END';
        'FOR' K:=1 'STEP' 1 'UNTIL' M1 'DO'
        'BEGIN' K0[K]:=Y[K]+2*H/3*D[K];
            Y[K]:=Y[K]+.25*H*D[K];
            D1[K]:=H*MATVEC(1,M,K,J,D);
            D2[K]:=D1[K]+D[K]
        'END';
        'FOR' I:=0 'STEP' 1 'UNTIL' L 'DO'
        'BEGIN' BETAI:=4*BETA[I]/3; BETHAI:=BETHA[I];
            'FOR' K:=1 'STEP' 1 'UNTIL' M1 'DO' D[K]:=H*D1[K];
            'FOR' K:=1 'STEP' 1 'UNTIL' M1 'DO'
            'BEGIN' K0[K]:=K0[K]+BETAI*D[K];
                D1[K]:=MATVEC(1,M1,K,J,D);
                D2[K]:=D2[K]+BETHAI*D1[K]
            'END'
        'END';
        DERIVATIVE(K0);
        'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO' Y[K]:=Y[K]+.75*H*K0[K]
    'END' DIFF SCHEME;

    B0:=PHI0:=-1; PI:=4*ARCTAN(1);
    BETAC[L]:=BETAC[L+1]:=BETAC[L+2]:=BETAC[L+3]:=0;
    BETA[0]:=1/6; BETHA[0]:=.5;
    FAC:=1; 'FOR' I:=2 'STEP' 1 'UNTIL' L-1 'DO' FAC:=I*FAC;
    M1:= 'IF' AUT 'THEN' M 'ELSE' M-1;
    K:=0; LAST:='FALSE';
 NEXT LEVEL:
    'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO' D[I]:=Y[I];
    DERIVATIVE(D);
    'IF' 'NOT' LINEAR 'OR' K=0 'THEN' JACOBIAN(J,Y);
    STEPSIZE;
    'IF' CHANGE 'THEN' COEFFICIENT;
    OUTPUT;
    DIFFERENCE SCHEME;
    K:=K+1;
    X:=X+H;
    'IF' 'NOT' LAST 'THEN' 'GOTO' NEXT LEVEL;
END OF EFERK: OUTPUT;
'END' EFERK;
        'EOP'
