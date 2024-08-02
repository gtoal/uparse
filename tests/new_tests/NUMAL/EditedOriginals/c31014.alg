'CODE' 31014;
    'PROCEDURE' INISYMROW(L, U, I, A, X); 'VALUE' L,U,I,X;
    'INTEGER' L,U,I; 'REAL' X; 'ARRAY' A;
    'BEGIN' 'INTEGER' K;
        'IF' L <= I 'THEN'
        'BEGIN' K:= (I - 1) * I//2; L := K + L;
            K := ('IF' U < I 'THEN' U 'ELSE' I) + K;
            'FOR' L:= L 'STEP' 1 'UNTIL' K 'DO' A[L]:= X;
            L := I + 1
        'END';
        'IF' U>I 'THEN''FOR' K:=(L-1)*L//2+I, K+L-1 'WHILE' L<= U 'DO'
        'BEGIN' A[K]:= X; L:= L + 1 'END'
    'END' INISYMROW;
        'EOP'
