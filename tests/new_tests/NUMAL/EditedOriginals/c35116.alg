'CODE' 35116;
 'REAL' 'PROCEDURE' ARCTANH(X); 'VALUE' X; 'REAL' X;
 'IF' ABS(X) >= 1 'THEN'
 'BEGIN'
     ARCTANH:= SIGN(X)*GIANT
 'END' 'ELSE'
 'BEGIN' 'REAL' AX;
     AX:= ABS(X); ARCTANH:= SIGN(X)*.5*LOG ONE PLUS X(2*AX/(1-AX))
 'END' ARCTANH;
        'EOP'
