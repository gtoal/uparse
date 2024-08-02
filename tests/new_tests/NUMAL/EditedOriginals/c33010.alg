'CODE' 33010;
   'PROCEDURE' RK1(X, A, B, Y, YA, FXY, E, D, FI);
   'VALUE' B, FI; 'REAL' X, A, B, Y, YA, FXY; 'BOOLEAN' FI;
   'ARRAY' E, D;
   'BEGIN' 'REAL' E1, E2, XL, YL, H, INT, HMIN, ABSH, K0, K1,
      K2, K3, K4, K5, DISCR, TOL, MU, MU1, FH, HL;
      'BOOLEAN' LAST, FIRST, REJECT;
      'IF' FI 'THEN'
      'BEGIN' D[3]:= A; D[4]:= YA 'END';
      D[1]:= 0; XL:= D[3]; YL:= D[4];
      'IF' FI 'THEN' D[2]:= B - D[3]; ABSH:= H:= ABS(D[2]);
      'IF' B - XL < 0 'THEN' H:= - H; INT:= ABS(B - XL);
      HMIN:= INT * E[1] + E[2]; E1:= E[1] / INT;
      E2:= E[2] / INT; FIRST:= 'TRUE'; 'IF' FI 'THEN'
      'BEGIN' LAST:= 'TRUE'; 'GOTO' STEP 'END';
   TEST: ABSH:= ABS(H); 'IF' ABSH < HMIN 'THEN'
      'BEGIN' H:= 'IF' H > 0 'THEN' HMIN 'ELSE' - HMIN; ABSH:= HMIN
      'END';
      'IF' H >= B - XL 'EQV' H >= 0 'THEN'
      'BEGIN' D[2]:= H; LAST:= 'TRUE'; H:= B - XL;
         ABSH:= ABS(H)
      'END'
      'ELSE' LAST:= 'FALSE';
   STEP: X:= XL; Y:= YL; K0:= FXY * H;
      X:= XL + H / 4.5; Y:= YL + K0 / 4.5;
      K1:= FXY * H; X:= XL + H / 3;
      Y:= YL + (K0 + K1 * 3) / 12; K2:= FXY * H;
      X:= XL + H * .5; Y:= YL + (K0 + K2 * 3) / 8;
      K3:= FXY * H; X:= XL + H * .8;
      Y:= YL + (K0 * 53 - K1 * 135 + K2 * 126 + K3 * 56)
      / 125; K4:= FXY * H; X:= 'IF' LAST 'THEN' B 'ELSE' XL + H;
      Y:= YL + (K0 * 133 - K1 * 378 + K2 * 276 + K3 * 112
      + K4 * 25) / 168; K5:= FXY * H;
      DISCR:= ABS(K0 * 21 - K2 * 162 + K3 * 224 - K4 * 125
      + K5 * 42) / 14; TOL:= ABS(K0) * E1 + ABSH * E2;
      REJECT:= DISCR > TOL; MU:= TOL / (TOL + DISCR) + .45;
      'IF' REJECT 'THEN'
      'BEGIN' 'IF' ABSH <= HMIN 'THEN'
         'BEGIN' D[1]:= D[1] + 1; Y:= YL; FIRST:= 'TRUE';
            'GOTO' NEXT
         'END';
         H:= MU * H; 'GOTO' TEST
      'END';
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= 'FALSE'; HL:= H; H:= MU * H; 'GOTO' ACC
      'END';
      FH:= MU * H / HL + MU - MU1; HL:= H; H:= FH * H;
   ACC: MU1:= MU;
      Y:= YL + ( - K0 * 63 + K1 * 189 - K2 * 36 - K3 * 112
      + K4 * 50) / 28; K5:= FXY * HL;
      Y:= YL + (K0 * 35 + K2 * 162 + K4 * 125 + K5 * 14)
      / 336;

   NEXT: 'IF' B ^= X 'THEN'
      'BEGIN' XL:= X; YL:= Y; 'GOTO' TEST 'END';
      'IF' 'NOT'LAST 'THEN' D[2]:= H; D[3]:= X; D[4]:= Y
   'END' RK1;
        'EOP'
