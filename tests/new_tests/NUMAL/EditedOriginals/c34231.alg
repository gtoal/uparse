'CODE' 34231;
    'PROCEDURE' GSSELM(A, N, AUX, RI, CI); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, AUX;
    'INTEGER' 'ARRAY' RI, CI;
    'BEGIN' 'INTEGER' I, J, P, Q, R, R1, JPIV, RANK, SIGNDET;
        'REAL' CRIT, PIVOT, RGROW, MAX, AID, MAX1, EPS;
        'BOOLEAN' PARTIAL;
        AUX[5]:= RGROW:= ABSMAXMAT(1, N, 1, N, I, J, A);
        CRIT:= N * RGROW * AUX[4]; EPS:= RGROW * AUX[2]; MAX:= 0;
        RANK:= N; SIGNDET:= 1; PARTIAL:= RGROW ^= 0;
        'FOR' Q:= 1 'STEP' 1 'UNTIL' N 'DO' 'IF' Q ^= J 'THEN'
        'BEGIN' AID:= ABS(A[I,Q]);
            'IF' AID > MAX 'THEN' MAX:= AID
        'END';
        RGROW:= RGROW + MAX;
        'FOR' R:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' R1:= R + 1; 'IF' I ^= R 'THEN'
            'BEGIN' SIGNDET:= - SIGNDET; ICHROW(1, N, R, I, A) 'END';
            'IF' J ^= R 'THEN'
            'BEGIN' SIGNDET:= - SIGNDET; ICHCOL(1, N, R, J, A) 'END';
            RI[R]:= I; CI[R]:= J; PIVOT:= A[R,R];
            'IF' PIVOT < 0 'THEN' SIGNDET:= - SIGNDET;
            'IF' PARTIAL 'THEN'
            'BEGIN' MAX:= MAX1:= 0; J:= R1;
                ROWCST(R1, N, R, A, 1 / PIVOT);
                'FOR' P:= R1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' ELMROW(R1, N, P, R, A, A, - A[P,R]);
                    AID:= ABS(A[P,R1]); 'IF' MAX < AID 'THEN'
                    'BEGIN' MAX:= AID; I:= P 'END';
                 'END';
                'FOR' Q:= R1 + 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' AID:= ABS(A[I,Q]);
                    'IF' MAX1 < AID 'THEN' MAX1:= AID
                'END';
                AID:= RGROW; RGROW:= RGROW + MAX1;
                'IF' RGROW > CRIT 'OR' MAX < EPS 'THEN'
                'BEGIN' PARTIAL:= 'FALSE'; RGROW:= AID;
                    MAX:= ABSMAXMAT(R1, N, R1, N, I, J, A)
                'END'
            'END' PARTIAL PIVOTINGSTEP
            'ELSE'
            'BEGIN' 'IF' MAX <= EPS 'THEN'
                'BEGIN' RANK:= R - 1;
                    'IF' PIVOT < 0 'THEN' SIGNDET:= - SIGNDET;'GOTO'OUT
                'END';
                MAX:= - 1;
                ROWCST(R1, N, R, A, 1 / PIVOT);
                'FOR' P:= R1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' JPIV:= MAXELMROW(R1, N, P, R, A, A, - A[P,R]);
                    AID:= ABS(A[P,JPIV]); 'IF' MAX < AID 'THEN'
                    'BEGIN' MAX:= AID; I:= P; J:= JPIV 'END'
                'END';
                'IF' RGROW < MAX 'THEN' RGROW:= MAX
            'END' COMPLETE PIVOTINGSTEP
        'END' ELIMINATIONSTEP;
    OUT: AUX[1]:= SIGNDET; AUX[3]:= RANK; AUX[7]:= RGROW
    'END' GSSELM

        ;'EOP'
