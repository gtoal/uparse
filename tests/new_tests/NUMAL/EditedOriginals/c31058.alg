'CODE' 31058;
'REAL' 'PROCEDURE' SUMORTPOLSYM(N,X,C,A);
'VALUE' N,X; 'INTEGER' N; 'REAL' X; 'ARRAY' C,A;
'IF' N=0 'THEN' SUMORTPOLSYM:=A[0] 'ELSE'
'BEGIN'
     'INTEGER' K; 'REAL' H,R,S;
     R:=A[N]; S:=0;
     'FOR' K:=N-1 'STEP' -1 'UNTIL' 1 'DO'
     'BEGIN'
          H:=R;
          R:=A[K]+X*R+S;
          S:= -C[K]*H
     'END';
     SUMORTPOLSYM:=A[0]+X*R+S
'END' SUMORTPOLSYM;
        'EOP'
