'CODE' 34260;
'PROCEDURE' HSHREABID(A, M, N, D, B, EM);
'VALUE' M, N; 'INTEGER' M, N; 'ARRAY' A, D, B, EM;
'BEGIN' 'INTEGER' I, J, I1;
    'REAL' NORM, MACHTOL, W, S, F, G, H;

    NORM:= 0;
    'FOR' I:= 1 'STEP' 1 'UNTIL' M 'DO'
    'BEGIN' W:= 0;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' W:= ABS(A[I,J]) + W;
        'IF' W > NORM 'THEN' NORM:= W
    'END';
    MACHTOL:= EM[0] * NORM; EM[1]:= NORM;
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' I1:= I + 1; S:= TAMMAT(I1, M, I, I, A, A);
        'IF' S < MACHTOL 'THEN' D[I]:= A[I,I] 'ELSE'
        'BEGIN' F:= A[I,I]; S:= F * F + S;
            D[I]:= G:= 'IF' F < 0 'THEN' SQRT(S) 'ELSE' - SQRT(S);
            H:= F * G - S; A[I,I]:= F - G;
            'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO'
            ELMCOL(I, M, J, I, A, A, TAMMAT(I, M, I, J, A, A) / H)
        'END';
        'IF' I < N 'THEN'
        'BEGIN' S:= MATTAM(I1 + 1, N, I, I, A, A);
            'IF' S < MACHTOL 'THEN' B[I]:= A[I,I1] 'ELSE'
            'BEGIN' F:= A[I,I1]; S:= F * F + S;
                B[I]:= G:= 'IF' F < 0 'THEN' SQRT(S) 'ELSE' - SQRT(S);
                H:= F * G - S; A[I,I1]:= F - G;
                'FOR' J:= I1 'STEP' 1 'UNTIL' M 'DO'
                ELMROW(I1, N, J, I, A, A, MATTAM(I1, N, I, J, A, A) /
                H)
            'END'
        'END'
    'END'
'END' HSHREABID

        ;'EOP'
