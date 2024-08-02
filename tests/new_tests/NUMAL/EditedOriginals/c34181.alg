'CODE' 34181;
    'COMMENT' MCA 2411;
    'PROCEDURE' REAVECHES(A, N, LAMBDA, EM, V); 'VALUE' N, LAMBDA;
    'INTEGER' N; 'REAL' LAMBDA; 'ARRAY' A, EM, V;
    'BEGIN' 'INTEGER' I, I1, J, COUNT, MAX;
        'REAL' M, R, NORM, MACHTOL, TOL;
        'BOOLEAN' 'ARRAY' P[1:N];

        NORM:= EM[1]; MACHTOL:= EM[0] * NORM; TOL:= EM[6] * NORM;
        MAX:= EM[8]; A[1,1]:= A[1,1] - LAMBDA;
     GAUSS: 'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' I1:= I + 1; R:= A[I,I]; M:= A[I1,I];
            'IF' ABS(M) < MACHTOL 'THEN' M:= MACHTOL;
            P[I]:= ABS(M) <= ABS(R);
            'IF' P[I] 'THEN'
            'BEGIN' A[I1,I]:= M:= M / R;
                'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO'
                A[I1,J]:= ('IF' J > I1 'THEN' A[I1,J]
                'ELSE' A[I1,J] - LAMBDA) - M * A[I,J]
            'END'
            'ELSE'
            'BEGIN' A[I,I]:= M; A[I1,I]:= M:= R / M;
                'FOR' J:= I1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' R:= ('IF' J > I1 'THEN' A[I1,J] 'ELSE'
                    A[I1,J] - LAMBDA);
                    A[I1,J]:= A[I,J] - M * R; A[I,J]:= R
                'END'
            'END'
        'END' GAUSS;
        'IF' ABS(A[N,N]) < MACHTOL 'THEN' A[N,N]:= MACHTOL;
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' V[J]:= 1; COUNT:= 0;
     FORWARD: COUNT:= COUNT + 1; 'IF' COUNT > MAX 'THEN' 'GOTO' OUT;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' I1:= I + 1;
            'IF' P[I] 'THEN' V[I1]:= V[I1] - A[I1,I] * V[I] 'ELSE'
            'BEGIN' R:= V[I1]; V[I1]:= V[I] - A[I1,I] * R;
                V[I]:=R
            'END'
        'END' FORWARD;
     BACKWARD: 'FOR' I:= N 'STEP' -1 'UNTIL' 1 'DO'
        V[I]:= (V[I] - MATVEC(I + 1, N, I, A, V)) / A[I,I];
        R:= 1 / SQRT(VECVEC(1, N, 0, V, V));
        'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' V[J]:= V[J] * R;
        'IF' R > TOL 'THEN' 'GOTO' FORWARD;
     OUT: EM[7]:= R; EM[9]:= COUNT
    'END' REAVECHES

        ;'EOP'
