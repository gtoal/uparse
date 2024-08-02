'CODE' 34354;
    'PROCEDURE' COMMATVEC(L, U, I, AR, AI, BR, BI, RR, RI);
    'VALUE' L, U, I; 'INTEGER' L, U, I; 'REAL' RR, RI;
    'ARRAY' AR, AI, BR, BI;
    'BEGIN'
        'REAL' MV;
        MV:= MATVEC(L, U, I, AR, BR) - MATVEC(L, U, I, AI, BI);
        RI:= MATVEC(L, U, I, AI, BR) + MATVEC(L, U, I, AR, BI);
        RR:=MV
    'END' COMMATVEC;
        'EOP'
