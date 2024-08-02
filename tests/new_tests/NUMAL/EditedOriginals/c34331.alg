'CODE' 34331;
'REAL''PROCEDURE' CHLDETERMBND(A, N, W); 'VALUE' N, W; 'INTEGER' N,W;
'ARRAY' A;
'BEGIN''INTEGER' J, KK, W1; 'REAL' P;
        W1:= W + 1; KK:= - W; P:= 1;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' KK:= KK + W1; P:= A[KK] * P 'END';
        CHLDETERMBND:= P * P
    'END' CHLDETERMBND;
        'EOP'
