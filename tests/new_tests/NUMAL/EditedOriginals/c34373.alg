'CODE' 34373;
    'INTEGER' 'PROCEDURE' QRICOM(A1, A2, B, N, EM, VAL1, VAL2, VEC1,
    VEC2); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A1, A2, B, EM, VAL1, VAL2, VEC1, VEC2;
    'BEGIN' 'INTEGER' M, NM1, I, I1, J, Q, Q1, MAX, COUNT;
        'REAL' R, Z1, Z2, DD1, DD2, CC, P1, P2, T1, T2, DELTA1,
        DELTA2, MV1, MV2, H, H1, H2, G1, G2, K1, K2, HC,
        AIJ12, AIJ22, A1NN, A2NN, AIJ1, AIJ2, AI1I, KAPPA,
        NUI, MUI1, MUI2, MUIM11, MUIM12, NUIM1, TOL, MACHTOL;
        'ARRAY' TF1, TF2[1:N];
        TOL:= EM[1] * EM[2]; MACHTOL:= EM[0] * EM[1];
        MAX:= EM[4]; COUNT:= 0; R:= 0; M:= N;
        'IF' N > 1 'THEN' HC:= B[N - 1];
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' VEC1[I,I]:= 1; VEC2[I,I]:= 0;
            'FOR' J:= I + 1 'STEP' 1 'UNTIL' N 'DO' VEC1[I,J]:=
            VEC1[J,I]:= VEC2[I,J]:= VEC2[J,I]:= 0
        'END';
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
            P1:= (A1[NM1,NM1] - DD1) * .5;
            P2:= (A2[NM1,NM1] - DD2) * .5;
            COMKWD(P1, P2, CC * A1[NM1,N], CC * A2[NM1,N], G1,
            G2, K1, K2); 'IF' Q = NM1 'THEN'
            'BEGIN' A1[N,N]:= VAL1[N]:= G1 + DD1;
                A2[N,N]:= VAL2[N]:= G2 + DD2;
                A1[Q,Q]:= VAL1[Q]:= K1 + DD1;
                A2[Q,Q]:= VAL2[Q]:= K2 + DD2;
                KAPPA:= SQRT(K1 ** 2 + K2 ** 2 + CC ** 2);
                NUI:= CC / KAPPA; MUI1:= K1 / KAPPA;
                MUI2:= K2 / KAPPA; AIJ1:= A1[Q,N];
                AIJ2:= A2[Q,N]; H1:= MUI1 ** 2 - MUI2 ** 2;
                H2:= 2 * MUI1 * MUI2; H:= - NUI * 2;
                A1[Q,N]:= H * (P1 * MUI1 + P2 * MUI2) - NUI *
                NUI * CC + AIJ1 * H1 + AIJ2 * H2;
                A2[Q,N]:= H * (P2 * MUI1 - P1 * MUI2) + AIJ2 *
                H1 - AIJ1 * H2;
                ROTCOMROW(Q + 2, M, Q, N, A1, A2, MUI1, MUI2,
                NUI);
                ROTCOMCOL(1, Q - 1, Q, N, A1, A2, MUI1, -
                MUI2, - NUI);
                ROTCOMCOL(1, M, Q, N, VEC1, VEC2, MUI1, -
                MUI2, - NUI); N:= N - 2;
                'IF' N > 1 'THEN' HC:= B[N - 1]; B[Q]:= 0
            'END'

            'ELSE'
            'BEGIN' COUNT:= COUNT + 1;
                'IF' COUNT > MAX 'THEN' 'GOTO' OUT; Z1:= K1 + DD1;
                Z2:= K2 + DD2;
                'IF' ABS(CC) > ABS(HC) 'THEN' Z1:= Z1 + ABS(CC);
                HC:= CC / 2; Q1:= Q + 1; AIJ1:= A1[Q,Q] - Z1;
                AIJ2:= A2[Q,Q] - Z2; AI1I:= B[Q];
                KAPPA:= SQRT(AIJ1 ** 2 + AIJ2 ** 2 + AI1I ** 2);
                MUI1:= AIJ1 / KAPPA; MUI2:= AIJ2 / KAPPA;
                NUI:= AI1I / KAPPA; A1[Q,Q]:= KAPPA;
                A2[Q,Q]:= 0; A1[Q1,Q1]:= A1[Q1,Q1] - Z1;
                A2[Q1,Q1]:= A2[Q1,Q1] - Z2;
                ROTCOMROW(Q1, M, Q, Q1, A1, A2, MUI1, MUI2,
                NUI);
                ROTCOMCOL(1, Q, Q, Q1, A1, A2, MUI1, - MUI2, -
                NUI); A1[Q,Q]:= A1[Q,Q] + Z1;
                A2[Q,Q]:= A2[Q,Q] + Z2;
                ROTCOMCOL(1, M, Q, Q1, VEC1, VEC2, MUI1, -
                MUI2, - NUI);
                'FOR' I:= Q1 'STEP' 1 'UNTIL' NM1 'DO'
                'BEGIN' I1:= I + 1; AIJ1:= A1[I,I]; AIJ2:= A2[I,I];
                    AI1I:= B[I];
                    KAPPA:= SQRT(AIJ1 ** 2 + AIJ2 ** 2 + AI1I **
                    2); MUIM11:= MUI1; MUIM12:= MUI2;
                    NUIM1:= NUI; MUI1:= AIJ1 / KAPPA;
                    MUI2:= AIJ2 / KAPPA; NUI:= AI1I / KAPPA;
                    A1[I1,I1]:= A1[I1,I1] - Z1;
                    A2[I1,I1]:= A2[I1,I1] - Z2;
                    ROTCOMROW(I1, M, I, I1, A1, A2, MUI1,
                    MUI2, NUI); A1[I,I]:= MUIM11 * KAPPA;
                    A2[I,I]:= - MUIM12 * KAPPA;
                    B[I - 1]:= NUIM1 * KAPPA;
                    ROTCOMCOL(1, I, I, I1, A1, A2, MUI1, -
                    MUI2, - NUI); A1[I,I]:= A1[I,I] + Z1;
                    A2[I,I]:= A2[I,I] + Z2;
                    ROTCOMCOL(1, M, I, I1, VEC1, VEC2, MUI1, -
                    MUI2, - NUI);
                'END';
                AIJ1:= A1[N,N]; AIJ2:= A2[N,N]; AIJ12:= AIJ1 ** 2;
                AIJ22:= AIJ2 ** 2; KAPPA:= SQRT(AIJ12 + AIJ22);
                'IF' ('IF' KAPPA < TOL 'THEN' 'TRUE' 'ELSE' AIJ22 <=
                EM[0] * AIJ12) 'THEN'
                'BEGIN' B[NM1]:= NUI * AIJ1;
                    A1[N,N]:= AIJ1 * MUI1 + Z1;
                    A2[N,N]:= - AIJ1 * MUI2 + Z2
                'END'
                'ELSE'
                'BEGIN' B[NM1]:= NUI * KAPPA; A1NN:= MUI1 * KAPPA;
                    A2NN:= - MUI2 * KAPPA; MUI1:= AIJ1 / KAPPA;
                    MUI2:= AIJ2 / KAPPA;
                    COMCOLCST(1, NM1, N, A1, A2, MUI1, MUI2);
                    COMCOLCST(1, NM1, N, VEC1, VEC2, MUI1,
                    MUI2);
                    COMROWCST(N + 1, M, N, A1, A2, MUI1, -
                    MUI2);
                    COMCOLCST(N, M, N, VEC1, VEC2, MUI1, MUI2);
                    A1[N,N]:= MUI1 * A1NN - MUI2 * A2NN + Z1;
                    A2[N,N]:= MUI1 * A2NN + MUI2 * A1NN + Z2;
                'END';
            'END';
        'END';
        'IF' N > 0 'THEN' 'GOTO' IN;
        'FOR' J:= M 'STEP' - 1 'UNTIL' 2 'DO'
        'BEGIN' TF1[J]:= 1; TF2[J]:= 0; T1:= A1[J,J]; T2:= A2[J,J];
            'FOR' I:= J - 1 'STEP' - 1 'UNTIL' 1 'DO'
            'BEGIN' DELTA1:= T1 - A1[I,I]; DELTA2:= T2 - A2[I,I];
                COMMATVEC(I + 1, J, I, A1, A2, TF1, TF2, MV1,
                MV2);
                'IF' ABS(DELTA1) < MACHTOL 'AND' ABS(DELTA2) <
                MACHTOL 'THEN'
                'BEGIN' TF1[I]:= MV1 / MACHTOL;
                    TF2[I]:= MV2 / MACHTOL
                'END'
                'ELSE' COMDIV(MV1, MV2, DELTA1, DELTA2, TF1[I],
                TF2[I]);
            'END';
            'FOR' I:= 1 'STEP' 1 'UNTIL' M 'DO' COMMATVEC(1, J, I,
            VEC1, VEC2, TF1, TF2, VEC1[I,J], VEC2[I,J]);
        'END';
    OUT: EM[3]:= R; EM[5]:= COUNT; QRICOM:= N;
    'END' QRICOM;
        'EOP'
