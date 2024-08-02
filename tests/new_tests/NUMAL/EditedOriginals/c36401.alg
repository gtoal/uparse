'CODE' 36401;
'PROCEDURE' SYMEIGIMP(N,A,VEC,VAL1,VAL2,LBOUND,UBOUND,AUX);
'VALUE' N;'INTEGER' N;'ARRAY' A,VEC,VAL1,VAL2,LBOUND,UBOUND,AUX;
'BEGIN'
    'INTEGER' K,I,J,I0,I1,ITER,MAXITP1;'REAL' S,HEAD,TAIL,MAX,TOL,
    MATEPS,RELERRA,RELTOLR,NORMA;'INTEGER' 'ARRAY' PERM[1:N];
    'ARRAY' R,P,Y[1:N,1:N],RQ,RQT,EPS,Z,VAL3,ETA[1:N];
    'PROCEDURE' BOUNDS(I0,I1,N,LBOUND,UBOUND);'VALUE' I0,I1,N;
    'INTEGER' I0,I1,N;'ARRAY' LBOUND,UBOUND;
    'BEGIN' 'INTEGER' K,I,J,I01;'REAL' EPS2,DL,DR;
        'FOR' I:=I0,I01 'WHILE' I<=I1 'DO'
        'BEGIN' J:=I01:=I;
            'FOR' J:=J+1 'WHILE' 'IF' J>I1 'THEN' 'FALSE' 'ELSE'
            RQ[J]-RQ[J-1]<=EPS[J]+EPS[J-1] 'DO' I01:=J;
            'IF' I = I01 'THEN'
            'BEGIN'
                'IF' I<N 'THEN'
                'BEGIN'
                    'IF' I=1 'THEN' DL:=DR:=RQ[I+1]-RQ[I]-EPS[I+1]
                    'ELSE' 'BEGIN' DL:=RQ[I]-RQ[I-1]-EPS[I-1];
                                   DR:=RQ[I+1]-RQ[I]-EPS[I+1]
                           'END'
                'END' 'ELSE' DL:=DR:=RQ[I]-RQ[I-1]-EPS[I-1];
                EPS2:=EPS[I]*EPS[I];LBOUND[I]:=EPS2/DR+MATEPS;
                UBOUND[I]:=EPS2/DL+MATEPS
            'END' 'ELSE'
            'BEGIN' 'FOR' K:=I 'STEP' 1 'UNTIL' I01 'DO'
                LBOUND[K]:=UBOUND[K]:=EPS[K]+MATEPS
            'END';I01:=I01+1
        'END'
    'END' BOUNDS;
    'BOOLEAN' STOP;STOP:='FALSE';NORMA:=INFNRMMAT(1,N,1,N,J,A);
    RELERRA:=AUX[0];RELTOLR:=AUX[2];MAXITP1:=AUX[4]+1;
    MATEPS:=RELERRA*NORMA;TOL:=RELTOLR*NORMA;
    'FOR' ITER:=1 'STEP' 1 'UNTIL' MAXITP1 'DO'
    'BEGIN' STOP:='TRUE';MAX:=0;
        'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO'
        'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN'
            LNGMATVEC(J,J,I,VEC,VAL1,0,0,HEAD,TAIL);
            LNGMATMAT(1,N,I,J,A,VEC,-HEAD,-TAIL,R[I,J],TAIL);
            'IF'ABS(R[I,J])>MAX 'THEN' MAX:=ABS(R[I,J])
        'END';'IF' MAX > TOL 'THEN' STOP:='FALSE';
        'IF' 'NOT' STOP 'AND' ITER<MAXITP1 'THEN'
        'BEGIN'
            'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
            LNGTAMMAT(1,N,I,I,VEC,R,VAL1[I],0,RQ[I],RQT[I]);
            'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
                ETA[I]:=R[I,J]-(RQ[J]-VAL1[J])*VEC[I,J];
                Z[J]:=SQRT(VECVEC(1,N,0,ETA,ETA))
            'END';
            MERGESORT(RQ,PERM,1,N);VECPERM(PERM,1,N,RQ);
            'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' EPS[I]:=Z[PERM[I]];VAL3[I]:=VAL1[PERM[I]];
                ROWPERM(PERM,1,N,I,VEC);ROWPERM(PERM,1,N,I,R)
            'END';
            'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
            'FOR' J:=I 'STEP' 1 'UNTIL' N 'DO'
            P[I,J]:=P[J,I]:=TAMMAT(1,N,I,J,VEC,R);
        'END';
        'FOR'I0:=1,I1+1 'WHILE' I0<=N 'DO'
        'BEGIN' J:=I1:=I0;
            'FOR' J:=J+1 'WHILE' 'IF' J>N 'THEN' 'FALSE' 'ELSE'
            RQ[J]-RQ[J-1]<=SQRT((EPS[J]+EPS[J-1])*NORMA) 'DO' I1:=J;
            'IF' STOP 'OR' ITER=MAXITP1 'THEN'
            BOUNDS(I0,I1,N,LBOUND,UBOUND) 'ELSE'
            'BEGIN'
                'IF' I0=I1 'THEN'
                'BEGIN' 'FOR' K:=1 'STEP' 1 'UNTIL' N 'DO'
                    'IF' K=I0 'THEN' Y[K,I0]:=1 'ELSE'
                    R[K,I0]:=P[K,I0];
                    VAL1[I0]:=RQ[I0];VAL2[I0]:=RQT[PERM[I0]]
                'END' 'ELSE'
                'BEGIN''INTEGER' N1,I0M1,I1P1;'REAL' M1;'ARRAY'EM[0:5];
                    N1:=I1-I0+1;EM[0]:=EM[2]:=@-14;EM[4]:=10*N1;
                    'BEGIN' 'ARRAY' PP[1:N1,1:N1],VAL4[1:N1];M1:=0;
                        'FOR' K:=I0 'STEP' 1 'UNTIL' I1 'DO'
                        M1:=M1+VAL3[K];M1:=M1/N1;
                        'FOR' I:=1 'STEP' 1 'UNTIL' N1 'DO'
                        'FOR' J:=1 'STEP' 1 'UNTIL' N1 'DO'
                        'BEGIN' PP[I,J]:=P[I+I0-1,J+I0-1];
                            'IF' I=J 'THEN'
                            PP[I,J]:=PP[I,J]+VAL3[J+I0-1]-M1
                        'END';'FOR' I:=I0 'STEP' 1 'UNTIL' I1 'DO'
                        'BEGIN' VAL3[I]:=M1;VAL1[I]:=RQ[I];
                            VAL2[I]:=RQT[PERM[I]]
                        'END';
                        QRISYM(PP,N1,VAL4,EM);
                        MERGESORT(VAL4,PERM,1,N1);
                        'FOR' I:=1 'STEP' 1 'UNTIL' N1 'DO'
                        'FOR' J:=1 'STEP' 1 'UNTIL' N1 'DO'
                        P[I+I0-1,J+I0-1]:=PP[I,PERM[J]];
                        I0M1:=I0-1;I1P1:=I1+1;
                        'FOR' J:=I0 'STEP' 1 'UNTIL' I1 'DO'
                        'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' I0M1,
                            I1P1 'STEP' 1 'UNTIL' N 'DO'
                            'BEGIN' S:=0;
                                'FOR' K:=I0 'STEP' 1 'UNTIL' I1 'DO'
                                S:=S+P[I,K]*P[K,J];
                                R[I,J]:=S
                            'END';'FOR' I:=I0 'STEP' 1 'UNTIL' I1 'DO'
                            Y[I,J]:=P[I,J]
                        'END' FOR J
                    'END' INNERBLOCK
                'END' I1>I0
            'END' NOT STOP
        'END' FOR I0;
        'IF' 'NOT' STOP 'AND' ITER<MAXITP1 'THEN'
        'BEGIN'
            'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO'
            'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
            'IF' VAL3[I]^=VAL3[J] 'THEN'
            Y[I,J]:=R[I,J]/(VAL3[J]-VAL3[I]);
            'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
            'BEGIN' 'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO'
                Z[J]:=MATMAT(1,N,I,J,VEC,Y);
                'FOR' J:=1 'STEP' 1 'UNTIL' N 'DO' VEC[I,J]:=Z[J]
            'END';ORTHOG(N,1,N,VEC)
        'END' 'ELSE'
        'BEGIN' AUX[5]:=ITER-1;'GOTO' EXIT 'END'
    'END' FOR ITER;
    EXIT: AUX[1]:=NORMA;AUX[3]:=MAX
'END' SYMEIGIMP;
        'EOP'
