'CODE' 31012;
    'PROCEDURE' INIMATD(LR, UR, SHIFT, A, X); 'VALUE' LR,UR,SHIFT,X;
    'INTEGER' LR,UR,SHIFT; 'REAL' X; 'ARRAY' A;
    'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO' A[LR, LR + SHIFT]:= X;
        'EOP'
