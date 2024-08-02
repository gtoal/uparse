'CODE' 34211;
   'PROCEDURE' RNK1UPD(H, N, V, C);'VALUE' N, C; 'INTEGER' N;
   'REAL' C;'ARRAY' H, V;
    'BEGIN' 'INTEGER' J, K;
        K:= 0;
        'FOR' J:= 1, J + K 'WHILE' K < N 'DO'
        'BEGIN' K:= K +1 ;
            ELMVEC(J, J + K - 1, 1 - J, H, V, V[K] * C)
        'END'
    'END' RNK1UPD;
        'EOP'
