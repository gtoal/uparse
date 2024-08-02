'CODE' 35055;
'PROCEDURE' FORWARD(X,P,Q,I0,I1,NMAX,I);
'VALUE' X,P,Q,I0,I1,NMAX; 'INTEGER' NMAX; 'REAL' X,P,Q,I0,I1;
'ARRAY' I;
'BEGIN' 'INTEGER' M,N; 'REAL' Y,R,S;
    I[0]:= I0; 'IF' NMAX > 0 'THEN' I[1]:= I1;
    M:= NMAX-1; R:= P+Q-1; Y:= 1-X;
    'FOR' N:= 1 'STEP' 1 'UNTIL' M 'DO'
    'BEGIN' S:= (N+R)*Y;
        I[N+1]:= ((N+Q+S)*I[N]-S*I[N-1])/(N+Q)
    'END'
'END' FORWARD

        ;'EOP'
