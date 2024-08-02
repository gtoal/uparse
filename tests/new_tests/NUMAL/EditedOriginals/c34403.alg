'CODE' 34403;
    'PROCEDURE' CHLDECINV1(A, N, AUX); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'BEGIN'

        CHLDEC1(A, N, AUX);
        'IF' AUX[3] = N 'THEN' CHLINV1(A, N)
    'END' CHLDECINV1;
        'EOP'
