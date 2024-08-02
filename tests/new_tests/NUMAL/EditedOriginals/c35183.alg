'CODE' 35183;
  'PROCEDURE' BESS PQA01(A,X,PA,QA,PA1,QA1);'VALUE' A,X;
  'REAL' A,X,PA,PA1,QA,QA1;
  'IF' A = 0 'THEN'
  'BEGIN'
    BESS PQ0(X,PA,QA); BESS PQ1(X,PA1,QA1)
  'END' 'ELSE'
  'BEGIN' 'INTEGER' N,NA;  'REAL' B, PI, P0, Q0 ; 'BOOLEAN' REC, REV;
    PI:= 4 * ARCTAN(1);
    REV:=A<-.5;'IF' REV 'THEN' A:=-A-1;
    REC:=A>=.5;'IF' REC 'THEN'
    'BEGIN' NA:=ENTIER(A+.5);A:=A-NA 'END';
    'IF' A=-.5 'THEN'
    'BEGIN' PA:=PA1:=1;QA:=QA1:=0 'END'

    'ELSE' 'IF' X >= 3 'THEN'
    'BEGIN' 'REAL' C,D,E,F,G,H,P,Q,R,S;
      C:=.25 - A*A; B:= X + X; F:= R:= 1; G:= -X; S:= 0;
      E:=(X*COS(A*PI)/PI*@15)**2;
      'FOR' N:=2,N+1 'WHILE' (P*P + Q*Q)*N*N<E 'DO'
      'BEGIN' D:=(N-1+C/N);
        P:= (2 * N * F + B * G - D * R) / (N + 1);
        Q:= (2 * N * G - B * F - D * S) / (N + 1);
        R:= F; F:= P; S:= G; G:= Q
      'END';
      E:= F * F + G * G;
      P:= (R * F + S * G) / E;
      Q:= (S * F - R * G) / E;
      F:= P; G:= Q;
      'FOR' N:=N-1 'WHILE' N>0 'DO'
      'BEGIN' R:=(N+1)*(2-P)-2;S:=B+(N+1)*Q;D:=(N-1+C/N)/
        (R*R+S*S);P:=D*R;Q:=D*S;E:=F;
        F:=P*(E+1)-G*Q;G:=Q*(E+1)+P*G
      'END';
      F:=1+F; D:=F*F + G*G;
      PA:=F/D;QA:=-G/D;D:=A+.5-P;Q:=Q+X;
      PA1:=(PA*Q-QA*D)/X; QA1:=(QA*Q+PA*D)/X
    'END' 'ELSE'
    'BEGIN' 'REAL' C, S, CHI, YA, YA1; 'ARRAY' JA[0:1];
      B:= SQRT(PI * X / 2);
      CHI:= X - PI * (A / 2 + .25); C:= COS(CHI); S:= SIN(CHI);
      BESS YA01(A, X, YA, YA1); BESS JAPLUSN(A, X, 1, JA);
      PA:= B * (YA * S + C * JA[0]); QA:= B * (C * YA - S * JA[0]);
      PA1:= B * (S * JA[1] - C * YA1);
      QA1:= B * (JA[1] * C + YA1 * S)
    'END';
    'IF' REC 'THEN'
    'BEGIN'  X:=2/X;B:=(A+1)*X;
      'FOR' N:=1 'STEP' 1 'UNTIL' NA 'DO'
      'BEGIN' P0:=PA-QA1*B; Q0:=QA+PA1*B;
        PA:=PA1;PA1:=P0; QA:=QA1; QA1:=Q0; B:=B+X
      'END'
    'END';
    'IF' REV 'THEN'
    'BEGIN' P0:=PA1;PA1:=PA;PA:=P0;Q0:=QA1;QA1:=QA;QA:=Q0 'END'
  'END' BESS PQA01;

        'EOP'
