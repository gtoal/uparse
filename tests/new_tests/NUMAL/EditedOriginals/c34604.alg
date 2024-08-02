'CODE' 34604;
'PROCEDURE' HESTGL2(N,A,B);'VALUE' N;'INTEGER' N;'ARRAY' A,B;
'BEGIN' 'INTEGER' NM1,K,L,K1,L1;
    'IF' N>2 'THEN'
    'BEGIN' 'FOR' K:=2 'STEP' 1 'UNTIL' N 'DO'
        'FOR' L:=1 'STEP' 1 'UNTIL' K-1 'DO' B[K,L]:=0;
        NM1:=N-1;K:=1;
        'FOR' K1:= 2 'STEP' 1 'UNTIL' NM1 'DO'
        'BEGIN' L1:=N;
            'FOR' L:=N-1 'STEP' -1 'UNTIL' K1 'DO'
            'BEGIN'
                HSH2COL(K,L,N,L,A[L,K],A[L1,K],A,B);A[L1,K]:=0;
                HSH2ROW2(1,1,N,L1,L,B[L1,L1],B[L1,L],A,B);
                B[L1,L]:=0;L1:=L
            'END';K:=K1
        'END'
    'END'
'END' HESTGL2;
        'EOP'
