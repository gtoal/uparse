'CODE' 35194;
  'PROCEDURE' NONEXP BESS KA01(A, X, KA, KA1); 'VALUE' A, X;
  'REAL' A, X, KA, KA1;
  'IF' A = 0 'THEN'
  'BEGIN'
    NONEXP BESS K01(X,KA,KA1)
  'END' 'ELSE'
  'BEGIN' 'REAL' F, G, H, PI; 'INTEGER' N, NA; 'BOOLEAN' REC, REV;
    PI:= 4 * ARCTAN(1);
    REV:= A < -.5; 'IF' REV 'THEN' A:= -A-1;
    REC:= A >=  .5; 'IF' REC 'THEN'
    'BEGIN' NA:=ENTIER(A+.5); A:= A - NA 'END';
    'IF' A = -.5 'THEN' F:= G:= SQRT(PI / X / 2) 'ELSE'
    'IF' X < 1 'THEN'
    'BEGIN'
      'REAL' EXPON;
      EXPON:= EXP(X); BESS KA01(A, X, KA, KA1);
      F:= EXPON * KA; G:= EXPON * KA1
    'END' 'ELSE'
    'BEGIN' 'REAL' B, C, E, P, Q;
      C:=.25-A*A;B:=X+X;G:=1;F:=0;E:=COS(A*PI)/PI*X*@15;
      'FOR' N:=1,N+1 'WHILE' H*N<E 'DO'
      'BEGIN' H:=(2*(N+X)*G-(N-1+C/N)*F)/(N+1);F:=G;
          G:=H
      'END';
      P:= Q:= F / G; E:= B - 2;
      'FOR' N:=N,N-1 'WHILE' N>0 'DO'
      'BEGIN' P:=(N-1+C/N)/(E+(N+1)*(2-P));Q:=P*(1+Q) 'END';
      F:=SQRT(PI/B)/(1+Q);G:=F*(A+X+.5-P)/X
    'END';
    'IF' REC 'THEN'
    'BEGIN' X:= 2 / X;
      'FOR' N:= 1 'STEP' 1 'UNTIL' NA 'DO'
      'BEGIN' H:= F + (A + N) * X * G; F:= G; G:= H 'END'
    'END';
    'IF' REV 'THEN' 'BEGIN' KA1:= F; KA:= G 'END' 'ELSE'
    'BEGIN' KA:= F; KA1:= G 'END'
  'END' NONEXP BESS KA01;
        'EOP'
