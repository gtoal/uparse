'CODE' 36402;
'PROCEDURE' ORTHOG(N,LC,UC,X);'VALUE' N,LC,UC;
'INTEGER' N,LC,UC;'ARRAY' X;
'BEGIN' 'INTEGER' I,J,K; 'REAL' NORMX;
    'FOR' J:=LC 'STEP' 1 'UNTIL' UC 'DO'
    'BEGIN' NORMX:=SQRT(TAMMAT(1,N,J,J,X,X));
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO' X[I,J]:=X[I,J]/NORMX;
        'FOR' K:=J+1 'STEP' 1 'UNTIL' UC 'DO'
        ELMCOL(1,N,K,J,X,X,-TAMMAT(1,N,K,J,X,X))
    'END'
'END' ORTHOG;
        'EOP'
