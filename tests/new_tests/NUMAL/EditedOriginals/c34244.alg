'CODE' 34244;
    'PROCEDURE' GSSINVERB(A, N, AUX); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'BEGIN' 'INTEGER' 'ARRAY' RI, CI[1:N];
        GSSELM(A, N, AUX, RI, CI);
        'IF' AUX[3] = N 'THEN'
        ERBELM(N, AUX, INV1(A, N, RI, CI, 'TRUE'))
    'END' GSSINVERB;
        'EOP'
