'CODE' 35176;
    'REAL' 'PROCEDURE' NONEXP BESS I1(X); 'VALUE' X; 'REAL' X;
    'IF' X=0 'THEN' NONEXP BESS I1:= 0
    'ELSE' 'IF' ABS(X)> 15.0 'THEN'
    'BEGIN' 'INTEGER' SIGNX ;
      'REAL' AR, BR, BR1, BR2, Z, Z2,
      SQRTX, DENOMINATOR, NUMERATOR;
      SIGNX:= SIGN(X); X:= ABS(X); SQRTX:= SQRT(X);
      Z:= 30/X - 1; Z2 := Z + Z;
          BR1:= BR2:= 0;
      'FOR' AR:=
      +.14940  52814  740  @+1,
      -.36202  64202  42263  @+3,
      +.22054  97222  60336  @+5,
      -.40892  80849  44275  @+6 'DO'
      'BEGIN' BR:= Z2 * BR1 - BR2 + AR;
          BR2:= BR1; BR1:= BR
      'END';
      NUMERATOR:= Z * BR1 -BR2 +.10277  66923  71524  @7;
      BR1:= BR2:= 0; 'FOR' AR:= 1,
      -.63100  32005  51590  @3,
      +.49681  19495  33398  @5,
      -.10042  54281  33695  @7  'DO'
      'BEGIN' BR:= Z2 * BR1 - BR2 + AR; BR2:= BR1; BR1:=BR 'END';
      DENOMINATOR:= Z * BR1 - BR2 +.26028  87678  9105  @7;
      NONEXP BESS I1:= ((NUMERATOR/DENOMINATOR)/SQRTX) * SIGN X
    'END' 'ELSE'
    'BEGIN'
      NONEXP BESS I1:= EXP(-ABS(X))*BESS I1(X)
    'END';

        'EOP'
