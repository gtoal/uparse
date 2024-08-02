'CODE' 34402;
    'PROCEDURE' CHLDECINV2(A, N, AUX); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'BEGIN'

        CHLDEC2(A, N, AUX);
        'IF' AUX[3] = N 'THEN' CHLINV2(A, N)
    'END' CHLDECINV2;
        'EOP'
