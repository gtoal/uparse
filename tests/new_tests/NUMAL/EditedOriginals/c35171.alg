'CODE' 35171;
    'REAL' 'PROCEDURE' BESS I1(X); 'VALUE' X; 'REAL' X;
    'IF' X=0 'THEN' BESS I1:=0 'ELSE'
    'IF' ABS(X) <= 15.0 'THEN'
    'BEGIN' 'REAL' Z, DENOMINATOR, NUMERATOR;
      Z:= X*X;
      DENOMINATOR:=
      Z*(Z-.22258  36740  00860  @4)
        +.13629  35930  52499  @7;
      NUMERATOR:=
      (Z*(Z*(Z*(Z*(Z*(Z*(Z*
      (Z*(Z*(Z*(Z*(Z*(Z*(Z*
       .20717  57672  32792  @-26
      +.25709  19055  84414  @-23)
      +.30627  92836  56135  @-20)
      +.26137  27721  58124  @-17)
      +.17846  93614  10091  @-14)
      +.96362  88915  18450  @-12)
      +.41006  89068  47159  @-09)
      +.13545  52288  41096  @-06)
      +.33947  28903  08516  @-04)
      +.62472  61951  27003  @-02)
      +.80614  48788  21295  @-00)
      +.68210  05679  80207  @+02)
      +.34106  97522  84422  @+04)
      +.84070  57728  77836  @+05)
      +.68146  79652  62502  @+06);
      BESS I1:= X*(NUMERATOR/DENOMINATOR)
    'END' 'ELSE'
    'BEGIN'
    BESS I1:= EXP(ABS(X))*NONEXP BESS I1(X)
    'END';
        'EOP'
