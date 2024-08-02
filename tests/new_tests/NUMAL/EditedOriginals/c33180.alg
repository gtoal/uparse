'CODE' 33180;
'PROCEDURE' DIFFSYS(X,XE,N,Y,DERIVATIVE,AETA,RETA,S,H0,OUTPUT);
'VALUE' N;
'INTEGER' N;
'REAL' X,XE,AETA,RETA,H0;
'ARRAY' Y,S;
'PROCEDURE' DERIVATIVE,OUTPUT;
'BEGIN' 'REAL' A,B,B1,C,G,H,U,V,TA,FC; 'INTEGER' I,J,K,KK,JJ,L,M,R,SR;
    'ARRAY' YA,YL,YM,DY,DZ[1:N],DT[1:N,0:6],D[0:6],YG,YH[0:7,1:N];
    'BOOLEAN' KONV,B0,BH,LAST;
    LAST:='FALSE'; H:=H0;
NEXT: 'IF' H*1.1>=XE-X 'THEN'
    'BEGIN' LAST:='TRUE'; H0:=H; H:=XE-X+@-13 'END';
    DERIVATIVE(X,Y,DZ); BH:='FALSE';
    'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO' YA[I]:=Y[I];
ANF: A:=H+X; FC:=1.5; B0:='FALSE'; M:=1; R:=2; SR:=3; JJ:=-1;
    'FOR' J:=0 'STEP' 1 'UNTIL' 9 'DO'
    'BEGIN' 'IF' B0 'THEN'
        'BEGIN' D[1]:=16/9; D[3]:=64/9; D[5]:=256/9 'END'
        'ELSE' 'BEGIN' D[1]:=9/4; D[3]:=9; D[5]:=36 'END';
        KONV:='TRUE';
        'IF' J>6 'THEN' 'BEGIN' L:=6; D[6]:=64; FC:=.6*FC 'END'
        'ELSE' 'BEGIN' L:=J; D[L]:=M*M 'END';
        M:=M*2; G:=H/M; B:=G*2;
        'IF' BH 'AND' J<8 'THEN'
        'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' YM[I]:=YH[J,I]; YL[I]:=YG[J,I] 'END'
        'END'
        'ELSE'
        'BEGIN'
                KK:=(M-2)/2; M:=M-1;
            'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' YL[I]:=YA[I]; YM[I]:=YA[I]+G*DZ[I] 'END';
            'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO'
            'BEGIN' DERIVATIVE(X+K*G,YM,DY);
                'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' U:=YL[I]+B*DY[I]; YL[I]:=YM[I]; YM[I]:=U;
                    U:=ABS(U); 'IF' U>S[I] 'THEN' S[I]:=U
                'END';
                'IF' K=KK 'AND' K^=2 'THEN'
                'BEGIN' JJ:=JJ+1; 'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
                    'BEGIN' YH[JJ,I]:=YM[I]; YG[JJ,I]:=YL[I] 'END'
                'END'
            'END'
        'END';
        DERIVATIVE(A,YM,DY);
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' V:=DT[I,0]; TA:=C:=DT[I,0]:=(YM[I]+YL[I]+G*DY[I])/2;
            'FOR' K:=1 'STEP' 1 'UNTIL' L 'DO'
            'BEGIN' B1:=D[K]*V; B:=B1-C; U:=V;
                'IF' B^=0 'THEN'
                'BEGIN' B:=(C-V)/B; U:=C*B; C:=B1*B 'END';
                V:=DT[I,K]; DT[I,K]:=U; TA:=U+TA
            'END';
            'IF' ABS(Y[I]-TA)>RETA*S[I]+AETA 'THEN' KONV:='FALSE';
            Y[I]:=TA
        'END';
        'IF' KONV 'THEN' 'GOTO' END;
        D[2]:=4; D[4]:=16; B0:=^B0; M:=R; R:=SR; SR:=M*2
    'END';
    BH:=^BH; LAST:='FALSE'; H:=H/2; 'GOTO' ANF;
END: H:=FC*H; X:=A; OUTPUT; 'IF' 'NOT' LAST 'THEN' 'GOTO' NEXT;
'END' DIFFSYS;
        'EOP'
