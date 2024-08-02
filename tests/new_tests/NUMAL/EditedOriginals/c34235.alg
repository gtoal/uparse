'CODE' 34235;
    'REAL' 'PROCEDURE' INV1(A, N, RI, CI, WITHNORM);
    'VALUE' N, WITHNORM; 'INTEGER' N; 'BOOLEAN' WITHNORM;
    'ARRAY' A; 'INTEGER' 'ARRAY' RI, CI;
    'BEGIN' 'INTEGER' L, K, K1;
        'REAL' AID, NRMINV;
        INV(A, N, RI); NRMINV:= 0; 'IF' WITHNORM 'THEN'
        'FOR' L:= 1 'STEP' 1 'UNTIL' N 'DO'
        NRMINV:= NRMINV + ABS(A[L,N]);
        'FOR' K:= N - 1 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' 'IF' WITHNORM 'THEN'
            'BEGIN' AID:= 0;
                'FOR' L:= 1 'STEP' 1 'UNTIL' N 'DO'
                AID:= AID + ABS(A[L,K]);
                'IF' NRMINV < AID 'THEN' NRMINV:= AID
            'END';
            K1:= CI[K]; 'IF' K1 ^= K 'THEN' ICHROW(1, N, K, K1, A)
        'END';
        INV1:= NRMINV
    'END' INV1;
        'EOP'
