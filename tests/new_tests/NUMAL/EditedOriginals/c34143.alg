'CODE' 34143;
    'COMMENT' MCA 2305;
    'PROCEDURE' TFMSYMTRI1(A, N, D, B, BB, EM); 'VALUE' N;'INTEGER' N;
     'ARRAY' A, B, BB, D, EM;
    'BEGIN' 'INTEGER' I, J, R, R1, P, Q, TI, TJ;
        'REAL' S, W, X, A1, B0, BB0, D0, NORM, MACHTOL;

        NORM:= 0; TJ:= 0;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' W:= 0;
            'FOR' I:= 1 'STEP' 1 'UNTIL' J 'DO' W:= ABS(A[I + TJ]) +W;
            TJ:= TJ + J; TI:= TJ + J;
            'FOR' I:= J + 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' W:= ABS(A[TI]) + W; TI:= TI + I 'END';
            'IF' W > NORM 'THEN' NORM:= W
        'END';
        MACHTOL:= EM[0] * NORM; EM[1]:= NORM; Q:= (N + 1) * N // 2;
        R:= N; 'FOR' R1:= N - 1 'STEP' -1 'UNTIL' 1 'DO'
        'BEGIN' P:= Q - R; D[R]:= A[Q];
            X:= VECVEC(P + 1, Q - 2, 0, A, A);
            A1:= A[Q - 1]; 'IF' SQRT(X) <= MACHTOL 'THEN'
            'BEGIN' B0:= B[R1]:= A1; BB[R1]:= B0 * B0; A[Q]:= 1 'END'
            'ELSE'
            'BEGIN' BB0:= BB[R1]:= A1 * A1 + X;
                B0:= 'IF' A1 > 0 'THEN' -SQRT(BB0) 'ELSE' SQRT(BB0);
                A1:= A[Q - 1]:= A1 - B0; W:= A[Q]:= 1 / (A1 * B0);
                TJ:= 0; 'FOR' J:= 1 'STEP' 1 'UNTIL' R1 'DO'
                'BEGIN' TI:= TJ + J; S:= VECVEC(TJ + 1, TI, P - TJ,
                    A, A); TJ:= TI + J;
                    B[J]:= (SEQVEC(J + 1, R1, TJ, P, A, A) + S) * W;
                    TJ:= TI
                'END';
                ELMVEC(1, R1, P, B, A, VECVEC(1,R1,P,B,A)* W *.5);
                TJ:= 0; 'FOR' J:= 1 'STEP' 1 'UNTIL' R1 'DO'
                'BEGIN' TI:= TJ + J; ELMVEC(TJ + 1, TI, P - TJ, A, A,
                    B[J]);ELMVEC(TJ + 1, TI, -TJ, A, B, A[J + P]);
                    TJ:= TI
                'END'; B[R1]:= B0
            'END';
            Q:= P; R:= R1
        'END';
        D[1]:= A[1]; A[1]:= 1; B[N]:= BB[N]:= 0
    'END' TFMSYMTRI1

        ;'EOP'
