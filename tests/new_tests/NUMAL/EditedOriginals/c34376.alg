'CODE' 34376;
    'PROCEDURE' ELMCOMVECCOL(L,U,J,AR,AI,BR,BI,XR,XI);
    'VALUE' L,U,J,XR,XI;
    'INTEGER' L,U,J;'REAL' XR,XI;'ARRAY' AR,AI,BR,BI;
    'BEGIN'
        ELMVECCOL(L,U,J,AR,BR,XR);
        ELMVECCOL(L,U,J,AR,BI,-XI);
        ELMVECCOL(L,U,J,AI,BR,XI);
        ELMVECCOL(L,U,J,AI,BI,XR)
    'END' ELMCOMVECCOL;
        'EOP'
