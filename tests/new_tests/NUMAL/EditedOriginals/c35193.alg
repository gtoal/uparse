'CODE' 35193;
  'COMMENT' COMPUTATION OF NONEXPONENTIAL MODIFIED BESSEL
  FUNCTIONS OF FRACTIONAL ORDER;
  'PROCEDURE' NONEXP BESS IAPLUSN(A, X, N, IA); 'VALUE' A, X, N;
  'REAL' X, A; 'INTEGER' N; 'ARRAY' IA;
  'IF' X= 0 'THEN'
  'BEGIN' IA[0]:= 'IF' A= 0 'THEN' 1 'ELSE' 0;
    'FOR' N:= N 'STEP' -1 'UNTIL' 1 'DO' IA[N]:= 0 'END'
  'ELSE' 'IF' A= 0 'THEN'
  'BEGIN'
    NONEXP BESSI(X, N, IA)
  'END' 'ELSE' 'IF' A= .5 'THEN'
  'BEGIN' 'REAL' C;
    C:= .797 884 560 802 865 * SQRT(X);
    NONEXP SPHER BESSI(X, N, IA);
    'FOR' N:= N 'STEP' -1 'UNTIL' 0 'DO' IA[N]:= C * IA[N]
  'END' 'ELSE'
  'BEGIN' 'INTEGER' M, NU; 'REAL' R, S, LABDA, L, A2, X2;
    A2:= A+A; X2:= 2/X; L:=1;
    NU:= START(X,N,1) ; R:= S:= 0;
    'FOR' M:= 1 'STEP' 1 'UNTIL' NU 'DO' L:= L * (M+A2)/(M+1);
    'FOR' M:= NU 'STEP' -1 'UNTIL' 1 'DO'
    'BEGIN' R:= 1/(X2 *(A+M)+R); L:= L*(M+1)/(M+A2);
      LABDA:= L*(M+A) * 2; S:= R * (LABDA + S);
      'IF' M  <=  N 'THEN' IA[M]:= R
    'END';
    IA[0]:= R:= 1/(1+S)/GAMMA(1+A)/X2 **A;
    'FOR' M:= 1 'STEP' 1 'UNTIL' N 'DO' IA[M]:= R:= IA[M] * R;
  'END';
        'EOP'
