'CODE' 35115;
 'REAL' 'PROCEDURE' ARCCOSH(X); 'VALUE' X; 'REAL' X;
 ARCCOSH:= 'IF' X <= 1 'THEN' 0 'ELSE'
           'IF' X > @10 'THEN' 0.69314718055995 + LN(X) 'ELSE'
           LN(X+SQRT((X-1)*(X+1)));
        'EOP'
