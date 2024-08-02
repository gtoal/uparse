'CODE' 34172;
    'COMMENT' MCA 2402;
    'PROCEDURE' BAKREAHES2(A, N, N1, N2, INT, VEC); 'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' A, VEC; 'INTEGER' 'ARRAY' INT;
    'BEGIN' 'INTEGER' I, L, K; 'ARRAY' U[1:N];

        'FOR' I:= N 'STEP' -1 'UNTIL' 2 'DO'
        'BEGIN' 'FOR' K:= I - 2 'STEP' -1 'UNTIL' 1 'DO'
            U[K + 1]:= A[I,K];
            'FOR' K:= N1 'STEP' 1 'UNTIL' N2 'DO'
            VEC[I,K]:= VEC[I,K] + TAMVEC(2 , I - 1, K, VEC, U);
            L:= INT[I]; 'IF' L > I 'THEN' ICHROW(N1, N2, I, L, VEC)
        'END'
    'END' BAKREAHES2;
        'EOP'
