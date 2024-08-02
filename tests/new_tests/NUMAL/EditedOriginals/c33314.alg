'CODE' 33314;
 'PROCEDURE' NONLIN FEM LAG SKEW(X, Y, N, F, FY, FZ, NC, E);
 'INTEGER' N, NC;
 'REAL' 'PROCEDURE' F, FY, FZ;
 'ARRAY' X, Y, E;
 'BEGIN' 'INTEGER' L, L1, IT;
   'REAL' XL1, XL, H, A12, A21, B1, B2, TAU1, TAU2, CH, TL, G, YL, PP,
    PLM, PRM, PL1, PL3, PL1PL2, PL1PL3, PL2PL2, PL2PL3,
    PR1PR2, PR1PR3, PR2PR3, PL1QL2, PL1QL3, PL2QL1, PL2QL2, PL2QL3,
    PL3QL1, PL3QL2, PR1QR2, PR1QR3, PR2QR1, PR2QR2, PR2QR3, PR3QR1,
    PR3QR2, H2RM, ZL1, ZL, E1, E2, E3, E4, E5, E6, EPS, RHO;
   'ARRAY' T, SUPER, SUB, CHI, GI[0:N-1], Z[0:N];

   'PROCEDURE' ELEMENT MAT VEC EVALUATION 1;
   'BEGIN' 'REAL'  XM,VL,VR,WL,WR,PR,QM,RM,FM,XL12,XL1XL,XL2,ZM,ZACCM;
    'IF' NC = 0 'THEN' VL:= VR:= 0.5 'ELSE' 'IF' NC = 1 'THEN'
    'BEGIN' VL:= (XL1*2 + XL)/6; VR:= (XL1 + XL*2)/6 'END' 'ELSE'
    'BEGIN' XL12:= XL1*XL1/12; XL1XL:=XL1*XL/6; XL2:=XL*XL/12;
     VL:= 3*XL12 + XL1XL + XL2;
     VR:= 3*XL2 + XL1XL + XL12
    'END';
    WL:= H*VL; WR:=H*VR; PR:= VR/(VL +VR);
    XM:= XL1 + H*PR; ZM:= PR*ZL + (1 - PR)*ZL1;
    ZACCM:= (ZL - ZL1)/H ; QM:= FZ(XM,ZM,ZACCM);
    RM:= FY(XM, ZM, ZACCM); FM:= F(XM,ZM,ZACCM);
    TAU1:= WL*RM; TAU2:=WR*RM;
    B1:= WL*FM - ZACCM*(VL +VR); B2:= WR*FM + ZACCM*(VL + VR);
    A12:= - (VL + VR)/H + VL*QM + (1 - PR)*PR*RM*(WL + WR);
    A21:= - (VL + VR)/H - VR*QM + (1 - PR)*PR*RM*(WL + WR);
   'END' ELEM. M.V. EV.;

   'PROCEDURE' BOUNDARY CONDITIONS;
   'IF' L=1 'AND' E2 = 0 'THEN'
   'BEGIN' TAU1:= 1; B1:= A12:= 0 'END'
   'ELSE' 'IF' L=1 'AND' E2 ^= 0 'THEN'
   'BEGIN' TAU1:= TAU1 - E1/E2
   'END' 'ELSE' 'IF' L=N 'AND' E5 = 0 'THEN'
   'BEGIN' TAU2:= 1; B2:= A21:= 0
   'END' 'ELSE' 'IF' L=N 'AND' E5 ^= 0 'THEN'
   'BEGIN' TAU2:= TAU2 + E4/E5
   'END' B.C.1;

   'PROCEDURE' FORWARD BABUSKA;
   'IF' L=1 'THEN'
   'BEGIN' CHI[0]:= CH:= TL:= TAU1; T[0]:= TL;
      GI[0]:= G:= YL:= B1; Y[0]:= YL;
      SUB[0]:= A21; SUPER[0]:= A12;
      PP:= A21/(CH - A12); CH:= TAU2 - CH*PP;
      G:= B2 - G*PP; TL:= TAU2; YL:= B2
   'END' 'ELSE'
   'BEGIN' CHI[L1]:= CH:= CH + TAU1;
      GI[L1]:= G:= G + B1;
      SUB[L1]:= A21; SUPER[L1]:= A12;
      PP:= A21/(CH - A12); CH:= TAU2 - CH*PP;
      G:= B2 - G*PP; T[L1]:= TL + TAU1; TL:= TAU2;
      Y[L1]:= YL +  B1; YL:= B2
   'END' FORWARD BABUSKA;

   'PROCEDURE' BACKWARD BABUSKA;
   'BEGIN'PP:= YL; Y[N]:= G/CH;
      G:= PP; CH:= TL; L:= N;
      'FOR' L:= L - 1 'WHILE' L >= 0 'DO'
      'BEGIN' PP:= SUPER[L]/(CH - SUB[L]);
        TL:= T[L]; CH:= TL - CH*PP;
        YL:= Y[L]; G:= YL - G*PP;
        Y[L]:=(GI[L] + G - YL)/(CHI[L] + CH - TL)  ;
      'END'
   'END' BACKWARD BABUSKA;
   DUPVEC(0,N,0,Z,Y);
    E1:= E[1]; E2:= E[2]; E3:= E[3]; E4:= E[4]; E5:= E[5]; E6:= E[6];
   'FOR' IT:= 1, IT + 1 'WHILE' EPS > RHO 'DO'
   'BEGIN' L:= 0;XL:= X[0]; ZL:= Z[0];
    'FOR' L:= L + 1 'WHILE' L <= N 'DO'
    'BEGIN' XL1:= XL; L1:= L - 1; XL:= X[L]; H:= XL - XL1;
      ZL1:= ZL; ZL:= Z[L];
      ELEMENT MAT VEC EVALUATION 1;
      'IF' L=1 'OR' L=N 'THEN' BOUNDARY CONDITIONS;
      FORWARD BABUSKA
    'END';
    BACKWARD BABUSKA;
    EPS:= 0; RHO:= 1;
    'FOR' L:= 0 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' RHO:= RHO + ABS(Z[L]);
     EPS:= EPS + ABS(Y[L]); Z[L]:= Z[L] - Y[L]
    'END';
    RHO:= @-14*RHO
   'END';
    DUPVEC(0,N,0,Y,Z)
 'END' NONLIN FEM LAG SKEW;
      'EOP'
