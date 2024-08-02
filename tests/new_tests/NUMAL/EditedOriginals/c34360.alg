'CODE' 34360;
    'PROCEDURE' SCLCOM(AR, AI, N, N1, N2); 'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' AR, AI;
    'BEGIN' 'INTEGER' I, J, K;
        'REAL' S, R;
        'FOR' J:= N1 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN' S:= 0;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' R:= AR[I,J] ** 2 + AI[I,J] ** 2; 'IF' R > S 'THEN'
                'BEGIN' S:= R; K:= I 'END'
            'END';
            'IF' S ^= 0 'THEN' COMCOLCST(1, N, J, AR, AI, AR[K,J] /
            S, - AI[K,J] / S)
        'END'
    'END' SCLCOM;
        'EOP'
