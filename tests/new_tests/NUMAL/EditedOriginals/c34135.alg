'CODE' 34135;
    'PROCEDURE' LSQORTDECSOL(A, N, M, AUX, DIAG, B); 'VALUE' N, M;
    'INTEGER' N, M; 'ARRAY' A, AUX, DIAG, B;
    'BEGIN' 'ARRAY' AID[1:M];
        'INTEGER' 'ARRAY' CI[1:M];

        LSQORTDEC(A, N, M, AUX, AID, CI);
        'IF' AUX[3] = M 'THEN'
        'BEGIN' LSQDGLINV(A, M, AID, CI, DIAG);
            LSQSOL(A, N, M, AID, CI, B)
        'END'
    'END' LSQORTDECSOL;
        'EOP'
