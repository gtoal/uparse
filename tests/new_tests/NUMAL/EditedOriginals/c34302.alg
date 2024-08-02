'CODE' 34302;
    'PROCEDURE' DECINV(A, N, AUX); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'BEGIN' 'INTEGER' 'ARRAY' P[1:N];
        DEC(A, N, AUX, P); 'IF' AUX[3] = N 'THEN' INV(A, N, P)
    'END' DECINV

        ;'EOP'
