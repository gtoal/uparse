'CODE' 35162;
    'PROCEDURE' BESS J(X, N, J); 'VALUE' X, N;
    'REAL'X; 'INTEGER' N; 'ARRAY' J;
    'IF' X=0 'THEN'
    'BEGIN' J[0]:= 1;
        'FOR' N:= N 'STEP' -1 'UNTIL' 1 'DO' J[N]:= 0
    'END'

    'ELSE'
    'BEGIN''REAL' X2, R, S; 'INTEGER' L, M, NU, SIGNX;
        SIGNX:= SIGN(X); X:= ABS(X);
        R:= S:= 0; X2:= 2/X; L:= 0; NU:= START(X,N,0);
        'FOR' M:= NU    'STEP' -1 'UNTIL' 1 'DO'
        'BEGIN' R:= 1/(X2*M-R);
            L:= 2-L; S:= R*(L+S);
            'IF' M<=N 'THEN' J[M]:= R
        'END';
        J[0]:= R:= 1/(1+S);
        'FOR' M:= 1 'STEP' 1 'UNTIL' N 'DO'
        J[M]:= R:= R*J[M];
        'IF' SIGNX < 0 'THEN'
        'FOR' M:= 1 'STEP' 2 'UNTIL' N 'DO'
        J[M]:= -J[M];
    'END' BESSELJ;
        'EOP'
