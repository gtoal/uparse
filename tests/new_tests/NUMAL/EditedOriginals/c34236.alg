'CODE' 34236;
    'PROCEDURE' GSSINV(A, N, AUX); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'BEGIN' 'INTEGER' 'ARRAY' RI, CI[1:N];
        GSSELM(A, N, AUX, RI, CI);
        'IF' AUX[3] = N 'THEN' AUX[9]:= INV1(A, N, RI, CI, 'TRUE')
    'END' GSSINV;
        'EOP'
