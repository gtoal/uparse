'CODE' 34212;
    'PROCEDURE' DAVUPD(H, N, V, W, C1, C2); 'VALUE' N, C1, C2;
    'INTEGER' N; 'REAL' C1, C2; 'ARRAY' H, V, W;
    'BEGIN' 'INTEGER' I, J, K;
        'REAL' VK, WK;
        K:= 0;
        'FOR' J:= 1, J + K 'WHILE' K < N 'DO'
        'BEGIN' K:= K +1 ; VK:= V[K] * C1; WK:= W[K] * C2;
            'FOR' I:= 0 'STEP' 1 'UNTIL' K -1  'DO'
            H[I + J]:= H[I + J] + V[I + 1] * VK - W[I + 1] * WK
        'END'
    'END' DAVUPD;
        'EOP'
