'CODE' 34300;
    'PROCEDURE' DEC(A, N, AUX, P); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX; 'INTEGER' 'ARRAY' P;
    'BEGIN' 'INTEGER' I, K, K1, PK, D;
        'REAL' R, S, EPS;
        'ARRAY' V[1:N];
        R:= -1;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' S:= SQRT(MATTAM(1,N,I,I,A,A));
            'IF' S > R 'THEN' R:= S; V[I]:= 1/S
        'END';
        EPS:= AUX[2] * R; D:= 1;
        'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' R:= - 1; K1:= K - 1;
            'FOR' I:= K 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' A[I,K]:= A[I,K] - MATMAT(1, K1, I, K, A, A);
                S:= ABS(A[I,K]) * V[I]; 'IF' S > R 'THEN'
                'BEGIN' R:= S; PK:= I 'END'
            'END' LOWER;
            P[K]:= PK; V[PK]:= V[K]; S:= A[PK,K];
            'IF' ABS(S) < EPS 'THEN' 'GOTO' END;
            'IF' S < 0 'THEN' D:= -D; 'IF' PK ^= K 'THEN'
            'BEGIN' D:= - D; ICHROW(1, N, K, PK, A) 'END';
            'FOR' I:= K + 1 'STEP' 1 'UNTIL' N 'DO'
            A[K,I]:= (A[K,I] - MATMAT(1, K1, K, I, A, A)) / S
        'END' LU;
        K:= N + 1;
     END: AUX[1]:= D; AUX[3]:= K - 1
    'END' DEC;
        'EOP'
