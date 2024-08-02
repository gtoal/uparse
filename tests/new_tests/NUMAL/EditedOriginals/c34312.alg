'CODE' 34312;
    'REAL' 'PROCEDURE' CHLDETERM2(A, N); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A;
    'BEGIN' 'INTEGER' K; 'REAL' D;
        D:= 1;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO' D:= A[K,K] * D;
        CHLDETERM2:= D * D
    'END' CHLDETERM2;
        'EOP'
