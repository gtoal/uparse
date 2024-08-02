'CODE' 34152;
    'COMMENT' MCA 2312;
    'PROCEDURE' VECSYMTRI(D, B, N, N1, N2, VAL, VEC, EM);
    'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' D, B, VAL, VEC, EM;
    'BEGIN' 'INTEGER' I, J, K, COUNT, MAXCOUNT, COUNTLIM, ORTH, IND;
        'REAL' BI, BI1, U, W, Y, MI1, LAMBDA, OLDLAMBDA, ORTHEPS,
        VALSPREAD, SPR, RES, MAXRES, OLDRES, NORM, NEWNORM, OLDNORM,
        MACHTOL, VECTOL;
        'ARRAY' M, P, Q, R, X[1:N];
        'BOOLEAN' 'ARRAY' INT[1:N];

        NORM:= EM[1]; MACHTOL:= EM[0] * NORM; VALSPREAD:= EM[4] * NORM;
        VECTOL:= EM[6] * NORM; COUNTLIM:= EM[8]; ORTHEPS:= SQRT(EM[0]);
        MAXCOUNT:= IND:= 0; MAXRES:= 0;
        'IF' N1 > 1 'THEN'
        'BEGIN' ORTH:= EM[5]; OLDLAMBDA:= VAL[N1 - ORTH];
            'FOR' K:= N1 - ORTH + 1 'STEP' 1 'UNTIL' N1 - 1  'DO'
            'BEGIN' LAMBDA:= VAL[K]; SPR:= OLDLAMBDA - LAMBDA;
                'IF' SPR < MACHTOL 'THEN' LAMBDA:= OLDLAMBDA - MACHTOL;
                OLDLAMBDA:= LAMBDA
            'END'
        'END' 'ELSE' ORTH:= 1;
        'FOR' K:= N1 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN' LAMBDA:= VAL[K]; 'IF' K > 1 'THEN'
            'BEGIN' SPR:= OLDLAMBDA - LAMBDA;
                'IF' SPR < VALSPREAD 'THEN'
                'BEGIN' 'IF' SPR < MACHTOL 'THEN'
                    LAMBDA:= OLDLAMBDA - MACHTOL;
                    ORTH:= ORTH +1
                'END' 'ELSE' ORTH:= 1
            'END';
            COUNT:= 0; U:= D[1] - LAMBDA; BI:= W:= B[1];
            'IF' ABS(BI) < MACHTOL 'THEN' BI:= MACHTOL;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1  'DO'
            'BEGIN' BI1:= B[I + 1];
                'IF' ABS(BI1) < MACHTOL 'THEN' BI1:= MACHTOL;
                'IF' ABS(BI) >= ABS(U) 'THEN'
                'BEGIN' MI1:= M[I + 1]:= U / BI; P[I]:= BI;
                    Y:= Q[I]:= D[I + 1] - LAMBDA; R[I]:= BI1;
                    U:= W - MI1 * Y; W:= - MI1 * BI1; INT[I]:= 'TRUE'
                'END'
                'ELSE'
                'BEGIN' MI1:= M[I + 1]:= BI / U; P[I]:= U; Q[I]:= W;
                    R[I]:= 0; U:= D[I + 1] - LAMBDA - MI1 * W;W:= BI1;
                    INT[I]:= 'FALSE'
                'END';
                X[I]:= 1; BI:= BI1
            'END' TRANSFORM;
            P[N]:= 'IF' ABS(U) < MACHTOL 'THEN' MACHTOL 'ELSE' U;
            Q[N]:= R[N]:= 0; X[N]:= 1; 'GOTO' ENTRY;
        ITERATE: W:= X[1];
            'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'IF' INT[I - 1] 'THEN'
                'BEGIN' U:= W; W:= X[I - 1]:= X[I] 'END'
                'ELSE' U:= X[I]; W:= X[I]:= U - M[I] * W
            'END' ALTERNATE;
        ENTRY: U:= W:= 0;
            'FOR' I:= N 'STEP' -1 'UNTIL' 1 'DO'
            'BEGIN' Y:= U; U:= X[I]:= (X[I] - Q[I] * U - R[I] * W) /
                P[I]; W:= Y
            'END' NEXT ITERATION;
            NEWNORM:= SQRT(VECVEC(1, N, 0, X, X)); 'IF' ORTH > 1'THEN'
            'BEGIN' OLDNORM:= NEWNORM;
                'FOR' J:= K - ORTH + 1 'STEP' 1 'UNTIL' K - 1 'DO'
                ELMVECCOL(1, N, J, X, VEC, -TAMVEC(1, N, J, VEC, X));
                NEWNORM:= SQRT(VECVEC(1, N, 0, X, X));
                'IF' NEWNORM < ORTHEPS * OLDNORM 'THEN'
                'BEGIN' IND:= IND + 1; COUNT:= 1;
                    'FOR' I:= 1 'STEP' 1 'UNTIL' IND - 1,
                    IND + 1 'STEP' 1 'UNTIL' N 'DO' X[I]:= 0;
                    X[IND]:= 1; 'IF' IND = N 'THEN' IND:= 0;
                    'GOTO' ITERATE
                'END' NEW START
            'END' ORTHOGONALISATION;
            RES:= 1 / NEWNORM; 'IF' RES > VECTOL 'OR' COUNT = 0 'THEN'
            'BEGIN' COUNT:= COUNT + 1; 'IF' COUNT <= COUNTLIM 'THEN'
                'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                    X[I]:= X[I] * RES; 'GOTO' ITERATE
                'END'
            'END';
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' VEC[I,K]:= X[I] * RES;
            'IF' COUNT > MAXCOUNT 'THEN' MAXCOUNT:= COUNT;
            'IF' RES > MAXRES 'THEN' MAXRES:= RES; OLDLAMBDA:= LAMBDA
        'END';
        EM[5]:= ORTH; EM[7]:= MAXRES; EM[9]:= MAXCOUNT
    'END' VECSYMTRI;

        'EOP'
