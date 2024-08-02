'CODE' 34375;
    'INTEGER' 'PROCEDURE' EIGCOM(AR, AI, N, EM, VALR, VALI, VR, VI);
    'VALUE' N; 'INTEGER' N; 'ARRAY' AR, AI, EM, VALR, VALI, VR, VI;
    'BEGIN' 'INTEGER' I;
        'INTEGER' 'ARRAY' INT[1:N];
        'ARRAY' D, B, DEL, TR, TI[1:N];
        EQILBRCOM(AR, AI, N, EM, D, INT);
        EM[1]:= COMEUCNRM(AR, AI, N - 1, N);
        HSHCOMHES(AR, AI, N, EM, B, TR, TI, DEL);
        I:= EIGCOM:= QRICOM(AR, AI, B, N, EM, VALR, VALI, VR,
        VI); 'IF' I = 0 'THEN'
        'BEGIN' BAKCOMHES(AR, AI, TR, TI, DEL, VR, VI, N, 1, N);
            BAKLBRCOM(N, 1, N, D, INT, VR, VI);
            SCLCOM(VR, VI, N, 1, N)
        'END'
    'END' EIGCOM;
        'EOP'
