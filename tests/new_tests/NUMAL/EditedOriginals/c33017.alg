'CODE' 33017 ;
   'PROCEDURE' RK4NA(X, XA, B, FXJ, J, E, D, FI, N, L, POS);
   'VALUE' FI, N, L, POS; 'INTEGER' J, N, L; 'BOOLEAN' FI, POS;
   'REAL' B, FXJ; 'ARRAY' X, XA, E, D;
   'BEGIN' 'INTEGER' I, IV, IV0;
      'BOOLEAN' FIR, FIRST, REJ;
      'REAL' H, COND0, COND1, FHM, ABSH, TOL, FH, MAX, X0,
      X1, S, HMIN, HL, MU, MU1;
      'ARRAY' XL, DISCR, Y[0:N], K[0:5,0:N], E1[1:2];

      'PROCEDURE' RKSTEP(H, D); 'VALUE' H, D; 'INTEGER' D; 'REAL' H;
      'BEGIN' 'INTEGER' I;

         'PROCEDURE' F(T); 'VALUE' T; 'INTEGER' T;
         'BEGIN' 'INTEGER' I;
            'REAL' P;
            'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' Y[J]:= FXJ;
            P:= H / Y[IV];
            'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'IF' I ^= IV 'THEN' K[T,I]:= Y[I] * P 'END'
         'END' F;

         'IF' D = 2 'THEN' 'GOTO' INTEGRATE; 'IF' D = 3 'THEN'
         'BEGIN' 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I];
            F(0)
         'END'
         'ELSE' 'IF' D = 1 'THEN'
         'BEGIN' 'REAL' P;
            P:= H / Y[IV];
            'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'IF' I ^= IV 'THEN' K[0,I]:= P * Y[I] 'END'
         'END'
         'ELSE'
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
         'BEGIN' 'IF' I ^= IV 'THEN' K[0,I]:= K[0,I] * MU 'END';
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + ('IF' I
         = IV 'THEN' H 'ELSE' K[0,I]) / 4.5; F(1);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + ('IF' I
         = IV 'THEN' H * 4 'ELSE' (K[0,I] + K[1,I] * 3)) / 12;
         F(2);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + ('IF' I
         = IV 'THEN' H * .5 'ELSE' (K[0,I] + K[2,I] * 3) / 8);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + ('IF' I
         = IV 'THEN' H * .8 'ELSE' (K[0,I] * 53 - K[1,I] * 135
         + K[2,I] * 126 + K[3,I] * 56) / 125); F(4);
         'IF' D <= 1 'THEN'
         'BEGIN' 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] +
            ('IF' I = IV 'THEN' H 'ELSE' (K[0,I] * 133 -
            K[1,I] * 378 + K[2,I] * 276 + K[3,I] * 112 +
            K[4,I] * 25) / 168); F(5);
            'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'IF' I ^= IV 'THEN' DISCR[I]:= ABS(K[0,I] * 21
               - K[2,I] * 162 + K[3,I] * 224 - K[4,I] *
               125 + K[5,I] * 42) / 14
            'END';
            'GOTO' END
         'END';
      INTEGRATE: 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I]
         + ('IF' I = IV 'THEN' H 'ELSE' ( - K[0,I] * 63 + K[1,I]
         * 189 - K[2,I] * 36 - K[3,I] * 112 + K[4,I] * 50)
         / 28); F(5);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
         'BEGIN' 'IF' I ^= IV 'THEN' X[I]:= XL[I] + (K[0,I] * 35
            + K[2,I] * 162 + K[4,I] * 125 + K[5,I] * 14) / 336
         'END';
      END: 
         'END' RKSTEP ;

      'REAL' 'PROCEDURE' FZERO;
      'BEGIN' 'IF' S = X0 'THEN' FZERO:= COND0 'ELSE' 'IF' S = X1
         'THEN' FZERO:= COND1 'ELSE'
         'BEGIN' RKSTEP(S - XL[IV], 3); FZERO:= B 'END'
      'END' FZERO;

      'IF' FI 'THEN'
      'BEGIN' 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' D[I + 3]:= XA[I];
         D[0]:= D[2]:= 0
      'END';
      D[1]:= 0;
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I]:= D[I + 3];
      IV:= D[0]; H:= D[2]; FIRST:= FIR:= 'TRUE'; Y[0]:= 1;
      'GOTO' CHANGE;
   AGAIN: ABSH:= ABS(H); 'IF' ABSH < HMIN 'THEN'
      'BEGIN' H:= 'IF' H > 0 'THEN' HMIN 'ELSE' - HMIN;
         ABSH:= ABS(H)
      'END';
      RKSTEP(H, I); REJ:= 'FALSE'; FHM:= 0;
      
'COMMENT' by GT: extraneous 'BEGIN' below after the 'DO' removed!: ;

      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
      'IF' I ^= IV 'THEN'
         'BEGIN' TOL:= E[2 * I] * ABS(K[0,I]) + E[2 * I + 1]
            * ABSH; REJ:= TOL < DISCR[I] 'OR' REJ;
            FH:= DISCR[I] / TOL; 'IF' FH > FHM 'THEN' FHM:= FH
         'END'
      MU:= 1 / (1 + FHM) + .45; 'IF' REJ 'THEN'
      'BEGIN' 'IF' ABSH <= HMIN 'THEN'
         'BEGIN' 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'IF' I ^= IV 'THEN' X[I]:= XL[I] + K[0,I]
               'ELSE' X[I]:= XL[I] + H
            'END';
            D[1]:= D[1] + 1; FIRST:= 'TRUE'; 'GOTO' NEXT
         'END';
         H:= H * MU; I:= 0; 'GOTO' AGAIN
      'END';
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= FIR; HL:= H; H:= MU * H; 'GOTO' ACCEPT
      'END';
      FH:= MU * H / HL + MU - MU1; HL:= H; H:= FH * H;
   ACCEPT: RKSTEP(HL, 2); MU1:= MU;
   NEXT: 'IF' FIR 'THEN'
      'BEGIN' FIR:= 'FALSE'; COND0:= B;
         'IF' 'NOT'(FI 'OR' REJ) 'THEN' H:= D[2]
      'END'
      'ELSE'
      'BEGIN' D[2]:= H; COND1:= B;
         'IF' COND0 * COND1 <= 0 'THEN' 'GOTO' ZERO;
         COND0:= COND1
      'END';
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' D[I + 3]:= XL[I]:= X[I];
   CHANGE: IV0:= IV;
      'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO' Y[J]:= FXJ;
      MAX:= ABS(Y[IV]);
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' 'IF' ABS(Y[I]) > MAX 'THEN'
         'BEGIN' MAX:= ABS(Y[I]); IV:= I 'END'
      'END';
      'IF' IV0 ^= IV 'THEN'
      'BEGIN' FIRST:= 'TRUE'; D[0]:= IV;
         D[2]:= H:= Y[IV] / Y[IV0] * H
      'END';
      X0:= XL[IV]; 'IF' FIR 'THEN'
      'BEGIN' HMIN:= E[0] + E[1];
         'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
         'BEGIN' H:= E[2 * I] + E[2 * I + 1];
            'IF' H < HMIN 'THEN' HMIN:= H
         'END';
         H:= E[2 * IV] + E[2 * IV + 1];
            'IF' (FI 'AND' (Y[L]/Y[IV]*H<0 'EQV' POS)) 'OR'
            ('NOT' FI 'AND' D[2]*H<0) 'THEN' H:= -H
      'END';
      I:= 1; 'GOTO' AGAIN;
   ZERO: E1[1]:= E[2 * N + 2]; E1[2]:= E[2 * N + 3];
      X1:=X[IV] ; S:=X0 ;
      ZEROIN(S,X1,FZERO,ABS(E1[1]*S) + ABS(E1[2])) ; X0:=S ; X1:=X[IV];
      RKSTEP(X0 - XL[IV], 3);
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' D[I + 3]:= X[I]
    'END' RK4NA;
   
'EOP'
