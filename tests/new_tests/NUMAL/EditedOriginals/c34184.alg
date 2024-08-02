'CODE' 34184;
    'COMMENT' MCA 2414;
    'INTEGER' 'PROCEDURE' REAEIG1(A, N, EM, VAL, VEC); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, EM, VAL, VEC;
    'BEGIN' 'INTEGER' I, K, MAX, J, L;
        'REAL' RESIDU, R, MACHTOL;
        'ARRAY' D, V[1:N], B[1:N,1:N];
        'INTEGER' 'ARRAY' INT, INT0[1:N];

        RESIDU:= 0; MAX:= 0; EQILBR(A, N, EM, D, INT0);
        TFMREAHES(A, N, EM, INT);
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'FOR' J:= ('IF' I = 1 'THEN' 1 'ELSE' I - 1)
        'STEP' 1 'UNTIL' N 'DO' B[I,J]:= A[I,J];
        K:= REAEIG1:= REAVALQRI(B, N, EM, VAL);
        'FOR' I:= K + 1 'STEP' 1 'UNTIL' N 'DO'
        'FOR' J:= I + 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' 'IF' VAL[J] > VAL[I] 'THEN'
            'BEGIN' R:= VAL[I]; VAL[I]:= VAL[J]; VAL[J]:= R 'END'
        'END';
        MACHTOL:= EM[0] * EM[1];
        'FOR' L:= K + 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' 'IF' L > 1 'THEN'
            'BEGIN' 'IF' VAL[L - 1] - VAL[L] < MACHTOL 'THEN'
                VAL[L]:= VAL[L - 1] - MACHTOL
            'END';
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'FOR' J:= ('IF' I = 1 'THEN' 1 'ELSE' I - 1)
            'STEP' 1 'UNTIL' N 'DO' B[I,J]:= A[I,J];
            REAVECHES(B, N, VAL[L], EM, V);
            'IF' EM[7] > RESIDU 'THEN' RESIDU:= EM[7];
            'IF' EM[9] > MAX 'THEN' MAX:= EM[9];
            'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' VEC[J,L]:= V[J]
        'END';
        EM[7]:= RESIDU; EM[9]:= MAX;
        BAKREAHES2(A, N, K + 1, N, INT, VEC);
        BAKLBR(N, K + 1, N, D, INT0, VEC);
        REASCL(VEC, N, K + 1, N)
    'END' REAEIG1

        ;'EOP'
