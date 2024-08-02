'CODE' 32051;
    'REAL' 'PROCEDURE' INTEGRAL(X, A, B, FX, E, UA, UB);
    'VALUE' A,B;'REAL' X, A, B, FX; 'ARRAY' E; 'BOOLEAN' UA, UB;
    'BEGIN'
        'REAL' 'PROCEDURE' TRANSF;
        'BEGIN' Z:= 1 / X; X:= Z + B1; TRANSF:= FX * Z * Z 'END';
        'REAL' 'PROCEDURE' QAD(FX); 'REAL' FX;
        'BEGIN' 'REAL' T, V, SUM, HMIN;
            'PROCEDURE' INT;
            'BEGIN' 'REAL' X3, X4, F3, F4, H;
                X4:= X2; X2:= X1; F4:= F2; F2:= F1;
            ANEW: X:= X1:= (X0 + X2) * .5; F1:= FX;
                X:= X3:= (X2 + X4) * .5; F3:= FX; H:= X4 - X0;
                V:= (4 * (F1 + F3) +2  * F2 + F0 + F4) * 15;
                T:= 6 * F2 -4  * (F1 + F3) + F0 + F4;
                'IF' ABS(T) < ABS(V) * RE + AE 'THEN'
                SUM:=SUM + (V - T) * H 'ELSE'
                'IF' ABS(H) < HMIN 'THEN' E[3]:= E[3] +1
                'ELSE'
                'BEGIN' INT; X2:= X3; F2:= F3; 'GOTO' ANEW 'END';
                X0:= X4; F0:= F4
            'END' INT;

            HMIN:= ABS(X0 - X2) * RE; X:= X1:= (X0 + X2) * .5;
            F1:=FX;SUM:= 0; INT; QAD:= SUM / 180
        'END' QAD;
        'REAL' X0, X1, X2, F0, F1, F2, RE, AE, B1, Z;
        RE:= E[1]; 'IF' UB 'THEN' AE:= E[2] * 180 / ABS(B - A)
        'ELSE' AE:= E[2] * 90 / ABS(B - A); 'IF' UA 'THEN'
        'BEGIN' E[3]:= E[4]:= 0; X:= X0:= A; F0:= FX 'END'
        'ELSE'
        'BEGIN' X:= X0:= A:= E[5]; F0:= E[6] 'END';
        E[5]:= X:= X2:= B; E[6]:= F2:= FX; E[4]:= E[4] + QAD(FX);
        'IF' 'NOT' UB 'THEN'
        'BEGIN' 'IF' A < B 'THEN'
            'BEGIN' B1:= B -1 ; X0:= 1 'END'
            'ELSE'
            'BEGIN' B1:= B +1 ; X0:= -1  'END';
            F0:= E[6]; E[5]:= X2:= 0; E[6]:= F2:= 0;
            AE:= E[2] * 90;
            E[4]:= E[4] - QAD(TRANSF)
        'END';
        INTEGRAL:= E[4]
    'END' INTEGRAL;
          'EOP'
