'CODE' 35081;
    'PROCEDURE' EIALPHA(X,N,ALPHA);
    'VALUE' X,N;'REAL' X;'INTEGER' N;'ARRAY' ALPHA;
    'BEGIN' 'REAL' A,B,C;'INTEGER' K;
        C:=1/X;A:=EXP(-X);
        B:=ALPHA[0]:=A*C;
        'FOR' K:=1 'STEP' 1 'UNTIL' N 'DO'
        ALPHA[K]:=B:=(A+K*B)*C
    'END' EIALPHA;
        'EOP'
