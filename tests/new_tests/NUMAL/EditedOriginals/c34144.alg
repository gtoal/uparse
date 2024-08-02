'CODE' 34144;
    'COMMENT' MCA 2306;
    'PROCEDURE' BAKSYMTRI1(A, N, N1, N2, VEC); 'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' A, VEC;
    'BEGIN' 'INTEGER' J, J1, K, TI, TJ;
        'REAL' W; 'ARRAY' AUXVEC[1:N];

        'FOR' K:= N1 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN' 'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
            AUXVEC[J]:= VEC[J,K]; TJ:= J1:= 1;
            'FOR' J:= 2 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' TI:= TJ + J; W:= A[TI];
                'IF' W < 0 'THEN' ELMVEC(1, J1, TJ, AUXVEC,A,VECVEC(1,
                J1, TJ, AUXVEC, A) * W); J1:= J; TJ:= TI
            'END';
            'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' VEC[J,K]:= AUXVEC[J]
        'END'
    'END' BAKSYMTRI1;
        'EOP'
