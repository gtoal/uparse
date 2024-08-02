'CODE' 34232;
    'PROCEDURE' GSSSOL(A, N, AUX, B); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX, B;
    'BEGIN' 'INTEGER' 'ARRAY' RI, CI[1:N];
        GSSELM(A, N, AUX, RI, CI);
        'IF' AUX[3] = N 'THEN' SOLELM(A, N, RI, CI, B)
    'END' GSSSOL;
        'EOP'
