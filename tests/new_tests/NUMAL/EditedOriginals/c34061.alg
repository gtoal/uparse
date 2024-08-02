'CODE' 34061;
    'PROCEDURE' SOLELM(A, N, RI, CI, B); 'VALUE' N; 'INTEGER' N;
    'ARRAY' A, B;
    'INTEGER' 'ARRAY' RI, CI;
    'BEGIN' 'INTEGER' R, CIR;
        'REAL' W;
        SOL(A, N, RI, B);
        'FOR' R:= N 'STEP' - 1 'UNTIL' 1 'DO'
        'BEGIN' CIR:= CI[R]; 'IF' CIR ^= R 'THEN'
            'BEGIN' W:= B[R]; B[R]:= B[CIR]; B[CIR]:= W 'END'
        'END'
    'END' SOLELM;
        'EOP'
