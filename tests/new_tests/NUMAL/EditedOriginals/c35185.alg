'CODE' 35185;
'INTEGER' 'PROCEDURE' START(X,N,T); 'VALUE' X,N,T; 'REAL' X;
                                   'INTEGER' N,T;
'BEGIN' 'REAL'P,Q,R,Y;   'INTEGER' S;
   S:= 2*T-1; P:= 36/X-T; R:= N/X; 'IF' R>1 'OR' T=1 'THEN'
   'BEGIN' Q:= SQRT(R*R+S); R:= R*LN(Q+R)-Q 'END' 'ELSE' R:= 0;
   Q:= 18/X+R; R:= 'IF' P>Q 'THEN' P 'ELSE' Q;
   P:= SQRT(2*(T+R)); P:= X*((1+R)+P)/(1+P); Y:= 0;
   'FOR' Q:= Y, Y 'WHILE' P>Q 'OR' P<Q-1 'DO'
   'BEGIN' Y:=P; P:= P/X; Q:= SQRT(P*P+S); P:= X*(R+Q)/LN(P+Q) 'END';
   START:= 'IF' T=1 'THEN' ENTIER(P+1) 'ELSE' -ENTIER(-P/2)*2
'END' START;
        'EOP'
