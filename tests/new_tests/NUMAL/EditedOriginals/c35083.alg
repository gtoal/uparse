'CODE' 35083;
    'REAL' 'PROCEDURE' JFRAC(N,A,B);
    'VALUE' N;'INTEGER' N;'ARRAY' A,B;
    'BEGIN' 'REAL' D;'INTEGER' I;
        D:=0;
        'FOR' I:=N 'STEP' -1 'UNTIL' 1 'DO' D:=A[I]/(B[I]+D);
        JFRAC:=D+B[0]
    'END' JFRAC;
        'EOP'
