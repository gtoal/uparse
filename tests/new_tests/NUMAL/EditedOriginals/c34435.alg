'CODE'34435;
    'REAL' 'PROCEDURE' MININDER(X, Y, FX, DFX, TOLX);
    'REAL' X, Y, FX, DFX, TOLX;
    'BEGIN' 'COMMENT' THE FUNCTION IS APPROXIMATED BY A CUBIC AS
        GIVEN BY DAVIDON, 1958, THE STRUCTURE IS SIMILAR TO THE
        STRUCTURE OF THE PROGRAM GIVEN BY BRENT, 1973, THIS IS
        A REVISION OF 760407;

        'INTEGER' SGN;
        'REAL' A, B, C, FA, FB, FU, DFA, DFB, DFU, E, D, TOL, BA,
        Z, P, Q, S;

        'IF' X <= Y 'THEN'
        'BEGIN' A:= X; FA:= FX; DFA:= DFX;
            B:= X:= Y; FB:= FX; DFB:= DFX
        'END' 'ELSE'
        'BEGIN' B:= X; FB:= FX; DFB:= DFX;
            A:= X:= Y; FA:= FX; DFA:= DFX
        'END';
        C:= (3 - SQRT(5)) / 2; D:= B - A; E:= D * 2; Z:= E * 2;
    LOOP: BA:= B - A; TOL:= TOLX; 'IF' BA >= TOL * 3 'THEN'
        'BEGIN' 'IF' ABS(DFA) <= ABS(DFB) 'THEN'
            'BEGIN' X:=A; SGN:= 1 'END' 'ELSE'
            'BEGIN' X:= B; SGN:= -1 'END';
            'IF' DFA <= 0 'AND' DFB >= 0 'THEN'
            'BEGIN' Z:= (FA - FB) * 3 / BA + DFA + DFB;
                S:= SQRT(Z ** 2 - DFA * DFB);
                P:= 'IF' SGN = 1 'THEN' DFA - S - Z 'ELSE'
                DFB + S - Z; P:= P * BA;
                Q:= DFB - DFA + S * 2; Z:= E; E:= D;
                D:= 'IF' ABS(P) <= ABS(Q) * TOL 'THEN' TOL * SGN
                'ELSE' -P / Q
            'END' 'ELSE' D:= BA;
            'IF' ABS(D) >= ABS(Z * 0.5) 'OR' ABS(D) > BA * 0.5 'THEN'
            'BEGIN' E:= BA; D:= C * BA * SGN 'END';
            X:= X + D; FU:= FX; DFU:= DFX;
            'IF' DFU >= 0 'OR' (FU >= FA 'AND' DFA <= 0) 'THEN'
            'BEGIN' B:= X; FB:= FU; DFB:= DFU 'END' 'ELSE'
            'BEGIN' A:= X; FA:= FU; DFA:= DFU 'END';
            'GOTO' LOOP
        'END'; 'IF' FA <= FB 'THEN'
        'BEGIN' X:= A; Y:= B; MININDER:= FA 'END' 'ELSE'
        'BEGIN' X:= B; Y:= A; MININDER:= FB 'END'
    'END' MININDER;
        'EOP'
