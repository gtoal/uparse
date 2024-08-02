'CODE' 34422;
      'PROCEDURE' DECSOLSYMTRI(DIAG, CO, N, AUX, B); 'VALUE' N;
      'INTEGER' N; 'ARRAY' DIAG, CO, AUX, B;
      'BEGIN'
              DECSYMTRI(DIAG, CO, N, AUX); 'IF' AUX[3] = N 'THEN'
              SOLSYMTRI(DIAG, CO, N, B)
      'END' DECSOLSYMTRI;
        'EOP'
