'CODE' 34301;
    'PROCEDURE' DECSOL(A, N, AUX, B); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX, B;
    'BEGIN' 'INTEGER' 'ARRAY' P[1:N];
        DEC(A, N, AUX, P);
        'IF' AUX[3] = N 'THEN' SOL(A, N, P, B)
    'END' DECSOL;
        'EOP'
