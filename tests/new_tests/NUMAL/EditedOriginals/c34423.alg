'CODE' 34423;
  'PROCEDURE' DECTRI(SUB, DIAG, SUPER, N, AUX);
  'VALUE' N; 'INTEGER' N; 'ARRAY' SUB, DIAG, SUPER, AUX;
  'BEGIN' 'INTEGER' I, N1;
     'REAL' D, R, S, U, NORM, NORM1, TOL;
     TOL:= AUX[2]; D:= DIAG[1]; R:= SUPER[1];
     NORM:= NORM1:= ABS(D) + ABS(R);
     'IF' ABS(D) <= NORM1 * TOL 'THEN'
     'BEGIN' AUX[3]:= 0; AUX[5]:= D; 'GOTO' EXIT 'END';
     U:= SUPER[1]:= R / D; S:= SUB[1]; N1:= N - 1;
     'FOR' I:= 2 'STEP' 1 'UNTIL' N1 'DO'
     'BEGIN' D:= DIAG[I]; R:= SUPER[I];
        NORM1:= ABS(S) + ABS(D) + ABS(R);
        D:= DIAG[I]:= D - U * S;
        'IF' ABS(D) <= NORM1 * TOL 'THEN'
        'BEGIN' AUX[3]:= I - 1; AUX[5]:= D; 'GOTO' EXIT 'END';
        U:= SUPER[I]:= R / D; S:= SUB[I];
        'IF' NORM1 > NORM 'THEN' NORM:= NORM1
     'END';
     D:= DIAG[N]; NORM1:= ABS(D) + ABS(S);
     D:= DIAG[N]:= D - U * S;
     'IF' ABS(D) <= NORM1 * TOL 'THEN'
     'BEGIN' AUX[3]:= N1; AUX[5]:= D; 'GOTO' EXIT 'END';
     'IF' NORM1 > NORM 'THEN' NORM:= NORM1;
     AUX[3]:= N; AUX[5]:= NORM;
 EXIT:
 'END' DECTRI

        ;'EOP'
