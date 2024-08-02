'CODE' 34401;
    'PROCEDURE' CHLINV1(A, N); 'VALUE' N; 'INTEGER' N; 'ARRAY' A;
    'BEGIN' 'INTEGER' I, II, I1, J, IJ; 'REAL' R;
        'ARRAY' U[1:N];

        II:= (N + 1) * N // 2;
        'FOR' I:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' R:= 1 / A[II]; I1:= I + 1; IJ:= II + I;
            'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' U[J]:= A[IJ]; IJ:= IJ + J 'END';
            'FOR' J:= N 'STEP' - 1 'UNTIL' I1 'DO'
            'BEGIN' IJ:= IJ - J; A[IJ]:= -SYMMATVEC(I1, N, J, A, U) * R
            'END';
            A[II]:= (R - SEQVEC(I1, N, II + I, 0, A, U)) * R;
            II:= II - I
        'END'
    'END' CHLINV1

        ;'EOP'
