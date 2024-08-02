'CODE' 31048;
'REAL' 'PROCEDURE' ORTPOLSYM(N,X,C);
'VALUE' N,X; 'INTEGER' N; 'REAL' X; 'ARRAY' C;
'IF' N=0 'THEN' ORTPOLSYM:=1.0 'ELSE'
'BEGIN'
     'INTEGER' K,L; 'REAL' R,S,H;
     R:=X; S:=1.0; L:=N-1;
     'FOR' K:=1 'STEP' 1 'UNTIL' L 'DO'
     'BEGIN'
          H:=R; R:=X*R-C[K]*S;
          S:=H
     'END';
     ORTPOLSYM:=R
'END' ORTPOLSYM;
        'EOP'
