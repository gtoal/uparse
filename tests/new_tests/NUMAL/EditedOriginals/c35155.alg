'CODE' 35155;
  'PROCEDURE' NONEXP SPHER BESS K(X, N, K); 'VALUE' X, N;
  'REAL' X; 'INTEGER' N; 'ARRAY' K;
  'BEGIN' 'INTEGER' I; 'REAL' KI, KI1, KI2;
    X:= 1/X; K[0]:= KI2:= X*1.5707963267949;
    'IF' N=0 'THEN' 'GOTO' EXIT;
    K[1]:= KI1:= KI2 * (1+X);
    'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' K[I]:= KI:= KI2 + (I+I-1) * X * KI1;
      KI2:= KI1; KI1:= KI 'END';
    EXIT:
  'END';
        'EOP'
