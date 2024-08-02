'CODE' 34372;
    'INTEGER' 'PROCEDURE' VALQRICOM(A1, A2, B, N, EM, VAL1, VAL2);
    'VALUE' N; 'INTEGER' N; 'ARRAY' A1, A2, B, EM, VAL1, VAL2;
    'BEGIN' 'INTEGER' M, NM1, I, I1, Q, Q1, MAX, COUNT;
        'REAL' R, Z1, Z2, DD1, DD2, CC, G1, G2, K1, K2, HC, A1NN,
        A2NN, AIJ1, AIJ2, AI1I, KAPPA, NUI, MUI1, MUI2,
        MUIM11, MUIM12, NUIM1, TOL;
        TOL:= EM[1] * EM[2]; MAX:= EM[4]; COUNT:= 0; R:= 0;
        M:= N; 'IF' N > 1 'THEN' HC:= B[N - 1];
    IN: NM1:= N - 1;
        'FOR' I:= N, I - 1 'WHILE' ('IF' I >= 1 'THEN' ABS(B[I]) > TOL
        'ELSE' 'FALSE') 'DO' Q:= I; 'IF' Q > 1 'THEN'
        'BEGIN' 'IF' ABS(B[Q - 1]) > R 'THEN' R:= ABS(B[Q - 1]) 'END';
        'IF' Q = N 'THEN'
        'BEGIN' VAL1[N]:= A1[N,N]; VAL2[N]:= A2[N,N]; N:= NM1;
            'IF' N > 1 'THEN' HC:= B[N - 1];
        'END'
        'ELSE'
        'BEGIN' DD1:= A1[N,N]; DD2:= A2[N,N]; CC:= B[NM1];
            COMKWD((A1[NM1,NM1] - DD1) / 2, (A2[NM1,NM1] - DD2)
            / 2, CC * A1[NM1,N], CC * A2[NM1,N], G1, G2, K1,
            K2); 'IF' Q = NM1 'THEN'
            'BEGIN' VAL1[NM1]:= G1 + DD1; VAL2[NM1]:= G2 + DD2;
                VAL1[N]:= K1 + DD1; VAL2[N]:= K2 + DD2;
                N:= N - 2; 'IF' N > 1 'THEN' HC:= B[N - 1];
            'END'
            'ELSE'
            'BEGIN' COUNT:= COUNT + 1;
                'IF' COUNT > MAX 'THEN' 'GOTO' OUT; Z1:= K1 + DD1;
                Z2:= K2 + DD2;
                'IF' ABS(CC) > ABS(HC) 'THEN' Z1:= Z1 + ABS(CC);
                HC:= CC / 2; I:= Q1:= Q + 1;
                AIJ1:= A1[Q,Q] - Z1; AIJ2:= A2[Q,Q] - Z2;
                AI1I:= B[Q];
                KAPPA:= SQRT(AIJ1 ** 2 + AIJ2 ** 2 + AI1I ** 2);
                MUI1:= AIJ1 / KAPPA; MUI2:= AIJ2 / KAPPA;
                NUI:= AI1I / KAPPA; A1[Q,Q]:= KAPPA;
                A2[Q,Q]:= 0; A1[Q1,Q1]:= A1[Q1,Q1] - Z1;
                A2[Q1,Q1]:= A2[Q1,Q1] - Z2;
                ROTCOMROW(Q1, N, Q, Q1, A1, A2, MUI1, MUI2,
                NUI);
                ROTCOMCOL(Q, Q, Q, Q1, A1, A2, MUI1, - MUI2, -
                NUI); A1[Q,Q]:= A1[Q,Q] + Z1;
                A2[Q,Q]:= A2[Q,Q] + Z2;
                'FOR' I1:= Q1 + 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' AIJ1:= A1[I,I]; AIJ2:= A2[I,I];
                    AI1I:= B[I];
                    KAPPA:= SQRT(AIJ1 ** 2 + AIJ2 ** 2 + AI1I **
                    2); MUIM11:= MUI1; MUIM12:= MUI2;
                    NUIM1:= NUI; MUI1:= AIJ1 / KAPPA;
                    MUI2:= AIJ2 / KAPPA; NUI:= AI1I / KAPPA;
                    A1[I1,I1]:= A1[I1,I1] - Z1;
                    A2[I1,I1]:= A2[I1,I1] - Z2;
                    ROTCOMROW(I1, N, I, I1, A1, A2, MUI1,
                    MUI2, NUI); A1[I,I]:= MUIM11 * KAPPA;
                    A2[I,I]:= - MUIM12 * KAPPA;
                    B[I - 1]:= NUIM1 * KAPPA;

                    ROTCOMCOL(Q, I, I, I1, A1, A2, MUI1, -
                    MUI2, - NUI); A1[I,I]:= A1[I,I] + Z1;
                    A2[I,I]:= A2[I,I] + Z2; I:= I1;
                'END';
                AIJ1:= A1[N,N]; AIJ2:= A2[N,N];
                KAPPA:= SQRT(AIJ1 ** 2 + AIJ2 ** 2);
                'IF' ('IF' KAPPA < TOL 'THEN' 'TRUE' 'ELSE' AIJ2 ** 2
                <= EM[0] * AIJ1 ** 2) 'THEN'
                'BEGIN' B[NM1]:= NUI * AIJ1;
                    A1[N,N]:= AIJ1 * MUI1 + Z1;
                    A2[N,N]:= - AIJ1 * MUI2 + Z2
                'END'
                'ELSE'
                'BEGIN' B[NM1]:= NUI * KAPPA; A1NN:= MUI1 * KAPPA;
                    A2NN:= - MUI2 * KAPPA; MUI1:= AIJ1 / KAPPA;
                    MUI2:= AIJ2 / KAPPA;
                    COMCOLCST(Q, NM1, N, A1, A2, MUI1, MUI2);
                    A1[N,N]:= MUI1 * A1NN - MUI2 * A2NN + Z1;
                    A2[N,N]:= MUI1 * A2NN + MUI2 * A1NN + Z2;
                'END';
            'END'
        'END';
        'IF' N > 0 'THEN' 'GOTO' IN;
    OUT: EM[3]:= R; EM[5]:= COUNT; VALQRICOM:= N;
    'END' VALQRICOM;
        'EOP'
