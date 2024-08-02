'CODE' 34427;
  'PROCEDURE' SOLTRIPIV(SUB, DIAG, SUPER, N, AID, PIV, B);
  'VALUE' N; 'INTEGER' N; 'ARRAY' SUB, DIAG, SUPER, AID, B;
  'BOOLEAN' 'ARRAY' PIV;
  'BEGIN' 'INTEGER' I, N1;
     'REAL' BI, BI1, R, S, T;
     N1:= N - 1;
     'FOR' I:= 1 'STEP' 1 'UNTIL' N1 'DO'
     'BEGIN' 'IF' PIV[I] 'THEN'
        'BEGIN' BI:= B[I+1]; BI1:= B[I] 'END'
        'ELSE'
        'BEGIN' BI:= B[I]; BI1:= B[I+1] 'END';
        R:= B[I]:= BI / DIAG[I];
        B[I+1]:= BI1 - SUB[I] * R
     'END';
     R:= B[N]:= B[N] / DIAG[N];
     T:= B[N1]:= B[N1] - SUPER[N1] * R;
     'FOR' I:= N - 2 'STEP' -1 'UNTIL' 1 'DO'
     'BEGIN' S:= R; R:= T; T:= B[I]:= B[I] - SUPER[I] * R -
        ('IF' PIV[I] 'THEN' AID[I] * S 'ELSE' 0)
     'END'
 'END' SOLTRIPIV

        ;'EOP'
