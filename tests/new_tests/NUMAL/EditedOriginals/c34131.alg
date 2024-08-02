'CODE' 34131;
    'PROCEDURE' LSQSOL(A, N, M, AID, CI, B); 'VALUE' N, M;
    'INTEGER' N, M; 'ARRAY' A, AID, B; 'INTEGER' 'ARRAY' CI;
    'BEGIN' 'INTEGER' K, CIK;
        'REAL' W;

        'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO' ELMVECCOL(K, N, K, B, A,
        TAMVEC(K, N, K, A, B) / (AID[K] * A[K,K]));
        'FOR' K:= M 'STEP' - 1 'UNTIL' 1 'DO' B[K]:= (B[K] - MATVEC
        (K + 1, M, K, A, B)) / AID[K];
        'FOR' K:= M 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' CIK:= CI[K]; 'IF' CIK ^= K 'THEN'
            'BEGIN' W:= B[K]; B[K]:= B[CIK]; B[CIK]:= W 'END'
        'END'
    'END' LSQSOL;
        'EOP'
