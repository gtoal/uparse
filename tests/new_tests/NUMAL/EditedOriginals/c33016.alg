'CODE' 33016 ;
   'PROCEDURE' RK4A(X, XA, B, Y, YA, FXY, E, D, FI, XDIR,
   POS); 'VALUE' FI, XDIR, POS; 'BOOLEAN' FI, XDIR, POS;
   'REAL' X, XA, B, Y, YA, FXY; 'ARRAY' E, D;
   'BEGIN' 'INTEGER' I;
      'BOOLEAN' IV, FIRST, FIR, REJ;
      'REAL' K0, K1, K2, K3, K4, K5, FHM, ABSH, DISCR, S, XL,
      COND0, S1, COND1, YL, HMIN, H, ZL, TOL, HL, MU, MU1;
      'ARRAY' E1[1:2];

      'PROCEDURE' RKSTEP(X, XL, H, Y, YL, ZL, FXY, D);
      'VALUE' XL, YL, ZL, H; 'REAL' X, XL, H, Y, YL, ZL, FXY;
      'INTEGER' D;
      'BEGIN' 'IF' D = 2 'THEN' 'GOTO' INTEGRATE; 'IF' D = 3 'THEN'
         'BEGIN' X:= XL; Y:= YL; K0:= FXY * H 'END'
         'ELSE' 'IF' D = 1 'THEN' K0:= ZL * H 'ELSE' K0:= K0 * MU;
         X:= XL + H / 4.5; Y:= YL + K0 / 4.5; K1:= FXY * H;
         X:= XL + H / 3; Y:= YL + (K0 + K1 * 3) / 12;
         K2:= FXY * H; X:= XL + H * .5;
         Y:= YL + (K0 + K2 * 3) / 8; K3:= H * FXY;
         X:= XL + H * .8;
         Y:= YL + (K0 * 53 - K1 * 135 + K2 * 126 + K3 *
         56) / 125; K4:= FXY * H; 'IF' D <= 1 'THEN'
         'BEGIN' X:= XL + H;
            Y:= YL + (K0 * 133 - K1 * 378 + K2 * 276 + K3
            * 112 + K4 * 25) / 168; K5:= FXY * H;
            DISCR:= ABS(K0 * 21 - K2 * 162 + K3 * 224 - K4
            * 125 + K5 * 42) / 14; 'GOTO' END
         'END';
      INTEGRATE: X:= XL + H;
         Y:= YL + ( - K0 * 63 + K1 * 189 - K2 * 36 - K3 *
         112 + K4 * 50) / 28; K5:= FXY * H;
         Y:= YL + (K0 * 35 + K2 * 162 + K4 * 125 + K5 *
         14) / 336;
      END:
      'END';
      
      'REAL' 'PROCEDURE' FZERO;
      'BEGIN' 'IF' IV 'THEN'
         'BEGIN' 'IF' S = XL 'THEN' FZERO:= COND0 'ELSE' 'IF' S = S1
            'THEN' FZERO:= COND1 'ELSE'
            'BEGIN' RKSTEP(X, XL, S - XL, Y, YL, ZL, FXY, 3);
               FZERO:= B
            'END'
         'END'
         'ELSE'
         'BEGIN' 'IF' S = YL 'THEN' FZERO:= COND0 'ELSE' 'IF' S = S1
            'THEN' FZERO:= COND1 'ELSE'
            'BEGIN' RKSTEP(Y, YL, S - YL, X, XL, ZL, 1 /
               FXY, 3); FZERO:= B
            'END'
         'END'
      'END' FZERO;

      'IF' FI 'THEN'
      'BEGIN' D[3]:= XA; D[4]:= YA; D[0]:= 1 'END';
      D[1]:= 0; X:= XL:= D[3]; Y:= YL:= D[4]; IV:= D[0] > 0;
      FIRST:= FIR:= 'TRUE'; HMIN:= E[0] + E[1];
      H:= E[2] + E[3]; 'IF' H < HMIN 'THEN' HMIN:= H;
   CHANGE: ZL:= FXY; 'IF' ABS(ZL) <= 1 'THEN'
      'BEGIN' 'IF' 'NOT'IV 'THEN'
         'BEGIN' D[2]:= H:= H / ZL; D[0]:= 1;
            IV:= FIRST:= 'TRUE'
         'END';
         'IF' FIR 'THEN' 'GOTO' A; I:= 1; 'GOTO' AGAIN
      'END'
      'ELSE'
      'BEGIN' 'IF' IV 'THEN'
         'BEGIN' 'IF' 'NOT'FIR 'THEN' D[2]:= H:= H * ZL; D[0]:= - 1;
            IV:= 'FALSE'; FIRST:= 'TRUE'
         'END';
         'IF' FIR 'THEN'
         'BEGIN' H:= E[0] + E[1];
         A: 'IF' ('IF' FI 'THEN' ('IF' IV 'EQV' XDIR 'THEN' H 'ELSE'
            H * ZL) < 0 'EQV' POS 'ELSE' H * D[2] < 0) 'THEN' H:= - H
         'END';
         I:= 1
      'END';
   AGAIN: ABSH:= ABS(H); 'IF' ABSH < HMIN 'THEN'
      'BEGIN' H:= SIGN(H) * HMIN; ABSH:= HMIN 'END';
      'IF' IV 'THEN'
      'BEGIN' RKSTEP(X, XL, H, Y, YL, ZL, FXY, I);
         TOL:= E[2] * ABS(K0) + E[3] * ABSH
      'END'
      'ELSE'
      'BEGIN' RKSTEP(Y, YL, H, X, XL, 1 / ZL, 1 / FXY, I);
         TOL:= E[0] * ABS(K0) + E[1] * ABSH
      'END';
      REJ:= DISCR > TOL; MU:= TOL / (TOL + DISCR) + .45;
      'IF' REJ 'THEN'
      'BEGIN' 'IF' ABSH <= HMIN 'THEN'
         'BEGIN' 'IF' IV 'THEN'
            'BEGIN' X:= XL + H; Y:= YL + K0 'END'
            'ELSE'
            'BEGIN' X:= XL + K0; Y:= YL + H 'END';
            D[1]:= D[1] + 1; FIRST:= 'TRUE'; 'GOTO' NEXT
         'END';
         H:= H * MU; I:= 0; 'GOTO' AGAIN
      'END' REJ;
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= FIR; HL:= H; H:= MU * H; 'GOTO' ACCEPT
      'END';
      FHM:= MU * H / HL + MU - MU1; HL:= H; H:= FHM * H;
   ACCEPT: 'IF' IV 'THEN' RKSTEP(X, XL, HL, Y, YL, ZL, FXY,
      2) 'ELSE' RKSTEP(Y, YL, HL, X, XL, ZL, 1 / FXY, 2);
      MU1:= MU;
   NEXT: 'IF' FIR 'THEN'
      'BEGIN' FIR:= 'FALSE'; COND0:= B;
         'IF' 'NOT'(FI 'OR' REJ) 'THEN' H:= D[2]
      'END'
      'ELSE'
      'BEGIN' D[2]:= H; COND1:= B;
         'IF' COND0 * COND1 <= 0 'THEN' 'GOTO' ZERO;
         COND0:= COND1
      'END';
      D[3]:= XL:= X; D[4]:= YL:= Y; 'GOTO' CHANGE;
   ZERO: E1[1]:= E[4]; E1[2]:= E[5];
      S1:= 'IF' IV 'THEN' X 'ELSE' Y;
      S:= 'IF' IV 'THEN' XL 'ELSE' YL ;
      ZEROIN(S,S1,FZERO,ABS(E1[1]*S)+ABS(E1[2])) ;
      S1:= 'IF' IV 'THEN' X 'ELSE' Y ;
      'IF' IV 'THEN' RKSTEP(X, XL, S - XL, Y, YL, ZL, FXY, 3)
      'ELSE' RKSTEP(Y, YL, S - YL, X, XL, ZL, 1 / FXY,
      3); D[3]:= X; D[4]:= Y
   'END' RK4A;
        'EOP'
