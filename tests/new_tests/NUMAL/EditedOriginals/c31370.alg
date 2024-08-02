'CODE' 31370;
    'PROCEDURE' ALL JAC ZER(N, ALFA, BETA, ZER);
    'VALUE' N, ALFA, BETA     ; 'INTEGER' N;
    'REAL' ALFA, BETA     ; 'ARRAY' ZER;
    'IF' ALFA = BETA 'THEN'
    'BEGIN' 'INTEGER' I, M;
        'ARRAY' A, B[0:N//2], EM[0:5];
        'REAL' MIN, GAMMA, SUM, ZERI;
        M:= N//2; 'IF' N ^= 2*M 'THEN'
        'BEGIN' GAMMA:= + 0.5; ZER[M + 1]:= 0 'END'
        'ELSE' GAMMA:= - 0.5;
        MIN:= 0.25 - ALFA*ALFA; SUM:= ALFA + GAMMA + 2;
        A[0]:= (GAMMA - ALFA)/SUM; A[1]:= MIN/SUM/(SUM + 2);
        B[1]:= 4*(1 + ALFA)*(1 + GAMMA)/SUM/SUM/(SUM + 1);
        'FOR' I:= 2 'STEP' 1 'UNTIL' M - 1 'DO'
        'BEGIN' SUM:= I + I + ALFA + GAMMA;
            A[I]:= MIN/SUM/(SUM + 2); SUM := SUM*SUM;
            B[I]:= 4*I*(I + ALFA + GAMMA)*(I + ALFA)*(I + GAMMA)/
            SUM/(SUM - 1)
        'END';
        EM[0]:=ARREB; EM[2]:=@-10; EM[4]:= 6*M;
        ALL ZER ORT POL (M, A, B, ZER, EM);
        'FOR' I:= 1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' ZER[I]:= ZERI:= - SQRT((1 + ZER[I])/2);
            ZER[N + 1 - I]:= - ZERI
        'END'
    'END' 'ELSE'
    'BEGIN' 'INTEGER' I; 'REAL' SUM, MIN;
        'ARRAY' A, B[0:N], EM[0:5];
        MIN:= (BETA - ALFA)*(BETA + ALFA);
        SUM:= ALFA + BETA + 2; B[0]:= 0;
        A[0]:= (BETA - ALFA)/SUM;
        A[1]:= MIN/SUM/(SUM + 2);
        B[1]:= 4*(1 + ALFA)*(1 + BETA)/SUM/SUM/(SUM + 1);
        'FOR' I:= 2 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' SUM:= I + I + ALFA + BETA;
            A[I]:= MIN/SUM/(SUM + 2); SUM:= SUM*SUM;
            B[I]:= 4*I*(I + ALFA + BETA)*(I + ALFA)*(I + BETA)/
            (SUM - 1)/SUM
        'END';
        EM[0]:=ARREB; EM[2]:= 1.0@-8; EM[4]:= 6*N;
        ALL ZER ORT POL(N, A, B, ZER, EM)
    'END' ALL JAC ZER;
        'EOP'
