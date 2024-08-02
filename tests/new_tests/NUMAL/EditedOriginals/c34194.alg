'CODE' 34194;
    'COMMENT' MCA 2424;
    'INTEGER' 'PROCEDURE' COMEIG1(A, N, EM, RE, IM, VEC);
    'VALUE' N; 'INTEGER' N;
    'ARRAY' A, EM, RE, IM, VEC;
    'BEGIN' 'INTEGER' I, J, K, PJ, ITT;
        'REAL' X, Y, MAX, NEPS;
        'ARRAY' AB[1:N,1:N], D, U, V[1:N];
        'INTEGER' 'ARRAY' INT, INT0[1:N];

        'PROCEDURE' TRANSFER;
        'BEGIN' 'INTEGER' I, J;
            'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
            'FOR' J:= ('IF' I = 1 'THEN' 1 'ELSE' I - 1) 'STEP' 1
            'UNTIL' N 'DO' AB[I,J]:= A[I,J]
        'END' TRANSFER;

        EQILBR(A, N, EM, D, INT0); TFMREAHES(A, N, EM, INT); TRANSFER;
        K:= COMEIG1:= COMVALQRI(AB, N, EM, RE, IM);
        NEPS:= EM[0] * EM[1]; MAX:= 0; ITT:= 0;
        'FOR' I:= K + 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' X:= RE[I]; Y:= IM[I]; PJ:= 0;
         AGAIN: 'FOR' J:= K + 1 'STEP' 1 'UNTIL' I - 1 'DO'
            'BEGIN' 'IF' ((X - RE[J]) ** 2 +
                (Y - IM[J]) ** 2 <= NEPS ** 2) 'THEN'
                'BEGIN' 'IF' PJ = J 'THEN' NEPS:= EM[2] * EM[1]
                    'ELSE' PJ:= J; X:= X + 2 * NEPS; 'GOTO' AGAIN
                'END'
            'END';
            RE[I]:= X; TRANSFER; 'IF' Y ^= 0 'THEN'
            'BEGIN' COMVECHES(AB, N, RE[I], IM[I], EM, U, V);
                'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' VEC[J,I]:= U[J];
                I:= I + 1; RE[I]:= X
            'END'
            'ELSE' REAVECHES(AB, N, X, EM, V);
            'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' VEC[J,I]:= V[J];
            'IF' EM[7] > MAX 'THEN' MAX:= EM[7];
            ITT:= 'IF' ITT > EM[9] 'THEN' ITT 'ELSE' EM[9]
        'END';
        EM[7]:= MAX; EM[9]:= ITT; BAKREAHES2(A, N, K + 1, N, INT, VEC);
        BAKLBR(N, K + 1, N, D, INT0, VEC); COMSCL(VEC, N, K + 1, N, IM)
    'END' COMEIG1;
        'EOP'
