'CODE' 31051;
'PROCEDURE' POLCHS(N,A);
'VALUE' N; 'INTEGER' N; 'ARRAY' A;
'IF' N>1 'THEN'
'BEGIN'
   'COMMENT'  SCALING;
   'INTEGER' K,L,TWOPOW;
   TWOPOW:=2;
   'FOR' K:=1 'STEP' 1 'UNTIL' N-2 'DO'
   'BEGIN'
      A[K]:=A[K]/TWOPOW; TWOPOW:=TWOPOW*2;
   'END';
   A[N-1]:=2*A[N-1]/TWOPOW;
   A[N]:=A[N]/TWOPOW;
   A[N-2]:=A[N-2]+A[N];
   'COMMENT' N<=2 READY;
   'FOR' K:=N-2 'STEP' -1 'UNTIL' 1 'DO'
   'BEGIN'
      A[K-1]:=A[K-1]+A[K+1]; A[K]:=A[K]*2 + A[K+2];
      'FOR' L:=K+1 'STEP' 1 'UNTIL' N-2 'DO'
      A[L]:=A[L]+A[L+2];
   'END';
'END' POLCHS;
        'EOP'
