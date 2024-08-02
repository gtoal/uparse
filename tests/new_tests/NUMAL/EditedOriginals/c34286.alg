'CODE' 34286;
'PROCEDURE' PSDINVSVD(U, VAL, V, M, N, EM);
'VALUE' M, N; 'INTEGER' M, N; 'ARRAY' U, VAL, V, EM;
'BEGIN' 'INTEGER' I, J;
    'REAL' MIN, VALI;
    'ARRAY' X[1:N];
    MIN:= EM[6];
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    'IF' VAL[I] > MIN 'THEN'
    'BEGIN' VALI:= 1 / VAL[I];
        'FOR' J:= 1 'STEP' 1 'UNTIL' M 'DO' U[J,I]:= U[J,I] * VALI
    'END'
    'ELSE' 'FOR' J:= 1 'STEP' 1 'UNTIL' M 'DO' U[J,I]:= 0;
    'FOR' I:= 1 'STEP' 1 'UNTIL' M 'DO'
    'BEGIN' 'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' X[J]:= U[I,J];
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        U[I,J]:= MATVEC(1, N, J, V, X)
    'END'
'END' PSDINVSVD;
        'EOP'
