'CODE' 35087;
    'PROCEDURE' NONEXPENX(X, N1, N2, A);
    'VALUE' X, N1, N2;
    'REAL' X; 'INTEGER' N1, N2; 'ARRAY' A;
    'BEGIN' 'INTEGER' I, N; 'REAL' W, AN;
        N:= 'IF' X<=1.5 'THEN' 1 'ELSE' ENTIER(X+.5);
        'IF' N<=10 'THEN'
        'BEGIN'
            'ARRAY' B[N:N];
            ENX(X, N, N, B);
            W:= B[N] * EXP(X)
        'END' 'ELSE'
        'BEGIN'
            'INTEGER' K, K1;
            'REAL' UE, VE, WE, WE1, UO, VO, WO, WO1, R, S;
            UE:=1; VE:= WE:= 1/(X+N); WE1:=0;
            UO:=1; VO:= -N/(X * (X + N + 1)); WO1:= 1/X; WO:= VO + WO1;
            W:= (WE + WO)/2;
            K1:=1;
            'FOR' K:=K1 'WHILE' WO-WE>@-15 * W & WE>WE1 & WO<WO1 'DO'
            'BEGIN'
                WE1:= WE; WO1:=WO;
                R:= N+K; S:= R + X + K;
                UE:= 1/(1-K*(R-1)*UE/((S-2)*S));
                UO:= 1/(1-K*  R  *UO/( S * S-1));
                VE:= VE * (UE-1);
                VO:= VO * (UO-1);
                WE:= WE + VE;
                WO:= WO + VO;
                W:= (WE + WO)/2;
                K1:= K1 + 1
            'END'
        'END';
        AN:=W;
        'IF' N<=N2 & N>=N1 'THEN' A[N]:=W;
        'FOR' I:= N-1 'STEP' -1 'UNTIL' N1 'DO'
        'BEGIN'
            W:= (1 - I * W)/X;
            'IF' I<= N2 'THEN' A[I]:=W
        'END';
        W:=AN;
        'FOR' I:= N+1 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN'
            W:= (1 - X * W)/(I - 1);
            'IF' I>=N1 'THEN' A[I]:=W
        'END'
    'END' EXPENX;
        'EOP'
