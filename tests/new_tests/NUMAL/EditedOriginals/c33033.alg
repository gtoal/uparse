'CODE' 33033;
   'PROCEDURE' RKE (X, XE, N, Y, DER, DATA, FI, OUT);
   'VALUE'  FI, N; 'INTEGER' N; 'REAL' X, XE;
   'BOOLEAN' FI; 'ARRAY' Y, DATA;
   'PROCEDURE' DER, OUT;
   'BEGIN' 'INTEGER' J;
      'REAL' XT, H, HMIN, INT, HL, HT, ABSH, FHM, DISCR, TOL, MU,
      MU1, FH, E1, E2;
      'BOOLEAN' LAST, FIRST, REJECT;
      'ARRAY' K0, K1, K2, K3, K4[1:N];
      'IF' FI 'THEN'
      'BEGIN' DATA[3]:= XE - X; DATA[4]:= DATA[5]:= DATA[6]:= 0 'END';
      ABSH:= H:= ABS(DATA[3]);
      'IF' XE < X 'THEN' H:= - H; INT:= ABS(XE - X);
      HMIN:= INT * DATA[1] + DATA[2];
      E1:= 12 * DATA[1] / INT; E2:= 12 * DATA[2] / INT;
      FIRST:= 'TRUE'; REJECT:= 'FALSE'; 'IF' FI 'THEN'
      'BEGIN' LAST:= 'TRUE'; 'GOTO' STEP 'END';
   TEST: ABSH:= ABS(H); 'IF' ABSH < HMIN 'THEN'
      'BEGIN' H:= SIGN (XE - X) * HMIN; ABSH:= HMIN 'END';
      'IF' H >= XE - X 'EQV' H >= 0 'THEN'
      'BEGIN' LAST:= 'TRUE'; H:= XE - X; ABSH:= ABS(H) 'END'
      'ELSE' LAST:= 'FALSE';
   STEP: 'IF' ^ REJECT 'THEN'
      'BEGIN' 'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K0[J]:= Y[J];
          DER(X, K0)
      'END';
      HT:= .184262134833347 * H; XT:= X + HT;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K1[J]:= K0[J] * HT + Y[J];
      DER(XT, K1);
      HT:= .690983005625053@-1 * H; XT:= 4 * HT + X;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K2[J]:=
      (3 * K1[J] + K0[J]) * HT + Y[J];
      DER(XT, K2);
      XT:= .5 * H + X; HT:= .1875 * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K3[J]:=((1.74535599249993
      * K2[J] - K1[J]) * 2.23606797749979 + K0[J]) * HT + Y[J];
      DER(XT, K3);
      XT:= .723606797749979 * H + X; HT:= .4 * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K4[J]:= (((.517595468166681
      * K0[J] - K1[J]) * .927050983124840 + K2[J]) * 1.46352549156242
      + K3[J]) * HT + Y[J];
      DER(XT, K4);
      XT:= 'IF' LAST 'THEN' XE 'ELSE' X + H; HT:= 2 * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K1[J]:= ((((2 * K4[J] +
      K2[J]) * .412022659166595 + K1[J]) * 2.23606797749979 -
      K0[J]) * .375 - K3[J]) * HT + Y[J];
      DER(XT, K1);
      REJECT:= 'FALSE'; FHM:= 0;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' DISCR:= ABS((1.6 * K3[J] - K2[J] - K4[J]) * 5 +
          K0[J] + K1[J]);
         TOL:= ABS(K0[J]) * E1 + E2;
         REJECT:= DISCR > TOL 'OR' REJECT;
         FH:= DISCR / TOL; 'IF' FH > FHM 'THEN' FHM:= FH
      'END';
      MU:= 1 / (1 + FHM) + .45; 'IF' REJECT 'THEN'
      'BEGIN' DATA[5]:= DATA[5] + 1; 'IF' ABSH <= HMIN 'THEN'
         'BEGIN' DATA[6]:= DATA[6] + 1; HL:= H; REJECT:= 'FALSE';
            FIRST:= 'TRUE'; 'GOTO' NEXT
         'END';
         H:= MU * H; 'GOTO' TEST
      'END';
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= 'FALSE'; HL:= H; H:= MU * H; 'GOTO' ACC
      'END';
      FH:= MU * H / HL + MU - MU1; HL:= H; H:= FH * H;
   ACC: MU1:= MU; HT:= HL / 12;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' Y[J]:=
      ((K2[J] + K4[J]) * 5 + K0[J] + K1[J]) * HT + Y[J];
   NEXT: DATA[3]:= HL; DATA[4]:= DATA[4] + 1; X:= XT; OUT;
      'IF' X ^= XE 'THEN' 'GOTO' TEST
   'END' RKE;
        'EOP'
