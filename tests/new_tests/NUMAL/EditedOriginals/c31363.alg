'CODE'31363;
'PROCEDURE' LUPZERORTPOL (N, M, B, C, ZER, EM);
'VALUE' N, M; 'INTEGER' N, M; 'ARRAY' B, C, ZER, EM;
'BEGIN'
'PROCEDURE' RATQR(N,M,POSDEF,DLAM,EPS)TRANS:(D,B2);
  'VALUE' N,M,POSDEF,DLAM,EPS;
  'INTEGER' N,M;
  'BOOLEAN' POSDEF;
  'REAL' DLAM,EPS;
  'ARRAY' D,B2;
'COMMENT' QR ALGORITHM FOR THE COMPUTATION OF THE LOWEST EIGENVALUES
  OF A SYMMETRIC TRIDIAGONAL MATRIX. A RATIONAL VARIANT OF THE
  QR TRANSFORMATION IS USED, CONSISTING OF TWO SUCCESSIVE QD STEPS
  PER ITERATION.
  A SHIFT OF THE SPECTRUM AFTER EACH ITERATION GIVES AN ACCELERATED
  RATE OF CONVERGENCE. A NEWTON CORRECTION,DERIVED FROM THE
  CHARACTERISTIC POLYNOMIAL,IS USED AS SHIFT.
   RATQR IS IMPLEMENTED BY REINSCH AND BAUER, SEE WILKINSON AND REINSCH
   ,1971, CONTR. II-6.
  FORMATS: D,B2[1:N];
'BEGIN'
  'INTEGER' I,J,K,T; 'REAL' DELTA,E,EP,ERR,P,Q,QP,R,S,TOT;
'COMMENT' LOWER BOUND FOR EIGENVALUES FROM GERSHGORIN, INITIAL SHIFT;
  B2[1]:= ERR:= Q:= S:= 0; TOT:= D[1];
  'FOR' I:= N 'STEP' -1   'UNTIL' 1 'DO'
  'BEGIN'
    P:= Q; Q:= SQRT(B2[I]); E:= D[I]-P-Q;
    'IF' E < TOT 'THEN' TOT:= E
  'END' I;
  'IF' POSDEF & TOT < 0 'THEN' TOT:= 0 'ELSE'
  'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' D[I]:= D[I]-TOT;
  T:= 0;
  'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
  'BEGIN'
NEXT QR TRANSFORMATION:  T:= T + 1;
  TOT:= TOT + S; DELTA:= D[N]-S; I:= N;
  E:= ABS(EPS*TOT); 'IF' DLAM < E 'THEN' DLAM:= E;
  'IF' DELTA <= DLAM 'THEN' 'GOTO' CONVERGENCE;
  E:= B2[N]/DELTA; QP:= DELTA+E; P:= 1;
  'FOR' I:= N-1 'STEP' -1 'UNTIL' K 'DO'
  'BEGIN'
    Q:= D[I]-S-E; R:= Q/QP; P:= P*R+1;
    EP:= E*R; D[I+1]:= QP+EP; DELTA:= Q-EP;
    'IF' DELTA <= DLAM 'THEN' 'GOTO' CONVERGENCE;
    E:= B2[I]/Q;QP:= DELTA+E; B2[I+1]:= QP*EP
  'END' I;
  D[K]:= QP; S:= QP/P;
  'IF' TOT+S > TOT 'THEN' 'GOTO' NEXT QR TRANSFORMATION;
'COMMENT' IRREGULAR END OF ITERATION,
  DEFLATE MINIMUM DIAGONAL ELEMENT;
  S:= 0; I:= K; DELTA:= QP;
  'FOR' J:= K+1 'STEP' 1 'UNTIL' N 'DO'
    'IF' D[J] < DELTA 'THEN'
    'BEGIN' I:= J; DELTA:= D[J] 'END';
CONVERGENCE:
  'IF' I < N 'THEN' B2[I+1]:= B2[I]*E/QP;
    'FOR' J:= I-1 'STEP' -1 'UNTIL' K 'DO'
      'BEGIN' D[J+1]:= D[J]-S; B2[J+1]:= B2[J] 'END' J;
    D[K]:= TOT; B2[K]:= ERR:= ERR+ABS(DELTA)
  'END' K;
EM[5]:=T;EM[3]:=INFNRMVEC(1,M,T,B2);
'END' RATQR;
    'PROCEDURE' DUPCEV (L, U, SHIFT, A, B);
    'VALUE'L,U,SHIFT;'INTEGER'L,U,SHIFT;'ARRAY'A,B;
    'FOR' U:=U 'STEP' -1 'UNTIL' L 'DO' A[U]:=B[U+SHIFT];
    'INTEGER' I;'REAL'NRM;
    NRM:=ABS(B[0]);
    'FOR'I:=1'STEP'1'UNTIL'N-2'DO''IF'C[I]+ABS(B[I])>NRM'THEN'
         NRM:=C[I]+ABS(B[I]);
     'IF'N>1'THEN'NRM:='IF'NRM+1>=C[N-1]+ABS(B[N-1])'THEN'NRM+1'ELSE'
                       C[N-1]+ABS(B[N-1]);
     EM[1]:=NRM;
    DUPCEV(1,N,-1,B,B);
    DUPCEV(2,N,-1,C,C);
    RATQR (N, M, EM[6] = 1, EM[2], EM[0], B, C);
    DUPVEC (1, M, 0, ZER, B)
'END' LUPZERORTPOL;
        'EOP'
