'CODE' 34292;
'PROCEDURE' SOLSYM2(A,N,B,P,DETAUX);
'VALUE' N;'INTEGER' N;
'ARRAY' A,B,DETAUX;'INTEGER' 'ARRAY' P;
'BEGIN' 'INTEGER' I,II,J,K,IP1,PI,PII,DUMMY;
    'REAL' DET,TEMP,SAVE;
    I:=1;
    'FOR' DUMMY:=0 'WHILE' I<N 'DO'
    'BEGIN' IP1:=I+1;PI:=P[I];SAVE:=B[PI];
      'IF' P[IP1]>0 'THEN'
      'BEGIN' B[PI]:=B[I];B[I]:=SAVE/A[I,I];
          ELMVECROW(IP1,N,I,B,A,SAVE);I:=IP1
      'END'
      'ELSE'
      'BEGIN' TEMP:=B[I];B[PI]:=B[IP1];DET:=DETAUX[IP1];
          B[I]:=(TEMP*A[IP1,IP1]-SAVE*A[I,IP1])/DET;
          B[IP1]:=(SAVE*A[I,I]-TEMP*A[I,IP1])/DET;
          ELMVECROW(I+2,N,I,B,A,TEMP);ELMVECROW(I+2,N,IP1,B,A,SAVE);
          I:=I+2
      'END'
    'END' WHILE I;
    'IF' I=N 'THEN' 'BEGIN' B[I]:=B[I]/A[I,I];I:=N-1 'END'
      'ELSE' I:=N-2;
    'FOR' DUMMY:=0 'WHILE' I>0 'DO'
    'BEGIN' 'IF' P[I]=0 'THEN' II:=I-1 'ELSE' II:=I;
      'FOR' K:=II 'STEP' 1 'UNTIL' I 'DO'
      'BEGIN' SAVE:=B[K];SAVE:=SAVE+MATVEC(I+1,N,K,A,B);
         B[K]:=SAVE
      'END';
      PII:=P[II];B[I]:=B[PII];B[PII]:=SAVE;I:=II-1
    'END' WHILE I
'END' SOLSYM2;
        'EOP'
