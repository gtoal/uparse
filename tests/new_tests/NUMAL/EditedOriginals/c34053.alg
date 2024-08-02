'CODE' 34053;
    'PROCEDURE' INV(A, N, P); 'VALUE' N; 'INTEGER' N; 'ARRAY' A;
    'INTEGER' 'ARRAY' P;
    'BEGIN' 'INTEGER' J, K, K1;
        'REAL' R;
        'ARRAY' V[1:N];
        'FOR' K:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' K1:= K + 1;
            'FOR' J:= N 'STEP' - 1 'UNTIL' K1 'DO'
            'BEGIN' A[J,K1]:= V[J];
                V[J]:= - MATMAT(K1, N, K, J, A, A)
            'END';
            R:= A[K,K];
            'FOR' J:= N 'STEP' - 1 'UNTIL' K1 'DO'
            'BEGIN' A[K,J]:= V[J];
                V[J]:= - MATMAT(K1, N, J, K, A, A) / R
            'END';
            V[K]:= (1 - MATMAT(K1, N, K, K, A, A)) / R
        'END';
        DUPCOLVEC(1, N, 1, A, V);
        'FOR' K:= N - 1 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' K1:= P[K]; 'IF' K1 ^= K 'THEN'
            ICHCOL(1, N, K, K1, A)
        'END'
    'END' INV;
        'EOP'
