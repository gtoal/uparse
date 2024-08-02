'CODE' 35086;
    'PROCEDURE' ENX(X, N1, N2, A);
    'VALUE' X, N1, N2;
    'REAL' X; 'INTEGER' N1, N2; 'ARRAY' A;
    'IF' X<= 1.5 'THEN'
    'BEGIN'
        'REAL' W, E; 'INTEGER' I;
        W:= -EI(-X);
        'IF' N1=1 'THEN' A[1]:=W;
        'IF' N2>1 'THEN' E:= EXP(-X);
        'FOR' I:=2 'STEP' 1 'UNTIL' N2 'DO'
        'BEGIN'
            W:= (E - X * W)/(I - 1);
            'IF' I>= N1 'THEN' A[I]:=W
        'END'
    'END' 'ELSE'
    'BEGIN' 'INTEGER' I, N; 'REAL' W, E, AN;
        N:=ENTIER(X+.5);
        'IF' N<=10 'THEN'
        'BEGIN' 'REAL' F, W1, T, H;
            'REAL' 'ARRAY' P[2:19];
            P[ 2]:=.37534261820491@-1; P[11]:=.135335283236613   ;
            P[ 3]:=.89306465560228@-2; P[12]:=.497870683678639@-1;
            P[ 4]:=.24233983686581@-2; P[13]:=.183156388887342@-1;
            P[ 5]:=.70576069342458@-3; P[14]:=.673794699908547@-2;
            P[ 6]:=.21480277819013@-3; P[15]:=.247875217666636@-2;
            P[ 7]:=.67375807781018@-4; P[16]:=.911881965554516@-3;
            P[ 8]:=.21600730159975@-4; P[17]:=.335462627902512@-3;
            P[ 9]:=.70411579854292@-5; P[18]:=.123409804086680@-3;
            P[10]:=.23253026570282@-5; P[19]:=.453999297624848@-4;
            F:= W:= P[N];
            E:= P[N+9];
            W1:= T:= 1;
            H:= X-N;
            'FOR' I:=N-1, I-1 'WHILE' ABS(W1)>@-15 * W 'DO'
            'BEGIN'
                F:= (E - I * F)/N;
                T:= -H * T / (N-I);
                W1:= T * F; W:= W + W1
             'END'
        'END' 'ELSE'
        'BEGIN'
            'ARRAY' B[N:N];
            NONEXPENX(X, N, N, B);
            W:= B[N] * EXP(-X)
        'END';
        'IF' N1=N2 & N1=N 'THEN' A[N]:=W 'ELSE'
        'BEGIN'
            E:= EXP(-X);
            AN:=W;
            'IF' N<=N2 & N>=N1 'THEN' A[N]:=W;
            'FOR' I:= N-1 'STEP' -1 'UNTIL' N1 'DO'
            'BEGIN'
                W:= (E - I * W)/X;
                'IF' I<= N2 'THEN' A[I]:= W
            'END';
            W:=AN;
            'FOR' I:=N+1 'STEP' 1 'UNTIL' N2 'DO'
            'BEGIN'
                W:= (E - X * W)/(I - 1);
                'IF' I>=N1 'THEN' A[I]:=W
            'END'
        'END'
    'END' ENX;

        'EOP'
