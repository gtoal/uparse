'CODE' 33012 ;
   'PROCEDURE' RK2(X, A, B, Y, YA, Z, ZA, FXYZ, E, D, FI);
   'VALUE' B, FI; 'REAL' X, A, B, Y, YA, Z, ZA, FXYZ; 'BOOLEAN' FI;
   'ARRAY' E, D;
   'BEGIN' 'REAL' E1, E2, E3, E4, XL, YL, ZL, H, INT, HMIN, HL,
      ABSH, K0, K1, K2, K3, K4, K5, DISCRY, DISCRZ, TOLY,
      TOLZ, MU, MU1, FHY, FHZ;
      'BOOLEAN' LAST, FIRST, REJECT;
      'IF' FI 'THEN'
      'BEGIN' D[3]:= A; D[4]:= YA; D[5]:= ZA 'END';
      D[1]:= 0; XL:= D[3]; YL:= D[4]; ZL:= D[5];
      'IF' FI 'THEN' D[2]:= B - D[3]; ABSH:= H:= ABS(D[2]);
      'IF' B - XL < 0 'THEN' H:= - H; INT:= ABS(B - XL);
      HMIN:= INT * E[1] + E[2]; HL:= INT * E[3] + E[4];
      'IF' HL < HMIN 'THEN' HMIN:= HL; E1:= E[1] / INT;
      E2:= E[2] / INT; E3:= E[3] / INT; E4:= E[4] / INT;
      FIRST:= 'TRUE'; 'IF' FI 'THEN'
      'BEGIN' LAST:= 'TRUE'; 'GOTO' STEP 'END';
   TEST: ABSH:= ABS(H); 'IF' ABSH < HMIN 'THEN'
      'BEGIN' H:= 'IF' H > 0 'THEN' HMIN 'ELSE' - HMIN; ABSH:= HMIN
      'END';
      'IF' H >= B - XL 'EQV' H >= 0 'THEN'
      'BEGIN' D[2]:= H; LAST:= 'TRUE'; H:= B - XL;
         ABSH:= ABS(H)
      'END'
      'ELSE' LAST:= 'FALSE';
   STEP: X:= XL; Y:= YL; Z:= ZL; K0:= FXYZ * H;
      X:= XL + H / 4.5;
      Y:= YL + (ZL * 18 + K0 * 2) / 81 * H;
      Z:= ZL + K0 / 4.5  ; K1:= FXYZ * H; X:= XL + H / 3;
      Y:= YL + (ZL * 6 + K0) / 18 * H;
      Z:= ZL + (K0 + K1 * 3) / 12; K2:= FXYZ * H;
      X:= XL + H * .5;
      Y:= YL + (ZL * 8 + K0 + K2) / 16 * H;
      Z:= ZL + (K0 + K2 * 3) / 8; K3:= FXYZ * H;
      X:= XL + H * .8;
      Y:= YL + (ZL * 100 + K0 * 12 + K3 * 28) / 125 * H;
      Z:= ZL + (K0 * 53 - K1 * 135 + K2 * 126 + K3 * 56)
      / 125; K4:= FXYZ * H; X:= 'IF' LAST 'THEN' B 'ELSE' XL + H;
      Y:= YL + (ZL * 336 + K0 * 21 + K2 * 92 + K4 * 55) /
      336 * H;
      Z:= ZL + (K0 * 133 - K1 * 378 + K2 * 276 + K3 * 112
      + K4 * 25) / 168; K5:= FXYZ * H;
      DISCRY:= ABS(( - K0 * 21 + K2 * 108 - K3 * 112 + K4
      * 25) / 56 * H);
      DISCRZ:= ABS(K0 * 21 - K2 * 162 + K3 * 224 - K4 *
      125 + K5 * 42) / 14;
      TOLY:= ABSH * (ABS(ZL) * E1 + E2);
      TOLZ:= ABS(K0) * E3 + ABSH * E4;
      REJECT:= DISCRY > TOLY 'OR' DISCRZ > TOLZ;
      FHY:= DISCRY / TOLY; FHZ:= DISCRZ / TOLZ;
      'IF' FHZ > FHY 'THEN' FHY:= FHZ;
      MU:= 1 / (1 + FHY) + .45; 'IF' REJECT 'THEN'
      'BEGIN' 'IF' ABSH <= HMIN 'THEN'
         'BEGIN' D[1]:= D[1] + 1; Y:= YL; Z:= ZL;
            FIRST:= 'TRUE'; 'GOTO' NEXT
         'END';
         H:= MU * H; 'GOTO' TEST
      'END';
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= 'FALSE'; HL:= H; H:= MU * H; 'GOTO' ACC
      'END';
      FHY:= MU * H / HL + MU - MU1; HL:= H; H:= FHY * H;
   ACC: MU1:= MU;
      Y:= YL + (ZL * 56 + K0 * 7 + K2 * 36 - K4 * 15) / 56
      * HL;
      Z:= ZL + ( - K0 * 63 + K1 * 189 - K2 * 36 - K3 * 112
      + K4 * 50) / 28; K5:= FXYZ * HL;
      Y:= YL + (ZL * 336 + K0 * 35 + K2 * 108 + K4 * 25)
      / 336 * HL;
      Z:= ZL + (K0 * 35 + K2 * 162 + K4 * 125 + K5 * 14)
      / 336;
   NEXT: 'IF' B ^= X 'THEN'
      'BEGIN' XL:= X; YL:= Y; ZL:= Z; 'GOTO' TEST 'END';
      'IF' 'NOT'LAST 'THEN' D[2]:= H; D[3]:= X; D[4]:= Y; D[5]:= Z
   'END' RK2;
        'EOP'
