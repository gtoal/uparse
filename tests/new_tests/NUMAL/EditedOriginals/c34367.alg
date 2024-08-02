'CODE' 34367;
    'PROCEDURE' BAKCOMHES(AR, AI, TR, TI, DEL, VR, VI, N, N1, N2);
    'VALUE' N, N1, N2; 'INTEGER' N, N1, N2;
     'ARRAY' AR, AI, TR, TI, DEL, VR, VI;
    'BEGIN' 'INTEGER' I, R, RM1;
        'REAL' H;
        'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO' COMROWCST(N1, N2, I, VR,
        VI, TR[I], TI[I]); R:= N - 1;
        'FOR' RM1:= N - 2 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' H:= DEL[RM1];
            'IF' H > 0 'THEN' HSHCOMPRD(R, N, N1, N2, RM1, VR, VI,
            AR, AI, H); R:= RM1
        'END'
    'END' BAKCOMHES;
        'EOP'
