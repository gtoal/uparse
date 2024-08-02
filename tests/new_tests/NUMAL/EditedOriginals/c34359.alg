'CODE' 34359;
    'REAL' 'PROCEDURE' COMEUCNRM(AR, AI, LW, N); 'VALUE' N, LW;
    'INTEGER' N, LW; 'ARRAY' AR, AI;
    'BEGIN' 'INTEGER' I, L;
        'REAL' R;
        R:= 0;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' L:= 'IF' I > LW 'THEN' I - LW 'ELSE' 1;
            R:= MATTAM(L, N, I, I, AR, AR) + MATTAM(L, N, I,
            I, AI, AI) + R;
        'END';
        COMEUCNRM:= SQRT(R)
    'END' COMEUCNRM;
        'EOP'
