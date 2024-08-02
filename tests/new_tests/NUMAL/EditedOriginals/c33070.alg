'CODE' 33070;
'PROCEDURE' EFRK(T,TE,M0,M,U,SIGMA,PHI,DIAMETER,DERIVATIVE,K,STEP,R,L,
        BETA,THIRDORDER,TOL,OUTPUT);
'VALUE' R,L;
'INTEGER' M0,M,K,R,L;
'REAL' T,TE,SIGMA,PHI,DIAMETER,STEP,TOL;
'ARRAY' U,BETA;
'BOOLEAN' THIRDORDER;
'PROCEDURE' DERIVATIVE,OUTPUT;
'BEGIN' 'INTEGER' N;
    'REAL' THETA0,THETANM1,H,B,B0,PHI0,PHIL,PI,COSPHI,SINPHI,EPS,BETAR;
    'BOOLEAN' FIRST,LAST,COMPLEX,CHANGE;
    'INTEGER' 'ARRAY' P[1:L];
    'REAL' 'ARRAY' MU,LABDA[0:R+L-1],PT[0:R],FAC,BETAC[0:L-1],RL[M0:M],
                   A[1:L,1:L],AUX[0:3];
    'PROCEDURE' FORM CONSTANTS;
    'BEGIN' 'INTEGER' I;
        FIRST:='FALSE';
        FAC[0]:=1;
        'FOR' I:=1 'STEP' 1 'UNTIL' L-1 'DO' FAC[I]:=I*FAC[I-1];
        PT[R]:=L*FAC[L-1];
        'FOR' I:=1 'STEP' 1 'UNTIL' R 'DO'
        PT[R-I]:=PT[R-I+1]*(L+I)/I
    'END' FORM CONSTANTS;

    'PROCEDURE' FORM BETA;
    'BEGIN' 'INTEGER' I,J; 'REAL' BB,C,D;
        'IF' FIRST 'THEN' FORM CONSTANTS;
        'IF' L=1 'THEN'
        'BEGIN' C:=1-EXP(-B);
            'FOR' J:=1 'STEP' 1 'UNTIL' R 'DO' C:=BETA[J]-C/B;
            BETA[R+1]:=C/B
        'END' 'ELSE'
        'IF' B>40 'THEN'
        'BEGIN' 'FOR' I:=R+1 'STEP' 1 'UNTIL' R+L 'DO'
            'BEGIN' C:=0;
                'FOR' J:=0 'STEP' 1 'UNTIL' R 'DO'
                C:=BETA[J]*PT[J]/(I-J)-C/B;
                BETA[I]:=C/B/FAC[L+R-I]/FAC[I-R-1]
            'END';
        'END' 'ELSE'
        'BEGIN' D:=C:=EXP(-B); BETAC[L-1]:=D/FAC[L-1];
            'FOR' I:=1 'STEP' 1 'UNTIL' L-1 'DO'
            'BEGIN' C:=B*C/I; D:=D+C; BETAC[L-1-I]:=D/FAC[L-1-I] 'END';
            BB:=1;
            'FOR' I:=R+1 'STEP' 1 'UNTIL' R+L 'DO'
            'BEGIN' C:=0;
                'FOR' J:=0 'STEP' 1 'UNTIL' R 'DO'
                C:=(BETA[J]-('IF' J<L 'THEN' BETAC[J] 'ELSE' 0))*
                   PT[J]/(I-J)-C/B;
                BETA[I]:=C/B/FAC[L+R-I]/FAC[I-R-1]+
                         ('IF' I<L 'THEN' BB*BETAC[I] 'ELSE' 0);
                BB:=BB*B
            'END'
        'END'
    'END' FORM BETA;

    'PROCEDURE' SOLUTION OF COMPLEX EQUATIONS;
    'BEGIN' 'INTEGER' I,J,C1,C3;
        'REAL' C2,E,B1,ZI,COSIPHI,SINIPHI,COSPHIL;
        'REAL' 'ARRAY' D[1:L];

        'PROCEDURE' ELEMENTS OF MATRIX;
        'BEGIN' PHIL:=PHI0;
            COSPHI:=COS(PHIL); SINPHI:=SIN(PHIL);
            COSIPHI:=1; SINIPHI:=0;
            'FOR' I:=0 'STEP' 1 'UNTIL' L-1 'DO'
            'BEGIN' C1:=R+1+I; C2:=1;
                'FOR' J:=L-1 'STEP' -2 'UNTIL' 1 'DO'
                'BEGIN' A[J,L-I]:=C2*COSIPHI;
                    A[J+1,L-I]:=C2*SINIPHI;
                    C2:=C1*C2; C1:=C1-1
                'END';
                COSPHIL:=COSIPHI*COSPHI-SINIPHI*SINPHI;
                SINIPHI:=COSIPHI*SINPHI+SINIPHI*COSPHI;
                COSIPHI:=COSPHIL
            'END';
            AUX[2]:=0; DEC(A,L,AUX,P)
        'END' EL OF MAT;

        'PROCEDURE' RIGHTHANDSIDE;
        'BEGIN' E:=EXP(B*COSPHI);
            B1:=B*SINPHI-(R+1)*PHIL;
            COSIPHI:=E*COS(B1); SINIPHI:=E*SIN(B1);
            B1:=1/B; ZI:=B1**R;
            'FOR' J:=L 'STEP' -2 'UNTIL' 2 'DO'
            'BEGIN' D[J]:=ZI*SINIPHI;
                D[J-1]:=ZI*COSIPHI;
                COSPHIL :=COSIPHI*COSPHI-SINIPHI*SINPHI;
                SINIPHI:=COSIPHI*SINPHI+SINIPHI*COSPHI;
                COSIPHI:=COSPHIL;
                ZI:=ZI*B
            'END';
            COSIPHI:=ZI:=1; SINIPHI:=0;
            'FOR' I:=R 'STEP' -1 'UNTIL' 0 'DO'
            'BEGIN' C1:=I; C2:=BETA[I];
                C3:='IF' 2*I>L-2 'THEN' 2 'ELSE' L-2*I;
                COSPHIL :=COSIPHI*COSPHI-SINIPHI*SINPHI;
                SINIPHI:=COSIPHI*SINPHI+SINIPHI*COSPHI;
                COSIPHI:=COSPHIL;
                'FOR' J:=L 'STEP' -2 'UNTIL' C3 'DO'
                'BEGIN' D[J]:=D[J]+ZI*C2*SINIPHI;
                    D[J-1]:=D[J-1]-ZI*C2*COSIPHI;
                    C2:=C2*C1; C1:=C1-1
                'END';
                ZI:=ZI*B1
            'END'
        'END' RIGHT HAND SIDE;

        'IF' PHI0^=PHIL 'THEN' ELEMENTS OF MATRIX;
        RIGHTHANDSIDE;
        SOL(A,L,P,D);
        'FOR' I:=1 'STEP' 1 'UNTIL' L 'DO' BETA[R+I]:=D[L+1-I]*B1
    'END';
    
    'PROCEDURE' COEFFICIENT;
    'BEGIN' 'INTEGER' J,K; 'REAL' C;
        B0:=B; PHI0:=PHI;
        'IF' B>=1 'THEN'
        'BEGIN' 'IF' COMPLEX 'THEN' SOLUTION OF COMPLEX EQUATIONS
            'ELSE' FORM BETA
        'END';
        LABDA[0]:=MU[0]:=0;
        'IF' THIRDORDER 'THEN'
        'BEGIN' THETA0:=.25; THETANM1:=.75;
            'IF' B<1 'THEN'
            'BEGIN' C:=MU[N-1]:=2/3; LABDA[N-1]:=5/12;
                'FOR' J:=N-2 'STEP' -1 'UNTIL' 1 'DO'
                'BEGIN' C:=MU[J]:=C/(C-.25)/(N-J+1);
                    LABDA[J]:=C-.25
                'END'
            'END' 'ELSE'
            'BEGIN' C:=MU[N-1]:=BETA[2]*4/3; LABDA[N-1]:=C-.25;
                'FOR' J:=N-2 'STEP' -1 'UNTIL' 1 'DO'
                'BEGIN' C:=MU[J]:=C/(C-.25)*BETA[N-J+1]/BETA[N-J]/
                           ('IF' J<L 'THEN' B 'ELSE' 1);
                    LABDA[J]:=C-.25
                'END'
            'END'
        'END' 'ELSE'
        'BEGIN' THETA0:=0; THETANM1:=1;
            'IF' B<1 'THEN'
            'BEGIN' 'FOR' J:=N-1 'STEP' -1 'UNTIL' 1 'DO'
                MU[J]:=LABDA[J]:=1/(N-J+1)
            'END' 'ELSE'
            'BEGIN' LABDA[N-1]:=MU[N-1]:=BETA[2];
                'FOR' J:=N-2 'STEP' -1 'UNTIL' 1 'DO'
                MU[J]:=LABDA[J]:=BETA[N-J+1]/BETA[N-J]/
                       ('IF' J<L 'THEN' B 'ELSE' 1)
            'END'
        'END'
    'END';
        
    'PROCEDURE' STEPSIZE;
    'BEGIN' 'REAL' D,HSTAB,HSTABINT;
        H:=STEP;
        D:=ABS(SIGMA*SIN(PHI));
        COMPLEX:=L//2*2=L 'AND' 2*D>DIAMETER;
        'IF' DIAMETER>0 'THEN'
        HSTAB:=(SIGMA**2/(DIAMETER*(DIAMETER*.25+D)))**(L*.5/R)/
               BETAR/SIGMA
        'ELSE' HSTAB:=H;
        D:= 'IF' THIRDORDER 'THEN' (2*TOL/EPS/BETA[R])**(1/(N-1))*
            4**((L-1)/(N-1)) 'ELSE' (TOL/EPS)**(1/R)/BETAR;
        HSTABINT:= ABS(D/SIGMA);
        'IF' H>HSTAB 'THEN' H:=HSTAB;
        'IF' H>HSTABINT 'THEN' H:=HSTABINT;
        'IF' T+H>TE*(1-K*EPS) 'THEN'
        'BEGIN' LAST:='TRUE'; H:=TE-T 'END';
        B:=H*SIGMA; D:=DIAMETER*.1*H; D:=D*D;
        'IF' H<T*EPS  'THEN' 'GOTO' ENDOFEFRK;
        CHANGE:=B0=-1 'OR' ((B-B0)*(B-B0)+B*B0*(PHI-PHI0)*(PHI-PHI0)>D)
    'END' STEPSIZE;

    'PROCEDURE' DIFFERENCESCHEME ;
    'BEGIN' 'INTEGER' I,J; 'REAL' MT,LT,THT;
        I:=-1;
        NEXTTERM:
        I:=I+1; MT:=MU[I]*H; LT:=LABDA[I]*H;
        'FOR' J:=M0 'STEP' 1 'UNTIL' M 'DO' RL[J]:=U[J]+LT*RL[J];
        DERIVATIVE(T+MT,RL);
        'IF' I=0 'OR' I=N-1 'THEN'
        'BEGIN' THT:='IF' I=0 'THEN' THETA0*H 'ELSE' THETANM1*H;
            ELMVEC(M0,M,0,U,RL,THT)
        'END';
        'IF' I<N-1 'THEN' 'GOTO' NEXTTERM;
        T:=T+H
    'END' DIFFERENCE SCHEME;

    N:=R+L; FIRST:='TRUE'; B0:=-1; BETAR:=BETA[R]**(1/R);
    LAST:='FALSE'; EPS:=2.0**(-48); PI:=PHI0:=PHIL:=4*ARCTAN(1);
    INIVEC(M0, M, RL, 0);
NEXTLEVEL:
    STEPSIZE;
    'IF' CHANGE 'THEN' COEFFICIENT;
    K:=K+1;
    DIFFERENCE SCHEME;
    OUTPUT;
    'IF' 'NOT' LAST 'THEN' 'GOTO' NEXTLEVEL;
ENDOFEFRK:
'END' EXPONENTIALLY FITTED RUNGE KUTTA;
        'EOP'
