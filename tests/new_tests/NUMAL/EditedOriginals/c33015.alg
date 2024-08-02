'CODE' 33015 ;
   'PROCEDURE' RK3N(X, A, B, Y, YA, Z, ZA, FXYJ, J, E, D,
   FI, N); 'VALUE' B, FI, N; 'INTEGER' J, N; 'REAL' X, A, B, FXYJ;
   'BOOLEAN' FI; 'ARRAY' Y, YA, Z, ZA, E, D;
   'BEGIN' 'INTEGER' JJ;
      'REAL' XL, H, HMIN, INT, HL, ABSH, FHM, DISCRY, DISCRZ,
      TOLY, TOLZ, MU, MU1, FHY, FHZ;
      'BOOLEAN' LAST, FIRST, REJECT;
      'ARRAY' YL, ZL, K0, K1, K2, K3, K4, K5[1:N], EE[1:4 *
      N];
      'IF' FI 'THEN'
      'BEGIN' D[3]:= A;
         'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
         'BEGIN' D[JJ + 3]:= YA[JJ]; D[N + JJ + 3]:= ZA[JJ]
         'END'
      'END';
      D[1]:= 0; XL:= D[3];
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' YL[JJ]:= D[JJ + 3]; ZL[JJ]:= D[N + JJ + 3] 'END';
      'IF' FI 'THEN' D[2]:= B - D[3]; ABSH:= H:= ABS(D[2]);
      'IF' B - XL < 0 'THEN' H:= - H; INT:= ABS(B - XL);
      HMIN:= INT * E[1] + E[2];
      'FOR' JJ:= 2 'STEP' 1 'UNTIL' 2 * N 'DO'
      'BEGIN' HL:= INT * E[2 * JJ - 1] + E[2 * JJ];
         'IF' HL < HMIN 'THEN' HMIN:= HL
      'END';
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' 4 * N 'DO' EE[JJ]:= E[JJ] / INT;
      FIRST:= REJECT:= 'TRUE'; 'IF' FI 'THEN'
      'BEGIN' LAST:= 'TRUE'; 'GOTO' STEP 'END';
   TEST: ABSH:= ABS(H); 'IF' ABSH < HMIN 'THEN'
      'BEGIN' H:= 'IF' H > 0 'THEN' HMIN 'ELSE' - HMIN; ABSH:= HMIN
      'END';
      'IF' H >= B - XL 'EQV' H >= 0 'THEN'
      'BEGIN' D[2]:= H; LAST:= 'TRUE'; H:= B - XL;
         ABSH:= ABS(H)
      'END'
      'ELSE' LAST:= 'FALSE';
   STEP: 'IF' REJECT 'THEN'
      'BEGIN' X:= XL;
         'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' Y[JJ]:= YL[JJ];
         'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K0[J]:= FXYJ * H
      'END'
      'ELSE'
      'BEGIN' FHY:= H / HL;
         'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' K0[JJ]:= K5[JJ] * FHY
      'END';
      X:= XL + .27639 3202250021 * H;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' Y[JJ]:= YL[JJ] + (ZL[JJ]
      * .276393202250021 + K0[JJ] * .038196601125011) * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K1[J]:= FXYJ * H;
      X:= XL + .723606797749979 * H;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' Y[JJ]:= YL[JJ] + (ZL[JJ]
      * .723606797749979 + K1[JJ] * .261803398874989) * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K2[J]:= FXYJ * H;
      X:= XL + H * .5;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' Y[JJ]:= YL[JJ] + (ZL[JJ]
      * .5 + K0[JJ] * .046875 + K1[JJ] * .079824155839840
      - K2[JJ] * .00169 9155839840) * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K4[J]:= FXYJ * H;
      X:= 'IF' LAST 'THEN' B 'ELSE' XL + H;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' Y[JJ]:= YL[JJ] + (ZL[JJ]
      + K0[JJ] * .309016994374947 + K2[JJ] *
      .190983005625053) * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K3[J]:= FXYJ * H;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' Y[JJ]:= YL[JJ] + (ZL[JJ]
      + K0[JJ] * .083333333333333 + K1[JJ] * .30150
      2832395825 + K2[JJ] * .115163834270842) * H;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K5[J]:= FXYJ * H;
      REJECT:= 'FALSE'; FHM:= 0;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' DISCRY:= ABS(( - K0[JJ] * .5 + K1[JJ] *
         1.809016994374947 + K2[JJ] * .690983005625053 -
         K4[JJ] * 2) * H);
         DISCRZ:= ABS((K0[JJ] - K3[JJ]) * 2 - (K1[JJ] +
         K2[JJ]) * 10 + K4[JJ] * 16 + K5[JJ] * 4);
         TOLY:= ABSH * (ABS(ZL[JJ]) * EE[2 * JJ - 1] +
         EE[2 * JJ]);
         TOLZ:= ABS(K0[JJ]) * EE[2 * (JJ + N) - 1] + ABSH
         * EE[2 * (JJ + N)];
         REJECT:= DISCRY > TOLY 'OR' DISCRZ > TOLZ 'OR' REJECT;
         FHY:= DISCRY / TOLY; FHZ:= DISCRZ / TOLZ;
         'IF' FHZ > FHY 'THEN' FHY:= FHZ;
         'IF' FHY > FHM 'THEN' FHM:= FHY
      'END';
      MU:= 1 / (1 + FHM) + .45; 'IF' REJECT 'THEN'
      'BEGIN' 'IF' ABSH <= HMIN 'THEN'
         'BEGIN' D[1]:= D[1] + 1;
            'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' Y[JJ]:= YL[JJ]; Z[JJ]:= ZL[JJ] 'END';
            FIRST:= 'TRUE'; 'GOTO' NEXT
         'END';
         H:= MU * H; 'GOTO' TEST
      'END' REJ;
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= 'FALSE'; HL:= H; H:= MU * H; 'GOTO' ACC
      'END';
      FHY:= MU * H / HL + MU - MU1; HL:= H; H:= FHY * H;
   ACC: MU1:= MU;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO' Z[JJ]:= ZL[JJ] + (K0[JJ]
      + K3[JJ]) * .083333333333333 + (K1[JJ] + K2[JJ]) *
      .416666666666667;
   NEXT: 'IF' B ^= X 'THEN'
      'BEGIN' XL:= X;
         'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
         'BEGIN' YL[JJ]:= Y[JJ]; ZL[JJ]:= Z[JJ] 'END';
         'GOTO' TEST
      'END';
      'IF' 'NOT'LAST 'THEN' D[2]:= H; D[3]:= X;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' D[JJ + 3]:= Y[JJ]; D[N + JJ + 3]:= Z[JJ] 'END'
   'END' RK3N;
        'EOP'
