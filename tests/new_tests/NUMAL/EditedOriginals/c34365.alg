'CODE' 34365;
    'PROCEDURE' BAKHRMTRI(A, N, N1, N2, VECR, VECI, TR, TI);
    'VALUE' N, N1, N2; 'INTEGER' N, N1, N2;
     'ARRAY' A, VECR, VECI, TR, TI;
    'BEGIN' 'INTEGER' I, J, R, RM1;
        'REAL' C, S, T, QR, QI;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'FOR' J:= N1 'STEP' 1 'UNTIL' N2 'DO' VECI[I,J]:= 0; C:= 1;
        S:= 0;
        'FOR' J:= N - 1 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' COMMUL(C, S, TR[J], TI[J], C, S);
            COMROWCST(N1, N2, J, VECR, VECI, C, S)
        'END' J;
        RM1:= 2;
        'FOR' R:= 3 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' T:= A[R,R]; 'IF' T > 0 'THEN'
            'FOR' J:= N1 'STEP' 1 'UNTIL' N2 'DO'
            'BEGIN' QR:= (TAMMAT(1, RM1, R, J, A, VECR) -
                MATMAT(1, RM1, R, J, A, VECI)) / T;
                QI:= (TAMMAT(1, RM1, R, J, A, VECI) +
                MATMAT(1, RM1, R, J, A, VECR)) / T;
                ELMCOL(1, RM1, J, R, VECR, A, - QR);
                ELMCOLROW(1, RM1, J, R, VECR, A, - QI);
                ELMCOLROW(1, RM1, J, R, VECI, A, QR);
                ELMCOL(1, RM1, J, R, VECI, A, - QI)
            'END';
            RM1:= R;
        'END' R
    'END' BAKHRMTRI

        ;'EOP'
