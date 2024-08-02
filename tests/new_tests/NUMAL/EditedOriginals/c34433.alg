'CODE' 34433;
   'REAL' 'PROCEDURE' MININ(X, A, B, FX, TOLX);
   'REAL' X, A, B, FX, TOLX;
   'BEGIN' 'COMMENT' SEE BRENT, 1973, P79;
       'REAL' Z, C, D, E, M, P, Q, R, TOL, T, U, V, W, FU, FV, FW, FZ;
       C:= (3 - SQRT(5)) / 2; 'IF' A > B 'THEN'
       'BEGIN' Z:= A; A:= B; B:= Z 'END';
       W:= X:= A; FW:= FX; Z:= X:= B; FZ:= FX; 'IF' FZ > FW 'THEN'
       'BEGIN' Z:= W; W:= X; V:= FZ; FZ:= FW; FW:= V 'END';
       V:= W; FV:= FW; E:= 0;
   LOOP: M:= (A + B) * 0.5; TOL:= TOLX; T:= TOL * 2;
       'IF' ABS(Z - M) > T - (B - A) * 0.5 'THEN'
       'BEGIN' P:= Q:= R:= 0; 'IF' ABS(E) > TOL 'THEN'
           'BEGIN' R:= (Z - W) * (FZ - FV);
               Q:= (Z - V) * (FZ - FW); P:= (Z - V) * Q - (Z - W) * R;
               Q:= (Q - R) * 2; 'IF' Q>0 'THEN' P:= -P 'ELSE' Q:= -Q;
               R:= E; E:= D
           'END';
           'IF' ABS(P) < ABS(Q * R * 0.5) 'AND' P > (A - Z) * Q
           'AND' P < (B - Z) * Q 'THEN'
           'BEGIN' D:= P / Q; U:= Z + D;
               'IF' U - A < T 'OR' B - U < T 'THEN'
               D:= 'IF' Z < M 'THEN' TOL 'ELSE' -TOL
           'END' 'ELSE'
           'BEGIN' E:= ('IF' Z < M 'THEN' B 'ELSE' A) - Z; D:= C * E
           'END';
           U:= X:= Z + ('IF' ABS(D) >= TOL 'THEN' D 'ELSE' 'IF' D > 0
           'THEN' TOL 'ELSE' -TOL); FU:= FX;
           'IF' FU <= FZ 'THEN'
           'BEGIN' 'IF' U < Z 'THEN' B:= Z 'ELSE' A:= Z;
               V:= W; FV:= FW; W:= Z; FW:= FZ; Z:= U; FZ:= FU
           'END' 'ELSE'
           'BEGIN' 'IF' U < Z 'THEN' A:= U 'ELSE' B:= U;
               'IF' FU <= FW 'THEN'
               'BEGIN' V:= W; FV:= FW; W:= U; FW:= FU 'END' 'ELSE'
               'IF' FU <= FV 'OR' V = W 'THEN'
               'BEGIN' V:= U; FV:= FU 'END'
           'END'; 'GOTO' LOOP
       'END'; X:= Z; MININ:= FZ
   'END' MININ;
        'EOP'
