'CODE' 34051;
    'PROCEDURE' SOL(A, N, P, B); 'VALUE' N; 'INTEGER' N; 'ARRAY' A, B;
    'INTEGER' 'ARRAY' P;
    'BEGIN' 'INTEGER' K, PK;
        'REAL' R;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' R:= B[K]; PK:= P[K];
            B[K]:= (B[PK] - MATVEC(1, K - 1, K, A, B)) / A[K,K];
            'IF' PK ^= K 'THEN' B[PK]:= R
        'END';
        'FOR' K:= N 'STEP' - 1 'UNTIL' 1 'DO'
        B[K]:= B[K] - MATVEC(K + 1, N, K, A, B)
    'END' SOL

        ;'EOP'
