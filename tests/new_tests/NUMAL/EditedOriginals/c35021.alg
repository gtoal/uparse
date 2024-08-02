'CODE' 35021;
    'PROCEDURE' ERRORFUNCTION(X, ERF, ERFC);
    'VALUE' X; 'REAL' X, ERF, ERFC;
    'IF' X > 26   'THEN' 'BEGIN' ERF:=  1; ERFC:= 0 'END' 'ELSE'
    'IF' X < -5.5 'THEN' 'BEGIN' ERF:= -1; ERFC:= 2 'END' 'ELSE'
    'BEGIN' 'REAL' ABSX, C, P, Q;

        ABSX:= ABS(X);
        'IF' ABSX <= 0.5 'THEN'
        'BEGIN' C:= X * X;         P:= ((-0.35609 84370 18154@-1  * C +
            0.69963 83488 61914@+1) * C + 0.21979 26161 82942@+2) * C +
            0.24266 79552 30532@+3;
            Q:= ((C +
            0.15082 79763 04078@+2) * C + 0.91164 90540 45149@+2) * C +
            0.21505 88758 69861@+3;
            ERF:=  X * P / Q; ERFC:= 1 - ERF
        'END' 'ELSE'
        'BEGIN' ERFC:= EXP(-X * X) * NONEXPERFC(ABSX);
            ERF:= 1 - ERFC;
            'IF' X < 0 'THEN'
            'BEGIN' ERF:= -ERF; ERFC:= 2 - ERFC 'END'
        'END'
    'END' ERRORFUNCTION;
        'EOP'
