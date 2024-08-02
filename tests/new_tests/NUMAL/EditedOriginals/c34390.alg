'CODE' 34390;
    'PROCEDURE' CHLSOL2(A, N, B); 'VALUE' N; 'INTEGER' N; 'ARRAY' A, B;
    'BEGIN' 'INTEGER' I;

        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        B[I]:= (B[I] - TAMVEC(1, I - 1, I, A, B)) / A[I,I];
        'FOR' I:= N 'STEP' - 1 'UNTIL' 1 'DO'
        B[I]:= (B[I] - MATVEC(I + 1, N, I, A, B)) / A[I,I]
    'END' CHLSOL2;
        'EOP'
