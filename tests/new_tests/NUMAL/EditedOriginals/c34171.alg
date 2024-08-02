'CODE' 34171;
    'COMMENT' MCA 2401;
    'PROCEDURE' BAKREAHES1(A, N, INT, V); 'VALUE' N; 'INTEGER' N;
     'ARRAY' A, V; 'INTEGER' 'ARRAY' INT;
    'BEGIN' 'INTEGER' I, L;
        'REAL' W; 'ARRAY' X[1:N];

        'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO' X[I - 1]:= V[I];
        'FOR' I:= N 'STEP' -1 'UNTIL' 2 'DO'
        'BEGIN' V[I]:= V[I] + MATVEC(1, I - 2, I, A, X);
            L:= INT[I]; 'IF' L > I 'THEN'
            'BEGIN' W:= V[I]; V[I]:= V[L]; V[L]:= W 'END'
        'END'
    'END' BAKREAHES1;
        'EOP'
