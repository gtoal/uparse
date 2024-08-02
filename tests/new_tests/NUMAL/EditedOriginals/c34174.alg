'CODE' 34174;
    'COMMENT' MCA 2406;
    'PROCEDURE' BAKLBR(N, N1, N2, D, INT, VEC); 'VALUE' N, N1, N2;
    'INTEGER' N, N1, N2; 'ARRAY' D, VEC; 'INTEGER' 'ARRAY' INT;
    'BEGIN' 'INTEGER' I, J, K, P, Q; 'REAL' DI;

        P:= 1; Q:= N;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' DI:= D[I]; 'IF' DI ^= 1 'THEN'
            'FOR' J:= N1 'STEP' 1 'UNTIL' N2 'DO' VEC[I,J]:=
            VEC[I,J] * DI; K:= INT[I];
            'IF' K > 0 'THEN' P:= P + 1 'ELSE'
            'IF' K < 0 'THEN' Q:= Q - 1
        'END';
        'FOR' I:= P - 1 + N - Q 'STEP' -1 'UNTIL' 1 'DO'
        'BEGIN' K:= INT[I]; 'IF' K > 0 'THEN'
            'BEGIN' P:= P - 1; 'IF' K ^= P 'THEN'
                ICHROW(N1, N2, K, P, VEC)
            'END' 'ELSE'
            'BEGIN' Q:= Q + 1; 'IF' -K ^= Q 'THEN'
                ICHROW(N1, N2, -K, Q, VEC)
            'END'
        'END'
    'END' BAKLBR;
        'EOP'
