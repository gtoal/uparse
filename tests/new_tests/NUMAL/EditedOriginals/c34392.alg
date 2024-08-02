'CODE' 34392;
    'PROCEDURE' CHLDECSOL2(A, N, AUX, B); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX, B;
    'BEGIN'

        CHLDEC2(A, N, AUX);
        'IF' AUX[3] = N 'THEN' CHLSOL2(A, N, B)
    'END' CHLDECSOL2;
        'EOP'
