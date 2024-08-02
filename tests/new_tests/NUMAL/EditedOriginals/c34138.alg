'CODE' 34138;
'PROCEDURE' LSQREFSOL(A, QR, N, M, N1, AUX, AID, CI, B,LDX,X,RES);
'VALUE'N,M,N1;'INTEGER'N,M,N1;'INTEGER''ARRAY'CI;'REAL'LDX;
'ARRAY'QR,A,AID,AUX,X,RES,B;
'BEGIN''INTEGER'I,J,K,S;
       'REAL'C1,NEXVE,NDX,NDR,D,DD,OP,OPL,CORRNORM;
       'ARRAY'F[1:N],G[1:M];
       'PROCEDURE' HOUSEHOLDER(P, Q, R, E);
       'VALUE' P,Q,R,E;'INTEGER' P,Q,R,E;
       'BEGIN' 'FOR' S:=P 'STEP' Q 'UNTIL' R 'DO'
               ELMVECCOL(S, E, S, F, QR,TAMVEC(S, E, S,QR, F)/(QR[S,S]*
               AID[S]))
       'END';
       'FOR' J:=1 'STEP' 1 'UNTIL' M 'DO'
       'BEGIN' S:=CI[J];'IF' S^=J'THEN' ICHCOL(1,N,J,S,A) 'END';
       'FOR'J:=1'STEP'1'UNTIL'M'DO'X[J]:=G[J]:=0;
       'FOR'I:=1'STEP'1'UNTIL'N'DO'
       'BEGIN'RES[I]:=0;F[I]:=B[I]'END';
       'FOR'K:=0,1,K+1
          'WHILE' (CORRNORM>AUX[2]*NEXVE & K<=AUX[6])
       'DO'
       'BEGIN'NDX:=NDR:=0;
          'IF'K^=0'THEN'
          'BEGIN''FOR'I:=1'STEP'1'UNTIL'N'DO'RES[I]:=RES[I]+F[I];
                 'FOR'S:=1'STEP'1'UNTIL'M'DO'
                 'BEGIN' X[S]:=X[S]+G[S];
                        LNGTAMVEC(1,N,S,A,RES,0,0,D,DD);
                        G[S]:=(-D-TAMVEC(1,S-1,S,QR,G))/AID[S]
                 'END';
                 'FOR'I:=1'STEP'1'UNTIL'N'DO'
                 'BEGIN' LNGMATVEC(1, M, I, A, X,
                         'IF' I>N1 'THEN' RES[I] 'ELSE' 0, 0, D, DD);
                        LNG SUB(B[I],0,D,DD,OP,OPL);
                        F[I]:=OP
                 'END'
          'END';
          NEXVE:=SQRT(VECVEC(1,M,0,X,X)+VECVEC(1,N,0,RES,RES));
          HOUSEHOLDER(1, 1, N1, N1);
          'FOR' I:=N1+1 'STEP' 1 'UNTIL' N 'DO'
          F[I]:=F[I]-MATVEC(1,N1, I, QR, F);
          HOUSEHOLDER(N1+1, 1, M, N);
          'FOR' I:=1 'STEP' 1 'UNTIL' M 'DO'
          'BEGIN' C1:=F[I];F[I]:=G[I];
              G[I]:='IF' I>N1 'THEN' C1-G[I] 'ELSE' C1
          'END';
          'FOR'S:=M'STEP'-1'UNTIL'1'DO'
          'BEGIN'G[S]:=(G[S]-MATVEC(S+1,M,S,QR,G))/AID[S];
                 NDX:=NDX+G[S]**2
          'END';
          HOUSEHOLDER(M, -1, N1+1, N);
          'FOR' S:=1 'STEP' 1 'UNTIL' N1 'DO'
          F[S]:=F[S]-TAMVEC(N1+1, N, S, QR, F);
          HOUSEHOLDER(N1, -1, 1, N1);
          AUX[7]:=K;
          'FOR'I:=1'STEP'1'UNTIL'N'DO'NDR:=NDR+F[I]**2;
          CORRNORM:=SQRT(NDX+NDR)
       'END'FOR K;
       LDX:=SQRT(NDX);
       'FOR' S:=M 'STEP' -1 'UNTIL' 1 'DO'
       'BEGIN' J:=CI[S];'IF' J^=S 'THEN'
          'BEGIN' C1:=X[J];X[J]:=X[S];X[S]:=C1;ICHCOL(1,N,J,S,A)'END'
       'END'
'END' LSQREFSOL;
        'EOP'
