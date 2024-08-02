'CODE' 34141;
    'COMMENT' MCA 2301;
    'PROCEDURE' BAKSYMTRI2(A, N, N1, N2, VEC); 'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' A, VEC;
    'BEGIN' 'INTEGER' I, J, K; 'REAL' W;

        'FOR' J:= 2 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' W:= A[J,J]; 'IF' W < 0 'THEN'
            'FOR' K:= N1 'STEP' 1 'UNTIL' N2 'DO'
            ELMCOL(1, J - 1, K, J, VEC, A,
            TAMMAT(1, J - 1, J, K, A, VEC) * W)
        'END'
    'END' BAKSYMTRI2;
        'EOP'
