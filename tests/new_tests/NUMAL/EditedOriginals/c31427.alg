'CODE' 31427;
    'PROCEDURE' GSS LAG WGHTS(N, ALFA, X, W);
    'VALUE' N, ALFA; 'INTEGER' N; 'REAL' ALFA; 'ARRAY' X, W;
    'BEGIN' 'INTEGER' I, J; 'REAL' H0, S, R0, R1, R2, XI;
        'ARRAY' A, B[0:N];
        A[0]:= 1 + ALFA; A[1]:= 3 + ALFA; B[1]:= SQRT(A[0]);
        'FOR' I:= 2 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' A[I]:= I + I + ALFA + 1;
            B[I]:= SQRT(I*(I + ALFA))
        'END';
        ALL LAG ZER(N, ALFA, X); H0:= GAMMA(1 + ALFA);
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' XI:= X[I]; R0:= 1;
            R1:= (XI - A[0])/B[1]; S:= 1 + R1*R1;
            'FOR' J:= 2 'STEP' 1 'UNTIL' N - 1 'DO'
            'BEGIN' R2:= ((XI - A[J - 1])*R1 - B[J - 1]*R0)/B[J];
                R0:= R1; R1:= R2; S:= S + R2*R2
                'END';
            W[I]:= H0/S
        'END'
    'END' GSS LAG WGHTS;
         'EOP'
