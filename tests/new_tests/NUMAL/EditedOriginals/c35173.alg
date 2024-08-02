'CODE' 35173;
    'PROCEDURE' BESS K01(X, K0, K1); 'VALUE' X; 'REAL' X, K0, K1;
    'IF' X <= 1.5 'THEN'
    'BEGIN' 'INTEGER' K; 'REAL' C, D, R, S, SUM0, SUM1, T,
        TERM, T0, T1;
        SUM0:= D:= LN(2/X) -.5772156649015328606;
        SUM1:=    C:= -1 -2    * D; R:= TERM:= 1; T:= X * X/4;
        'FOR' K:= 1,K+1 'WHILE' ABS(T0/SUM0) + ABS(T1/SUM1) >
        @-15 'DO'
        'BEGIN'  TERM:= T * TERM * R * R; D:= D + R;
            C:= C - R; R:= 1/(K+1); C:= C - R;
            T0:= TERM * D; T1:= TERM * C * R;
            SUM0:= SUM0 + T0; SUM1:= SUM1 + T1
        'END';
        K0:= SUM0; K1:= (1 + T * SUM1) / X
    'END' 'ELSE'
    'BEGIN' 'REAL' EXPX;
        EXPX:= EXP(- X);
        NONEXP BESS K01(X, K0, K1); K1:= EXPX * K1; K0:= K0 * EXPX
    'END' BESS K01;
        'EOP'
