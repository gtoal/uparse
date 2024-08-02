'CODE' 34313;
    'REAL' 'PROCEDURE' CHLDETERM1(A, N); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A;
    'BEGIN' 'INTEGER' K, KK; 'REAL' D;
        D:= 1; KK:= 0;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' KK:= KK + K; D:= A[KK] * D 'END';
        CHLDETERM1:= D * D
    'END' CHLDETERM1;
        'EOP'
