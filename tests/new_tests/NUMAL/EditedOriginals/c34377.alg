'CODE' 34377;
    'PROCEDURE' ELMCOMCOL(L,U,I,J,AR,AI,BR,BI,XR,XI);
    'VALUE' L,U,I,J,XR,XI;
    'INTEGER' L,U,I,J;'REAL' XR,XI;'ARRAY' AR,AI,BR,BI;
    'BEGIN'
        ELMCOL(L,U,I,J,AR,BR,XR);
        ELMCOL(L,U,I,J,AR,BI,-XI);
        ELMCOL(L,U,I,J,AI,BR,XI);
        ELMCOL(L,U,I,J,AI,BI,XR)
    'END' ELMCOMCOL;
        'EOP'
