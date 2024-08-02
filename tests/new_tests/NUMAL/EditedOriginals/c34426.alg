'CODE' 34426;
  'PROCEDURE' DECTRIPIV(SUB, DIAG, SUPER, N, AID, AUX, PIV);
  'VALUE' N; 'INTEGER' N; 'ARRAY' SUB, DIAG, SUPER, AID, AUX;
  'BOOLEAN' 'ARRAY' PIV;
  'BEGIN' 'INTEGER' I, I1, N1, N2;
     'REAL' D, R, S, U, T, Q, V, W, NORM, NORM1, NORM2, TOL;
     TOL:= AUX[2]; D:= DIAG[1]; R:= SUPER[1];
     NORM:= NORM2:= ABS(D) + ABS(R); N2:= N - 2;
     'FOR' I:= 1 'STEP' 1 'UNTIL' N2 'DO'
     'BEGIN' I1:= I + 1; S:= SUB[I]; T:= DIAG[I1]; Q:= SUPER[I1];
        NORM1:= NORM2; NORM2:= ABS(S) + ABS(T) + ABS(Q);
        'IF' NORM2 > NORM 'THEN' NORM:= NORM2;
        'IF' ABS(D) * NORM2 < ABS(S) * NORM1 'THEN'
        'BEGIN' 'IF' ABS(S) <= TOL * NORM2 'THEN'
           'BEGIN' AUX[3]:= I - 1; AUX[5]:= S; 'GOTO' EXIT 'END';
           DIAG[I]:= S; U:= SUPER[I]:= T / S;
           V:= AID[I]:= Q / S; SUB[I]:= D;
           W:= SUPER[I1]:= -V * D; D:= DIAG[I1]:= R - U * D;
           R:= W; NORM2:= NORM1; PIV[I]:= 'TRUE'
        'END' 'ELSE'
        'BEGIN' 'IF' ABS(D) <= TOL * NORM1 'THEN'
           'BEGIN' AUX[3]:= I - 1; AUX[5]:= D; 'GOTO' EXIT 'END';
           U:= SUPER[I]:= R / D; D:= DIAG[I1]:= T - U * S;
           AID[I]:= 0; PIV[I]:= 'FALSE'; R:= Q
        'END'
     'END';
     N1:= N - 1; S:= SUB[N1]; T:= DIAG[N]; NORM1:= NORM2;
     NORM2:= ABS(S) + ABS(T); 'IF' NORM2 > NORM 'THEN' NORM:= NORM2;
     'IF' ABS(D) * NORM2 < ABS(S) * NORM1 'THEN'
     'BEGIN' 'IF' ABS(S) <= TOL * NORM2 'THEN'
        'BEGIN' AUX[3]:= N2; AUX[5]:= S; 'GOTO' EXIT 'END';
        DIAG[N1]:= S; U:= SUPER[N1]:= T / S; SUB[N1]:= D;
        D:= DIAG[N]:= R - U * D; NORM2:= NORM1; PIV[N1]:= 'TRUE'
     'END' 'ELSE'
     'BEGIN' 'IF' ABS(D) <= TOL * NORM1 'THEN'
        'BEGIN' AUX[3]:= N2; AUX[5]:= D; 'GOTO' EXIT 'END';
        U:= SUPER[N1]:= R / D; D:= DIAG[N]:= T - U * S;
        PIV[N1]:= 'FALSE'
     'END';
     'IF' ABS(D) <= TOL * NORM2 'THEN'
     'BEGIN' AUX[3]:= N1; AUX[5]:= D; 'GOTO' EXIT 'END';
     AUX[3]:= N; AUX[5]:= NORM;
 EXIT:
 'END' DECTRIPIV;
        'EOP'
