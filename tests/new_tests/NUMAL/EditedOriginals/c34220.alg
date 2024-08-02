'CODE' 34220;
    'PROCEDURE' CONJ GRAD( MATVEC, X, R, L, N, GO ON, ITERATE, NORM2);
    'VALUE' L, N; 'PROCEDURE' MATVEC; 'ARRAY' X, R; 'BOOLEAN' GO ON;
    'INTEGER' L, N, ITERATE; 'REAL' NORM2;
    'BEGIN' 'ARRAY' P, AP[ L: N];
        'INTEGER' I;
        'REAL'  A, B, PRR, RRP;
        'FOR' ITERATE:= 0, ITERATE + 1 'WHILE' GO ON 'DO'
        'BEGIN' 'IF' ITERATE = 0 'THEN'
            'BEGIN' MATVEC( X, P);
                'FOR' I:= L 'STEP' 1 'UNTIL' N 'DO'
                P[ I]:= R[ I]:= R[ I] - P[ I];
                PRR:= VECVEC( L, N, 0, R, R)
            'END' 'ELSE'
            'BEGIN' B:= RRP / PRR; PRR:= RRP;
                'FOR' I:= L 'STEP' 1 'UNTIL' N 'DO'
                P[ I]:= R[ I] + B * P[ I]
            'END';
            MATVEC( P, AP);
            A:= PRR / VECVEC( L, N, 0, P, AP);
            ELMVEC( L, N, 0, X, P, A);
            ELMVEC( L, N, 0, R, AP, -A);
            NORM2:= RRP:= VECVEC( L, N, 0, R, R)
        'END'
    'END' CONJ GRAD;
        'EOP'
