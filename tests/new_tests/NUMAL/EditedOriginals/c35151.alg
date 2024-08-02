'CODE' 35151;
  'COMMENT' SPHERICAL BESSEL FUNCTIONS Y[.5](X),   , Y[N+.5](X);
  'PROCEDURE' SPHER BESS Y(X, N, Y); 'VALUE' X, N;
  'INTEGER' N; 'REAL' X; 'ARRAY' Y;
  'IF' N=0 'THEN'  Y[0]:= - COS(X)/X 'ELSE'
  'BEGIN' 'REAL' YI, YI1, YI2; 'INTEGER' I;
    YI2:= Y[0]:= -COS(X)/X; YI1:= Y[1]:= (YI2 - SIN(X))/X;
    'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' Y[I]:= YI:= -YI2 + (I+I-1) * YI1/X;
      YI2:= YI1; YI1:= YI
    'END'
  'END'

        ;'EOP'
