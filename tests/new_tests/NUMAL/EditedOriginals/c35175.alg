
'CODE' 35175;
    'REAL' 'PROCEDURE' NONEXP BESS I0(X);
    'VALUE' X; 'REAL' X;
    'IF' X= 0 'THEN'
    NONEXP BESS I0:=1 'ELSE'
    'IF' ABS(X) <= 15.0 'THEN'
    'BEGIN'
      NONEXP BESS I0:= EXP(-ABS(X))*BESS I0(X)
    'END' 'ELSE'
    'BEGIN' 'REAL' SQRTX, AR, BR, BR1, BR2, Z, Z2, NUMERATOR,
      DENOMINATOR;
      X:=ABS(X); SQRTX:= SQRT(X);
      BR1:= BR2:= 0; Z:= 30/X-1; Z2:= Z+Z;
      'FOR' AR:= .24392  60769  778,
      -.11559  19781  04435  @3,
      +.78403  42490  05088  @4,
      -.14346  46313  13583  @6  'DO'
      'BEGIN' BR:= Z2*BR1-BR2+AR; BR2:= BR1; BR1:= BR 'END';
      NUMERATOR:= Z*BR1-BR2+.34651  98333  57379  @6;
      BR1:= BR2:= 0;
      'FOR' AR:= 1, -.32519  73333  69824  @3,
      +.20312  84361  00794  @5,
      -.36184  77792  19653  @6  'DO'
      'BEGIN' BR:= Z2*BR1 - BR2 + AR;
          BR2:= BR1; BR1:= BR
      'END';
      DENOMINATOR:= Z*BR1 - BR2 +.86566  52748  32055  @6;
      NONEXP BESS I0:= (NUMERATOR/DENOMINATOR)/SQRTX;
    'END';
        'EOP'
