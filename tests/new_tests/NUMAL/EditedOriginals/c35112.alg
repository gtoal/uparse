'CODE' 35112;
 'REAL' 'PROCEDURE' COSH(X); 'VALUE' X; 'REAL' X;
 'IF' ABS(X) < 17.5 'THEN'
 'BEGIN' X:= EXP(X); COSH:= 0.5 * ( X + 1/X ) 'END' 'ELSE'
 'BEGIN'
     COSH:= SINH(ABS(X))
 'END' COSH;
        'EOP'
