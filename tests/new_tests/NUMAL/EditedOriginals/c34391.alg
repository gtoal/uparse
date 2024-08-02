'CODE' 34391;
    'PROCEDURE' CHLSOL1(A, N, B); 'VALUE' N; 'INTEGER' N; 'ARRAY' A, B;
    'BEGIN' 'INTEGER' I, II;

        II:= 0;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' II:= II + I;
            B[I]:= (B[I] - VECVEC(1, I - 1, II - I, B, A)) / A[II]
        'END';
        'FOR' I:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' B[I]:= (B[I] -
                SEQVEC(I + 1, N, II + I, 0, A, B)) / A[II];
            II:= II - I
        'END'
    'END' CHLSOL1;
        'EOP'
