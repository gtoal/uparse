'CODE' 33014 ;
   'PROCEDURE' RK3(X, A, B, Y, YA, Z, ZA, FXY, E, D, FI);
   'VALUE' B, FI; 'REAL' X, A, B, Y, YA, Z, ZA, FXY; 'BOOLEAN' FI;
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
      'BEGIN' X:= XL; Y:= YL; K0:= FXY * H 'END'
      'ELSE' K0:= K5 * H / HL; X:= XL + .276393202250021 * H;
      Y:= YL + (ZL * .2763932022 50021 + K0 *
      .038196601125011) * H; K1:= FXY * H;
      X:= XL + .72360 6797749979 * H;
      Y:= YL + (ZL * .723606797749979 + K1 * .26180
      3398874989) * H; K2:= FXY * H; X:= XL + H * .5;
      Y:= YL + (ZL * .5 + K0 * .046875 + K1 *
      .079824155839840 - K2 * .001699155839840) * H;
      K4:= FXY * H; X:= 'IF' LAST 'THEN' B 'ELSE' XL + H;
      Y:= YL + (ZL + K0 * .309016994374947 + K2 *
      .190983005625053) * H; K3:= FXY * H;
      Y:= YL + (ZL + K0 * .083333333333333 + K1 *
      .301502832395825 + K2 * .115163834270842) * H;
      K5:= FXY * H;
      DISCRY:= ABS(( - K0 * .5 + K1 * 1.809016994374947 +
      K2 * .690983005625053 - K4 * 2) * H);
      DISCRZ:= ABS((K0 - K3) * 2 - (K1 + K2) * 10 + K4 *
      16 + K5 * 4); TOLY:= ABSH * (ABS(ZL) * E1 + E2);
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
      Z:= ZL + (K0 + K3) * .083333333333333 + (K1 + K2) *
      .416666666666667;
   NEXT: 'IF' B ^= X 'THEN'
      'BEGIN' XL:= X; YL:= Y; ZL:= Z; 'GOTO' TEST 'END';
      'IF' 'NOT'LAST 'THEN' D[2]:= H; D[3]:= X; D[4]:= Y; D[5]:= Z
   'END' RK3;
        'EOP'
