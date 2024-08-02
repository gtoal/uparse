'CODE' 35190;
  'COMMENT' COMPUTATION OF I[A](X),   , I[N+A](X);
  'PROCEDURE' BESS IAPLUSN(A, X, N, IA); 'VALUE' A, X, N;
  'INTEGER' N; 'REAL' X, A; 'ARRAY' IA;
  'IF' X= 0 'THEN'
  'BEGIN' IA[0]:= 'IF' A= 0 'THEN' 1 'ELSE' 0;
    'FOR' N:= N 'STEP' -1 'UNTIL' 1 'DO' IA[N]:= 0
  'END' 'ELSE' 'IF' A= 0 'THEN'
  'BEGIN'
    BESS I(X, N, IA);
  'END' 'ELSE' 'IF' A= .5 'THEN'
  'BEGIN' 'REAL' C;
    C:= .797 884 560 802 865 * SQRT(ABS(X)) * EXP (ABS (X));
    NONEXP SPHER BESSI(X, N, IA);
    'FOR' N:= N 'STEP' -1 'UNTIL' 0 'DO' IA[N]:= C*IA[N]
  'END' 'ELSE'
  'BEGIN' 'REAL' EXPX;
    EXPX:= EXP(ABS(X));
    NONEXP BESS IAPLUSN(A, X, N, IA);
    'FOR' N:= N 'STEP' -1 'UNTIL' 0 'DO' IA[N]:= EXPX * IA[N]
  'END' BESS IAPLUSN;
        'EOP'
