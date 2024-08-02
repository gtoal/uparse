'CODE' 33300;
 'PROCEDURE' FEM LAG SYM(X, Y, N, P, R, F, ORDER, E);
 'VALUE' N, ORDER; 'INTEGER' N, ORDER;
 'REAL' 'PROCEDURE' P, R, F;
 'ARRAY' X, Y, E;
 'BEGIN' 'INTEGER' L, L1;
   'REAL' XL1, XL, H, A12, B1, B2, TAU1, TAU2, CH, TL, G, YL, PP,
     P1, P2, P3, P4, R1, R2, R3, R4, F1, F2, F3, F4,
     E1, E2, E3, E4, E5, E6;
   'ARRAY' T, SUB, CHI, GI[0:N-1];

   'PROCEDURE' ELEMENT MAT VEC EVALUATION 1;
   'BEGIN' 'REAL'  H2;
     'IF' L=1 'THEN'
     'BEGIN' P2:= P(XL1); R2:= R(XL1); F2:= F(XL1) 'END';
     P1:= P2; P2:= P(XL); R1:= R2; R2:= R(XL); F1:= F2; F2:= F(XL);
     H2:= H/2; B1:= H2*F1; B2:= H2*F2; TAU1:= H2*R1; TAU2:= H2*R2;
     A12:= -0.5*(P1 + P2)/H
   'END' ELAN. M.V. EV.;

   'PROCEDURE' ELEMENT MAT VEC EVALUATION 2;
   'BEGIN' 'REAL'  X2, H6, H15, B3, TAU3, C12, C32, A13, A22, A23;
     'IF' L=1 'THEN'
     'BEGIN' P3:= P(XL1); R3:= R(XL1); F3:= F(XL1) 'END';
     X2:= (XL1 + XL)/2; H6:= H/6; H15:= H/1.5;
     P1:= P3; P2:= P(X2); P3:= P(XL);
     R1:= R3; R2:= R(X2); R3:= R(XL);
     F1:= F3; F2:= F(X2); F3:= F(XL);
     B1:= H6*F1; B2:= H15*F2; B3:= H6*F3;
     TAU1:= H6*R1; TAU2:= H15*R2; TAU3:= H6*R3;
     A12:= -(2*P1 + P3/1.5)/H; A13:= (0.5*(P1 + P3) - P2/1.5)/H;
     A22:= (P1 + P3)/H/0.375 + TAU2; A23:= -(P1/3 + P3)*2/H;
     'COMMENT' STATIC CONDENSATION;
     C12:= - A12/A22; C32:= - A23/A22; A12:= A13 + C32*A12;
     B1:= B1 + C12*B2; B2:= B3 + C32*B2;
     TAU1:= TAU1 + C12*TAU2; TAU2:= TAU3 + C32*TAU2
   'END' ELEMENT MAT VEC EVALUATION 2;

   'PROCEDURE' ELEMENT MAT VEC EVALUATION 3;
   'BEGIN' 'REAL'  X2, X3, H12, H24, DET, C12, C13, C42, C43,
     A13, A14, A22, A23, A24, A33, A34, B3, B4, TAU3, TAU4;
     'IF' L=1 'THEN'
     'BEGIN' P4:= P(XL1); R4:= R(XL1); F4:= F(XL1) 'END';
     X2:= XL1 + 0.27639320225*H; X3:= XL - X2 + XL1;
     H12:= H/12; H24:= H/2.4;
     P1:= P4; P2:= P(X2); P3:= P(X3); P4:= P(XL);
     R1:= R4; R2:= R(X2); R3:= R(X3); R4:= R(XL);
     F1:= F4; F2:= F(X2); F3:= F(X3); F4:= F(XL);
     B1:= H12*F1; B2:= H24*F2; B3:= H24*F3; B4:= H12*F4;
     TAU1:= H12*R1; TAU2:= H24*R2; TAU3:= H24*R3; TAU4:= H12*R4;
     A12:= -(+ 4.04508497187450*P1
             + 0.57581917135425*P3
             + 0.25751416197911*P4)/H;
     A13:= (+ 1.5450849718747*P1
            - 1.5075141619791*P2
            + 0.6741808286458*P4)/H;
     A14:= ((P2 + P3)/2.4 - (P1 + P4)/2)/H;
     A22:= (5.454237476562*P1 + P3/.48 +.79576252343762*P4)/H + TAU2;
     A23:= - (P1 + P4)/(H*0.48);
     A24:= (+ 0.67418082864575*P1
            - 1.50751416197910*P3
            + 1.54508497187470*P4)/H;
     A33:= (.7957625234376*P1 + P2/.48 + 5.454237476562*P4)/H + TAU3;
     A34:= -(+ 0.25751416197911*P1
             + 0.57581917135418*P2
             + 4.0450849718747*P4)/H;
     'COMMENT' STATIC CONDENSATION;
     DET:= A22*A33 - A23*A23;
     C12:= (A13*A23 - A12*A33)/DET;
     C13:= (A12*A23 - A13*A22)/DET;
     C42:= (A23*A34 - A24*A33)/DET;
     C43:= (A24*A23 - A34*A22)/DET;
     TAU1:= TAU1 + C12*TAU2 + C13*TAU3;
     TAU2:= TAU4 + C42*TAU2 + C43*TAU3;
     A12:= A14 + C42*A12 + C43*A13;
     B1:= B1 + C12*B2 + C13*B3;
     B2:= B4 + C42*B2 + C43*B3
   'END' ELEMENT MAT VEC EVALUATION 3;

   'PROCEDURE' BOUNDARY CONDITIONS;
   'IF' L=1 'AND' E2 = 0 'THEN'
   'BEGIN'  TAU1:= 1; B1:= E3/E1;B2:= B2 - A12*B1;
     TAU2:= TAU2 - A12; A12:= 0 'END'
   'ELSE' 'IF' L=1 'AND' E2 ^= 0 'THEN'
   'BEGIN' 'REAL' AUX; AUX:= P1/E2; TAU1:= TAU1 - AUX*E1 ;
     B1:= B1 - E3*AUX
   'END' 'ELSE' 'IF' L=N 'AND' E5 = 0 'THEN'
   'BEGIN' TAU2:= 1; B2:= E6/E4;
     B1:= B1 - A12*B2; TAU1:= TAU1 - A12; A12:= 0
   'END' 'ELSE' 'IF' L=N 'AND' E5 ^= 0 'THEN'
   'BEGIN' 'REAL' AUX; AUX:= P2/E5;
     TAU2:= TAU2 + AUX*E4; B2:= B2 + AUX*E6
   'END' B.C.1;

   'PROCEDURE' FORWARD BABUSHKA;
   'IF' L=1 'THEN'
   'BEGIN' CHI[0]:= CH:= TL:= TAU1; T[0]:= TL;
      GI[0]:=  G:= YL:=   B1; Y[0]:= YL;
     SUB[0]:= A12; PP:= A12/(CH - A12);
     CH:= TAU2 - CH*PP; G:= B2 - G*PP; TL:= TAU2; YL:= B2
   'END' 'ELSE'
   'BEGIN' CHI[L1]:= CH:= CH + TAU1;
      GI[L1]:=  G:=  G + B1;
     SUB[L1]:= A12; PP:= A12/(CH - A12);
     CH:= TAU2 - CH*PP; G:= B2 - G*PP;
     T[L1]:= TL + TAU1; TL:= TAU2;
     Y[L1]:= YL +   B1; YL:=   B2
   'END' FORWARD BABUSHKA 1;

   'PROCEDURE' BACKWARD BABUSHKA;
   'BEGIN' PP:= YL; Y[N]:= G/CH;
     G:= PP; CH:= TL; L:= N;
     'FOR' L:= L - 1 'WHILE' L >= 0 'DO'
     'BEGIN' PP:= SUB[L]; PP:= PP/(CH - PP);
         TL:= T[L]; CH:= TL - CH*PP;
         YL:= Y[L]; G:= YL - G*PP;
         Y[L]:=(GI[L] + G - YL)/(CHI[L] + CH - TL)
     'END'
   'END' BACKWARD BABUSHKA;

   L:= 0; XL:= X[0];
   E1:= E[1]; E2:= E[2]; E3:= E[3]; E4:= E[4]; E5:= E[5]; E6:= E[6];
   'FOR' L:= L + 1 'WHILE' L <= N 'DO'
   'BEGIN' L1:= L - 1; XL1:= XL; XL:= X[L]; H:= XL - XL1;
     'IF' ORDER = 2 'THEN' ELEMENT MAT VEC EVALUATION 1 'ELSE'
     'IF' ORDER = 4 'THEN' ELEMENT MAT VEC EVALUATION 2 'ELSE'
                           ELEMENT MAT VEC EVALUATION 3;
     'IF' L=1 'OR' L=N 'THEN' BOUNDARY CONDITIONS;
     FORWARD BABUSHKA
   'END';
   BACKWARD BABUSHKA;
 'END' FEM LAG SYM;
      'EOP'
