'CODE' 35030;
    'PROCEDURE' INCOMGAM(X,A,KLGAM,GRGAM,GAM,EPS);
    'VALUE' X,A,EPS; 'REAL' X,A,KLGAM,GRGAM,GAM,EPS;
    'BEGIN' 'REAL' C0,C1,C2,D0,D1,D2,X2,AX,P,Q,R,S,R1,R2,SCF;
        'INTEGER' N;
        S:= EXP(-X + A * LN(X)); SCF:= @+300;
        'IF' X <= ('IF' A < 3 'THEN' 1 'ELSE' A) 'THEN'
        'BEGIN' X2:= X * X; AX:= A * X; D0:= 1; P:= A; C0:= S;
            D1:=(A+1)*(A+2-X); C1:=((A+1) * (A+2)+X) * S;
             R2:= C1/D1;
             'FOR' N:= 1, N+1 'WHILE' ABS((R2-R1)/R2) > EPS 'DO'
                'BEGIN' P:= 2+P; Q:= (P+1) * (P*(P+2)-AX);
                R:= N * (N+A) * (P+2) * X2;
                C2:= (Q*C1 + R*C0)/P; D2:= (Q*D1 + R*D0)/P;
                 R1:=R2; R2:=C2/D2;
                C0:=C1; C1:=C2; D0:=D1; D1:=D2;
                'IF' ABS(C1) > SCF 'OR' ABS(D1) > SCF 'THEN'
               'BEGIN' C0:= C0/SCF; C1:= C1/SCF;
                       D0:= D0/SCF; D1:= D1/SCF
               'END'
            'END'; KLGAM:= R2/A; GRGAM:= GAM - KLGAM
        'END' 'ELSE'
        'BEGIN' C0:=A*S; C1:=(1+X)* C0; Q:= X +2  - A;
            D0:= X; D1:= X * Q; R2:= C1/D1;
            'FOR' N:=1, N+1 'WHILE' ABS((R2-R1)/R2)>EPS 'DO'
            'BEGIN'     Q:= 2 + Q; R:= N * (N+1-A);
                C2:= Q*C1-R*C0; D2:= Q*D1-R*D0;
                R1:=R2; R2:=C2/D2;
                C0:=C1; C1:=C2; D0:=D1; D1:=D2;
                'IF' ABS(C1) > SCF 'OR' ABS(D1) > SCF 'THEN'
               'BEGIN' C0:= C0/SCF; C1:= C1/SCF;
                       D0:= D0/SCF; D1:= D1/SCF
               'END'
            'END'; GRGAM:= R2/A; KLGAM:= GAM - GRGAM
        'END'
    'END' INCOMGAM;

        'EOP'
