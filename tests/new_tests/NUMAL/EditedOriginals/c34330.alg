'CODE' 34330;
'PROCEDURE' CHLDECBND(A, N, W, AUX); 'VALUE' N, W; 'INTEGER' N, W;
'ARRAY' A, AUX;
'BEGIN' 'INTEGER' J, K, JMAX, KK, KJ, W1, START;
        'REAL' R, EPS, MAX;
        MAX:= 0; KK:= - W; W1:= W + 1;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' KK:= KK + W1; 'IF' A[KK] > MAX 'THEN' MAX:= A[KK]'END';
        JMAX:= W; W1:= W + 1; KK:= - W; EPS:= AUX[2] * MAX;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN''IF' K + W > N 'THEN' JMAX:= JMAX - 1; KK:= KK + W1;
            START:= KK - K + 1;
            R:= A[KK] - VECVEC('IF' K <= W1 'THEN' START 'ELSE' KK - W,
            KK - 1, 0, A, A); 'IF' R <= EPS 'THEN'
            'BEGIN' AUX[3]:= K - 1; 'GOTO' END 'END';
            A[KK]:= R:= SQRT(R); KJ:= KK;
            'FOR' J:= 1 'STEP' 1 'UNTIL' JMAX 'DO'
            'BEGIN' KJ:= KJ + W;
                A[KJ]:= (A[KJ] - VECVEC('IF' K + J <= W1 'THEN' START
                'ELSE' KK - W + J, KK - 1, KJ - KK, A, A)) / R
            'END'
        'END';
        AUX[3]:= N;
    END:
    'END' CHLDECBND;
        'EOP'
