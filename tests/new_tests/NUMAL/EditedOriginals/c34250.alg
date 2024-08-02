'CODE' 34250;
    'PROCEDURE' ITISOL(A, LU, N, AUX, RI, CI, B); 'VALUE' N;
    'INTEGER' N;
    'ARRAY' A, LU, AUX, B; 'INTEGER' 'ARRAY' RI, CI;
    'BEGIN' 'INTEGER' I, ITER, MAXITER;
        'REAL' MAXERX, ERX, NRMRES, NRMSOL, R, RR;
        'ARRAY' RES, SOL[1:N];
        MAXERX:= ERX:= AUX[10]; MAXITER:= AUX[12];
        INIVEC(1, N, SOL, 0); DUPVEC(1, N, 0, RES, B);
        'FOR' ITER:= 1, ITER + 1 'WHILE' ITER <= MAXITER &
        MAXERX < ERX 'DO'
        'BEGIN' SOLELM(LU, N, RI, CI, RES); ERX:= NRMSOL:= NRMRES:= 0;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' R:= RES[I]; ERX:= ERX + ABS(R); RR:= SOL[I] + R;
                SOL[I]:= RR; NRMSOL:= NRMSOL + ABS(RR)
            'END';
            ERX:= ERX / NRMSOL;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' LNGMATVEC(1, N, I, A, SOL, - B[I], 0, R, RR);
                R:= - (R + RR); RES[I]:= R; NRMRES:= NRMRES + ABS(R)
            'END'
        'END' ITERATION;
        DUPVEC(1, N, 0, B, SOL);
        AUX[11]:= ERX; AUX[13]:= NRMRES
    'END' ITISOL

        ;'EOP'
