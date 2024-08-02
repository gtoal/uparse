'CODE' 31371;
    'PROCEDURE'  ALL LAG ZER(N, ALFA, ZER);
    'VALUE' N, ALFA     ; 'INTEGER'N; 'REAL' ALFA     ; 'ARRAY' ZER;
    'BEGIN' 'INTEGER' I; 'ARRAY' A, B[0:N], EM[0:5];
        B[0]:= 0; A[N - 1]:= N + N + ALFA - 1;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' A[I - 1]:= I + I + ALFA - 1;
            B[I]:= I*(I + ALFA)
        'END';
       EM[0]:=ARREB; EM[2]:= @-10;EM[4]:= 6*N;
        ALL ZER ORT POL(N, A, B, ZER, EM)
    'END' ALL LAG ZER;
        'EOP'
