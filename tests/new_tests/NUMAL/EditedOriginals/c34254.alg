'CODE' 34254;
    'PROCEDURE' GSSITISOLERB(A, N, AUX, B); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX, B;
    'BEGIN' 'INTEGER' I, J;
        'ARRAY' AA[1:N,1:N];
        'INTEGER' 'ARRAY' RI, CI[1:N];
        DUPMAT(1, N, 1, N, AA, A);
        GSSNRI(A, N, AUX, RI, CI);
        'IF' AUX[3] = N 'THEN' ITISOLERB(AA, A, N, AUX, RI, CI, B)
    'END' GSSITISOLERB;
        'EOP'
