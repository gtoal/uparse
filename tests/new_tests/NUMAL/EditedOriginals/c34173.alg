'CODE' 34173;
    'COMMENT' MCA 2405;
    'PROCEDURE' EQILBR(A, N, EM, D, INT); 'VALUE' N; 'INTEGER' N;
     'ARRAY' A, EM, D; 'INTEGER' 'ARRAY' INT;
    'BEGIN' 'INTEGER' I, IM, I1, P, Q, J, T, COUNT, EXPONENT, NI;
        'REAL' C, R, EPS, OMEGA, FACTOR;

        'PROCEDURE' MOVE(K); 'VALUE' K; 'INTEGER' K;
        'BEGIN' 'REAL' DI;
            NI:= Q - P; T:= T + 1; 'IF' K ^= I 'THEN'
            'BEGIN' ICHCOL(1, N, K, I, A); ICHROW(1, N, K, I, A);
                DI:= D[I]; D[I]:= D[K]; D[K]:= DI
            'END'
        'END' MOVE;

        FACTOR:= 1 / (2 * LN(2)); 'COMMENT' MORE GENERALLY: LN(BASE);
        EPS:= EM[0]; OMEGA:= 1 / EPS; T:= P:= 1; Q:= NI:= I:= N;
        COUNT:= (N + 1) * N // 2;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' D[J]:= 1; INT[J]:= 0 'END';
        'FOR' I:= 'IF' I < Q 'THEN' I + 1 'ELSE' P
        'WHILE' COUNT > 0 'AND' NI > 0 'DO'
        'BEGIN' COUNT:= COUNT - 1; IM:= I - 1; I1:= I + 1;
            C:= SQRT(TAMMAT(P, IM, I, I, A, A) +
            TAMMAT(I1, Q, I, I, A, A));
            R:= SQRT(MATTAM(P, IM, I, I, A, A) +
            MATTAM(I1, Q, I, I, A, A));
            'IF' C * OMEGA <= R * EPS 'THEN'
            'BEGIN' INT[T]:= I; MOVE(P); P:= P + 1 'END'
            'ELSE' 'IF' R * OMEGA <= C * EPS 'THEN'
            'BEGIN' INT[T]:= -I; MOVE(Q); Q:= Q - 1 'END'
            'ELSE'
            'BEGIN' EXPONENT:= LN(R / C) * FACTOR;
                'IF' ABS(EXPONENT) > 1 'THEN'
                'BEGIN' NI:= Q - P; C:= 2 ** EXPONENT; R:= 1 / C;
                    D[I]:= D[I] * C;
                    'FOR' J:= 1 'STEP' 1 'UNTIL' IM,
                    I1 'STEP' 1 'UNTIL' N 'DO'
                    'BEGIN' A[J,I]:= A[J,I] * C;
                        A[I,J]:= A[I,J] * R
                    'END'
                'END' 'ELSE' NI:= NI - 1
            'END'
        'END'
    'END' EQILBR

        ;'EOP'
