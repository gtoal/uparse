'CODE' 31242;
     'PROCEDURE' NORDERPOL (N,K,X,A);
     'VALUE' N,K,X;
     'INTEGER' N,K;'REAL' X;'ARRAY' A;
     'IF' X^= 0 'THEN'
     'BEGIN' 'INTEGER' I,J,NM1;
        'REAL' XJ,AA,H;
        'ARRAY' XX[0:N];
        XJ:=1;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' XJ:=XX[J]:=XJ*X;A[J]:=A[J]*XJ 'END';
        H:=AA:=A[N];NM1:=N-1;
        'FOR' I:= NM1 'STEP' -1 'UNTIL' 0 'DO' H:= A[I]:=A[I]+H;
        'FOR' J:= 1 'STEP' 1 'UNTIL' K 'DO'
        'BEGIN' H:=AA;
           'FOR' I:= NM1 'STEP' -1 'UNTIL' J 'DO'
           H:= A[ I]:=A[I]+H;
           A[J]:=H/XX[J]
        'END'
     'END' NORDERPOL ;
        'EOP'
