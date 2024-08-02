'CODE' 31425;
    'PROCEDURE' GSS JAC WGHTS(N, ALFA, BETA, X, W);
    'VALUE' N, ALFA, BETA; 'INTEGER' N; 'REAL' ALFA, BETA;
    'ARRAY' X, W;
    'IF' ALFA = BETA 'THEN'
    'BEGIN' 'INTEGER' I, J, M;
        'ARRAY' B[1:N - 1]; 'REAL' R0, R1, R2, S, H0, ALFA2, XI;

        ALL JAC ZER(N, ALFA, ALFA, X); ALFA2:= 2*ALFA;
        H0:= 2**(ALFA2 + 1)*GAMMA(1 + ALFA)**2/GAMMA(ALFA2 + 2);
        B[1]:= 1/SQRT(3 + ALFA2); M:= N - (N//2);
        'FOR' I:= 2 'STEP' 1 'UNTIL' N - 1 'DO'
        B[I]:= SQRT(I*(I + ALFA2)/(4*(I + ALFA)**2 - 1));
        'FOR' I:= 1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' XI:= ABS(X[I]); R0:= 1; R1:= XI/B[1];
            S:= 1 + R1*R1;
            'FOR' J:= 2 'STEP' 1 'UNTIL' N - 1 'DO'
            'BEGIN' R2:= (XI*R1 - B[J - 1]*R0)/B[J];
                R0:= R1; R1:= R2; S:= S + R2*R2
            'END';
            W[I]:= W[N + 1 - I]:= H0/S
        'END'
    'END' 'ELSE'
    'BEGIN' 'INTEGER' I, J; 'ARRAY' A, B[0:N];
        'REAL' MIN, SUM, H0, R0, R1, R2, XI, ALFABETA;
        ALFABETA:= ALFA + BETA; MIN:= (BETA - ALFA)*ALFABETA;
        B[0]:= 0; SUM:= ALFABETA + 2; A[0]:= (BETA - ALFA)/SUM;
        A[1]:= MIN /SUM/(SUM + 2);
        B[1]:= 2*SQRT((1 + ALFA)*(1 + BETA)/(SUM + 1))/SUM;
        'FOR' I:= 2 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' SUM:= I + I + ALFABETA;
            A[I]:= MIN/SUM/(SUM + 2);
            B[I]:= (2/SUM)*
            SQRT(I*(SUM - I)*(I + ALFA)*(I + BETA)/(SUM*SUM - 1))
        'END';
        H0:= 2**(ALFABETA + 1)*GAMMA(1 + ALFA)*GAMMA(1 + BETA)/
                                  GAMMA(2 + ALFABETA);
        ALL JAC ZER(N, ALFA, BETA, X);
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' XI:= X[I]; R0:= 1; R1:= (XI - A[0])/B[1];
            SUM:= 1 + R1*R1;
            'FOR' J:= 2 'STEP' 1 'UNTIL' N - 1 'DO'
            'BEGIN' R2:= ((XI - A[J - 1])*R1 - B[J - 1]*R0)/B[J];
                SUM:= SUM + R2*R2; R0:= R1; R1:= R2
            'END';
            W[I]:= H0/SUM
        'END'
    'END' GSS JAC WGHTS

         ;'EOP'
