'CODE' 34252;
    'PROCEDURE' GSSNRI(A, N, AUX, RI, CI); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'INTEGER' 'ARRAY' RI, CI;
    'BEGIN'
        GSSELM(A, N, AUX, RI, CI);
        'IF' AUX[3] = N 'THEN' AUX[9]:= ONENRMINV(A, N)
    'END' GSSNRI;
        'EOP'
