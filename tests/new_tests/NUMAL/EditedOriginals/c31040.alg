'CODE' 31040;
     'REAL' 'PROCEDURE' POL(N,X,A);
     'VALUE' N,X;'INTEGER' N;'REAL' X;'ARRAY' A;
     'BEGIN' 'REAL' R;
        R:= 0;
        'FOR' N:= N 'STEP' -1 'UNTIL' 0 'DO'
        R:=R*X  + A[N];
        POL:= R
     'END' POL

        ;'EOP'
