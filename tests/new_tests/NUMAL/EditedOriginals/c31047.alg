'CODE' 31047;
'REAL' 'PROCEDURE' SUMORTPOL(N,X,B,C,A);
'VALUE' N,X; 'INTEGER' N; 'REAL' X; 'ARRAY' B,C,A;
'IF' N=0 'THEN' SUMORTPOL:=A[0] 'ELSE'
'BEGIN' 'INTEGER' K; 'REAL' H,R,S;
  R:=A[N]; S:=0;
  'FOR' K:=N-1 'STEP' -1 'UNTIL' 1 'DO'
  'BEGIN'
    H:=R;
    R:=A[K]+(X-B[K])*R+S;
    S:=       -C[K]*H
  'END';
  SUMORTPOL:=A[0]+(X-B[0])*R+S
'END' SUMORTPOL;
        'EOP'
