'CODE' 34182;
    'COMMENT' MCA 2412;
    'INTEGER' 'PROCEDURE' REAEIGVAL(A, N, EM, VAL); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, EM, VAL;
    'BEGIN' 'INTEGER' I, J; 'REAL' R;
        'ARRAY' D[1:N]; 'INTEGER' 'ARRAY' INT, INT0[1:N];

        EQILBR(A, N, EM, D, INT0); TFMREAHES(A, N, EM, INT);
        J:= REAEIGVAL:= REAVALQRI(A, N, EM, VAL);
        'FOR' I:= J + 1 'STEP' 1 'UNTIL' N 'DO'
        'FOR' J:= I + 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' 'IF' VAL[J] > VAL[I] 'THEN'
            'BEGIN' R:= VAL[I]; VAL[I]:= VAL[J]; VAL[J]:= R 'END'
        'END'
    'END' REAEIGVAL

        ;'EOP'
