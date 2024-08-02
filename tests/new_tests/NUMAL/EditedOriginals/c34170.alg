'CODE' 34170;
    'COMMENT' MCA 2400;
    'PROCEDURE' TFMREAHES(A, N, EM, INT); 'VALUE' N; 'INTEGER' N;
     'ARRAY' A, EM; 'INTEGER' 'ARRAY' INT;
    'BEGIN' 'INTEGER' I, J, J1, K, L;
        'REAL' S, T, MACHTOL, MACHEPS, NORM;
         'ARRAY' B[0:N - 1];

        MACHEPS:= EM[0]; NORM:= 0;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' S:= 0;
            'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' S:= S + ABS(A[I,J]);
            'IF' S > NORM 'THEN' NORM:= S
        'END';
        EM[1]:= NORM; MACHTOL:= NORM * MACHEPS; INT[1]:= 0;
        'FOR' J:= 2 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' J1:= J - 1; L:= 0; S:= MACHTOL;
            'FOR' K:= J + 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' T:= ABS(A[K,J1]); 'IF' T > S 'THEN'
                'BEGIN' L:= K; S:= T 'END'
            'END';
            'IF' L ^= 0 'THEN'
            'BEGIN' 'IF' ABS(A[J,J1]) < S 'THEN'
                'BEGIN' ICHROW(1, N, J, L, A);
                    ICHCOL(1, N, J, L, A)
                'END'
                'ELSE' L:= J; T:= A[J,J1];
                'FOR' K:= J + 1 'STEP' 1 'UNTIL' N 'DO'
                A[K,J1]:= A[K,J1] / T
            'END'
            'ELSE'
            'FOR' K:= J + 1 'STEP' 1 'UNTIL' N 'DO' A[K,J1]:= 0;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            B[I - 1]:= A[I,J]:= A[I,J] +
            ('IF' L = 0 'THEN' 0 'ELSE' MATMAT(J + 1, N, I, J1, A, A))-
            MATVEC(1, 'IF' J1 < I - 2 'THEN' J1 'ELSE' I - 2, I, A, B);
            INT[J]:= L
        'END'
    'END' TFMREAHES

        ;'EOP'
