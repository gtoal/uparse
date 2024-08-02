'CODE' 34291;
'PROCEDURE' DECSYM2(A,N,TOL,AUX,P,DETAUX);
'VALUE' N;'INTEGER' N;'REAL' TOL;
'ARRAY' A,DETAUX;'INTEGER' 'ARRAY' P,AUX;
'BEGIN' 'INTEGER' I,J,K,M,IP1,IP2,DUMMY;'BOOLEAN' ONEBYONE,SYM;
    'REAL' DET,S,T,ALPHA,LAMBDA,SIGMA,AII,AIP1,AIP1I;
    AUX[3]:=AUX[4]:=0;SYM:='TRUE';I:=0;
    'FOR' DUMMY:=0 'WHILE' SYM 'AND' (I<N) 'DO'
    'BEGIN' I:=I+1;J:=I;
      'FOR' M:=0 'WHILE' SYM 'AND' (J<N) 'DO'
      'BEGIN' J:=J+1;SYM:=SYM 'AND' (A[I,J]=A[J,I]) 'END';
    'END';
    'IF' SYM 'THEN' AUX[2]:=1
        'ELSE' 'BEGIN' AUX[2]:=0;'GOTO' ENDDEC 'END';
    ALPHA:=(1+SQRT(17))/8;P[N]:=N;I:=1;
    'FOR' DUMMY:=0 'WHILE' I<N 'DO'
    'BEGIN' IP1:=I+1;IP2:=I+2;AII:=ABS(A[I,I]);P[I]:=I;
      LAMBDA:=ABS(A[I,IP1]);J:=IP1;
      'FOR' M:=IP2 'STEP' 1 'UNTIL' N 'DO'
      'IF' ABS(A[I,M])>LAMBDA 'THEN'
      'BEGIN' J:=M;LAMBDA:=ABS(A[I,M]) 'END';
      T:=ALPHA*LAMBDA;ONEBYONE:='TRUE';
      'IF' AII<T 'THEN'
      'BEGIN' SIGMA:=LAMBDA;
         'FOR' M:=IP1 'STEP' 1 'UNTIL' J-1 'DO'
            'IF' ABS(A[M,J])>SIGMA 'THEN' SIGMA:=ABS(A[M,J]);
         'FOR' M:=J+1 'STEP' 1 'UNTIL' N 'DO'
            'IF' ABS(A[J,M])>SIGMA 'THEN' SIGMA:=ABS(A[J,M]);
         'IF' SIGMA*AII<LAMBDA 'THEN'
         'BEGIN' 'IF' ALPHA*SIGMA<ABS(A[J,J]) 'THEN'
            'BEGIN' ICHROW(J+1,N,I,J,A);ICHROWCOL(IP1,J-1,I,J,A);
               T:=A[I,I];A[I,I]:=A[J,J];A[J,J]:=T;P[I]:=J
            'END'
            'ELSE'
            'BEGIN' 'IF' J>IP1 'THEN'
              'BEGIN' ICHROW(J+1,N,IP1,J,A);ICHROWCOL(IP2,J-1,IP1,J,A);
                  T:=A[I,I];A[I,I]:=A[J,J];A[J,J]:=T;
                  T:=A[I,J];A[I,J]:=A[I,IP1];A[I,IP1]:=T
               'END';
               DET:=A[I,I]*A[IP1,IP1]-A[I,IP1]**2;AIP1I:=A[I,IP1]/DET;
               AII:=A[I,I]/DET;AIP1:=A[IP1,IP1]/DET;P[I]:=J;P[IP1]:=0;
               DETAUX[I]:=1;DETAUX[IP1]:=DET;
               'FOR' J:=IP2 'STEP' 1 'UNTIL' N 'DO'
               'BEGIN' S:=AIP1I*A[IP1,J]-AIP1*A[I,J];
                  T:=AIP1I*A[I,J]-AII*A[IP1,J];ELMROW(J,N,J,I,A,A,S);
                  ELMROW(J,N,J,IP1,A,A,T);A[I,J]:=S;A[IP1,J]:=T
               'END';
               AUX[3]:=AUX[3]+1;AUX[4]:=AUX[4]+1;I:=IP2;
               ONEBYONE:='FALSE'
            'END'
         'END'
      'END';
      'IF' ONEBYONE 'THEN'
      'BEGIN' 'IF' TOL<ABS(A[I,I]) 'THEN'
         'BEGIN' AII:=A[I,I];DETAUX[I]:=A[I,I];
            'IF' AII>0 'THEN' AUX[3]:=AUX[3]+1 'ELSE' AUX[4]:=AUX[4]+1;
            'FOR' J:=IP1 'STEP' 1 'UNTIL' N 'DO'
           'BEGIN' S:=-A[I,J]/AII;ELMROW(J,N,J,I,A,A,S);A[I,J]:=S 'END'
         'END';I:=IP1
      'END'
    'END' WHILE I;
    'IF' I=N 'THEN'
    'BEGIN' 'IF' TOL<ABS(A[N,N]) 'THEN'
      'BEGIN' 'IF' A[N,N]>0 'THEN' AUX[3]:=AUX[3]+1
              'ELSE' AUX[4]:=AUX[4]+1
      'END';DETAUX[N]:=A[N,N]
    'END';
  ENDDEC:
    AUX[5]:=N-AUX[3]-AUX[4]
'END' DECSYM2;
        'EOP'
