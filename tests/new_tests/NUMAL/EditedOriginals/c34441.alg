'CODE' 34441;
    'PROCEDURE' GSSNEWTON(M, N, PAR, RV, JJINV, FUNCT, JACOBIAN,
      IN, OUT);
    'VALUE' M, N; 'INTEGER' M, N;
    'ARRAY' PAR, RV, JJINV, IN, OUT;
    'BOOLEAN' 'PROCEDURE' FUNCT;
    'PROCEDURE' JACOBIAN;

    'BEGIN' 'INTEGER' I, J, INR, MIT, TEXT,
        IT, ITMAX, INRMAX, TIM, FEVAL, FEVALMAX;
        'REAL' RHO, RES1, RES2, RN, RELTOLPAR, ABSTOLPAR, ABSTOLRES,
           STAP, NORMX;
        'BOOLEAN' CONV, TESTTHF, DAMPING ON;
        'ARRAY' JAC[1:M + 1,1:N], PR, AID, SOL[1 : N], FU2[1 : M],
           AUX[2 : 5];
        'INTEGER''ARRAY' CI[1:N];

        'BOOLEAN''PROCEDURE' LOC FUNCT(M, N, PAR, RV);
        'VALUE' M, N; 'INTEGER' M, N; 'ARRAY' PAR, RV;
        'BEGIN' LOC FUNCT:= TEST THF:= FUNCT(M, N, PAR, RV)
            'AND' TEST THF; FEVAL:= FEVAL + 1
        'END' LOC FUNCT;

        ITMAX:= FEVALMAX:= IN[5]; AUX[2]:= N * IN[0]; TIM:= IN[7];
        RELTOLPAR:= IN[1] ** 2; ABSTOLPAR:= IN[2] ** 2;
        ABSTOLRES:= IN[4] ** 2; INRMAX:= IN[6];
        DUPVEC(1, N, 0, PR, PAR);
        'IF' M < N 'THEN'
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO' JAC[M + 1, I]:= 0;
        TEXT:= 4; MIT:= 0; TEST THF:= 'TRUE';
        RES2:= STAP:= OUT[5]:= OUT[6]:= OUT[7]:= 0;
        FUNCT(M, N, PAR, FU2); RN:= VECVEC(1, M, 0, FU2, FU2);
        OUT[3]:= SQRT(RN); FEVAL:= 1; DAMPING ON:= 'FALSE';
        'FOR' IT:= 1, IT + 1 'WHILE' IT <= ITMAX 'AND'
               FEVAL < FEVALMAX 'DO'
        'BEGIN' OUT[5]:= IT; JACOBIAN(M, N, PAR, FU2, JAC, LOCFUNCT);
           'IF' 'NOT' TEST THF 'THEN'
           'BEGIN' TEXT:= 7; 'GOTO' FAIL 'END';
           LSQORTDEC(JAC, M, N, AUX, AID, CI);
           'IF' AUX[3] ^= N 'THEN'
           'BEGIN' TEXT:= 5; 'GOTO' FAIL 'END';
           LSQSOL(JAC, M, N, AID, CI, FU2); DUPVEC(1, N, 0, SOL, FU2);
           STAP:= VECVEC(1, N, 0, SOL, SOL);
           RHO:= 2; NORMX:= VECVEC(1, N, 0, PAR, PAR);
           'IF' STAP > RELTOLPAR * NORMX + ABSTOLPAR
              'OR' IT = 1 'AND' STAP > 0 'THEN'
           'BEGIN''FOR' INR:= 0, INR + 1
              'WHILE''IF' INR = 1 'THEN' DAMPING ON 'OR' RES2 >= RN
              'ELSE''NOT' CONV 'AND' (RN <= RES1 'OR' RES2 < RES1) 'DO'
              'BEGIN''COMMENT' DAMPING STOPS WHEN
                 R0 > R1 'AND' R1 <= R2 (BEST RESULT IS X1, R1)
                 WITH  X1 = X0 + I * DX, I:= 1, .5, .25, .125, ETC.  ;
                 RHO:= RHO / 2; 'IF' INR > 0 'THEN'
                 'BEGIN' RES1:= RES2; DUPVEC(1, M, 0, RV, FU2);
                    DAMPING ON:= INR > 1
                 'END';
                 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                 PR[I]:= PAR[I] - SOL[I] * RHO;
                 FEVAL:= FEVAL + 1;
                 'IF' 'NOT' FUNCT(M, N, PR, FU2) 'THEN'
                 'BEGIN' TEXT:= 6; 'GOTO' FAIL 'END';
                 RES2:= VECVEC(1, M, 0, FU2, FU2); CONV:= INR >= INRMAX
              'END' DAMPING OF STEP VECTOR;
              'IF' CONV 'THEN'
              'BEGIN''COMMENT' RESIDUE CONSTANT; MIT:= MIT + 1;
                 'IF' MIT < TIM 'THEN' CONV:= 'FALSE'
              'END' 'ELSE' MIT:= 0;
              'IF' INR > 1 'THEN'
              'BEGIN' RHO:= RHO * 2; ELMVEC(1, N, 0, PAR, SOL, - RHO);
                 RN:= RES1; 'IF' INR > 2 'THEN' OUT[7]:= IT
              'END''ELSE'
              'BEGIN' DUPVEC(1, N, 0, PAR, PR); RN:= RES2;
                 DUPVEC(1, M, 0, RV, FU2)
              'END';

              'IF' RN <= ABSTOLRES 'THEN'
              'BEGIN' TEXT:= 1; ITMAX:= IT 'END''ELSE'
              'IF' CONV 'AND' INRMAX > 0 'THEN'
              'BEGIN' TEXT:= 3; ITMAX:= IT 'END'
              'ELSE' DUPVEC(1, M, 0, FU2, RV)
           'END' ITERATION WITH DAMPING AND TESTS 'ELSE'
           'BEGIN' TEXT:= 2; RHO:= 1; ITMAX:= IT 'END'
        'END' OF ITERATIONS;

        LSQINV(JAC, N, AID, CI);
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' JJINV[I,I]:= JAC[I,I];
            'FOR' J:= I + 1 'STEP' 1 'UNTIL' N 'DO'
            JJINV[I,J]:= JJINV[J,I]:= JAC[I,J]
        'END' CALCULATION OF INVERSE MATRIX OF NORMAL EQUATIONS;
    FAIL :
        OUT[6]:= SQRT(STAP) * RHO; OUT[2]:= SQRT(RN); OUT[4]:= FEVAL;
        OUT[1]:= TEXT; OUT[8]:= AUX[3]; OUT[9]:= AUX[5]
    'END' GSSNEWTON;
        'EOP'
