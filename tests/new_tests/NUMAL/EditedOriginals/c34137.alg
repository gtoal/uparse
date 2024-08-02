'CODE' 34137;
'PROCEDURE' LSQDECOMP( A, N ,M ,N1 ,AUX ,AID ,CI );
'VALUE' N , M ,N1;'INTEGER' N,M,N1;'ARRAY' A,AUX, AID;
'INTEGER''ARRAY' CI;
'BEGIN''INTEGER'J,K,KPIV,NR,S;'BOOLEAN' FSUM;
    'REAL' BETA,SIGMA,NORM,AIDK,AKK,W,EPS;
    'ARRAY' SUM[1:M];

    NORM:=0 ; AUX[3]:=M;NR:=N1;FSUM:='TRUE';
    'FOR' K:=1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' 'IF' K=N1+1 'THEN' 'BEGIN' FSUM:='TRUE'; NR:=N 'END';
        'IF' FSUM 'THEN'
        'FOR' J:=K 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' W:=SUM[J]:= TAMMAT(K ,NR ,J ,J ,A ,A);
                'IF' W>NORM 'THEN' NORM:=W
        'END'; FSUM:='FALSE';EPS:=AUX[2]*SQRT(NORM);
        SIGMA:=SUM[K]; KPIV:=K;
        'FOR' J:=K+1 'STEP' 1 'UNTIL' M 'DO'
        'IF' SUM[J]>SIGMA 'THEN'
        'BEGIN' SIGMA:=SUM[J]; KPIV:=J 'END';
        'IF' KPIV^=K 'THEN'
        'BEGIN' SUM[KPIV]:=SUM[K]; ICHCOL( 1 ,N ,K ,KPIV ,A) 'END';
        CI[K]:=KPIV; AKK:=A[K,K];
        SIGMA:=TAMMAT(K ,NR ,K ,K ,A ,A); W:=SQRT(SIGMA);
        AIDK:=AID[K]:='IF' AKK<0 'THEN' W 'ELSE' -W;
        'IF' W<EPS 'THEN'
        'BEGIN' AUX[3]:=K-1;'GOTO' ENDDEC 'END';
        BETA:= 1/(SIGMA-AKK*AIDK); A[K,K]:=AKK-AIDK;
        'FOR' J:=K+1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' ELMCOL(K ,NR ,J ,K ,A ,A ,-BETA*TAMMAT(K ,NR ,
        K ,J ,A ,A)); SUM[J]:=SUM[J]-A[K,J]**2
        'END';
        'IF' K=N1 'THEN'
        'FOR' J:=N1+1 'STEP' 1 'UNTIL' N 'DO'
        'FOR' S:=1 'STEP' 1 'UNTIL' M 'DO'
        'BEGIN' NR:='IF' S>N1 'THEN' N1 'ELSE' S-1;
        W:=A[J,S]-MATMAT(1 ,NR , J ,S ,A ,A);
        A[J,S]:='IF' S>N1 'THEN' W 'ELSE' W/AID[S]
        'END'
    'END' FOR K;
  ENDDEC:
'END' LSQDECOMP;
        'EOP'
