'CODE' 34366;
    'PROCEDURE' HSHCOMHES(AR, AI, N, EM, B, TR, TI, DEL); 'VALUE' N;
    'INTEGER' N; 'ARRAY' AR, AI, EM, B, TR, TI, DEL;
    'BEGIN' 'INTEGER' R, RM1, I, J, NM1;
        'REAL' TOL, T, XR, XI;
        NM1:= N - 1; TOL:= (EM[0] * EM[1]) ** 2; RM1:= 1;
        'FOR' R:= 2 'STEP' 1 'UNTIL' NM1 'DO'
        'BEGIN' 'IF' HSHCOMCOL(R, N, RM1, AR, AI, TOL, B[RM1],
            TR[R], TI[R], T) 'THEN'
            'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' XR:= (MATMAT(R, N, I, RM1, AI, AI) -
                    MATMAT(R, N, I, RM1, AR, AR)) / T;
                    XI:= ( - MATMAT(R, N, I, RM1, AR, AI) -
                    MATMAT(R, N, I, RM1, AI, AR)) / T;
                    ELMROWCOL(R, N, I, RM1, AR, AR, XR);
                    ELMROWCOL(R, N, I, RM1, AR, AI, XI);
                    ELMROWCOL(R, N, I, RM1, AI, AR, XI);
                    ELMROWCOL(R, N, I, RM1, AI, AI, - XR)
                'END';
                HSHCOMPRD(R, N, R, N, RM1, AR, AI, AR, AI, T);
            'END';
            DEL[RM1]:= T; RM1:= R
        'END' FORR;
        'IF' N > 1 'THEN' CARPOL(AR[N,NM1], AI[N,NM1], B[NM1],
        TR[N], TI[N]); RM1:= 1; TR[1]:= 1; TI[1]:= 0;
        'FOR' R:= 2 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' COMMUL(TR[RM1], TI[RM1], TR[R], TI[R], TR[R],
            TI[R]); COMCOLCST(1, RM1, R, AR, AI, TR[R], TI[R]);
            COMROWCST(R + 1, N, R, AR, AI, TR[R], - TI[R]);
            RM1:= R
        'END';
    'END' HSHCOMHES

        ;'EOP'
