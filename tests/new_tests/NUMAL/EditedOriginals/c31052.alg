'CODE' 31052;
'PROCEDURE' CHSPOL(N,A);
'VALUE' N; 'INTEGER' N; 'ARRAY' A;
'IF' N>1 'THEN'
'BEGIN'
    'INTEGER' K,L,TWOPOW;
    'FOR' K:=0 'STEP' 1 'UNTIL' N-2 'DO'
    'BEGIN'
        'FOR' L:=N-2 'STEP' -1 'UNTIL' K 'DO'
        A[L]:=A[L]-A[L+2]; A[K+1]:=A[K+1]/2;
    'END';
    TWOPOW:=2;
    'FOR' K:=1 'STEP' 1 'UNTIL' N-2 'DO'
    'BEGIN'
        A[K]:=A[K]*TWOPOW; TWOPOW:=TWOPOW*2;
    'END';
    A[N-1]:=TWOPOW*A[N-1];
    A[N]:=TWOPOW*A[N];
'END' CHSPOL

        ;'EOP'
