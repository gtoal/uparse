'CODE' 35180;
  'PROCEDURE' BESS JAPLUSN(A, X, N, JA); 'VALUE' A, X, N;
  'INTEGER' N; 'REAL' X, A; 'ARRAY' JA;
  'IF' X = 0 'THEN'
  'BEGIN' JA[0]:= 'IF' A = 0 'THEN' 1 'ELSE' 0;
    'FOR' N:= N 'STEP' -1 'UNTIL' 1 'DO' JA[N]:= 0
  'END' 'ELSE'
  'IF' A = 0 'THEN'
  'BEGIN'
    BESS J(X, N, JA)
  'END' 'ELSE'
  'IF' A = .5 'THEN'
  'BEGIN' 'REAL' S;
    S:= SQRT(X) * .797 884 560 802 865; 'COMMENT' S = SQRT(2X / PI);
    SPHER BESS J(X, N, JA);
    'FOR' N:= N 'STEP' - 1 'UNTIL' 0 'DO' JA[N]:= JA[N] * S
  'END'

  'ELSE'
  'BEGIN' 'REAL' A2, X2, R, S, L, LABDA; 'INTEGER' K, M, NU;
    L:= 1; NU:= START(X,N,0);
    'FOR' M:= 1 'STEP' 1 'UNTIL' NU 'DO'
    L:= L * (M+A) / (M+1); R:= S:= 0; X2:= 2 / X; K:= -1; A2:= A + A;
    'FOR' M:= NU+NU 'STEP' - 1 'UNTIL' 1 'DO'
    'BEGIN' R:= 1 / (X2 * (A + M)    - R);
      'IF' K = 1 'THEN' LABDA:= 0 'ELSE'
      'BEGIN' L:= L * (M + 2) / (M + A2); LABDA:= L * (M + A) 'END';
      S:= R * (LABDA + S); K:= -K;
      'IF' M<= N 'THEN' JA[M]:= R
    'END';
    JA[0]:= R:= 1 / GAMMA(1 + A) / (1 + S) / X2 ** A;
    'FOR' M:= 1 'STEP' 1 'UNTIL' N 'DO' JA[M]:= R:= R * JA[M];
  'END' BESS JAPLUSN;
        'EOP'
