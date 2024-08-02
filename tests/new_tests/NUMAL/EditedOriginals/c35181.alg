'CODE' 35181;
  'PROCEDURE' BESS YA01(A,X,YA,YA1);'VALUE' A,X; 'REAL' A,X,YA,YA1;
  'IF' A = 0 'THEN'
  'BEGIN'
    BESS Y01(X,YA,YA1)
  'END' 'ELSE'
  'BEGIN' 'REAL' B,C,D,E,F,G,H,P,PI,Q,R,S;'INTEGER' N,NA;
    'BOOLEAN' REC,REV;
    PI:=4*ARCTAN(1);NA:=ENTIER(A+.5);REC:=A>=.5;
    REV:=A<-.5;'IF' REV 'OR' REC 'THEN' A:=A-NA;
    'IF' A=-.5 'THEN'
    'BEGIN' P:=SQRT(2/PI/X);F:=P*SIN(X);G:=-P*COS(X) 'END' 'ELSE'
    'IF' X<3 'THEN'
    'BEGIN'
      B:=X/2;D:=-LN(B);E:=A*D;
      C:='IF' ABS(A)<@-8  'THEN' 1/PI 'ELSE' A/SIN(A*PI);
      S:='IF' ABS(E)<@-8  'THEN' 1 'ELSE' SINH(E)/E;
      E:=EXP(E);G:=RECIP GAMMA(A,P,Q)*E;E:=(E+1/E)/2;
      F:=2*C*(P*E+Q*S*D);E:=A*A;
      P:=G*C;Q:=1/G/PI;C:=A*PI/2;
      R:='IF' ABS(C)<@-8  'THEN' 1 'ELSE' SIN(C)/C;R:=PI*C*R*R;
      C:=1;D:=-B*B;YA:=F+R*Q;YA1:=P;
      'FOR' N:=1,N+1 'WHILE'
      ABS(G/(1+ABS(YA)))+ABS(H/(1+ABS(YA1)))>@-15 'DO'
      'BEGIN' F:=(F*N+P+Q)/(N*N-E);C:=C*D/N;
        P:=P/(N-A);Q:=Q/(N+A);
        G:=C*(F+R*Q);H:=C*P-N*G;
        YA:=YA+G;YA1:=YA1+H;
      'END';
      F:=-YA;G:=-YA1/B
    'END'

    'ELSE'
    'BEGIN'
      B:=X-PI*(A+.5)/2;C:=COS(B);S:=SIN(B);
      D:=SQRT(2/X/PI);
      BESS PQA01(A,X,P,Q,B,H);
      F:=D*(P*S+Q*C);G:=D*(H*S-B*C)
    'END';
    'IF' REV 'THEN'
    'BEGIN' X:=2/X;NA:=-NA-1;
      'FOR' N:=0 'STEP' 1 'UNTIL' NA 'DO'
      'BEGIN' H:=X*(A-N)*F-G;G:=F;F:=H 'END'
    'END' 'ELSE' 'IF' REC 'THEN'
    'BEGIN' X:=2/X;
      'FOR' N:=1 'STEP' 1 'UNTIL' NA 'DO'
      'BEGIN' H:=X*(A+N)*G-F;F:=G;G:=H 'END'
    'END';
    YA:=F;YA1:=G
  'END' BESS YA01;
        'EOP'
