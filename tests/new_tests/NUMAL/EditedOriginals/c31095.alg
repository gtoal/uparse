'CODE' 31095;
'PROCEDURE'COMFOUSER(N,THETA,A,RR,RI);
'VALUE'N,THETA;'INTEGER'N;'REAL'THETA,RR,RI;'ARRAY'A;
'BEGIN''INTEGER'K;'REAL'C,CC,LAMBDA,H,DUN,UN,UN1;
   C:=COS(THETA);
   'IF'C<-.5'THEN'
   'BEGIN'LAMBDA:= 4*COS(THETA/2)**2;UN:=DUN:=0;
          'FOR'K:=N'STEP'-1'UNTIL'0'DO'
          'BEGIN'UN:=DUN-UN;
                 DUN:=LAMBDA*UN-DUN+A[K]
          'END';RR    :=DUN-LAMBDA/2*UN
   'END''ELSE''IF'C> .5'THEN'
   'BEGIN'LAMBDA:=-4*SIN(THETA/2)**2;UN:=DUN:=0;
          'FOR'K:=N'STEP'-1'UNTIL'0'DO'
          'BEGIN'UN:=DUN+UN;
                 DUN:=LAMBDA*UN+DUN+A[K]
          'END';RR    :=DUN-LAMBDA/2*UN
   'END''ELSE'
   'BEGIN'CC:=C+C;UN:=UN1:=0;
          'FOR'K:=N'STEP'-1'UNTIL'1'DO'
          'BEGIN'H:=CC*UN-UN1+A[K];
                 UN1:=UN;UN:=H
          'END';RR    :=A[0]+UN*C-UN1
   'END';RI:=UN*SIN(THETA)
'END'COMFOUSER;
        'EOP'
