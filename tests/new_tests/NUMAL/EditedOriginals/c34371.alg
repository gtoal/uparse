'CODE' 34371;
    'INTEGER' 'PROCEDURE' QRIHRM(A, N, VAL, VR, VI, EM); 'VALUE' N;
    'INTEGER' N; 'ARRAY' A, VAL, VR, VI, EM;
    'BEGIN' 'INTEGER' I, J;
        'ARRAY' B, BB[1:N], TR, TI[1:N - 1];
        HSHHRMTRI(A, N, VAL, B, BB, EM, TR, TI);
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' VR[I,I]:= 1;
            'FOR' J:= I + 1 'STEP' 1 'UNTIL' N 'DO' VR[I,J]:= VR[J,I]:=
            0
        'END';
        B[N]:= BB[N]:= 0;
        I:= QRIHRM:= QRISYMTRI(VR, N, VAL, B, BB, EM);
        BAKHRMTRI(A, N, I+1, N, VR, VI, TR, TI);
    'END' QRIHRM;
        'EOP'
