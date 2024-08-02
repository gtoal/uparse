'CODE' 34187;
    'COMMENT' MCA 2417;
    'INTEGER' 'PROCEDURE' REAEIG3(A, N, EM, VAL, VEC); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, EM, VAL, VEC;
    'BEGIN' 'INTEGER' I; 'REAL' S;
        'INTEGER' 'ARRAY' INT, INT0[1:N]; 'ARRAY' D[1:N];

        EQILBR(A, N, EM, D, INT0); TFMREAHES(A, N, EM, INT);
        I:= REAEIG3:= REAQRI(A, N, EM, VAL, VEC);
        'IF' I = 0 'THEN'
        'BEGIN' BAKREAHES2(A, N, 1, N, INT, VEC);
            BAKLBR(N, 1, N, D, INT0, VEC); REASCL(VEC, N, 1, N)
        'END'
    'END' REAEIG3;
        'EOP'
