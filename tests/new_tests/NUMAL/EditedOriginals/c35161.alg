'CODE' 35161;
    'REAL' 'PROCEDURE' BESS J1(X); 'VALUE' X; 'REAL' X;
    'IF' X=0 'THEN' BESS J1:= 0 'ELSE'
    'IF' ABS(X) < 8 'THEN'
    'BEGIN' 'REAL' Z, Z2, AR, B0, B1, B2;
      X:= X/8; Z:= 2*X*X - 1; Z2:= Z + Z;
        'COMMENT' COMPUTATION OF J1;
        B1:= B2:= 0;
        'FOR' AR:=
        -.19554          @-15, +.1138572        @-13,
        -.57774042       @-12, +.2528123664     @-10,
        -.94242129816    @- 9, +.2949707007278  @- 7,
        -.76175878054003 @- 6, +.158870192399321@- 4,
        -.260444389348581@- 3, +.324027018268386@- 2,
        -.291755248061542@- 1, +.177709117239728@- 0,
        -.661443934134543@- 0, +.128799409885768@+ 1,
        -.119180116054122@+ 1 'DO'
        'BEGIN' B0:= Z2*B1-B2+AR;
          B2:= B1; B1:= B0
        'END';
      BESS J1:= X * (Z * B1 - B2 + .64835 87706 05265)
    'END' 'ELSE'
    'BEGIN' 'REAL' C, COSX, SINX, P1, Q1; 'INTEGER' SGNX;
      SGNX:= SIGN(X); X:= ABS(X);
      C:= .79788 45608 02865 / SQRT(X);
      COSX:= COS(X-.70685 83470 57703@+1);
      SINX:= SIN(X-.70685 83470 57703@+1);
      BESS PQ1(X, P1, Q1);
      BESS J1:= SGNX * C * (P1*SINX + Q1*COSX)
    'END' BESS J1;
        'EOP'
