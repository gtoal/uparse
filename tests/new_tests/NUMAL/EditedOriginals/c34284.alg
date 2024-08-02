'CODE' 34284;
'PROCEDURE' HOMSOLSVD(U, VAL, V, M, N);
'VALUE' M, N; 'INTEGER' M, N; 'ARRAY' U, VAL, V;
'BEGIN' 'INTEGER' I, J;
    'REAL' X;

    'FOR' I:= N 'STEP' - 1 'UNTIL' 2 'DO'
    'FOR' J:= I - 1 'STEP' - 1 'UNTIL' 1 'DO'
    'IF' VAL[I] > VAL[J] 'THEN'
    'BEGIN' X:= VAL[I]; VAL[I]:= VAL[J]; VAL[J]:= X;
        ICHCOL(1, M, I, J, U); ICHCOL(1, N, I, J, V)
    'END'
'END' HOMSOLSVD;
        'EOP'
