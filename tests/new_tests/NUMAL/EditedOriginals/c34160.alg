'CODE' 34160;
    'INTEGER' 'PROCEDURE' QRIVALSYMTRI(D, BB, N, EM); 'VALUE' N;
    'INTEGER' N; 'ARRAY' D, BB, EM;
    'BEGIN' 'INTEGER' I, I1, LOW, OLDLOW, N1, COUNT, MAX;
        'REAL' BBTOL, BBMAX, BBI, BBN1, MACHTOL, DN, DELTA, F, NUM,
        SHIFT, G, H, T, P, R, S, C, OLDG;
        BBTOL:= (EM[2] * EM[1]) ** 2; MACHTOL:= EM[0] * EM[1];
        MAX:= EM[4]; BBMAX:= 0; COUNT:= 0; OLDLOW:= N;
        'FOR' N1:= N - 1 'WHILE' N > 0 'DO'
        'BEGIN'
            'FOR' I:= N, I - 1 'WHILE' ('IF' I >= 1 'THEN'
            BB[I] > BBTOL 'ELSE' 'FALSE') 'DO' LOW:= I;
            'IF' LOW > 1 'THEN' 'BEGIN' 'IF' BB[LOW-1] > BBMAX 'THEN'
            BBMAX:= BB[LOW-1] 'END';
            'IF' LOW = N 'THEN' N:= N1 'ELSE'
            'BEGIN' DN:= D[N]; DELTA:= D[N1] - DN;
                BBN1:= BB[N1];
                'IF' ABS(DELTA) < MACHTOL 'THEN' R:= SQRT(BBN1) 'ELSE'
                'BEGIN'
                    F:= 2 / DELTA; NUM:= BBN1 * F;
                    R:= -NUM / (SQRT(NUM * F + 1) + 1)
                'END';
                'IF' LOW = N1 'THEN'
                'BEGIN' D[N]:= DN + R; D[N1]:= D[N1] - R; N:= N - 2
                'END'
                'ELSE'
                'BEGIN' COUNT:= COUNT + 1;
                    'IF' COUNT > MAX 'THEN' 'GOTO' END;
                    'IF' LOW < OLDLOW 'THEN'
                    'BEGIN' SHIFT:= 0; OLDLOW:= LOW 'END'
                    'ELSE'  SHIFT:= DN + R;
                    H:= D[LOW] - SHIFT;
                    'IF' ABS(H) < MACHTOL 'THEN' H:= 'IF' H <= 0 'THEN'
                    -MACHTOL 'ELSE' MACHTOL;
                    G:= H; T:= G * H;
                    BBI:= BB[LOW]; P:= T + BBI; I1:= LOW;
                    'FOR' I:= LOW + 1 'STEP' 1 'UNTIL' N 'DO'
                    'BEGIN' S:= BBI / P; C:= T / P;
                        H:= D[I] - SHIFT - BBI / H;
                        'IF' ABS(H) < MACHTOL 'THEN' H:= 'IF' H <= 0
                        'THEN' -MACHTOL 'ELSE' MACHTOL;
                        OLDG:= G; G:= H * C; T:= G * H;
                        D[I1]:= OLDG - G + D[I];
                        BBI:= 'IF' I = N 'THEN' 0 'ELSE' BB[I];
                        P:= T + BBI; BB[I1]:= S * P; I1:= I
                    'END';
                    D[N]:= G + SHIFT
                'END' QRSTEP
            'END'
        'END';
     END: EM[3]:= SQRT(BBMAX); EM[5]:= COUNT; QRIVALSYMTRI:= N
    'END' QRIVALSYMTRI

         ;'EOP'
