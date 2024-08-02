'CODE' 34361;
    'PROCEDURE' EQILBRCOM(A1, A2, N, EM, D, INT); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A1, A2, EM, D; 'INTEGER' 'ARRAY' INT;
    'BEGIN' 'INTEGER' I, P, Q, J, T, COUNT, EXPONENT, NI, IM, I1;
        'REAL' C, R, EPS;
        'PROCEDURE' MOVE(K); 'VALUE' K; 'INTEGER' K;
        'BEGIN' 'REAL' DI;
            NI:= Q - P; T:= T + 1; 'IF' K ^= I 'THEN'
            'BEGIN' ICHCOL(1, N, K, I, A1); ICHROW(1, N, K, I, A1);
                ICHCOL(1, N, K, I, A2); ICHROW(1, N, K, I, A2);
                DI:= D[I]; D[I]:= D[K]; D[K]:= DI
            'END'
        'END' MOVE;
        EPS:= EM[0] ** 4; T:= P:= 1; Q:= NI:= I:= N;
        COUNT:= EM[6];
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' D[J]:= 1; INT[J]:= 0 'END';
        'FOR' I:= 'IF' I < Q 'THEN' I + 1 'ELSE' P 'WHILE' COUNT > 0
        'AND' NI > 0 'DO'
        'BEGIN' COUNT:= COUNT - 1; IM:= I - 1; I1:= I + 1;
            C:= TAMMAT(P, IM, I, I, A1, A1) + TAMMAT(I1, Q, I,
            I, A1, A1) + TAMMAT(P, IM, I, I, A2, A2) +
            TAMMAT(I1, Q, I, I, A2, A2);
            R:= MATTAM(P, IM, I, I, A1, A1) + MATTAM(I1, Q, I,
            I, A1, A1) + MATTAM(P, IM, I, I, A2, A2) +
            MATTAM(I1, Q, I, I, A2, A2); 'IF' C / EPS <= R 'THEN'
            'BEGIN' INT[T]:= I; MOVE(P); P:= P + 1 'END'
            'ELSE' 'IF' R / EPS <= C 'THEN'
            'BEGIN' INT[T]:= - I; MOVE(Q); Q:= Q - 1 'END'
            'ELSE'
            'BEGIN' EXPONENT:= LN(R / C) * 0.36067;
                'IF' ABS(EXPONENT) > 1 'THEN'
                'BEGIN' NI:= Q - P; C:= 2 ** EXPONENT;
                    D[I]:= D[I] * C;
                    'FOR' J:= 1 'STEP' 1 'UNTIL' IM, I1 'STEP' 1
                    'UNTIL' N 'DO'
                    'BEGIN' A1[J,I]:= A1[J,I] * C;
                        A1[I,J]:= A1[I,J] / C;
                        A2[J,I]:= A2[J,I] * C;
                        A2[I,J]:= A2[I,J] / C
                    'END'
                'END'
                'ELSE' NI:= NI - 1
            'END'
        'END';
        EM[7]:= EM[6] - COUNT
    'END' EQILBRCOM;
        'EOP'
