'CODE' 31254;
'PROCEDURE' RECCOF(N,M,X,WX,B,C,L,SYM);
'VALUE' N,M,SYM;'INTEGER' N,M; 'BOOLEAN' SYM;
'REAL' X,WX;'ARRAY' B,C,L;
'BEGIN' 'INTEGER' I,J,UP;'REAL' R,S,PIM,H,HH,ARG,SA;
PIM:=4*ARCTAN(1)/M;
'IF' SYM 'THEN' 'BEGIN'
'FOR' J:=0 'STEP' 1 'UNTIL' N'DO'
'BEGIN' R:=B[J]:=0;UP:=M 'DIV' 2;
   'FOR' I:=1 'STEP' 1 'UNTIL' UP'DO'
   'BEGIN' ARG:=(I-.5)*PIM;X:=COS(ARG);
      R:=R+SIN(ARG)*WX*ORTPOL(J,X,B,C)**2;
   'END';'IF' UP*2=M 'THEN' L[J]:=2*R*PIM 'ELSE'
   'BEGIN' X:=0;L[J]:=(2*R+WX*ORTPOL(J,0,B,C)**2)*PIM 'END';
   C[J]:='IF' J=0 'THEN' 0 'ELSE' L[J]/L[J-1];
'END' 'END' 'ELSE'
'FOR' J:=0 'STEP' 1 'UNTIL' N 'DO'
'BEGIN' R:=S:=0;UP:=M'DIV' 2;
   'FOR' I:=1 'STEP' 1 'UNTIL' UP 'DO'
   'BEGIN' ARG:=(I-.5)*PIM;SA:=SIN(ARG);X:=COS(ARG);
      H:=WX*ORTPOL(J,X,B,C)**2;X:=-X;HH:=WX*ORTPOL(J,X,B,C)**2;
      R:=R+(H+HH)*SA;S:=S+(HH-H)*X*SA;
   'END';B[J]:=S*PIM;
   'IF' UP*2=M 'THEN' L[J]:=R*PIM'ELSE'
   'BEGIN' X:=0;L[J]:=(R+WX*ORTPOL(J,0,B,C)**2)*PIM 'END';
   C[J]:='IF' J=0 'THEN' 0 'ELSE' L[J]/L[J-1];
'END';
'END' RECCOF

        ;'EOP'
