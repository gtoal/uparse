'CODE' 34262;
'PROCEDURE' PRETFMMAT(A, M, N, D);
'VALUE' M, N; 'INTEGER' M, N; 'ARRAY' A, D;
'BEGIN' 'INTEGER' I, I1, J;
    'REAL' G, H;

    'FOR' I:= N 'STEP' - 1 'UNTIL' 1 'DO'
    'BEGIN' I1:= I + 1; G:= D[I]; H:= G * A[I,I];
        'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO' A[I,J]:= 0;
        'IF' H < 0 'THEN'
        'BEGIN' 'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO'
            ELMCOL(I, M, J, I, A, A, TAMMAT(I1, M, I, J, A, A) / H);
            'FOR' J:= I 'STEP' 1 'UNTIL' M 'DO' A[J,I]:= A[J,I] / G
        'END'
        'ELSE'
        'FOR' J:= I 'STEP' 1 'UNTIL' M 'DO' A[J,I]:= 0;
        A[I,I]:= A[I,I] + 1
    'END'
'END' PRETFMMAT;
        'EOP'
