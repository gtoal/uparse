'CODE' 31241;
     'PROCEDURE' TAYPOL(N,K,X,A);
     'VALUE' N,K,X;
     'INTEGER' N,K;'REAL' X;'ARRAY' A;
     'IF' X^= 0 'THEN'
     'BEGIN' 'INTEGER' I,J,NM1;
        'REAL' XJ,AA,H;
        XJ:=1;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' XJ:=XJ*X;A[J]:=A[J]*XJ 'END';
        AA:=A[N];NM1:=N-1;
        'FOR' J:= 0 'STEP' 1 'UNTIL' K 'DO'
        'BEGIN' H:=AA;
           'FOR' I:= NM1 'STEP' -1 'UNTIL' J 'DO'
           H:= A[ I]:=A[I]+H
        'END'
     'END' 'ELSE'
     'FOR' K:= K 'STEP' -1 'UNTIL' 1 'DO' A[K]:=0;
        'EOP'
