'CODE' 34161;
    'COMMENT' MCA 2321;
    'INTEGER' 'PROCEDURE' QRISYMTRI(A, N, D, B, BB, EM); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, D, B, BB, EM;
    'BEGIN' 'INTEGER' I, J, J1, K, M, M1, COUNT, MAX;
        'REAL' BBMAX, R, S, SIN, T, C, COS, OLDCOS, G, P, W, TOL, TOL2,
        LAMBDA, DK1, A0, A1;

        TOL:= EM[2] * EM[1]; TOL2:= TOL * TOL; COUNT:= 0; BBMAX:= 0;
        MAX:= EM[4]; M:= N;
     IN: K:= M; M1:= M - 1;
     NEXT: K:= K - 1; 'IF' K > 0 'THEN'
        'BEGIN' 'IF' BB[K] >= TOL2 'THEN' 'GOTO' NEXT;
            'IF' BB[K] > BBMAX 'THEN' BBMAX:= BB[K]
        'END';
        'IF' K = M1 'THEN' M:= M1 'ELSE'
        'BEGIN'
            T:= D[M] - D[M1]; R:= BB[M1];
            'IF' ABS(T) < TOL 'THEN' S:= SQRT(R) 'ELSE'
            'BEGIN' W:= 2 / T; S:= W * R / (SQRT(W * W * R + 1) + 1)
            'END'; 'IF' K = M - 2 'THEN'
            'BEGIN' D[M]:= D[M] + S; D[M1]:= D[M1] - S;
                T:= - S / B[M1]; R:= SQRT(T * T + 1); COS:= 1 / R;
                SIN:= T / R; ROTCOL(1,N,M1,M,A,COS,SIN); M:= M - 2
            'END'
            'ELSE'
            'BEGIN' COUNT:= COUNT + 1;
                'IF' COUNT > MAX 'THEN' 'GOTO' END;
                LAMBDA:= D[M] + S; 'IF' ABS(T) < TOL 'THEN'
                'BEGIN' W:= D[M1] - S;
                    'IF' ABS(W) < ABS(LAMBDA) 'THEN' LAMBDA:= W
                'END';
                K:= K + 1; T:= D[K] - LAMBDA; COS:= 1; W:= B[K];
                P:= SQRT(T * T + W * W); J1:= K;
                'FOR' J:= K + 1 'STEP' 1 'UNTIL' M 'DO'
                'BEGIN' OLDCOS:= COS; COS:= T / P; SIN:= W / P;
                    DK1:= D[J] - LAMBDA; T:= OLDCOS * T;
                    D[J1]:= (T + DK1) * SIN * SIN + LAMBDA + T;
                    T:= COS * DK1 - SIN * W * OLDCOS; W:= B[J];
                    P:= SQRT(T * T + W * W); G:= B[J1]:= SIN * P;
                    BB[J1]:= G * G; ROTCOL(1, N, J1, J, A, COS, SIN);
                    J1:= J
                'END';
                D[M]:= COS * T + LAMBDA; 'IF' T < 0 'THEN' B[M1]:= - G
            'END' QRSTEP
        'END';
        'IF' M > 0 'THEN' 'GOTO' IN;
     END: EM[3]:= SQRT(BBMAX); EM[5]:= COUNT; QRISYMTRI:= M
    'END' QRISYMTRI;
        'EOP'
