'CODE' 31203;
'PROCEDURE' LNG INT DIVIDE(U,V,QUOTIENT,REMAINDER); 'VALUE' U;
'INTEGER''ARRAY' U,V,QUOTIENT,REMAINDER;
'BEGIN''INTEGER' LU,LV,V1,DIFF,I,T,SCALE,D,Q1,J,CARRY;
   LU:=U[0]; LV:=V[0]; V1:=V[1]; DIFF:=LU - LV;

   'IF' LV=1 'THEN'
   'BEGIN' CARRY:=0;
      'FOR' I:=1 'STEP' 1 'UNTIL' LU 'DO'
      'BEGIN' T:=CARRY * 10 000 000 + U[I]; QUOTIENT[I]:=T//V1;
         CARRY:=T - QUOTIENT[I] * V1
      'END'; REMAINDER[0]:=1; REMAINDER[1]:=CARRY;
      'IF' QUOTIENT[1]=0 'THEN'
      'BEGIN' 'FOR' I:=2 'STEP' 1 'UNTIL' LU 'DO'
         QUOTIENT[I-1]:=QUOTIENT[I];
         QUOTIENT[0]:=LU - ('IF' LU=1 'THEN' 0 'ELSE' 1)
      'END' 'ELSE' QUOTIENT[0]:=LU
   'END' LV=1
   'ELSE'

   'IF' LU<LV 'THEN'
   'BEGIN' QUOTIENT[0]:=1; QUOTIENT[1]:=0;
      'FOR' I:=0 'STEP' 1 'UNTIL' LU 'DO' REMAINDER[I]:=U[I]
   'END' LU<LV
   'ELSE'

   'BEGIN''INTEGER''ARRAY' A[0:LV];
      SCALE:=10 000 000//(V1+1);
      'IF' SCALE>1 'THEN'
      'BEGIN''COMMENT' NORMALIZE U; CARRY:=0;
         'FOR' I:=LU 'STEP' -1 'UNTIL' 1 'DO'
         'BEGIN' T:=SCALE * U[I] + CARRY; CARRY:=T//10 000 000;
            U[I]:=T - CARRY * 10 000 000
         'END'; U[0]:=CARRY;
         'COMMENT' NORMALIZE V; CARRY:=0;
         'FOR' I:=LV 'STEP' -1 'UNTIL' 1 'DO'
         'BEGIN' T:=SCALE * V[I] + CARRY; CARRY:=T//10 000 000;
            V[I]:=T - CARRY * 10 000 000
         'END'; V1:=V[1]
      'END' NORMALIZATION
      'COMMENT' COMPUTE QUOTIENT AND REMAINDER;
      'FOR' I:=0 'STEP' 1 'UNTIL' DIFF 'DO'
      'BEGIN' D:=U[I] * 10 000 000 + U[I+1];
         Q1:='IF' U[I]=V1 'THEN' 9 999 999 'ELSE' D//V1;
         'IF' V[2] * Q1 > (D-Q1*V1) * 10 000 000 + U[I+2] 'THEN'
         'BEGIN' Q1:=Q1 - 1;
            'IF' V[2]*Q1>(D-Q1*V1)*10 000 000+U[I+2] 'THEN' Q1:=Q1-1
         'END';

         'COMMENT' U[I:I+LV]:=U[I:I+LV] - Q1 * V[1:LV];
         CARRY:=0;
         'FOR' J:=LV 'STEP' -1 'UNTIL' 1 'DO'
         'BEGIN' T:=Q1 * V[J] + CARRY; CARRY:=T//10 000 000;
            A[J]:=T - CARRY * 10 000 000
         'END'; A[0]:=CARRY;
         CARRY:=0;
         'FOR' J:=LV 'STEP' -1 'UNTIL' 0 'DO'
         'BEGIN' T:=U[I+J] - A[J] + CARRY; CARRY:='IF' T<0 'THEN' -1
            'ELSE' 0; U[I+J]:=T - CARRY * 10 000 000
         'END';

         'COMMENT' IF CARRY=-1 THEN Q1 IS ONE TOO LARGE,
         AND V MUST BE ADDED BACK TO U[I:I+LV];
         'IF' CARRY=-1 'THEN'
         'BEGIN' Q1:=Q1 - 1; CARRY:=0;
            'FOR' J:=LV 'STEP' -1 'UNTIL' 1 'DO'
            'BEGIN' T:=U[I+J] + V[J] + CARRY; CARRY:='IF' T<10 000 000
               'THEN' 0 'ELSE' 1; U[I+J]:=T - CARRY * 10 000 000
            'END'
         'END'; QUOTIENT[I]:=Q1
      'END' I;

      'COMMENT' CORRECT STORAGE OF QUOTIENT;
      'IF' QUOTIENT[0] ^= 0 'THEN'
      'BEGIN' 'FOR' I:=DIFF 'STEP' -1 'UNTIL' 0 'DO'
         QUOTIENT[I+1]:=QUOTIENT[I]; QUOTIENT[0]:=DIFF + 1
      'END' 'ELSE'
      'IF' DIFF < 2 'THEN'
      'BEGIN' QUOTIENT[0]:= 1; 'IF' DIFF = 0 'THEN' QUOTIENT[1]:= 0
      'END' 'ELSE'
      'IF' QUOTIENT[1] ^= 0 'THEN' QUOTIENT[0]:=DIFF 'ELSE'
      'BEGIN' 'FOR' I:=1 'STEP' 1 'UNTIL' DIFF - 1 'DO'
         QUOTIENT[I]:=QUOTIENT[I+1]; QUOTIENT[0]:=DIFF - 1
      'END';
      'COMMENT' REMAINDER := U[DIFF+1:LU]//SCALE;
      'IF' SCALE>1 'THEN'
      'BEGIN' CARRY:=0;
         'FOR' I:=1 'STEP' 1 'UNTIL' LV 'DO'
         'BEGIN' T:=CARRY * 10 000 000 + U[DIFF+I];
            REMAINDER[I]:=T//SCALE; CARRY:=T - REMAINDER[I] * SCALE
         'END'
      'END' 'ELSE'
      'FOR' I:=1 'STEP' 1 'UNTIL' LV 'DO' REMAINDER[I]:=U[DIFF+I];

      'COMMENT' CORRECT STORAGE OF REMAINDER;
      I:=0; J:=LV;
      'FOR' I:=I+1 'WHILE' REMAINDER[I]=0 'AND' J>1 'DO' J:=J-1;
      REMAINDER[0]:=J;
      'IF' J<LV 'THEN'
      'FOR' I:=1 'STEP' 1 'UNTIL' J 'DO'
      REMAINDER[I]:=REMAINDER[LV + I - J];

      'COMMENT' UNNORMALIZE THE DIVISOR V;
      'IF' SCALE>1 'THEN'
      'BEGIN' CARRY:=0;
         'FOR' I:=1 'STEP' 1 'UNTIL' LV 'DO'
         'BEGIN' T:=CARRY * 10 000 000 + V[I];
            V[I]:=T//SCALE; CARRY:=T - V[I] * SCALE
         'END'
      'END'
   'END'
'END' LNG INT DIVIDE;
        'EOP'
