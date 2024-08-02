'CODE' 34440;
 'PROCEDURE' MARQUARDT(M,N,PAR,G,V,FUNCT,JACOBIAN,IN,OUT);
 'VALUE' M,N; 'INTEGER' M,N; 'ARRAY' PAR,G,V,IN,OUT;
 'BOOLEAN' 'PROCEDURE' FUNCT; 'PROCEDURE' JACOBIAN;
 'BEGIN' 'INTEGER' MAXFE,FE,IT,I,J,ERR;
         'REAL' VV,WW,W,MU,RES,FPAR,FPARPRES,LAMBDA,LAMBDAMIN,
                P,PW,RELTOLRES,ABSTOLRES;
         'ARRAY' EM[0:7],VAL,B,BB,PARPRES[1:N],JAC[1:M,1:N];

        'PROCEDURE' LOCFUNCT(M,N,PAR,G); 'VALUE' M, N;
        'INTEGER' M,N; 'ARRAY' PAR,G;
        'BEGIN' FE:= FE+1; 'IF' FE >= MAXFE 'THEN' ERR:= 1 'ELSE'
                'IF' 'NOT' FUNCT(M,N,PAR,G) 'THEN' ERR:= 2;
                'IF' ERR^=0 'THEN' 'GOTO' EXIT
        'END' LOCFUNCT;

        VV:=10; W:=0.5; MU:= 0.01;
        WW:=('IF' IN[6]<@-7 'THEN' @-8 'ELSE' @-1*IN[6]);
        EM[0]:=EM[2]:=EM[6]:=IN[0]; EM[4]:=10*N;
        RELTOLRES:=IN[3]; ABSTOLRES:=IN[4]**2; MAXFE:=IN[5];
        ERR:= 0; FE:= IT:= 1; P:=FPAR:= RES:= 0;
        PW:=-LN(WW*IN[0])/2.30;

        'IF' 'NOT' FUNCT(M,N,PAR,G) 'THEN'
        'BEGIN' ERR:= 3; 'GOTO' ESCAPE 'END';
        FPAR:= VECVEC(1,M,0,G,G); OUT[3]:=SQRT(FPAR);

        'FOR' IT:= 1, IT+1 'WHILE' FPAR > ABSTOLRES 'AND'
                      RES > RELTOLRES*FPAR+ABSTOLRES 'DO'
        'BEGIN' JACOBIAN(M,N,PAR,G,JAC,LOCFUNCT);
                I:=QRISNGVALDEC(JAC,M,N,VAL,V,EM);
                'IF' IT=1 'THEN'
                      LAMBDA:= IN[6] * VECVEC(1,N,0,VAL,VAL) 'ELSE'
                'IF' P =0 'THEN' LAMBDA:= LAMBDA*W 'ELSE' P:= 0;

                'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
                B[I]:=VAL[I]*TAMVEC(1,M,I,JAC,G);
           L:   'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
                BB[I]:=B[I]/(VAL[I]*VAL[I]+LAMBDA);
                'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
                PARPRES[I]:= PAR[I] - MATVEC(1,N,I,V,BB);
                LOCFUNCT(M,N,PARPRES,G);
                FPARPRES:= VECVEC(1,M,0,G,G);
                RES:=FPAR-FPARPRES;
                'IF' RES < MU * VECVEC(1,N,0,B,BB) 'THEN'
                'BEGIN' P:= P+1; LAMBDA:= VV * LAMBDA;
                    'IF' P=1 'THEN'
                    'BEGIN' LAMBDAMIN:= WW * VECVEC(1,N,0,VAL,VAL);
                        'IF' LAMBDA<LAMBDAMIN 'THEN' LAMBDA:= LAMBDAMIN
                    'END';
                    'IF' P<PW 'THEN' 'GOTO' L 'ELSE'
                    'BEGIN' ERR:= 4;
                            'GOTO' EXIT
                    'END';
                'END';

                DUPVEC(1,N,0,PAR,PARPRES);
                FPAR:=FPARPRES
          'END' ITERATION;

     EXIT:
          'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
          MULCOL(1,N,I,I,JAC,V,1/(VAL[I]+IN[0]));
          'FOR' I:=1 'STEP' 1 'UNTIL' N 'DO'
          'FOR' J:=1 'STEP' 1 'UNTIL' I 'DO'
          V[I,J]:= V[J,I]:= MATTAM(1,N,I,J,JAC,JAC);

          LAMBDA:= LAMBDAMIN:= VAL[1];
          'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
          'IF' VAL[I]>LAMBDA    'THEN' LAMBDA   := VAL[I] 'ELSE'
          'IF' VAL[I]<LAMBDAMIN 'THEN' LAMBDAMIN:= VAL[I];

          OUT[7]:=(LAMBDA/(LAMBDAMIN+IN[0]))**2;
          OUT[2]:=SQRT(FPAR);
          OUT[6]:=SQRT(RES+FPAR)-OUT[2];
     ESCAPE:
          OUT[4]:=FE;
          OUT[5]:=IT-1;
          OUT[1]:=ERR
     'END' MARQUARDT;

        'EOP'
