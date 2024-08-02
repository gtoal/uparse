'CODE' 34400;
    'PROCEDURE' CHLINV2(A, N); 'VALUE' N; 'INTEGER' N; 'ARRAY' A;
    'BEGIN' 'REAL' R; 'INTEGER' I, J, I1;
        'ARRAY' U[1:N];

        'FOR' I:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' R:= 1 / A[I,I]; I1:= I + 1;
            DUPVECROW(I1, N, I, U, A);
            'FOR' J:= N 'STEP' - 1 'UNTIL' I1 'DO' A[I,J]:=
            - (TAMVEC(I1, J, J, A, U) + MATVEC(J + 1, N, J, A, U)) * R;
            A[I,I]:= (R - MATVEC(I1, N, I, A, U)) * R
        'END'
    'END' CHLINV2;
        'EOP'
