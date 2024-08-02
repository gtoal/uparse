'CODE' 34358;
    'PROCEDURE' ROTCOMROW(L, U, I, J, AR, AI, CR, CI, S);
    'VALUE' L, U, I, J, CR, CI, S; 'INTEGER' L, U, I, J;
    'REAL' CR, CI, S; 'ARRAY' AR, AI;
    'BEGIN' 'REAL' ARIL, AIIL, ARJL, AIJL;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' ARIL:= AR[I,L]; AIIL:= AI[I,L]; ARJL:= AR[J,L];
            AIJL:= AI[J,L];
            AR[I,L]:= CR * ARIL + CI * AIIL + S * ARJL;
            AI[I,L]:= CR * AIIL - CI * ARIL + S * AIJL;
            AR[J,L]:= CR * ARJL - CI * AIJL - S * ARIL;
            AI[J,L]:= CR * AIJL + CI * ARJL - S * AIIL;
        'END'
    'END' ROTCOMROW;
        'EOP'
