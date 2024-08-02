'CODE' 34142;
    'COMMENT' MCA 2302;
    'PROCEDURE' TFMPREVEC(A, N); 'VALUE' N; 'INTEGER' N; 'ARRAY' A;
    'BEGIN' 'INTEGER' I, J, J1, K; 'REAL' AB;

        J1:= 1;
        'FOR' J:= 2 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' J1 - 1 ,
            J 'STEP' 1 'UNTIL' N 'DO' A[I,J1]:= 0;
            A[J1,J1]:= 1; AB:= A[J,J];
            'IF' AB < 0 'THEN'
            'FOR' K:= 1 'STEP' 1 'UNTIL' J1 'DO'
            ELMCOL(1, J1, K, J, A, A,
            TAMMAT(1, J1, J, K, A, A) * AB); J1:= J
        'END';
        'FOR' I:= N - 1 'STEP' -1 'UNTIL' 1 'DO'
        A[I,N]:= 0; A[N,N]:= 1
    'END' TFMPREVEC

        ;'EOP'
