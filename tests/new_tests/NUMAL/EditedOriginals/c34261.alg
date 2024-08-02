'CODE' 34261;
'PROCEDURE' PSTTFMMAT(A, N, V, B);
'VALUE' N; 'INTEGER' N; 'ARRAY' A, V, B;
'BEGIN' 'INTEGER' I, I1, J;
    'REAL' H;

    I1:= N; V[N,N]:= 1;
    'FOR' I:= N - 1 'STEP' - 1 'UNTIL' 1 'DO'
    'BEGIN' H:= B[I] * A[I,I1]; 'IF' H < 0 'THEN'
        'BEGIN' 'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO' V[J,I]:= A[I,J] /
            H;
            'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO'
            ELMCOL(I1, N, J, I, V, V, MATMAT(I1, N, I, J, A, V))
        'END';
        'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO' V[I,J]:= V[J,I]:= 0;
        V[I,I]:= 1; I1:= I
    'END'
'END' PSTTFMMAT;
        'EOP'
