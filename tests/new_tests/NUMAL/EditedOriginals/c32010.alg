'CODE' 32010;
'REAL''PROCEDURE' EULER(AI, I, EPS, TIM);
'VALUE' EPS, TIM; 'INTEGER' I, TIM; 'REAL' AI, EPS;
'BEGIN''INTEGER' K, N, T; 'REAL' MN, MP, DS, SUM; 'ARRAY' M[0:15];
    N:= T:= 0; I:= 0; M[0]:= AI; SUM:= M[0] / 2;
NEXT TERM: I:= I + 1; MN:= AI;
    'FOR' K:= 0 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' MP:= (MN + M[K]) / 2; M[K]:= MN; MN:= MP 'END';
    'IF' ABS(MN) < ABS(M[N]) & N < 15 'THEN'
    'BEGIN' DS:= MN / 2; N:= N + 1; M[N]:= MN 'END' 'ELSE' DS:= MN;
    SUM:= SUM + DS; T:= 'IF' ABS(DS) < EPS 'THEN' T + 1 'ELSE' 0;
    'IF' T < TIM 'THEN' 'GOTO' NEXT TERM;
    EULER:= SUM
'END' EULER;
        'EOP'
