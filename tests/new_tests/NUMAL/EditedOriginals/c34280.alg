'CODE' 34280;
'PROCEDURE' SOLSVDOVR(U, VAL, V, M, N, X, EM);
'VALUE' M, N; 'INTEGER' M, N; 'ARRAY' U, VAL, V, X, EM;
'BEGIN' 'INTEGER' I;
    'REAL' MIN;
    'ARRAY' X1[1:N];
    MIN:= EM[6];
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    X1[I]:= 'IF' VAL[I] <= MIN 'THEN' 0 'ELSE' TAMVEC(1, M, I, U, X) /
    VAL[I];
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    X[I]:= MATVEC(1, N, I, V, X1)
'END' SOLSVDOVR;
        'EOP'
