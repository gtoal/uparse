'CODE' 34253;
    'PROCEDURE' ITISOLERB(A, LU, N, AUX, RI, CI, B); 'VALUE' N;
    'INTEGER' N;
    'ARRAY' A, LU, AUX, B; 'INTEGER' 'ARRAY' RI, CI;
    'BEGIN' 'INTEGER' I;
        'REAL' NRMSOL, NRMINV, NRMB, ALFA, TOLA, EPS;
        EPS:= AUX[0];
        NRMINV:= AUX[9]; TOLA:= AUX[5] * AUX[6]; NRMB:= NRMSOL:= 0;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' NRMB:= NRMB + ABS(B[I]);
        ITISOL(A, LU, N, AUX, RI, CI, B);
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        NRMSOL:= NRMSOL + ABS(B[I]);
        ALFA:= 1 - (1.06 * EPS * AUX[7] * (.75 * N + 4.5) * N ** 2
               + TOLA) * NRMINV;
        'IF' ALFA < EPS 'THEN' AUX[11]:= - 1 'ELSE'
        'BEGIN' ALFA:= ((AUX[13] + AUX[8] * NRMB) / NRMSOL + TOLA) *
                       NRMINV / ALFA;
            AUX[11]:= 'IF' 1 - ALFA < EPS 'THEN' - 1 'ELSE'
                      ALFA / (1 - ALFA)
        'END'
    'END' ITISOLERB;
        'EOP'
