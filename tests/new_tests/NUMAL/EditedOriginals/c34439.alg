'CODE' 34439;
    'PROCEDURE' JACOBNBNDF(N, LW, RW, X, F, JAC, I, DI, FUNCT);
    'VALUE' N, LW, RW; 'INTEGER' I, N, LW, RW; 'REAL' DI;
    'ARRAY' X, F, JAC; 'PROCEDURE' FUNCT;
    'BEGIN' 'INTEGER' J, K, L, U, T, B; 'REAL' AID, STEPI;
        L:= 1; U:= LW + 1; T:= RW + 1; B:= LW + RW;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' 'ARRAY' F1[L:U];
            STEPI:= DI; AID:= X[I]; X[I]:= AID + STEPI;
            FUNCT(N, L, U, X, F1); X[I]:= AID;
            K:= I + ('IF' I <= T 'THEN' 0 'ELSE' I - T) * B;
            'FOR' J:= L 'STEP' 1 'UNTIL' U 'DO'
            'BEGIN' JAC[K]:= (F1[J] - F[J]) / STEPI; K:=K + B 'END';
            'IF' I >= T 'THEN' L:= L + 1;
            'IF' U < N 'THEN' U:= U + 1
        'END'
    'END' JACOBNBNDF;
        'EOP'
