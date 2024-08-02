'CODE' 35061;
'REAL' 'PROCEDURE' GAMMA(X); 'VALUE' X; 'REAL' X;
'BEGIN' 'REAL' Y, S, F, G, ODD, EVEN;
    'BOOLEAN' INV;
    'IF' X < .5 'THEN'
    'BEGIN' Y:= X - ENTIER(X / 2) * 2; S:= 3.14159 26535 8979;
        'IF' Y >= 1 'THEN' 'BEGIN' S:= - S; Y:= 2 - Y 'END';
        'IF' Y >= .5 'THEN' Y:= 1 - Y; INV:= 'TRUE'; X:= 1 - X;
        F:= S / SIN(3.14159 26535 8979 * Y)
    'END'
    'ELSE' INV:= 'FALSE';
    'IF' X > 22 'THEN' G:= EXP(LOG GAMMA(X)) 'ELSE'
    'BEGIN' S:= 1;
    NEXT: 'IF' X > 1.5 'THEN'
        'BEGIN' X:= X - 1; S:= S * X; 'GOTO' NEXT 'END';
        G:= S / RECIP GAMMA(1 - X, ODD, EVEN)
    'END';
    GAMMA:= 'IF' INV 'THEN' F / G 'ELSE' G
'END' GAMMA

        ;'EOP'
