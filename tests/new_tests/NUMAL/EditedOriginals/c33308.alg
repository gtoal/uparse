'CODE' 33308;
 'PROCEDURE' FEM LAG SPHER(X, Y, N, NC, R, F, ORDER, E);
 'VALUE' N, NC, ORDER; 'INTEGER' N, NC, ORDER;
 'REAL' 'PROCEDURE' R, F;
 'ARRAY' X, Y, E;
 'BEGIN' 'INTEGER' L, L1;
   'REAL' XL1, XL, H, A12, B1, B2, TAU1, TAU2, CH, TL, G, YL, PP,
    TAU3, B3, A13, A22, A23, C32, C12,
     E1, E2, E3, E4, E5, E6;
   'ARRAY' T, SUB, CHI, GI[0:N-1];

   'PROCEDURE' ELEMENT MAT VEC EVALUATION 1;
   'BEGIN' 'REAL'  XM, VL, VR,WL, WR, PR, RM, FM, XL2, XLXR, XR2;
    'IF' NC = 0 'THEN' VL:= VR:= 0.5 'ELSE' 'IF' NC = 1 'THEN'
    'BEGIN' VL:= (XL1*2 + XL)/6; VR:= (XL1 + XL*2)/6 'END' 'ELSE'
    'BEGIN' XL2:= XL1*XL1/12; XLXR:=XL1*XL/6; XR2:=XL*XL/12;
     VL:= 3*XL2 + XLXR + XR2;
     VR:= 3*XR2 + XLXR + XL2
    'END';

    WL:= H*VL; WR:=H*VR; PR:= VR/(VL +VR);
    XM:= XL1 + H*PR; FM:= F(XM); RM:=R(XM);
    TAU1:= WL*RM; TAU2:=WR*RM;
    B1:= WL*FM; B2:= WR*FM; A12:= - (VL + VR)/H + H*(1 - PR)*PR*RM
   'END' ELEM. M.V. EV.;

   'PROCEDURE' ELEMENT MAT VEC EVALUATION 2;
   'BEGIN' 'REAL' XLM, XRM, VLM, VRM, WLM, WRM, FLM, FRM,
    RLM, RRM, PL1, PL2, PL3, PR1, PR2, PR3, QL1, QL2, QL3,
    RLMPL1, RLMPL2, RLMPL3, RRMPR1, RRMPR2, RRMPR3,
    VLMQL1, VLMQL2, VLMQL3, VRMQR1, VRMQR2, VRMQR3,
    QR1, QR2,QR3;

    'IF' NC = 0 'THEN'
    'BEGIN' XLM:=XL1 + H*0.2113248654052; XRM:= XL1 + XL - XLM;
     VLM:= VRM:= 0.5;
     PL1:= PR3:= 0.45534180126148; PL3:= PR1:= -0.12200846792815;
     PL2:= PR2:= 1 - PL1 - PL3;
     QL1:= - 2.15470053837925; QL3:= -0.15470053837925;
     QL2:= - QL1 - QL3; QR1:= - QL3; QR3:= - QL1; QR2:= - QL2;
    'END' 'ELSE' 'IF' NC = 1 'THEN'
    'BEGIN' 'REAL' A, A2, A3, A4, B, B2, B3, B4, P4H,
     P2, P3, P4, AUX1, AUX2;
     A:= XL1; A2:= A*A; A3:= A*A2; A4:= A*A3;
     B:= XL; B2:= B*B; B3:= B*B2; B4:= B*B3;
     P2:= 10*(A2 + 4*A*B + B2); P3:= 6*(A3 + 4*(A2*B + A*B2) + B3);
     P4:= SQRT(6*(A4 + 10*(A*B3 + A3*B) + 28*A2*B2 + B4));
     P4H:= P4*H; XLM:= (P3 - P4H)/P2; XRM:= (P3 + P4H)/P2;
     AUX1:= (A + B)/4; AUX2:= H*(A2 + 7*A*B + B2)/6/P4;
     VLM:= AUX1 - AUX2; VRM:= AUX1 + AUX2;
    'END' 'ELSE'
    'BEGIN' 'REAL' A, A2, A3, A4, A5, A6, A7, A8,
     B, B2, B3, B4, B5, B6, B7, B8, AB4, A2B3, A3B2, A4B,
     P4, P5, P8, P8H, AUX1, AUX2;
     A:= XL1; A2:= A*A; A3:= A*A2; A4:= A*A3; A5:= A*A4; A6:= A*A5;
       A7:= A*A6; A8:= A*A7;
     B:= XL; B2:= B*B; B3:= B*B2; B4:= B*B3; B5:= B*B4; B6:= B*B5;
       B7:= B*B6; B8:= B*B7;
     AB4:= A*B4; A2B3:= A2*B3; A3B2:= A3*B2; A4B:=A4*B;
     P4:= 15*(A4 + 4*(A3*B + A*B3) + 10*A2*B2 + B4);
     P5:= 10*(A5 + 4*(A4B + AB4) + 10*(A3B2 + A2B3) + B5);
     P8:= SQRT(10*(A8 + 10*(A7*B + A*B7) + 55*(A2*B6 + A6*B2)
         + 164*(A5*B3 +A3*B5) + 290*A4*B4 + B8));
     AUX1:= (A2 +A*B + B2)/6; P8H:= P8*H;
     AUX2:= (H*(A5 + 7*(A4B + AB4) + 28*(A3B2 + A2B3) + B5))/4.8/P8;
     XLM:= (P5 - P8H)/P4; XRM:= (P5 + P8H)/P4;
     VLM:= AUX1 - AUX2; VRM:= AUX1 + AUX2
    'END';

    'IF' NC > 0 'THEN'
    'BEGIN' 'REAL' AUX, PLM, PRM;
     PLM:= (XLM - XL1)/H; PRM:= (XRM - XL1)/H;
     AUX:= 2*PLM - 1; PL1:= AUX*(PLM - 1); PL3:= AUX*PLM;
       PL2:= 1 - PL1 - PL3;
     AUX:= 2*PRM - 1; PR1:= AUX*(PRM - 1); PR3:= AUX*PRM;
       PR2:= 1 - PR1 - PR3;
     AUX:= 4*PLM; QL1:= AUX - 3; QL3:= AUX - 1; QL2:= - QL1 - QL3;
     AUX:= 4*PRM; QR1:= AUX - 3; QR3:= AUX - 1; QR2:= - QR1 - QR3;
    'END';

    WLM:= H*VLM; WRM:= H*VRM; VLM:= VLM/H; VRM:= VRM/H;
    FLM:= F(XLM)*WLM; FRM:= WRM*F(XRM);
    RLM:= R(XLM)*WLM; RRM:= WRM*R(XRM);
    TAU1:= PL1*RLM + PR1*RRM;
    TAU2:= PL2*RLM + PR2*RRM;
    TAU3:= PL3*RLM + PR3*RRM;
    B1:= PL1*FLM + PR1*FRM;
    B2:= PL2*FLM + PR2*FRM;
    B3:= PL3*FLM + PR3*FRM;
    VLMQL1:= QL1*VLM; VRMQR1:= QR1*VRM;
    VLMQL2:= QL2*VLM; VRMQR2:= QR2*VRM;
    VLMQL3:= QL3*VLM; VRMQR3:= QR3*VRM;
    RLMPL1:= RLM*PL1; RRMPR1:= RRM*PR1;
    RLMPL2:= RLM*PL2; RRMPR2:= RRM*PR2;
    RLMPL3:= RLM*PL3; RRMPR3:= RRM*PR3;
    A12:= VLMQL1*QL2 + VRMQR1*QR2 + RLMPL1*PL2 + RRMPR1*PR2;
    A13:= VLMQL1*QL3 + VRMQR1*QR3 + RLMPL1*PL3 + RRMPR1*PR3;
    A22:= VLMQL2*QL2 + VRMQR2*QR2 + RLMPL2*PL2 + RRMPR2*PR2;
    A23:= VLMQL2*QL3 + VRMQR2*QR3 + RLMPL2*PL3 + RRMPR2*PR3;
    'COMMENT' STATIC CONDENSATION;
    C12:= - A12/A22; C32:= - A23/A22; A12:= A13 + C32*A12;
    B1:= B1 + C12*B2; B2:= B3 + C32*B2;
    TAU1:= TAU1 + C12*TAU2; TAU2:= TAU3 + C32*TAU2
   'END' ELEMENT MAT VEC EVALUATION 2;

   'PROCEDURE' BOUNDARY CONDITIONS;
   'IF' L=1 'AND' E2 = 0 'THEN'
   'BEGIN'  TAU1:= 1; B1:= E3/E1;B2:= B2 - A12*B1;
     TAU2:= TAU2 - A12; A12:= 0 'END'
   'ELSE' 'IF' L=1 'AND' E2 ^= 0 'THEN'
   'BEGIN' 'REAL' AUX;
     AUX:= ('IF' NC = 0 'THEN' 1 'ELSE' X[0]**NC)/E2;
     B1:= B1 - E3*AUX; TAU1:= TAU1 - E1*AUX
   'END' 'ELSE' 'IF' L=N 'AND' E5 = 0 'THEN'
   'BEGIN' TAU2:= 1; B2:= E6/E4;
     B1:= B1 - A12*B2; TAU1:= TAU1 - A12; A12:= 0
   'END' 'ELSE' 'IF' L=N 'AND' E5 ^= 0 'THEN'
   'BEGIN' 'REAL' AUX;
     AUX:= ('IF' NC = 0 'THEN' 1 'ELSE' X[N]**NC)/E5;
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
   'END' FORWARD BABUSHKA
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
                           ELEMENT MAT VEC EVALUATION 2;
     'IF' L=1 'OR' L=N 'THEN' BOUNDARY CONDITIONS;
     FORWARD BABUSHKA
   'END';
   BACKWARD BABUSHKA;
 'END' FEM LAG SPHER;
      'EOP'
