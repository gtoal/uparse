'CODE' 34151;
    'COMMENT' MCA 2311;
    'PROCEDURE' VALSYMTRI(D, BB, N, N1, N2, VAL, EM);
    'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' D, BB, VAL, EM;
        'BEGIN' 'INTEGER' K, COUNT;
        'REAL' MAX, X, Y, MACHEPS, NORM, RE, MACHTOL, UB, LB, LAMBDA;

        'REAL' 'PROCEDURE' STURM;
        'BEGIN' 'INTEGER' P, I; 'REAL' F;
            COUNT:= COUNT + 1;
            P:= K; F:= D[1] - X;
            'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'IF' F <= 0 'THEN'
                'BEGIN' P:= P + 1;
                    'IF' P > N 'THEN' 'GOTO' OUT
                'END'
                'ELSE' 'IF' P < I - 1 'THEN'
                'BEGIN' LB:= X; 'GOTO' OUT 'END';
                'IF' ABS(F) < MACHTOL 'THEN'
                F:= 'IF' F <= 0 'THEN' - MACHTOL 'ELSE' MACHTOL;
                F:= D[I] - X - BB[I - 1] / F
            'END';
            'IF' P = N 'OR' F <= 0 'THEN'
            'BEGIN' 'IF' X < UB 'THEN' UB:= X 'END' 'ELSE' LB:= X;
       OUT: STURM:= 'IF' P = N 'THEN' F 'ELSE' (N - P) * MAX
        'END' STURM;

        MACHEPS:= EM[0]; NORM:= EM[1]; RE:= EM[2];
        MACHTOL:= NORM * MACHEPS; MAX:= NORM / MACHEPS; COUNT:= 0;
        UB:= 1.1 * NORM; LB:= - UB; LAMBDA:= UB;
        'FOR' K:= N1 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN' X:= LB; Y:= UB; LB:= -1.1  * NORM;
            ZEROIN(X, Y, STURM, ABS(X) * RE + MACHTOL);
            VAL[K]:= LAMBDA:= 'IF' X > LAMBDA 'THEN' LAMBDA 'ELSE' X;
            'IF' UB > X 'THEN' UB:= 'IF' X > Y 'THEN' X 'ELSE' Y
        'END';
        EM[3]:= COUNT
    'END' VALSYMTRI

        ;'EOP'
