'CODE' 34017;
   'REAL' 'PROCEDURE' SCAPRD1(LA, SA, LB, SB, N, A, B);
   'VALUE' LA,SA,LB,SB,N; 'INTEGER' LA,SA,LB,SB,N; 'ARRAY' A,B;
   'BEGIN' 'REAL' S;'INTEGER' K;
       S:= 0;
       'FOR' K:= 1 'STEP' 1 'UNTIL' N 'DO'
       'BEGIN' S:=A[LA] * B[LB] + S; LA:= LA + SA; LB:= LB + SB 'END';
       SCAPRD1:= S
   'END' SCAPRD1;
       'EOP'
