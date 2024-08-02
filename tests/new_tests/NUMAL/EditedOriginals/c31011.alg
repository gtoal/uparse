'CODE' 31011;
    'PROCEDURE' INIMAT(LR, UR, LC, UC, A, X); 'VALUE' LR,UR,LC,UC,X;
    'INTEGER' LR,UR,LC,UC; 'REAL' X; 'ARRAY' A;
    'BEGIN' 'INTEGER' J;

        'FOR' LR:= LR 'STEP' 1 'UNTIL' UR 'DO'
        'FOR' J:= LC 'STEP' 1 'UNTIL' UC 'DO' A[LR, J]:= X
    'END' INIMAT;
        'EOP'
