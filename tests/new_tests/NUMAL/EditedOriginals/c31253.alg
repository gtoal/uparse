'CODE' 31253;
'PROCEDURE' GSSWTS(N,ZER,B,C)RESULTS:(W);
'VALUE' N; 'INTEGER' N;
'ARRAY' ZER,B,C,W;
'BEGIN'
    'INTEGER' J,K; 'REAL' S; 'ARRAY' P[0:N-1];
    'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN'
        ALLORTPOL(N-1,ZER[J],B,C,P);
        S:=0.0;
        'FOR' K:=N-1 'STEP' -1 'UNTIL' 1 'DO'
        S:=(S+P[K]**2)/C[K];
        W[J]:=1/(1+S);
    'END'
'END' GSSWTS;
        'EOP'
