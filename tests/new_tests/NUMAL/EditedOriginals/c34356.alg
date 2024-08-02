'CODE' 34356;
    'PROCEDURE' HSHCOMPRD(I, II, L, U, J, AR, AI, BR, BI, T);
    'VALUE' I, II, L, U, J, T; 'INTEGER' I, II, L, U, J; 'REAL' T;
    'ARRAY' AR, AI, BR, BI;
    'BEGIN'
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' ELMCOMCOL(I, II, L, J, AR, AI,
    BR, BI, ( - TAMMAT(I, II, J, L, BR, AR) - TAMMAT(I, II, J,
    L, BI, AI)) / T, (TAMMAT(I, II, J, L, BI, AR) - TAMMAT(I,
    II, J, L, BR, AI)) / T);
    'END' HSHCOMPRD;
        'EOP'
