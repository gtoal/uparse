'CODE' 33013 ;
   'PROCEDURE' RK2N(X, A, B, Y, YA, Z, ZA, FXYZJ, J, E, D,
   FI, N); 'VALUE' B, FI, N; 'INTEGER' J, N; 'REAL' X, A, B, FXYZJ;
   'BOOLEAN' FI; 'ARRAY' Y, YA, Z, ZA, E, D;
   'BEGIN' 'INTEGER' JJ;
      'REAL' XL, H, INT, HMIN, HL, ABSH, FHM, DISCRY, DISCRZ,
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
      FIRST:= 'TRUE'; 'IF' FI 'THEN'
      'BEGIN' LAST:= 'TRUE'; 'GOTO' STEP 'END';
   TEST: ABSH:= ABS(H); 'IF' ABSH < HMIN 'THEN'
      'BEGIN' H:= 'IF' H > 0 'THEN' HMIN 'ELSE' - HMIN;
         ABSH:= ABS(H)
      'END';
      'IF' H >= B - XL 'EQV' H >= 0 'THEN'
      'BEGIN' D[2]:= H; LAST:= 'TRUE'; H:= B - XL;
         ABSH:= ABS(H)
      'END'
      'ELSE' LAST:= 'FALSE';
   STEP: X:= XL;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ]; Z[JJ]:= ZL[JJ] 'END';
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K0[J]:= FXYZJ * H;
      X:= XL + H / 4.5;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ] + (ZL[JJ] * 18 + K0[JJ] * 2) /
         81 * H; Z[JJ]:= ZL[JJ] + K0[JJ] / 4.5;
      'END';
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K1[J]:= FXYZJ * H;
      X:= XL + H / 3;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ] + (ZL[JJ] * 6 + K0[JJ]) / 18 * H;
         Z[JJ]:= ZL[JJ] + (K0[JJ] + K1[JJ] * 3) / 12
      'END';
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K2[J]:= FXYZJ * H;
      X:= XL + H * .5;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ] + (ZL[JJ] * 8 + K0[JJ] + K2[JJ])
         / 16 * H;
         Z[JJ]:= ZL[JJ] + (K0[JJ] + K2[JJ] * 3) / 8
      'END';
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K3[J]:= FXYZJ * H;
      X:= XL + H * .8;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ] + (ZL[JJ] * 100 + K0[JJ] * 12 +
         K3[JJ] * 28) / 125 * H;
         Z[JJ]:= ZL[JJ] + (K0[JJ] * 53 - K1[JJ] * 135 +
         K2[JJ] * 126 + K3[JJ] * 56) / 125
      'END';
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K4[J]:= FXYZJ * H;
      X:= 'IF' LAST 'THEN' B 'ELSE' XL + H;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ] + (ZL[JJ] * 336 + K0[JJ] * 21 +
         K2[JJ] * 92 + K4[JJ] * 55) / 336 * H;
         Z[JJ]:= ZL[JJ] + (K0[JJ] * 133 - K1[JJ] * 378 +
         K2[JJ] * 276 + K3[JJ] * 112 + K4[JJ] * 25) / 168
      'END';
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K5[J]:= FXYZJ * H;
      REJECT:= 'FALSE'; FHM:= 0;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' DISCRY:= ABS(( - K0[JJ] * 21 + K2[JJ] * 108 -
         K3[JJ] * 112 + K4[JJ] * 25) / 56 * H);
         DISCRZ:= ABS(K0[JJ] * 21 - K2[JJ] * 162 + K3[JJ]
         * 224 - K4[JJ] * 125 + K5[JJ] * 42) / 14;
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
      'END';
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= 'FALSE'; HL:= H; H:= MU * H; 'GOTO' ACC
      'END';
      FHM:= MU * H / HL + MU - MU1; HL:= H; H:= FHM * H;
   ACC: MU1:= MU;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ] + (ZL[JJ] * 56 + K0[JJ] * 7 +
         K2[JJ] * 36 - K4[JJ] * 15) / 56 * HL;
         Z[JJ]:= ZL[JJ] + ( - K0[JJ] * 63 + K1[JJ] * 189
         - K2[JJ] * 36 - K3[JJ] * 112 + K4[JJ] * 50) / 28
      'END';
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' K5[J]:= FXYZJ * HL;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' Y[JJ]:= YL[JJ] + (ZL[JJ] * 336 + K0[JJ] * 35 +
         K2[JJ] * 108 + K4[JJ] * 25) / 336 * HL;
         Z[JJ]:= ZL[JJ] + (K0[JJ] * 35 + K2[JJ] * 162 +
         K4[JJ] * 125 + K5[JJ] * 14) / 336
      'END';
   NEXT: 'IF' B ^= X 'THEN'
      'BEGIN' XL:= X;
         'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
         'BEGIN' YL[JJ]:= Y[JJ]; ZL[JJ]:= Z[JJ] 'END';
         'GOTO' TEST
      'END';
      'IF' 'NOT'LAST 'THEN' D[2]:= H; D[3]:= X;
      'FOR' JJ:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' D[JJ + 3]:= Y[JJ]; D[N + JJ + 3]:= Z[JJ] 'END'
   'END' RK2N;
   
        'EOP'
