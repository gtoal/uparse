'CODE' 35152;
  'COMMENT' SPHERICAL BESSEL FUNCTIONS I[.5](X),   , I[N+.5](X);
  'PROCEDURE' SPHER BESS I(X, N, I); 'VALUE' X, N;
  'REAL' X; 'INTEGER' N; 'ARRAY' I;
  'IF' X= 0 'THEN'
  'BEGIN' I[0]:=1;
    'FOR' N:= N 'STEP' -1 'UNTIL'  1 'DO' I[N]:= 0
  'END' 'ELSE'
  'BEGIN' 'REAL' EXPX;
    EXPX:= EXP(X);
    NONEXP SPHER BESS I(X, N, I);
    'FOR' N:= N 'STEP' - 1 'UNTIL' 0 'DO' I [N]:= I [N] * EXPX
  'END' SPHER BESS I;
        'EOP'
