'CODE' 34210;
    'PROCEDURE' LINEMIN(N, X, D, ND, ALFA, G, FUNCT, F0, F1, DF0, DF1,
    EVLMAX, STRONGSEARCH, IN); 'VALUE' N, ND, F0, DF0, STRONGSEARCH;
    'INTEGER' N, EVLMAX; 'BOOLEAN' STRONGSEARCH;
    'REAL' ND, ALFA, F0, F1, DF0, DF1;
    'ARRAY' X, D, G, IN;
    'REAL' 'PROCEDURE' FUNCT;
    'BEGIN' 'INTEGER' I, EVL;
        'BOOLEAN' NOTININT;
        'REAL' F,OLDF,DF,OLDDF,MU,ALFA0,Q,W,Y,Z,RELTOL,ABSTOL
        ,EPS, AID;
        'ARRAY' X0[1:N];

        RELTOL:= IN[1]; ABSTOL:= IN[2]; MU:= IN[3]; EVL:= 0;
        ALFA0:= 0; OLDF:= F0; OLDDF:= DF0; Y:= ALFA; NOTININT:= 'TRUE';
        DUPVEC(1, N, 0, X0, X);
        EPS:= (SQRT(VECVEC(1, N, 0, X, X)) * RELTOL + ABSTOL) / ND;
        Q:= (F1 - F0) / (ALFA * DF0);
    INT: 'IF' NOTININT 'THEN' NOTININT:= DF1 < 0 'AND' Q > MU;
        AID:= ALFA; 'IF' DF1 >= 0 'THEN'
        'BEGIN' Z:= 3 * (OLDF - F1) / ALFA + OLDDF + DF1;
            W:= SQRT(Z ** 2 - OLDDF * DF1);
            ALFA:= ALFA * (1 - (DF1 + W - Z) / (DF1 - OLDDF + W * 2));
            'IF' ALFA < EPS 'THEN' ALFA:= EPS 'ELSE'
            'IF' AID - ALFA < EPS 'THEN' ALFA:= AID - EPS
        'END' CUBIC INTERPOLATION
        'ELSE' 'IF' NOTININT 'THEN'
        'BEGIN' ALFA0:= ALFA:= Y; OLDDF:= DF1; OLDF:= F1 'END'
        'ELSE' ALFA:= 0.5 * ALFA; Y:= ALFA + ALFA0;
        DUPVEC(1, N, 0, X, X0); ELMVEC(1, N, 0, X, D, Y);
        EPS:= (SQRT(VECVEC(1, N, 0, X, X)) * RELTOL + ABSTOL) / ND;
        F:= FUNCT(N, X, G); EVL:= EVL +1 ; DF:= VECVEC(1, N, 0, D, G);
        Q:= (F - F0) / (Y * DF0);
        'IF' ('IF' NOTININT 'OR' STRONGSEARCH 'THEN' 'TRUE' 'ELSE'
        Q < MU 'OR' Q > 1 - MU) 'AND' EVL < EVLMAX 'THEN'
        'BEGIN' 'IF' NOTININT 'OR' DF > 0 'OR' Q < MU 'THEN'
            'BEGIN' DF1:= DF; F1:= F 'END'
            'ELSE'
            'BEGIN' ALFA0:= Y; ALFA:= AID - ALFA; OLDDF:= DF; OLDF:= F
            'END';
            'IF' ALFA > EPS * 2 'THEN' 'GOTO' INT
        'END';
        ALFA:= Y; EVLMAX:= EVL; DF1:= DF; F1:= F
    'END' LINEMIN

        ;'EOP'
