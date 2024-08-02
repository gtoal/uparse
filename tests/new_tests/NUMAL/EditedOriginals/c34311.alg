'CODE' 34311;
    'PROCEDURE' CHLDEC1(A, N, AUX); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'BEGIN' 'INTEGER' J, K, KK, KJ, LOW, UP; 'REAL' R, EPSNORM;

        R:= 0; KK:= 0;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' KK:= KK + K; 'IF' A[KK] > R 'THEN' R:= A[KK] 'END';
        EPSNORM:= AUX[2] * R; KK:= 0;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' KK:= KK + K; LOW:= KK - K + 1; UP:= KK - 1;
            R:= A[KK] - VECVEC(LOW, UP, 0, A, A);
            'IF' R <= EPSNORM 'THEN'
            'BEGIN' AUX[3]:= K - 1; 'GOTO' END 'END';
            A[KK]:= R:= SQRT(R); KJ:= KK + K;
            'FOR' J:= K + 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' A[KJ]:= (A[KJ] -
                    VECVEC(LOW, UP, KJ - KK, A, A)) / R;
                KJ:= KJ + J
            'END'
        'END';
        AUX[3]:= N;
    END:
    'END' CHLDEC1;
        'EOP'
