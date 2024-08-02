'CODE' 34393;
    'PROCEDURE' CHLDECSOL1(A, N, AUX, B); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX, B;
    'BEGIN'

        CHLDEC1(A, N, AUX);
        'IF' AUX[3] = N 'THEN' CHLSOL1(A, N, B)
    'END' CHLDECSOL1;
        'EOP'
