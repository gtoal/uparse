'CODE' 33018 ;
   'PROCEDURE' RK5NA(X, XA, B, FXJ, J, E, D, FI, N, L, POS);
   'VALUE' FI, N, L, POS; 'INTEGER' J, N, L; 'BOOLEAN' FI, POS;
   'REAL' B, FXJ; 'ARRAY' X, XA, E, D;
   'BEGIN' 'INTEGER' I;
      'BOOLEAN' FIRST, FIR, REJ;
      'REAL' FHM, S, S0, COND0, S1, COND1, H, ABSH, TOL, FH,
      HL, MU, MU1;
      'ARRAY' Y, XL, DISCR[0:N], K[0:5,0:N], E1[1:2];
      'REAL' 'PROCEDURE' SUM(J,A,B,XJ) ; 'INTEGER' J,A,B ; 'REAL' XJ ;
      'BEGIN' 'REAL' S ; S:= 0 ;
         'FOR' J:=A 'STEP' 1 'UNTIL' B 'DO' S:=S+XJ ; SUM:= S
      'END' SUM ;
      'PROCEDURE' RKSTEP(H, D); 'VALUE' H, D; 'INTEGER' D; 'REAL' H;
      'BEGIN' 'INTEGER' I;
         'PROCEDURE' F(T); 'VALUE' T; 'INTEGER' T;
         'BEGIN' 'INTEGER' I;
            'REAL' P;
            'FOR' J:= 0 'STEP' 1 'UNTIL' N 'DO' Y[J]:= FXJ;
            P:= H / SQRT(SUM(I, 0, N, Y[I] ** 2));
            'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' K[T,I]:= Y[I] * P
         'END' F;
         'IF' D = 2 'THEN' 'GOTO' INTEGRATE; 'IF' D = 1 'THEN'
         'BEGIN' 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' K[0,I]:= K[0,I]
            * MU; 'GOTO' A
         'END';
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I]; F(0);
      A: 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] +
         K[0,I] / 4.5; F(1);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + (K[0,I]
         + K[1,I] * 3) / 12; F(2);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + (K[0,I]
         + K[2,I] * 3) / 8; F(3);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + (K[0,I]
         * 53 - K[1,I] * 135 + K[2,I] * 126 + K[3,I] * 56)
         / 125; F(4); 'IF' D <= 1 'THEN'
         'BEGIN' 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] +
            (K[0,I] * 133 - K[1,I] * 378 + K[2,I] * 276 +
            K[3,I] * 112 + K[4,I] * 25) / 168; F(5);
            'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' DISCR[I]:=
            ABS(K[0,I] * 21 - K[2,I] * 162 + K[3,I] * 224
            - K[4,I] * 125 + K[5,I] * 42) / 14; 'GOTO' END
         'END';
      INTEGRATE: 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I]
         + ( - K[0,I] * 63 + K[1,I] * 189 - K[2,I] * 36 -
         K[3,I] * 112 + K[4,I] * 50) / 28; F(5);
         'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I] + (K[0,I]
         * 35 + K[2,I] * 162 + K[4,I] * 125 + K[5,I] * 14)
         / 336;
      END:
      'END';
      
      'REAL' 'PROCEDURE' FZERO;
      'BEGIN' 'IF' S = S0 'THEN' FZERO:= COND0 'ELSE' 'IF' S = S1
         'THEN' FZERO:= COND1 'ELSE'
         'BEGIN' RKSTEP(S - S0, 3); FZERO:= B 'END'
      'END' FZERO;

      'IF' FI 'THEN'
      'BEGIN' 'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' D[I + 3]:= XA[I];
         D[1]:= D[2]:= 0
      'END';
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' X[I]:= XL[I]:= D[I + 3];
      S:= D[1]; FIRST:= FIR:= 'TRUE'; H:= E[0] + E[1];
      'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' ABSH:= E[2 * I] + E[2 * I + 1];
         'IF' H > ABSH 'THEN' H:= ABSH
      'END';
      'IF' FI 'THEN'
      'BEGIN' J:= L; 'IF' FXJ * H < 0 'EQV' POS 'THEN' H:= - H 'END'
      'ELSE' 'IF' D[2] * H < 0 'THEN' H:= - H; I:= 0;
   AGAIN: RKSTEP(H, I); REJ:= 'FALSE'; FHM:= 0;
      ABSH:= ABS(H);
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO'
      'BEGIN' TOL:= E[2 * I] * ABS(K[0,I]) + E[2 * I + 1] *
         ABSH; REJ:= TOL < DISCR[I] 'OR' REJ;
         FH:= DISCR[I] / TOL; 'IF' FH > FHM 'THEN' FHM:= FH
      'END';
      MU:= 1 / (1 + FHM) + .45; 'IF' REJ 'THEN'
      'BEGIN' H:= H * MU; I:= 1; 'GOTO' AGAIN 'END';
      'IF' FIRST 'THEN'
      'BEGIN' FIRST:= FIR; HL:= H; H:= MU * H 'END'
      'ELSE'
      'BEGIN' FH:= MU * H / HL + MU - MU1; HL:= H; H:= FH * H
      'END';
   ACCEPT: RKSTEP(HL, 2); MU1:= MU; S:= S + HL;
      'IF' FIR 'THEN'
      'BEGIN' COND0:= B; FIR:= 'FALSE'; 'IF' 'NOT'FI 'THEN' H:= D[2]
      'END'
      'ELSE'
      'BEGIN' D[2]:= H; COND1:= B;
         'IF' COND0 * COND1 <= 0 'THEN' 'GOTO' ZERO;
         COND0:= COND1
      'END';
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' D[I + 3]:= XL[I]:= X[I];
      D[1]:= S0:= S; I:= 0; 'GOTO' AGAIN;
   ZERO: E1[1]:= E[2 * N + 2]; E1[2]:= E[2 * N + 3];
      S1:=S ; S:=S0 ;
      ZEROIN(S,S1,FZERO,ABS(E1[1]*S)+ABS(E1[2])) ;
      RKSTEP(S - S0, 3);
      'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' D[I + 3]:= X[I]; D[1]:= S
   'END' RK5NA;
        'EOP'
