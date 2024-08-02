'CODE' 35122;
'REAL' 'PROCEDURE' ARCCOS(X); 'VALUE' X; 'REAL' X;
'BEGIN' 'REAL' U,V; U:= ABS(X); V:= (1-U)/(1+U);
    V:= 'IF' V  =0 'THEN' 0 'ELSE'
        'IF' U+1=1 'THEN' 1.57079632679489 'ELSE'
                          2*ARCTAN(SQRT(V));
    ARCCOS:= 'IF' X>0 'THEN' V 'ELSE' 3.14159265358979 - V
'END' ARCCOS;
        'EOP'
