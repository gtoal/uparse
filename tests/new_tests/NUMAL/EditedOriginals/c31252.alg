'CODE' 31252;
'PROCEDURE' GSSWTSSYM(N,ZER,C)RESULTS:(W);
'VALUE' N; 'INTEGER' N;
'ARRAY' ZER,C,W;
'BEGIN'
   'INTEGER' LOW,UP,DUMMY;
   'ARRAY' P[0:N-1];
   LOW:=1; UP:=N;
      'FOR' DUMMY:=1
   'WHILE' LOW < UP 'DO'
      'BEGIN' 'INTEGER' I; 'REAL' S;
      ALLORTPOLSYM( N-1,ZER[LOW],C,P );
      S:=P[N-1]**2;
      'FOR' I:=N-1 'STEP' -1 'UNTIL' 1 'DO'
         S:=S/C[I] + (P[I-1])**2;
      W[LOW]:=1/S; LOW:=LOW+1; UP:=UP-1;
      'END';
   'IF' LOW = UP
   'THEN' 'BEGIN' 'INTEGER' TWOI; 'REAL' S; S:=1.0;
      'FOR' TWOI:=N-1 'STEP' -2 'UNTIL' 2 'DO'
         S:=S*C[TWOI-1]/C[TWOI]+1;
      W[LOW]:=1/S;
      'END';
'END' GSSWTSSYM;
        'EOP'
