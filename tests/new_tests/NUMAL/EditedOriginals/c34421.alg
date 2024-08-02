'CODE' 34421;
      'PROCEDURE' SOLSYMTRI(DIAG, CO, N, B); 'VALUE' N; 'INTEGER' N;
      'ARRAY' DIAG, CO, B;
      'BEGIN' 'INTEGER' I;
         'REAL' R, S;
         R:= B[1]; B[1]:= R / DIAG[1];
         'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
         'BEGIN' R:= B[I] - CO[I-1] * R; B[I]:= R / DIAG[I] 'END';
         S:= B[N];
         'FOR' I:= N - 1 'STEP' -1 'UNTIL' 1 'DO'
         S:= B[I]:= B[I] - CO[I] * S
      'END' SOLSYMTRI;
        'EOP'
