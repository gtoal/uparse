'CODE' 34363;
    'PROCEDURE' HSHHRMTRI(A, N, D, B, BB, EM, TR, TI); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, D, B, BB, EM, TR, TI;
    'BEGIN' 'INTEGER' I, J, J1, JM1, R, RM1;
        'REAL' NRM, W, TOL2, X, AR, AI, MOD, C, S, H, K, T, Q,
        AJR, ARJ, BJ, BBJ;
        NRM:= 0;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' W:= ABS(A[I,I]);
            'FOR' J:= I - 1 'STEP' - 1 'UNTIL' 1, I + 1 'STEP' 1
            'UNTIL' N 'DO' W:= W + ABS(A[I,J]) + ABS(A[J,I]);
            'IF' W > NRM 'THEN' NRM:= W
        'END' I;
        TOL2:= (EM[0] * NRM) ** 2; EM[1]:= NRM; R:= N;
        'FOR' RM1:= N - 1 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' X:= TAMMAT(1, R - 2, R, R, A, A) + MATTAM(1, R -
            2, R, R, A, A); AR:= A[RM1,R]; AI:= - A[R,RM1];
            D[R]:= A[R,R]; CARPOL(AR, AI, MOD, C, S);
            'IF' X < TOL2 'THEN'
            'BEGIN' A[R,R]:= - 1; B[RM1]:= MOD;
                BB[RM1]:= MOD * MOD
            'END'

            'ELSE'
            'BEGIN' H:= MOD * MOD + X; K:= SQRT(H);
                T:= A[R,R]:= H + MOD * K;
                'IF' AR = 0 'AND' AI = 0 'THEN' A[RM1,R]:= K 'ELSE'
                'BEGIN' A[RM1,R]:= AR + C * K;
                    A[R,RM1]:= - AI - S * K; S:= - S
                'END';
                C:= - C; J:= 1; JM1:= 0;
                'FOR' J1:= 2 'STEP' 1 'UNTIL' R 'DO'
                'BEGIN' B[J]:= (TAMMAT(1, J, J, R, A, A) +
                    MATMAT(J1, RM1, J, R, A, A) + MATTAM(1,
                    JM1, J, R, A, A) - MATMAT(J1, RM1, R, J,
                    A, A)) / T;
                    BB[J]:= (MATMAT(1, JM1, J, R, A, A) -
                    TAMMAT(J1, RM1, J, R, A, A) - MATMAT(1, J,
                    R, J, A, A) - MATTAM(J1, RM1, J, R, A, A))
                    / T; JM1:= J; J:= J1
                'END' J1;
                Q:= (TAMVEC(1, RM1, R, A, B) - MATVEC(1, RM1,
                R, A, BB)) / T / 2;
                ELMVECCOL(1, RM1, R, B, A, - Q);
                ELMVECROW(1, RM1, R, BB, A, Q); J:= 1;
                'FOR' J1:= 2 'STEP' 1 'UNTIL' R 'DO'
                'BEGIN' AJR:= A[J,R]; ARJ:= A[R,J]; BJ:= B[J];
                    BBJ:= BB[J];
                    ELMROWVEC(J, RM1, J, A, B, - AJR);
                    ELMROWVEC(J, RM1, J, A, BB, ARJ);
                    ELMROWCOL(J, RM1, J, R, A, A, - BJ);
                    ELMROW(J, RM1, J, R, A, A, BBJ);
                    ELMCOLVEC(J1, RM1, J, A, B, - ARJ);
                    ELMCOLVEC(J1, RM1, J, A, BB, - AJR);
                    ELMCOL(J1, RM1, J, R, A, A, BBJ);
                    ELMCOLROW(J1, RM1, J, R, A, A, BJ); J:= J1;
                'END' J1;
                BB[RM1]:= H; B[RM1]:= K;
            'END';
            TR[RM1]:= C; TI[RM1]:= S; R:= RM1;
        'END' RM1;
        D[1]:= A[1,1];
    'END' HSHHRMTRI

        ;'EOP'
