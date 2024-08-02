'CODE' 34132;
    'PROCEDURE' LSQDGLINV(A, M, AID, CI, DIAG); 'VALUE' M; 'INTEGER' M;
    'ARRAY' A, AID, DIAG; 'INTEGER' 'ARRAY' CI;
    'BEGIN' 'INTEGER' J, K, CIK;
        'REAL' W;

        'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' DIAG[K]:= 1 / AID[K];
            'FOR' J:= K + 1 'STEP' 1 'UNTIL' M 'DO'
            DIAG[J]:= - TAMVEC(K, J - 1, J, A, DIAG) / AID[J];
            DIAG[K]:= VECVEC(K, M, 0, DIAG, DIAG)
        'END';
        'FOR' K:= M 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' CIK:= CI[K]; 'IF' CIK ^= K 'THEN'
            'BEGIN' W:= DIAG[K]; DIAG[K]:= DIAG[CIK]; DIAG[CIK]:= W
            'END'
        'END'
    'END' LSQDGLINV;
        'EOP'
