'CODE' 34134;
    'PROCEDURE' LSQORTDEC(A, N, M, AUX, AID, CI); 'VALUE' N, M;
    'INTEGER' N, M; 'ARRAY' A, AUX, AID; 'INTEGER' 'ARRAY' CI;
    'BEGIN' 'INTEGER' J, K, KPIV;
        'REAL' BETA, SIGMA, NORM, W, EPS, AKK, AIDK;
        'ARRAY' SUM[1:M];

        NORM:= 0; AUX[3]:= M;
        'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' W:= SUM[K]:= TAMMAT(1, N, K, K, A, A);
            'IF' W > NORM 'THEN' NORM:= W
        'END';
        W:= AUX[5]:= SQRT(NORM); EPS:= AUX[2] * W;
        'FOR' K:= 1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' SIGMA:= SUM[K]; KPIV:= K;
            'FOR' J:= K + 1 'STEP' 1 'UNTIL' M 'DO'
            'IF' SUM[J] > SIGMA 'THEN'
            'BEGIN' SIGMA:= SUM[J]; KPIV:= J 'END';
            'IF' KPIV ^= K 'THEN'
            'BEGIN' SUM[KPIV]:= SUM[K]; ICHCOL(1, N, K, KPIV, A) 'END';
            CI[K]:= KPIV; AKK:= A[K,K];
            SIGMA:= TAMMAT(K, N, K, K, A, A); W:= SQRT(SIGMA);
            AIDK:= AID[K]:= 'IF' AKK < 0 'THEN' W 'ELSE' - W;
            'IF' W < EPS 'THEN'
            'BEGIN' AUX[3]:= K - 1; 'GOTO' ENDDEC 'END';
            BETA:= 1 / (SIGMA - AKK * AIDK); A[K,K]:= AKK - AIDK;
            'FOR' J:= K + 1 'STEP' 1 'UNTIL' M 'DO'
            'BEGIN' ELMCOL(K, N, J, K, A, A, - BETA * TAMMAT(K, N,
                K, J, A, A)); SUM[J]:= SUM[J] - A[K,J] ** 2
            'END'
        'END' FOR K;
    ENDDEC:
    'END' LSQORTDEC;

        'EOP'
