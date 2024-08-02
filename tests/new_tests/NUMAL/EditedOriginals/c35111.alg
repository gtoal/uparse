'CODE' 35111;
 'REAL' 'PROCEDURE' SINH(X); 'VALUE' X; 'REAL' X;
 'BEGIN' 'REAL' AX,Y;
    AX:= ABS(X);
    'IF' AX < 0.3 'THEN'
    'BEGIN' Y:= 'IF' AX < 0.1 'THEN' X*X 'ELSE' X*X/9;
        X:=  ((( 0.0001984540     * Y +
                 0.0083333331783 )* Y +
                 0.16666666666675)* Y +
                 1.0             )* X ;
       SINH:= 'IF' AX < 0.1 'THEN' X 'ELSE'
              X * ( 1.0 + 0.14814814814815 * X * X )
    'END' 'ELSE' 'IF' AX < 17.5 'THEN'
    'BEGIN' AX:= EXP( AX ); SINH:= SIGN(X) * .5 * ( AX -1/AX ) 'END'
    'ELSE' 'IF' AX > 742.36063037970 'THEN'
    'BEGIN'
        SINH:= SIGN(X)*GIANT
    'END' 'ELSE'
    SINH:= SIGN(X)*EXP(AX- .69314 71805 59945)
 'END' SINH;
        'EOP'
