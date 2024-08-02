'CODE' 34193;
    'COMMENT' MCA 2423;
    'PROCEDURE' COMSCL(A, N, N1, N2, IM); 'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' A, IM;
    'BEGIN' 'INTEGER' I, J, K;
        'REAL' S, U, V, W;

        'FOR' J:= N1 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN' S:= 0; 'IF' IM[J] ^= 0 'THEN'
            'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' U:= A[I,J] ** 2 + A[I,J + 1] ** 2;
                    'IF' U > S 'THEN' 'BEGIN' S:= U; K:= I 'END'
                'END';
                'IF' S ^= 0 'THEN'
                'BEGIN' V:= A[K,J] / S; W:= - A[K,J + 1] / S;
                    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                    'BEGIN' U:= A[I,J]; S:= A[I,J + 1];
                        A[I,J]:= U * V - S * W;
                        A[I,J + 1]:= U * W + S * V
                    'END'
                'END';
                J:= J + 1
            'END'
            'ELSE'
            'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                'IF' ABS(A[I,J]) > ABS(S) 'THEN' S:= A[I,J];
                'IF' S ^= 0 'THEN'
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' A[I,J]:= A[I,J] / S
            'END'
        'END'
    'END' COMSCL;
        'EOP'
