'CODE' 35145;
'REAL' 'PROCEDURE' AIRYZEROS(N,D,ZAI,VAI);
'VALUE' N,D; 'INTEGER' N,D; 'ARRAY' ZAI,VAI;
'BEGIN' 'BOOLEAN' A, FOUND; 'INTEGER' I;
    'REAL' C,E,R,ZAJ,ZAK,VAJ,DAJ,KAJ,ZZ;

    A :=  D = 0 'OR' D = 2;
    R := 'IF' D = 0 'OR' D = 3 'THEN' -1.1780 97245 09617
                               'ELSE' -3.5342 91735 28852;
    'COMMENT'  R := 'IF' D = 0 'OR' D = 3 'THEN' -3 * PI / 8
                                          'ELSE' -9 * PI / 8;
    AIRY(0,ZAJ,VAJ,DAJ,KAJ,ZZ,'TRUE');
    'FOR' I := 1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' R := R + 4.7123 88980 38469; 'COMMENT' R := R + 3 * PI / 2;
        ZZ := R * R;
        ZAJ := 'IF' I = 1 'AND' D = 1 'THEN' -1.01879 297 'ELSE'
               'IF' I = 1 'AND' D = 2 'THEN' -1.17371 322 'ELSE'
               R ** 0.66666 66666 66667 * ( 'IF' A 'THEN'
               - ( 1 + ( 5/48 - ( 5/36 - ( 77125/82944 - (
               1080 56875 / 69 67296 - (16 23755 96875 / 3344 30208)
               /ZZ)/ZZ)/ZZ)/ZZ)/ZZ)
                                                   'ELSE'
               - ( 1 - ( 7/48 - ( 35/288 - ( 1 81223 / 2 07360 - (
               186 83371 / 12 44160 - ( 9 11458 84361 / 1911 02976 )
               /ZZ)/ZZ)/ZZ)/ZZ)/ZZ));
        'IF'  D <= 1 'THEN' AIRY(ZAJ,VAJ,DAJ,C,E,ZZ,'FALSE')
                     'ELSE' AIRY(ZAJ,C,E,VAJ,DAJ,ZZ,'FALSE');
        FOUND := ABS( 'IF' A 'THEN' VAJ 'ELSE' DAJ ) < @-12;
        'FOR' C := C 'WHILE' 'NOT' FOUND 'DO'
        'BEGIN' 'IF' A 'THEN'
            'BEGIN' KAJ := VAJ / DAJ;
                ZAK := ZAJ - KAJ * (1 + ZAJ * KAJ * KAJ)
            'END' 'ELSE'
            'BEGIN' KAJ := DAJ / (ZAJ * VAJ);
                ZAK := ZAJ - KAJ * (1 + KAJ * (KAJ * ZAJ + 1 / ZAJ))
            'END';
            'IF'  D <= 1 'THEN' AIRY(ZAK,VAJ,DAJ,C,E,ZZ,'FALSE')
                         'ELSE' AIRY(ZAK,C,E,VAJ,DAJ,ZZ,'FALSE');
            FOUND := ABS(ZAK - ZAJ) < @-14 * ABS(ZAK) 'OR'
                     ABS('IF' A 'THEN' VAJ 'ELSE' DAJ) < @-12;
            ZAJ := ZAK
        'END';
        VAI[I] := 'IF' A 'THEN' DAJ 'ELSE' VAJ;
        ZAI[I] := ZAJ;
    'END';
    AIRYZEROS := ZAI[N];
'END' AIRYZEROS;
        'EOP'
