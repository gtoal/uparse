'CODE' 34357;
    'PROCEDURE' ROTCOMCOL(L, U, I, J, AR, AI, CR, CI, S);
    'VALUE' L, U, I, J, CR, CI, S; 'INTEGER' L, U, I, J;
    'REAL' CR, CI, S; 'ARRAY' AR, AI;
    'BEGIN' 'REAL' ARLI, AILI, ARLJ, AILJ;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' ARLI:= AR[L,I]; AILI:= AI[L,I]; ARLJ:= AR[L,J];
            AILJ:= AI[L,J];
            AR[L,I]:= CR * ARLI + CI * AILI - S * ARLJ;
            AI[L,I]:= CR * AILI - CI * ARLI - S * AILJ;
            AR[L,J]:= CR * ARLJ - CI * AILJ + S * ARLI;
            AI[L,J]:= CR * AILJ + CI * ARLJ + S * AILI;
        'END'
    'END' ROTCOMCOL;
        'EOP'
