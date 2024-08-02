'CODE'36021;
 'PROCEDURE' SNDREMEZ(N,M,S,G,EM);
 'VALUE' N,M;'INTEGER' N,M;
 'INTEGER' 'ARRAY' S; 'ARRAY' G,EM;
 'COMMENT' SNDREMEZ EXCHANGES ATMOST N+1 NUMBERS ,GIVEN IN
           INTEGER ARRAY S[0:N], WITH NUMBERS OUT OF THE
           REFERENCE SET 0,...M, UNDER THE CONDITIONS:
      I.   THE ALTERNANCE PROPERTY OF THE FUNCTIONVALUES G[S[J]],
           J=0,...N IS PRESERVED.
      II.  !G[S[J]]!>=!EM[0]!,J=0,...N.
      III. THE FIRST INDEX K , WITH G[K]=INFINITY NORM OF G,
           IS ONE OF THE RESULTING NUMBERS S[0],...S[N].
           IN ARRAY G[0:M] ONE MUST GIVE ERROR FUNCTION VALUES.
           MOREOVER,
           EM[1]:=INFINITY NORM OF G,
      THE PROCEDURE INFNRMVEC IS USED;
 'BEGIN' 'INTEGER' S0,SN,SJP1,I,J,K,UP,INDEXMAX,LOW,NM1;
    'REAL' MAX,MSJP1,HI,HJ,HE,ABSE,H;
     INDEX MAX:=S0:=SJP1:=S[0];
     HE:=EM[0];LOW:=S0+1;
     MAX:=MSJP1:=ABSE:=ABS(HE);
     NM1:=N-1;
     'FOR' J:= 0 'STEP' 1 'UNTIL' NM1 'DO'
     'BEGIN'
        UP:= S[J+1]-1;
        H:= INFNRMVEC(LOW,UP,I,G);
        'IF' H > MAX  'THEN' 'BEGIN' MAX:= H; INDEX MAX:= I 'END';
        'IF' H > ABSE 'THEN'
        'BEGIN' 'IF' HE * G[I] > 0 'THEN'
           'BEGIN' S[J]:= 'IF' MSJP1 < H 'THEN' I 'ELSE' SJP1;
              SJP1:= S[J+1]; MSJP1:= ABSE
           'END' 'ELSE'
           'BEGIN' S[J]:= SJP1; SJP1:= I; MSJP1:= H 'END'
        'END' 'ELSE'
        'BEGIN' S[J]:=SJP1; SJP1:=S[J+1]; MSJP1:= ABSE 'END';
        HE:=-HE;LOW:=UP+2;
    'END' FOR J; SN:= S[N]; S[N]:= SJP1;

    HI:=INFNRMVEC(0,S0-1,I,G);
    HJ:=INFNRMVEC(SN+1,M,J,G);
    'IF' J  > M  'THEN' J:=M;
    'IF' HI > HJ 'THEN'
    'BEGIN' 'IF' HI > MAX 'THEN' 'BEGIN' MAX:= HI; INDEXMAX:= I 'END';
       'IF' SIGN(G[I]) =  SIGN(G[S[0]]) 'THEN'
       'BEGIN' 'IF' HI > ABS(G[S[0]])   'THEN'
          'BEGIN' S[0]:= I;
             'IF' G[J]/G[S[N]] > 1 'THEN' S[N]:=J
          'END'
       'END' 'ELSE'
       'IF' HI > ABS(G[S[N]]) 'THEN'
       'BEGIN' S[N]:= 'IF' G[J]/G[S[NM1]] > 1  'THEN' J 'ELSE' S[NM1];
          'FOR' K:= NM1 'STEP' -1 'UNTIL' 1 'DO' S[K]:= S[K-1];
          S[0]:= I
       'END'
    'END' 'ELSE'
    'BEGIN' 'IF' HJ > MAX 'THEN' 'BEGIN' MAX:= HJ; INDEXMAX:= J 'END';
       'IF' SIGN(G[J]) = SIGN(G[S[N]]) 'THEN'
       'BEGIN' 'IF' HJ > ABS(G[S[N]])  'THEN'
          'BEGIN' S[N]:= J; 'IF' G[I]/G[S[0]] > 1 'THEN'S[0]:=I 'END'
       'END' 'ELSE'
       'IF' HJ > ABS(G[S[0]]) 'THEN'
       'BEGIN' S[0]:= 'IF' G[I]/G[S[1]] > 1 'THEN' I 'ELSE' S[1];
          'FOR' K:= 1 'STEP' 1 'UNTIL' NM 1 'DO' S[K]:= S[K+1];
          S[N]:= J
       'END'
    'END' RANDGEBIEDEN;
    EM[1]:=MAX;
 'END' SNDREMEZ;
        'EOP'
