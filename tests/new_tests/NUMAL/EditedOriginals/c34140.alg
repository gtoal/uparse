'CODE' 34140;
    'COMMENT' MCA 2300;
    'PROCEDURE' TFMSYMTRI2(A, N, D, B, BB, EM); 'VALUE' N;'INTEGER' N;
     'ARRAY' A, B, BB, D, EM;
    'BEGIN' 'INTEGER' I, J, R, R1;
        'REAL' W, X, A1, B0, BB0, D0, MACHTOL, NORM;

        NORM:= 0;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' W:= 0;
            'FOR' I:= 1 'STEP' 1 'UNTIL' J 'DO' W:= ABS(A[I,J]) + W;
            'FOR' I:= J + 1 'STEP' 1 'UNTIL' N 'DO' W:= ABS(A[J,I]) +
            W; 'IF' W > NORM 'THEN' NORM:= W
        'END';
        MACHTOL:= EM[0] * NORM; EM[1]:= NORM; R:= N;
        'FOR' R1:= N - 1 'STEP' -1 'UNTIL' 1 'DO'
        'BEGIN' D[R]:= A[R,R]; X:= TAMMAT(1, R - 2, R, R, A, A);
            A1:= A[R1,R]; 'IF' SQRT(X) <= MACHTOL 'THEN'
            'BEGIN' B0:= B[R1]:= A1; BB[R1]:= B0 * B0;A[R,R]:= 1 'END'
            'ELSE'
            'BEGIN' BB0:= BB[R1]:= A1 * A1 + X;
                B0:= 'IF' A1 > 0 'THEN' -SQRT(BB0) 'ELSE' SQRT(BB0);
                A1:= A[R1,R]:= A1 - B0; W:= A[R,R]:= 1 / (A1 * B0);
                'FOR' J:= 1 'STEP' 1 'UNTIL' R1 'DO' B[J]:= (TAMMAT(1,
                J, J, R, A, A) + MATMAT(J + 1, R1, J, R, A, A)) * W;
                ELMVECCOL(1, R1, R, B, A, TAMVEC(1, R1, R, A, B) *
                W * .5); 'FOR' J:= 1 'STEP' 1 'UNTIL' R1 'DO'
                'BEGIN' ELMCOL(1, J, J, R, A, A, B[J]);
                    ELMCOLVEC(1, J, J, A, B, A[J,R])
                'END'; B[R1]:= B0
            'END'; R:= R1
        'END';
        D[1]:= A[1,1]; A[1,1]:= 1; B[N]:= BB[N]:= 0
    'END' TFMSYMTRI2

        ;'EOP'
