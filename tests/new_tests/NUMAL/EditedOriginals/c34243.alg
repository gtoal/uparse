'CODE' 34243;
    'PROCEDURE' GSSSOLERB(A, N, AUX, B); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX, B;
    'BEGIN' 'INTEGER' 'ARRAY' RI, CI[1:N];
        GSSERB(A, N, AUX, RI, CI);
        'IF' AUX[3] = N 'THEN' SOLELM(A, N, RI, CI, B)
    'END' GSSSOLERB;
        'EOP'
