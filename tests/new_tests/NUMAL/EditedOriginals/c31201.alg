'CODE' 31201;
'PROCEDURE' LNG INT SUBTRACT(U,V,DIFFERENCE);
'INTEGER''ARRAY' U,V,DIFFERENCE;
'BEGIN''INTEGER' LU,LV,DIFF,I,T,J,CARRY;
   LU:=U[0]; LV:=V[0];
   'IF' LU<LV 'OR' LU=LV 'AND' U[1]<V[1] 'THEN' DIFFERENCE[0]:=0 'ELSE'
   'BEGIN' DIFF:=LU - LV + 1; CARRY:=0;
      'FOR' I:=LU 'STEP' -1 'UNTIL' DIFF 'DO'
      'BEGIN' T:=U[I] - V[I-DIFF+1] + CARRY;
         CARRY:='IF' T<0 'THEN' -1 'ELSE' 0;
         DIFFERENCE[I]:=T - CARRY * 10 000 000
      'END';
      'FOR' I:=DIFF - 1 'STEP' -1 'UNTIL' 1 'DO'
      'BEGIN' T:=U[I] + CARRY; CARRY:='IF' T<0 'THEN' -1 'ELSE' 0;
         DIFFERENCE[I]:=T - CARRY * 10 000 000
      'END';
      'IF' CARRY=-1 'THEN'
      'BEGIN' DIFFERENCE[0]:=0; 'GOTO' READY 'END';
      I:=0; J:=LU;
      'FOR' I:=I+1 'WHILE' DIFFERENCE[I]=0 'AND' J>1 'DO' J:=J-1;
      DIFFERENCE[0]:=J;
      'IF' J<LU 'THEN'
      'FOR' I:=1 'STEP' 1 'UNTIL' J 'DO'
      DIFFERENCE[I]:=DIFFERENCE[LU+I-J]
   'END';
   READY:
'END' LNG INT SUBTRACT;
        'EOP'
