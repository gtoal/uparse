'CODE' 35056;
'PROCEDURE' BACKWARD(X,P,Q,I0,NMAX,EPS,I);
'VALUE' X,P,Q,I0,NMAX,EPS; 'INTEGER' NMAX; 'REAL' X,P,Q,I0,EPS;
'ARRAY' I;
'BEGIN' 'INTEGER' M,N,NU; 'REAL' R,PQ,Y,LOGX;
    'ARRAY' IAPPROX[0:NMAX];
    I[0]:= I0; 'IF' NMAX>0 'THEN'
    'BEGIN''FOR' N:= 1 'STEP' 1 'UNTIL' NMAX 'DO' IAPPROX[N]:= 0;
        PQ:= P+Q-1; LOGX:= LN(X);
        R:= NMAX+(LN(EPS)+Q*LN(NMAX))/LOGX;
        NU:= ENTIER(R-Q*LN(R)/LOGX);
L1:     N:= NU; R:= X;
L2:     Y:= (N+PQ)*X; R:= Y/(Y+(N+P)*(1-R));
        'IF' N<= NMAX 'THEN' I[N]:= R; N:= N-1;
        'IF' N >= 1 'THEN' 'GOTO' L2; R:= I0;
        'FOR' N:= 1 'STEP' 1 'UNTIL' NMAX 'DO' R:= I[N]:= I[N]*R;
        'FOR' N:= 1 'STEP' 1 'UNTIL' NMAX 'DO'
        'IF' ABS((I[N]-IAPPROX[N])/I[N]) > EPS 'THEN'
        'BEGIN' 'FOR' M:= 1 'STEP' 1 'UNTIL' NMAX 'DO'
            IAPPROX[M]:= I[M]; NU:= NU+5; 'GOTO' L1
        'END'
    'END'
'END' BACKWARD;
        'EOP'
