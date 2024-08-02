'CODE' 35191;
  'PROCEDURE'  BESS KA01(A, X, KA, KA1); 'VALUE' A, X;
  'REAL' A, X, KA, KA1;
  'IF' A = 0 'THEN'
  'BEGIN'
    BESS K01(X,KA,KA1)
  'END' 'ELSE'
  'BEGIN' 'REAL' F, G, H, PI; 'INTEGER' N, NA; 'BOOLEAN' REC, REV;
    PI:= 4 * ARCTAN(1);
    REV:= A < -.5; 'IF' REV 'THEN' A:= -A-1;
    REC:= A >=  .5; 'IF' REC 'THEN'
    'BEGIN' NA:=ENTIER(A+.5); A:= A - NA 'END';
    'IF' A = .5 'THEN' F:= G:= SQRT(PI / X / 2) * EXP (-X) 'ELSE'
    'IF' X < 1 'THEN'
    'BEGIN'
    'REAL' A1, B, C, D, E, P, Q, S;
      B:=X/2;D:=-LN(B);E:=A*D;C:=A*PI;
      C:='IF' ABS(C)<@-15 'THEN' 1 'ELSE' C/SIN(C);
      S:='IF' ABS(E)<@-15 'THEN' 1 'ELSE' SINH(E)/E;
      E:=EXP(E);A1:=(E+1/E)/2;G:=RECIP GAMMA(A,P,Q)*E;
      KA:=F:=C*(P*A1+Q*S*D);E:=A*A;
      P:=.5*G*C;Q:=.5/G;C:=1;D:=B*B;KA1:=P;
      'FOR' N:=1,N+1 'WHILE' H/KA+ABS(G)/KA1>@-15 'DO'
      'BEGIN' F:=(F*N+P+Q)/(N*N-E);C:=C*D/N;
        P:=P/(N-A);Q:=Q/(N+A);G:=C*(P-N*F);
        H:=C*F;KA:=KA+H;KA1:=KA1+G
      'END';
      F:=KA;G:=KA1/B
    'END' 'ELSE'
    'BEGIN' 'REAL' EXPON;
      EXPON:= EXP(-X); NONEXP BESS KA01(A, X, KA, KA1);
      F:= EXPON * KA; G:= EXPON * KA1
    'END';
    'IF' REC 'THEN'
    'BEGIN' X:= 2 / X;
      'FOR' N:= 1 'STEP' 1 'UNTIL' NA 'DO'
      'BEGIN' H:= F + (A + N) * X * G; F:= G; G:= H 'END'
    'END';
    'IF' REV 'THEN' 'BEGIN' KA1:= F; KA:= G 'END' 'ELSE'
    'BEGIN' KA:= F; KA1:= G 'END'
  'END' BESS KA01;
        'EOP'
