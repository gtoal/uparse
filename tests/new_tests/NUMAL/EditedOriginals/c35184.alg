'CODE' 35184;
'PROCEDURE' BESS ZEROS(A,N,Z,D); 'VALUE' A,N,D; 'REAL' A;'ARRAY' Z;
                                 'INTEGER' N,D;
'COMMENT' COMPUTES Z[1],...Z[N],THE FIRST N ZEROS OF A BESSEL FUNCTION.
   THE CHOICE OF D DETERMINES THE TYPE OF THE BESSEL FUNCTION :
   IF D=1 THEN JA       ELSE
   IF D=2 THEN YA       ELSE
   IF D=3 THEN JA-PRIME ELSE
   IF D=4 THEN YA-PRIME.
   A IS THE ORDER OF THE BESSEL FUNCTION, IT MUST BE NON-NEGATIVE.;
'BEGIN''REAL' AA,A2,B,BB,C,CHI,CO,MU,MU2,MU3,MU4,P,PI,PA,PA1,P0,P1,PP1,
             Q,QA,QA1,Q1,QQ1,RO,SI,T,TT,U,V,W,X,XX,X4,Y; 'INTEGER' J,S;

   'REAL' 'PROCEDURE' FI(Y); 'VALUE' Y; 'REAL' Y;
   'COMMENT' COMPUTES FI FROM THE EQUATION
          TAN(FI)-FI=Y , WHERE Y>=0.
   THE RELATIVE ACCURACY IS AT LEAST 5 DIGITS;
   'IF' Y=0  'THEN' FI:=0         'ELSE'
   'IF' Y>@5 'THEN' FI:=1.570796  'ELSE'
   'BEGIN' 'REAL' R,P,PP;
       'IF' Y<1 'THEN'
       'BEGIN' P:=(3*Y)**(1/3); PP:=P*P;
           P:=P*(1+PP*(-210+PP*(27-2*PP))/1575)
       'END' 'ELSE'
       'BEGIN' P:=1/(Y+1.570796); PP:=P*P;
           P:= 1.570796-P*(1+PP*(2310+PP*(3003+PP*(4818+PP*
                   (8591+PP*16328))))/3465)
       'END';
       PP:=(Y+P)*(Y+P); R:=(P-ARCTAN(P+Y))/PP;
       FI:=P-(1+PP)*R*(1+R/(P+Y))
   'END' FI;

   'REAL' 'PROCEDURE' R;
   'BEGIN' BESS PQA01(A,X,PA,QA,PA1,QA1);
       CHI:=X-PI*(A/2+0.25);
       SI :=SIN(CHI); CO:=COS(CHI);
       R:= 'IF' D=1 'THEN' (PA*CO-QA*SI)/(PA1*SI+QA1*CO) 'ELSE'
           'IF' D=2 'THEN' (PA*SI+QA*CO)/(QA1*SI-PA1*CO) 'ELSE'
           'IF' D=3 'THEN' A/X-(PA1*SI+QA1*CO)/(PA*CO-QA*SI) 'ELSE'
                           A/X-(QA1*SI-PA1*CO)/(PA*SI+QA*CO)
   'END' R;
   PI:=4*ARCTAN(1); AA:=A*A; MU:=4*AA; MU2:=MU*MU;
   MU3:=MU*MU2; MU4:=MU2*MU2;
   'IF' D<3 'THEN'
   'BEGIN' P:=7*MU-31; P0:=MU-1;
       P1:=4*(253*MU2-3722*MU+17869)/15/P*P0;
       Q1:=8*( 83*MU2- 982*MU+ 3779)/ 5/P
   'END' 'ELSE'
   'BEGIN' P:=7*MU2+82*MU-9; P0:=MU+3;
       P1:=(4048*MU4+131264*MU3-221984*MU2-417600*MU+1012176)/60/P;
       Q1:=1.6*(83*MU3+2075*MU2-3039*MU+3537)/P
   'END';
   T:='IF' D=1'OR'D=4 'THEN' 0.25 'ELSE' 0.75; TT:=4*T;
   'IF' D<3 'THEN'
   'BEGIN' PP1:= 5/48; QQ1:= -5/36  'END' 'ELSE'
   'BEGIN' PP1:=-7/48; QQ1:= 35/288 'END';
   Y:= 3*PI/8; BB:= 'IF' A>=3 'THEN' A **(-2/3) 'ELSE' 0.0 ;
   'FOR' S:=1 'STEP' 1 'UNTIL' N 'DO'
   'BEGIN' 'IF' A=0'AND'S=1'AND'D=3 'THEN'
       'BEGIN' X:=0; J:=0 'END' 'ELSE'
       'BEGIN' 'IF' S >= 3*A -8  'THEN'
           'BEGIN' B:=(S+A/2-T)*PI; C:=1/B/B/64;
               X:=B-1/B/8*(P0-P1*C)/(1-Q1*C)
           'END' 'ELSE'
           'BEGIN' 'IF' S=1 'THEN'
               'BEGIN' X:= 'IF' D=1 'THEN' -2.33811 'ELSE'
                           'IF' D=2 'THEN' -1.17371 'ELSE'
                           'IF' D=3 'THEN' -1.01879 'ELSE' -2.29444
               'END' 'ELSE'
               'BEGIN' X:= Y*(4*S-TT); V:= 1/X/X;
                   X:= -X**(2/3)*(1+V*(PP1+QQ1*V))
               'END';
               U:=X*BB; V:=FI(2/3*(-U)**1.5);
               W:=1/COS(V); XX:=1-W*W; C:=SQRT(U/XX);
               X:=W*(A+C/A/U*
               ('IF' D<3 'THEN' -5/48/U-C*(-5/24/XX+1/8)
                         'ELSE'  7/48/U+C*(-7/24/XX+3/8)))
           'END';  J:=0;
           L1: XX:=X*X; X4:=XX*XX; A2:=AA-XX; RO:=R; J:=J+1;
               'IF' D<3 'THEN'
               'BEGIN' U:=RO; P:=(1-4*A2)/6/X/(2*A+1);
                   Q:=(2*(XX-MU)-1-6*A)/3/X/(2*A+1)
               'END' 'ELSE'
               'BEGIN' U:=-XX*RO/A2; V:=2*X*A2/(AA+XX)/3;
                   W:=A2*A2*A2;
                   Q:=V*(1+( MU2+32*MU*XX+48*X4)/32/W);
                   P:=V*(1+(-MU2+40*MU*XX+48*X4)/64/W)
               'END';
           W:=U*(1+P*RO)/(1+Q*RO); X:=X+W;
           'IF' ABS(W/X)>@-13 'AND'J<5 'THEN' 'GOTO' L1
       'END'; Z[S]:=X
   'END'
'END' BESS ZEROS;

        'EOP'
