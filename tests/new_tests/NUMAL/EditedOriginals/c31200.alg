'CODE' 31200;
'PROCEDURE' LNG INT ADD(U,V,SUM); 'INTEGER''ARRAY' U,V,SUM;
'BEGIN''INTEGER' LU,LV,DIFF,CARRY,I,T,MAX;
   LU:=U[0]; LV:=V[0];
   'IF' LU >= LV 'THEN'
   'BEGIN' MAX:=LU; DIFF:=LU - LV + 1; CARRY:=0;
      'FOR' I:=LU 'STEP' -1 'UNTIL' DIFF 'DO'
      'BEGIN' T:=U[I] + V[I-DIFF+1] + CARRY;
         CARRY:='IF' T<10 000 000 'THEN' 0 'ELSE' 1;
         SUM[I]:=T - CARRY * 10 000 000
      'END';
      'FOR' I:=DIFF - 1 'STEP' -1 'UNTIL' 1 'DO'
      'BEGIN' T:=U[I] + CARRY;
         CARRY:='IF' T<10 000 000 'THEN' 0 'ELSE' 1;
         SUM[I]:=T - CARRY * 10 000 000
      'END'
   'END' 'ELSE'
   'BEGIN' MAX:=LV; DIFF:=LV - LU + 1; CARRY:=0;
      'FOR' I:=LV 'STEP' -1 'UNTIL' DIFF 'DO'
      'BEGIN' T:=V[I] + U[I-DIFF+1] + CARRY;
         CARRY:='IF' T<10 000 000 'THEN' 0 'ELSE' 1;
         SUM[I]:=T - CARRY * 10 000 000
      'END';
      'FOR' I:=DIFF - 1 'STEP' -1 'UNTIL' 1 'DO'
      'BEGIN' T:=V[I] + CARRY;
         CARRY:='IF' T<10 000 000 'THEN' 0 'ELSE' 1;
         SUM[I]:=T - CARRY * 10 000 000
      'END'
   'END';
   'IF' CARRY=1 'THEN'
   'BEGIN' 'FOR' I:=MAX 'STEP' -1 'UNTIL' 1 'DO'
      SUM[I+1]:=SUM[I]; SUM[1]:=1; MAX:=MAX + 1
   'END';
   SUM[0]:=MAX
'END' LNG INT ADD

        ;'EOP'
