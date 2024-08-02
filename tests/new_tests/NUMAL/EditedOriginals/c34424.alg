'CODE' 34424;
  'PROCEDURE' SOLTRI(SUB, DIAG, SUPER, N, B);
  'VALUE' N; 'INTEGER' N; 'ARRAY' SUB, DIAG, SUPER, B;
  'BEGIN' 'INTEGER' I;
     'REAL' R;
     R:= B[1]:= B[1] / DIAG[1];
     'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
     R:= B[I]:= (B[I] - SUB[I - 1] * R) / DIAG[I];
     'FOR' I:= N - 1 'STEP' -1 'UNTIL' 1 'DO'
     R:= B[I] := B[I] - SUPER[I] * R
  'END' SOLTRI;
        'EOP'
