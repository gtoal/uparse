'CODE' 34437;
'PROCEDURE' JACOBNNF(N, X, F, JAC, I, DI, FUNCT); 'VALUE' N;
'INTEGER' N, I; 'REAL' DI; 'ARRAY' X, F, JAC; 'PROCEDURE' FUNCT;
'BEGIN' 'INTEGER' J; 'REAL' STEP, AID; 'ARRAY' F1[1:N];
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' STEP:= DI; AID:= X[I]; X[I]:= AID + STEP;
        STEP:= 1 / STEP; FUNCT(N, X, F1);
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        JAC[J,I]:= (F1[J] - F[J]) * STEP; X[I]:= AID
    'END'
'END' JACOBNNF;
        'EOP'
