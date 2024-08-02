'CODE' 34136;
    'PROCEDURE' LSQINV(A, M, AID, C); 'VALUE' M; 'INTEGER' M;
    'ARRAY' A, AID; 'INTEGER''ARRAY' C;
    'BEGIN''INTEGER' I, CI;
       'REAL' W;

       'FOR' I:= 1 'STEP' 1 'UNTIL' M 'DO' A[I,I]:= AID[I];
       CHLINV2(A, M);
       'FOR' I:= M 'STEP' - 1 'UNTIL' 1 'DO'
       'BEGIN' CI:= C[I]; 'IF' CI ^= I 'THEN'
          'BEGIN' ICHCOL(1, I - 1, I, CI, A); ICHROWCOL(I + 1, CI - 1,
             I, CI, A); ICHROW(CI + 1, M, I, CI, A);
             W:= A[I,I]; A[I,I]:= A[CI,CI]; A[CI,CI]:= W
          'END'
       'END'
    'END' LSQINV;
        'EOP'
