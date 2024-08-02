'CODE' 34241;
    'PROCEDURE' ERBELM(N, AUX, NRMINV); 'VALUE' N, NRMINV;
    'INTEGER' N; 'REAL' NRMINV;
    'ARRAY' AUX;
    'BEGIN' 'REAL' AID, EPS;
        EPS:= AUX[0]; AID:= (1.06 * EPS * (.75 * N + 4.5) * N ** 2
        * AUX[7] + AUX[5] * AUX[6]) * NRMINV;
        AUX[11]:= 'IF' 2 * AID >= (1 - EPS) 'THEN' - 1 'ELSE'
        AID / (1 - 2 * AID); AUX[9]:= NRMINV
    'END' ERBELM;
        'EOP'
