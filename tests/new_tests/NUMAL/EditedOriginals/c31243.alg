'CODE' 31243;
     'PROCEDURE' DERPOL (N,K,X,A);
     'VALUE' N,K,X;
     'INTEGER' N,K;'REAL' X;'ARRAY' A;
     'BEGIN' 'INTEGER' J; 'REAL' FAC;
        FAC:=1;
        NORDERPOL (N,K,X,A);
        'FOR' J:= 2 'STEP' 1 'UNTIL' K 'DO'
        'BEGIN' FAC:=FAC*J;A[J]:=A[J]*FAC 'END'
     'END' DERPOL ;
        'EOP'
