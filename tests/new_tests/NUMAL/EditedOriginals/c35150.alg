'CODE' 35150;
  'COMMENT' SPHERICAL BESSEL FUNCTIONS J[.5](X),  , J[N+.5](X);
  'PROCEDURE' SPHER BESS J(X, N, J); 'VALUE' X, N;
  'REAL' X; 'INTEGER' N; 'ARRAY' J;
  'IF' X = 0 'THEN'
  'BEGIN' J[0]:= 1;
    'FOR' N:= N 'STEP' -1 'UNTIL' 1 'DO' J[N]:=0
  'END' 'ELSE' 'IF' N = 0 'THEN'
  'BEGIN' 'REAL' X2;
    'IF' ABS(X) < .015 'THEN'
    'BEGIN' X2:= X * X / 6; J[0]:= 1 + X2 * (X2 * .3 - 1) 'END' 'ELSE'
    J[0]:= SIN(X)/X
  'END' 'ELSE'
  'BEGIN' 'INTEGER' M; 'REAL' R, S;
    R:= 0; M:= START(X,N,0);
    'FOR' M:= M 'STEP' - 1 'UNTIL' 1 'DO'
    'BEGIN' R:= 1 / ((M + M + 1) / X - R); 'IF' M <= N 'THEN' J[M]:= R
    'END'; 'IF' X < .015  'THEN'
    'BEGIN' S:= X * X / 6;
      J[0]:= R:= S * (S * .3 - 1) + 1 'END' 'ELSE'
    J[0]:= R:= SIN(X) / X;
    'FOR' M:= 1 'STEP' 1 'UNTIL' N 'DO' J[M]:= R:= J[M] * R;
  'END' SPHER BESS J;
        'EOP'
