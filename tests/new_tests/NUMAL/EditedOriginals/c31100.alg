'CODE'31100;
'PROCEDURE'LNGREATODECI(X,XX,S,MANT,EXPO);
'VALUE'X,XX,S;'INTEGER'S,EXPO;'REAL'X,XX;'INTEGER''ARRAY'MANT;
'BEGIN''INTEGER'I,K;
       'REAL'P,PP;
       MANT[0]:=SIGN(X);'IF'X<0'THEN''BEGIN'X:=-X;XX:=-XX'END';
       'IF'X=0'THEN'EXPO:=0
              'ELSE'EXPO:=ENTIER(LN(X)/LN(10))+1;
       DP POW(10,-EXPO,P,PP);
       LNG MUL(X,XX,P,PP,X,XX);
       'FOR'I:=0'WHILE'ENTIER(X)=0 & X^=0 'DO'
       'BEGIN'LNG MUL(X,XX,10,0,X,XX);EXPO:=EXPO-1'END';
       'FOR'I:=1'STEP'1'UNTIL'S'DO'
       'BEGIN'K:=ENTIER(X);'IF'K>9'THEN'K:=9;MANT[I]:=K;
              LNG SUB(X,XX,K,0,P,PP);LNG MUL(P,PP,10,0,X,XX)
       'END';
       'IF'ENTIER(X)>=5
       'THEN''BEGIN''FOR'I:=S'STEP'-1'UNTIL'1'DO'
                'BEGIN'K:=MANT[I]+1;
                       'IF'K<10'THEN''BEGIN'MANT[I]:=K;'GOTO'READY
                                     'END';
                       MANT[I]:=0
                'END';
                EXPO:=EXPO+1;
                'IF'S>0'THEN'MANT[1]:=1;
                 READY:
             'END';
       EXPO:=EXPO+1
'END' LNGREATODECI;
   'EOP'
