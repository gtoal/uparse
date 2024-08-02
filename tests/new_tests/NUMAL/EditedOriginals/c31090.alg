'CODE' 31090;
'REAL''PROCEDURE'SINSER(N,THETA,B);
'VALUE'N,THETA;'INTEGER'N;'REAL'THETA;'ARRAY'B;
'BEGIN''INTEGER'K;'REAL'C,CC,LAMBDA,H,DUN,UN,UN1;
   C:=COS(THETA);
   'IF'C<-.5'THEN'
   'BEGIN'LAMBDA:= 4*COS(THETA/2)**2;UN:=DUN:=0;
          'FOR'K:=N'STEP'-1'UNTIL'1'DO'
          'BEGIN'DUN:=LAMBDA*UN-DUN+B[K] ;
                 UN:=DUN-UN;
          'END'
   'END''ELSE''IF'C> .5'THEN'
   'BEGIN'LAMBDA:=-4*SIN(THETA/2)**2;UN:=DUN:=0;
          'FOR'K:=N'STEP'-1'UNTIL'1'DO'
          'BEGIN'DUN:=LAMBDA*UN+DUN+B[K] ;
                 UN:=DUN+UN;
          'END'
   'END''ELSE'
   'BEGIN'CC:=C+C;UN:=UN1:=0;
          'FOR'K:=N'STEP'-1'UNTIL'1'DO'
          'BEGIN'H:=CC*UN-UN1+B[K]; UN1 := UN; UN := H; 'END'
   'END';
   SINSER:=UN*SIN(THETA)
'END'SINSER;
        'EOP'
