'CODE' 35164;
    'PROCEDURE' BESS Y(X, N, Y); 'VALUE' X, N;
    'REAL' X; 'INTEGER' N; 'ARRAY' Y;
    'BEGIN' 'INTEGER' I; 'REAL' Y0, Y1, Y2;
      BESS Y01(X, Y0, Y1); Y[0]:= Y0;
      'IF' N > 0 'THEN' Y[1]:= Y1 ;
      X:= 2/X;
      'FOR' I:=2 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[I]:= Y2:= (I-1)*X*Y1 - Y0;
        Y0:= Y1; Y1:= Y2
      'END'
    'END' BESS Y

        ;'EOP'
