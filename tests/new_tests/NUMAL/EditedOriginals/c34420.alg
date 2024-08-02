'CODE' 34420;
      'PROCEDURE' DECSYMTRI(DIAG, CO, N, AUX); 'VALUE' N; 'INTEGER' N;
      'ARRAY' DIAG, CO, AUX;
      'BEGIN'  'INTEGER' I, N1;
         'REAL' D, R, S, U, TOL, NORM, NORMR;
         TOL:= AUX[2]; D:= DIAG[1]; R:= CO[1];
         NORM:= NORMR:= ABS(D) + ABS(R);
         'IF' ABS(D) <= NORMR * TOL 'THEN'
         'BEGIN' AUX[3]:= 0; AUX[5]:= D; 'GOTO' EXIT 'END';
         U:= CO[1]:= R / D; N1:= N - 1;
         'FOR' I:= 2 'STEP' 1 'UNTIL' N1 'DO'
         'BEGIN' S:= R; R:= CO[I]; D:= DIAG[I];
            NORMR:= ABS(S) + ABS(D) + ABS(R);
            D:= DIAG[I]:= D - U * S;
            'IF' ABS(D) <= NORMR * TOL 'THEN'
            'BEGIN' AUX[3]:= I - 1; AUX[5]:= D; 'GOTO' EXIT 'END';
            U:= CO[I]:= R / D; 'IF' NORMR > NORM 'THEN' NORM:= NORMR
         'END';
         D:= DIAG[N]; NORMR:= ABS(D) + ABS(R);
         D:= DIAG[N]:= D - U * R;
         'IF' ABS(D) <= NORMR * TOL 'THEN'
         'BEGIN' AUX[3]:= N1; AUX[5]:= D; 'GOTO' EXIT 'END';
         'IF' NORMR > NORM 'THEN' NORM:= NORMR;
         AUX[3]:= N; AUX[5]:= NORM;
      EXIT:
      'END' DECSYMTRI;
        'EOP'
