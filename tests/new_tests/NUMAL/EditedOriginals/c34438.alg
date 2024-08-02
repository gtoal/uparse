'CODE' 34438;
'PROCEDURE' JACOBNMF(N, M, X, F, JAC, I, DI, FUNCT); 'VALUE' N, M;
'INTEGER' N, M, I; 'REAL' DI; 'ARRAY' X, F, JAC; 'PROCEDURE' FUNCT;
'BEGIN' 'INTEGER' J; 'REAL' STEP, AID; 'ARRAY' F1[1:N];
    'FOR' I:= 1 'STEP' 1 'UNTIL' M 'DO'
    'BEGIN' STEP:= DI; AID:= X[I]; X[I]:= AID + STEP;
        STEP:= 1 / STEP; FUNCT(N, M, X, F1);
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        JAC[J,I]:= (F1[J] - F[J]) * STEP; X[I]:= AID
    'END'
'END' JACOBNMF;
        'EOP'
