'CODE' 34150;
'BOOLEAN' 'PROCEDURE' ZEROIN(X, Y, FX, TOLX);
'REAL' X, Y, FX, TOLX;
'BEGIN' 'INTEGER' EXT;
        'REAL' C, FC, B, FB, A, FA, D, FD, FDB, FDA, W, MB,
        TOL, M, P, Q, DW;
        DW:= DWARF; B:= X; FB:= FX; A:= X:= Y; FA:= FX;
    INTERPOLATE: C:= A; FC:= FA; EXT:= 0;
    EXTRAPOLATE: 'IF' ABS(FC) < ABS(FB) 'THEN'
        'BEGIN' 'IF' C ^= A 'THEN' 'BEGIN' D:= A; FD:= FA 'END';
            A:= B; FA:= FB; B:= X:= C; FB:= FC; C:= A; FC:= FA
        'END' INTERCHANGE;
        TOL:= TOLX; M:= (C + B) * 0.5; MB:= M - B;
        'IF' ABS(MB) > TOL 'THEN'
        'BEGIN' 'IF' EXT > 2 'THEN' W:= MB 'ELSE'
            'BEGIN' TOL:= TOL * SIGN(MB);
                P:= (B - A) * FB; 'IF' EXT <= 1 'THEN'
                Q:= FA - FB 'ELSE'
                'BEGIN' FDB:= (FD - FB) / (D - B);
                    FDA:= (FD - FA) / (D - A);
                    P:= FDA * P; Q:= FDB * FA - FDA * FB
                'END'; 'IF' P < 0 'THEN'
                'BEGIN' P:= -P; Q:= -Q 'END';
                W:= 'IF' P < DW 'OR' P <= Q * TOL 'THEN' TOL 'ELSE'
                'IF' P < MB * Q 'THEN' P / Q 'ELSE' MB
            'END'; D:= A; FD:= FA; A:= B; FA:= FB;
            X:= B:= B + W; FB:= FX;
            'IF' ('IF' FC >= 0 'THEN' FB >= 0 'ELSE' FB <= 0) 'THEN'
            'GOTO' INTERPOLATE 'ELSE'
            'BEGIN' EXT:= 'IF' W = MB 'THEN' 0 'ELSE' EXT + 1;
                'GOTO' EXTRAPOLATE
            'END'
        'END'; Y:= C;
        ZEROIN:= 'IF' FC >= 0 'THEN' FB <= 0 'ELSE' FB >= 0
'END' ZEROIN

        ;'EOP'
