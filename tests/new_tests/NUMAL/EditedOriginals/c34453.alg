'CODE' 34453;
    'BOOLEAN' 'PROCEDURE' ZEROINDER(X, Y, FX, DFX, TOLX);
    'REAL' X, Y, FX, DFX, TOLX;
    'BEGIN' 'INTEGER' EXT;
        'REAL' B, FB, DFB, A, FA, DFA, C, FC, DFC, D, W, MB,
        TOL, M, P, Q, DW;
        DW:= DWARF;
        B:= X; FB:= FX; DFB:= DFX; A:= X:= Y; FA:= FX; DFA:= DFX;
    INTERPOLATE: C:= A; FC:= FA; DFC:= DFA; EXT:= 0;
    EXTRAPOLATE: 'IF' ABS(FC) < ABS(FB) 'THEN'
        'BEGIN' A:= B; FA:= FB; DFA:= DFB; B:= X:= C; FB:= FC;
            DFB:= DFC; C:= A; FC:= FA; DFC:= DFA
        'END' INTERCHANGE;
        TOL:= TOLX; M:= (C + B) * 0.5; MB:= M - B;
        'IF' ABS(MB) > TOL 'THEN'
        'BEGIN' 'IF' EXT > 2 'THEN' W:= MB 'ELSE'
            'BEGIN' TOL:= TOL * SIGN(MB);
                D:= 'IF' EXT = 2 'THEN' DFA 'ELSE' (FB - FA) / (B - A);
                P:= FB * D * (B - A);
                Q:= FA * DFB - FB * D;
                'IF' P < 0 'THEN' 'BEGIN' P:= -P; Q:= -Q 'END';
                W:= 'IF' P < DW 'OR' P <= Q * TOL 'THEN' TOL 'ELSE'
                    'IF' P < MB * Q 'THEN' P / Q 'ELSE' MB;
            'END'; A:= B; FA:= FB; DFA:= DFB;
            X:= B:= B + W; FB:= FX; DFB:= DFX;
            'IF' ('IF' FC >= 0 'THEN' FB >= 0 'ELSE' FB <= 0) 'THEN'
            'GOTO' INTERPOLATE 'ELSE'
            'BEGIN' EXT:= 'IF' W = MB 'THEN' 0 'ELSE' EXT + 1;
                'GOTO' EXTRAPOLATE
            'END'
        'END'; Y:= C;
        ZEROINDER:= 'IF' FC >= 0 'THEN' FB <= 0 'ELSE' FB >= 0
    'END' ZEROINDER;
        'EOP'
