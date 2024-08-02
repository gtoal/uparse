'CODE' 35154;
  'PROCEDURE' NONEXP SPHER BESS I(X, N, I); 'VALUE' X, N;
  'REAL' X; 'INTEGER' N; 'ARRAY' I;
  'IF' X= 0 'THEN'
  'BEGIN' I[0]:=1;
    'FOR' N:= N 'STEP' -1 'UNTIL' 1 'DO' I[N]:= 0
  'END' 'ELSE'
  'BEGIN' 'REAL' X2, R, S; 'INTEGER' M;
    X2:= X+X;
    I[0]:= X2:= 'IF' X = 0 'THEN' 1 'ELSE' 'IF' X2 < 0.7 'THEN'
        SINH(X) / (X * EXP(X)) 'ELSE' (1-EXP(-X2))/X2;
    'IF' N= 0 'THEN' 'GOTO' EXIT;
    R:= 0; M:= START(X,N,1);
    'FOR' M:= M 'STEP' -1 'UNTIL' 1 'DO'
    'BEGIN' R:= 1/((M+M+1)/X+R);
      'IF' M  <=  N 'THEN' I[M]:= R
    'END';
    'FOR' M:= 1 'STEP' 1 'UNTIL' N 'DO'
    I[M]:= X2:= X2 * I[M];       EXIT:
  'END';
        'EOP'
