'CODE' 31049;
'PROCEDURE' ALLORTPOLSYM(N,X,C)RESULTS:(P);
'VALUE' N,X; 'INTEGER' N; 'REAL' X; 'ARRAY' C,P;
'IF' N=0 'THEN' P[0]:=1.0 'ELSE'
'BEGIN'
     'INTEGER' K; 'REAL' R,S,H;
     R:=P[1]:=X; S:=P[0]:=1.0;
     'FOR' K:=2 'STEP' 1 'UNTIL' N 'DO'
     'BEGIN'
          H:=R;
          P[K]:=R:=X*R-C[K-1]*S;
          S:=H
     'END';
'END' ALLORTPOLSYM;
        'EOP'
