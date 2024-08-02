'CODE' 34242;
    'PROCEDURE' GSSERB(A, N, AUX, RI, CI); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'INTEGER' 'ARRAY' RI, CI;
    'BEGIN'
        GSSELM(A, N, AUX, RI, CI);
        'IF' AUX[3] = N 'THEN' ERBELM(N, AUX, ONENRMINV(A, N))
    'END' GSSERB;
        'EOP'
