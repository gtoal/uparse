'CODE' 35050;
'REAL' 'PROCEDURE' INCBETA(X,P,Q,EPS);
'VALUE' X,P,Q,EPS; 'REAL' X,P,Q,EPS;
'BEGIN' 'INTEGER' M,N; 'REAL' G,F,FN,FN1,FN2,GN,GN1,GN2,DN,PQ;
    'BOOLEAN' N EVEN,RECUR;

    'IF' X=0 'OR' X=1 'THEN' INCBETA:= X 'ELSE'
    'BEGIN' 'IF' X>.5 'THEN'
        'BEGIN' F:= P; P:= Q; Q:= F; X:= 1-X; RECUR:= 'TRUE''END'
        'ELSE' RECUR:= 'FALSE';
        G:= FN2:= 0; M:= 0; PQ:= P+Q; F:= FN1:= GN1:= GN2:= 1;
        N EVEN:= 'FALSE';
        'FOR' N:= 1,N+1 'WHILE' ABS((F-G)/F) > EPS 'DO'
        'BEGIN' 'IF' N EVEN 'THEN'
            'BEGIN' M:= M+1; DN:= M*X*(Q-M)/(P+N-1)/(P+N) 'END'
            'ELSE' DN:= -X*(P+M)*(PQ+M)/(P+N-1)/(P+N);
            G:= F; FN:= FN1+DN*FN2; GN:= GN1+DN*GN2;
            N EVEN:= ^ N EVEN; F:= FN/GN;
            FN2:= FN1; FN1:= FN; GN2:= GN1; GN1:= GN
        'END';
        F:= F*X**P*(1-X)**Q*GAMMA(P+Q)/GAMMA(P+1)/GAMMA(Q);
        'IF' RECUR 'THEN' F:= 1-F;
        INCBETA:= F
    'END'
'END' INCBETA;
        'EOP'
