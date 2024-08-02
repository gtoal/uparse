'CODE' 34428;
  'PROCEDURE' DECSOLTRIPIV(SUB, DIAG, SUPER, N, AUX, B);
  'VALUE' N; 'INTEGER' N; 'ARRAY' SUB, DIAG, SUPER, AUX, B;
  'BEGIN' 'INTEGER' I, I1, N1, N2;
     'REAL' D, R, S, U, T, Q, V, W, NORM, NORM1, NORM2, TOL,
     BI, BI1, BI2;
     'BOOLEAN' 'ARRAY' PIV[1:N];
     TOL:= AUX[2]; D:= DIAG[1]; R:= SUPER[1]; BI:= B[1];
     NORM:= NORM2:= ABS(D) + ABS(R); N2:= N - 2;
     'FOR' I:= 1 'STEP' 1 'UNTIL' N2 'DO'
     'BEGIN' I1:= I + 1; S:= SUB[I]; T:= DIAG[I1]; Q:= SUPER[I1];
        BI1:= B[I1];
        NORM1:= NORM2; NORM2:= ABS(S) + ABS(T) + ABS(Q);
        'IF' NORM2 > NORM 'THEN' NORM:= NORM2;
        'IF' ABS(D) * NORM2 < ABS(S) * NORM1 'THEN'
        'BEGIN' 'IF' ABS(S) <= TOL * NORM2 'THEN'
           'BEGIN' AUX[3]:= I - 1; AUX[5]:= S; 'GOTO' EXIT 'END';
           U:= SUPER[I]:= T / S; BI1:= B[I]:= BI1 / S;
           BI:= BI - BI1 * D; V:= SUB[I]:= Q / S;
           W:= SUPER[I1]:= -V * D; D:= DIAG[I1]:= R - U * D;
           R:= W; NORM2:= NORM1; PIV[I]:= 'TRUE'
        'END' 'ELSE'
        'BEGIN' 'IF' ABS(D) <= TOL * NORM1 'THEN'
           'BEGIN' AUX[3]:= I - 1; AUX[5]:= D; 'GOTO' EXIT 'END';
           U:= SUPER[I]:= R / D; BI:= B[I]:= BI / D;
           BI:= BI1 - BI * S; D:= DIAG[I1]:= T - U * S;
           PIV[I]:= 'FALSE'; R:= Q
        'END'
     'END';
     N1:= N - 1; S:= SUB[N1]; T:= DIAG[N]; NORM1:= NORM2; BI1:= B[N];
     NORM2:= ABS(S) + ABS(T); 'IF' NORM2 > NORM 'THEN' NORM:= NORM2;
     'IF' ABS(D) * NORM2 < ABS(S) * NORM1 'THEN'
     'BEGIN' 'IF' ABS(S) <= TOL * NORM2 'THEN'
        'BEGIN' AUX[3]:= N2; AUX[5]:= S; 'GOTO' EXIT 'END';
        U:= SUPER[N1]:= T / S; BI1:= B[N1]:= BI1 / S;
        BI:= BI - BI1 * D; D:= R - U * D; NORM2:= NORM1
     'END' 'ELSE'
     'BEGIN' 'IF' ABS(D) <= TOL * NORM1 'THEN'
        'BEGIN' AUX[3]:= N2; AUX[5]:= D; 'GOTO' EXIT 'END';
        U:= SUPER[N1]:= R / D; BI:= B[N1]:= BI / D;
        BI:= BI1 - BI * S; D:= T - U * S
     'END';
     'IF' ABS(D) <= TOL * NORM2 'THEN'
     'BEGIN' AUX[3]:= N1; AUX[5]:= D; 'GOTO' EXIT 'END';
     AUX[3]:= N; AUX[5]:= NORM;
     BI1:= B[N]:= BI / D; BI:= B[N1]:= B[N1] - SUPER[N1] * BI1;
     'FOR' I:= N - 2 'STEP' -1 'UNTIL' 1 'DO'
     'BEGIN' BI2:= BI1; BI1:= BI;
         BI:= B[I]:= B[I] - SUPER[I] * BI1 -
         ('IF' PIV[I] 'THEN' SUB[I] * BI2 'ELSE' 0)
     'END';
 EXIT:
 'END' DECSOLTRIPIV;
        'EOP'
