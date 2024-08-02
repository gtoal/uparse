'CODE' 34364;
    'PROCEDURE' HSHHRMTRIVAL(A, N, D, BB, EM); 'VALUE' N; 'INTEGER' N;
     'ARRAY' A, D, BB, EM;
    'BEGIN' 'INTEGER' I, J, J1, JM1, R, RM1;
        'REAL' NRM, W, TOL2, X, AR, AI, H, T, Q, AJR, ARJ, DJ,
        BBJ, MOD2;
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
            D[R]:= A[R,R];
            'IF' X < TOL2 'THEN' BB[RM1]:= AR * AR + AI * AI 'ELSE'
            'BEGIN' MOD2:= AR * AR + AI * AI; 'IF' MOD2 = 0 'THEN'
                'BEGIN' A[RM1,R]:= SQRT(X); T:= X 'END'
                'ELSE'
                'BEGIN' X:= X + MOD2; H:= SQRT(MOD2 * X);
                    T:= X + H; H:= 1 + X / H;
                    A[R,RM1]:= - AI * H; A[RM1,R]:= AR * H;
                'END';
                J:= 1; JM1:= 0;
                'FOR' J1:= 2 'STEP' 1 'UNTIL' R 'DO'
                'BEGIN' D[J]:= (TAMMAT(1, J, J, R, A, A) +
                    MATMAT(J1, RM1, J, R, A, A) + MATTAM(1,
                    JM1, J, R, A, A) - MATMAT(J1, RM1, R, J,
                    A, A)) / T;
                    BB[J]:= (MATMAT(1, JM1, J, R, A, A) -
                    TAMMAT(J1, RM1, J, R, A, A) - MATMAT(1, J,
                    R, J, A, A) - MATTAM(J1, RM1, J, R, A, A))
                    / T; JM1:= J; J:= J1
                'END' J1;
                Q:= (TAMVEC(1, RM1, R, A, D) - MATVEC(1, RM1,
                R, A, BB)) / T / 2;
                ELMVECCOL(1, RM1, R, D, A, - Q);
                ELMVECROW(1, RM1, R, BB, A, Q); J:= 1;
                'FOR' J1:= 2 'STEP' 1 'UNTIL' R 'DO'

                'BEGIN' AJR:= A[J,R]; ARJ:= A[R,J]; DJ:= D[J];
                    BBJ:= BB[J];
                    ELMROWVEC(J, RM1, J, A, D, - AJR);
                    ELMROWVEC(J, RM1, J, A, BB, ARJ);
                    ELMROWCOL(J, RM1, J, R, A, A, - DJ);
                    ELMROW(J, RM1, J, R, A, A, BBJ);
                    ELMCOLVEC(J1, RM1, J, A, D, - ARJ);
                    ELMCOLVEC(J1, RM1, J, A, BB, - AJR);
                    ELMCOL(J1, RM1, J, R, A, A, BBJ);
                    ELMCOLROW(J1, RM1, J, R, A, A, DJ); J:= J1;
                'END' J1;
                BB[RM1]:= X;
            'END';
            R:= RM1;
        'END' RM1;
        D[1]:= A[1,1];
    'END' HSHHRMTRIVAL;
        'EOP'
