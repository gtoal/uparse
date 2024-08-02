'CODE' 35113;
 'REAL' 'PROCEDURE' TANH(X); 'VALUE' X; 'REAL' X;
 'BEGIN' 'REAL'AX; AX:= ABS(X);
  'IF' AX < 0.005 'THEN'
  'BEGIN' 'REAL' Y; Y:= X*X; TANH:= X * ( 1 - Y *
     (.33333333333333 - Y *
     (.13333333333333 - Y *
      .05396825396825   )))
  'END' 'ELSE' 'IF' AX < 0.3 'THEN'
  'BEGIN' 'REAL' SH;
     SH:= SINH(X);
     TANH:= SH/SQRT(1+SH*SH)
  'END' 'ELSE'
  'IF' AX > 17.5 'THEN' TANH:= SIGN(X) 'ELSE'
  'BEGIN' AX:= EXP(-2*AX); TANH:= SIGN(X)*(1-AX)/(1+AX) 'END'
 'END'

        ;'EOP'
