'CODE' 34240;
    'REAL' 'PROCEDURE' ONENRMINV(A, N); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A;
    'BEGIN' 'INTEGER' I, J;
        'REAL' NORM, MAX, AID;
        'ARRAY' Y[1:N];
        NORM:= 0;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' Y[I]:= 'IF' I < J
            'THEN' 0 'ELSE' 'IF' I = J 'THEN' 1 / A[I,I] 'ELSE'
            - MATVEC(J, I - 1, I, A, Y) / A[I,I];
            MAX:= 0;
            'FOR' I:= N 'STEP' - 1 'UNTIL' 1 'DO'
            'BEGIN' AID:= Y[I]:= Y[I] - MATVEC(I + 1, N, I, A, Y);
                MAX:= MAX + ABS(AID)
            'END';
            'IF' NORM < MAX 'THEN' NORM:= MAX
        'END';
        ONENRMINV:= NORM
    'END' ONENRMINV;
        'EOP'
