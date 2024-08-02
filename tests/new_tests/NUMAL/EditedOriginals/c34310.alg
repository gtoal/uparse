'CODE' 34310;
    'PROCEDURE' CHLDEC2(A, N, AUX); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'BEGIN' 'INTEGER' K, J; 'REAL' R, EPSNORM;

        R:= 0;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'IF' A[K,K] > R 'THEN' R:= A[K,K];
        EPSNORM:= AUX[2] * R;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' R:= A[K,K] - TAMMAT(1, K - 1, K, K, A, A);
            'IF' R <= EPSNORM 'THEN'
            'BEGIN' AUX[3]:= K - 1; 'GOTO' END 'END';
            A[K,K]:= R:= SQRT(R);
            'FOR' J:= K + 1 'STEP' 1 'UNTIL' N 'DO'
            A[K,J]:= (A[K,J] - TAMMAT(1, K - 1, J, K, A, A)) / R
        'END';
        AUX[3]:= N;
    END:
    'END' CHLDEC2;
        'EOP'
