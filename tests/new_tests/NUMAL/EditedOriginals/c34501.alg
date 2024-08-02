'CODE' 34501;
'INTEGER''PROCEDURE' ZERPOL(N, A, EM, RE, IM, D);
  'VALUE' N; 'INTEGER' N; 'ARRAY' A, EM, RE, IM, D;
'BEGIN' 'INTEGER' I, TOTIT, IT, FAIL, START, UP, MAX, GIEX, ITMAX;
   'REAL' X, Y, NEWF, OLDF, MAXRAD, AE, TOL, H1, H2, LN2;
   'ARRAY' F[0 : 5], TRIES[1 : 10];

  'BOOLEAN''PROCEDURE' FUNCTION;
  'BEGIN' 'INTEGER' K, M1, M2;
    'REAL' P, Q, QSQRT, F01, F02, F03, F11, F12, F13,
           F21, F22, F23, STOP;
    IT:= IT + 1;
    P:= 2 * X; Q:= -(X * X + Y * Y); QSQRT:= SQRT(-Q);
    F01:= F11:= F21:= D[0]; F02:= F12:= F22:= 0;
    M1:= N - 4; M2:= N - 2;
    STOP:= ABS(F01) * 0.8;
    'FOR' K:= 1 'STEP' 1 'UNTIL' M1 'DO'
    'BEGIN' F03:= F02; F02:= F01; F01:= D[K] + P * F02 + Q * F03;
      F13:= F12; F12:= F11; F11:= F01 + P * F12 + Q * F13;
      F23:= F22; F22:= F21; F21:= F11 + P * F22 + Q * F23;
      STOP:= QSQRT * STOP + ABS(F01)
    'END';
    'IF' M1 < 0 'THEN' M1:= 0;
    'FOR' K:= M1 + 1 'STEP' 1 'UNTIL' M2 'DO'
    'BEGIN' F03:= F02; F02:= F01; F01:= D[K] + P * F02 + Q * F03;
      F13:= F12; F12:= F11; F11:= F01 + P * F12 + Q * F13;
      STOP:= QSQRT * STOP + ABS(F01)
    'END';
    'IF' N = 3 'THEN' F21:= 0;
    F03:= F02; F02:= F01; F01:= D[N - 1] + P * F02 + Q * F03;
    F[0]:= D[N] + X * F01 + Q * F02;
    F[1]:= Y * F01;
    F[2]:= F01 - 2 * F12 * Y * Y;
    F[3]:= 2 * Y * (- X * F12 + F11);
    F[4]:= 2 * (- X * F12 + F11) - 8 * Y * Y * (- X * F22 + F21);
    F[5]:= Y * (6 * F12 - 8 * Y * Y * F22);
    STOP:= QSQRT * (QSQRT * STOP + ABS(F01)) + ABS(F[0]);
    NEWF:= F02:= COMABS(F[0], F[1]);
    FUNCTION:= F02 < (2 * ABS(X * F01) - 8 * (ABS(F[0]) + ABS(F01)
       * QSQRT) + 10 * STOP) * TOL * (1 + TOL) ** (4 * N + 3)
  'END';
  'BOOLEAN''PROCEDURE' CONTROL;
  'IF' IT > ITMAX 'THEN'
  'BEGIN' TOTIT:= TOTIT + IT; FAIL:= 3; 'GOTO' EXIT 'END'
  'ELSE' 'IF' IT = 0 'THEN'
  'BEGIN' 'INTEGER' I, H; 'REAL' H1, SIDE;
    MAXRAD:= 0; MAX:= (GIEX - LN(ABS(D[0])) / LN2) / N;
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' H1:= 'IF' D[I] = 0 'THEN' 0
      'ELSE' EXP(LN(ABS(D[I] / D[0])) / I);
      'IF' H1 > MAXRAD 'THEN' MAXRAD:= H1
    'END';
    'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1 'DO'
    'IF' D[I] ^= 0 'THEN'
    'BEGIN' H:= (GIEX - LN(ABS(D[I])) / LN2) / (N - I);
      'IF' H < MAX 'THEN' MAX:= H
    'END';
    MAX:= MAX * LN2 / LN(N);
    SIDE:= - D[1] / D[0];
    SIDE:= 'IF' ABS(SIDE) < TOL 'THEN' 0 'ELSE' SIGN(SIDE);
    'IF' SIDE = 0 'THEN'
    'BEGIN' TRIES[7]:= TRIES[2]:= MAXRAD; TRIES[9]:= -MAXRAD;
      TRIES[6]:= TRIES[4]:= TRIES[3]:= MAXRAD / SQRT(2);
      TRIES[5]:= -TRIES[3]; TRIES[10]:= TRIES[8]:= TRIES[1]:= 0
    'END' 'ELSE'
    'BEGIN' TRIES[8]:= TRIES[4]:= MAXRAD/ SQRT(2);
       TRIES[1]:= SIDE * MAXRAD; TRIES[3]:= TRIES[4] * SIDE;
       TRIES[6]:= MAXRAD; TRIES[7]:= -TRIES[3];
       TRIES[9]:= -TRIES[1]; TRIES[2]:= TRIES[5]:= TRIES[10]:= 0
    'END';
    'IF' COMABS(X, Y) > 2 * MAXRAD 'THEN' X:= Y:= 0;
    CONTROL:= 'FALSE'
  'END' 'ELSE'
  'BEGIN' 'IF' IT > 1 & NEWF >= OLDF 'THEN'
    'BEGIN' UP:= UP+ 1;
      'IF' UP = 5 & START < 5 'THEN'
      'BEGIN' START:= START + 1; UP:= 0; X:= TRIES[2 * START - 1];
        Y:= TRIES[2 * START]; CONTROL:= 'FALSE'
      'END' 'ELSE' CONTROL:= 'TRUE'
    'END' 'ELSE' CONTROL:= 'TRUE'
  'END';
  'PROCEDURE' DEFLATION;
  'IF' X = 0 & Y = 0 'THEN' N:= N - 1 'ELSE'
  'BEGIN' 'INTEGER' I, SPLIT; 'REAL' H1, H2;
    'ARRAY' B[0 : N - 1];
    'IF' Y = 0 'THEN'
    'BEGIN' N:= N - 1; B[N]:= -D[N + 1] / X;
      'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
      B[N - I]:= (B[N - I + 1] - D[N - I + 1]) / X;
      'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
      D[I]:= D[I] + D[I - 1] * X
    'END' 'ELSE'
    'BEGIN' H1:= - 2 * X; H2:= X * X + Y * Y;
      N:= N - 2;
      B[N]:= D[N + 2] / H2; B[N - 1]:= (D[N + 1] - H1 * B[N]) / H2;
      'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
      B[N - I]:=  (D[N - I + 2] - H1 * B[N - I + 1] - B[N - I + 2])/H2;
      D[1]:= D[1] - H1 * D[0];
      'FOR' I:= 2 'STEP' 1 'UNTIL' N 'DO'
      D[I]:= D[I] - H1 * D[I-1] - H2 * D[I-2]
    'END';
    SPLIT:= N;
    H2:= ABS(D[N] - B[N]) / (ABS(D[N]) + ABS(B[N]));
    'FOR' I:= N - 1 'STEP' -1 'UNTIL' 0 'DO'
    'BEGIN' H1:= ABS(D[I]) + ABS(B[I]);
      'IF' H1 > TOL 'THEN'
      'BEGIN' H1:= ABS(D[I] - B[I]) / H1;
        'IF' H1 < H2 'THEN' 'BEGIN' H2:= H1; SPLIT:= I 'END'
      'END'
    'END';
    'FOR' I := SPLIT + 1 'STEP' 1 'UNTIL' N 'DO' D[I]:= B[I];
    D[SPLIT]:= (D[SPLIT] + B[SPLIT]) / 2
  'END' OF DEFLATION;

  'PROCEDURE' LAGUERRE;
  'BEGIN' 'INTEGER' M;
    'REAL' S1RE, S1IM, S2RE, S2IM, DX, DY, H1, H2, H3, H4, H5, H6;
    'IF' ABS(F[0]) > ABS(F[1]) 'THEN'
    'BEGIN' H1:= F[0]; H6:= F[1] / H1; H2:= F[2] + H6 * F[3];
      H3:= F[3] - H6 * F[2]; H4:= F[4] + H6 * F[5];
      H5:= F[5] - H6 * F[4]; H6:= H6 * F[1] + H1
    'END' 'ELSE'
    'BEGIN' H1:= F[1]; H6:= F[0] / H1; H2:= H6 * F[2] + F[3];
      H3:= H6 * F[3] - F[2]; H4:= H6 * F[4] + F[5];
      H5:= H6 * F[5] - F[4]; H6:= H6 * F[0] + F[1]
    'END';
    S1RE:= H2 / H6; S1IM:= H3 / H6;
    H2:= S1RE * S1RE - S1IM * S1IM; H3:= 2 * S1RE * S1IM;
    S2RE:= H2 - H4 / H6; S2IM:= H3 - H5 / H6;
    H1:= S2RE * S2RE + S2IM * S2IM;
    H1:= 'IF' H1 ^= 0 'THEN' (S2RE * H2 + S2IM * H3) / H1 'ELSE' 1;
    M:= 'IF' H1 >= N - 1 'THEN' ('IF' N > 1 'THEN' N - 1 'ELSE' 1)
        'ELSE' 'IF' H1 > 1 'THEN' H1 'ELSE' 1;
    H1:= (N - M) / M;
    COMSQRT(H1 * (N * S2RE - H2), H1 * (N * S2IM - H3), H2, H3);
    'IF' S1RE * H2 + S1IM * H3 < 0 'THEN'
    'BEGIN' H2:= - H2; H3:= - H3 'END';
    H2:= S1RE + H2; H3:= S1IM + H3;
    H1:= H2 * H2 + H3 * H3;
    'IF' H1 = 0 'THEN' 'BEGIN' DX:= -N; DY:= N 'END' 'ELSE'
    'BEGIN' DX:= - N * H2 / H1; DY:= N * H3 / H1 'END';
    H1:= ABS(X) * TOL + AE; H2:= ABS(Y) * TOL+ AE;
    'IF' ABS(DX) < H1 & ABS(DY) < H2 'THEN'
    'BEGIN' DX:= 'IF' DX = 0 'THEN' H1 'ELSE' SIGN(DX) * H1;
      DY:= 'IF' DY = 0 'THEN' H2 'ELSE' SIGN(DY) * H2
    'END';
    X:= X + DX; Y:= Y + DY;
    'IF' COMABS(X, Y) > 2 * MAXRAD 'THEN'
    'BEGIN' H1:= 'IF' ABS(X) > ABS(Y) 'THEN' ABS(X) 'ELSE' ABS(Y);
      H2:= LN(H1) / LN2 + 1 - MAX;
      'IF' H2 > 0 'THEN'
      'BEGIN' H2:= 2 ** H2; X:= X / H2; Y:= Y / H2 'END'
    'END'
  'END' OF LAGUERRE;

  TOTIT:= IT:= FAIL:= UP:= START:= 0; LN2:= LN(2);
  NEWF:= GIANT; AE:= DWARF; GIEX:= LN(NEWF) / LN2 - 40;
  TOL:= EM[0]; ITMAX:= EM[1];
  'FOR' I:= 0 'STEP' 1 'UNTIL' N 'DO' D[I]:= A[N-I];
  'IF' N <= 0 'THEN'
  'BEGIN' FAIL:= 1; 'GOTO' EXIT 'END'
  'ELSE' 'IF' D[0] = 0 'THEN'
  'BEGIN' FAIL:= 2; 'GOTO' EXIT 'END';
  'FOR' I:= 1 'WHILE' D[N] = 0 & N > 0 'DO'
  'BEGIN' RE[N]:= IM[N]:= 0; N:= N - 1 'END';
  'FOR' I:= 1 'WHILE' N > 2 'DO'
  'BEGIN' 'IF' CONTROL 'THEN' LAGUERRE;
    OLDF:= NEWF;
    'IF' FUNCTION 'THEN'
    'BEGIN' 'IF' Y ^= 0 & ABS(Y) < .1 'THEN'
      'BEGIN' 'REAL' H; H:= Y; Y:= 0;
         'IF' ^ FUNCTION 'THEN' Y:= H
      'END';
      RE[N]:= X; IM[N]:= Y;
      'IF' Y ^= 0 'THEN' 'BEGIN' RE[N - 1]:= X; IM[N - 1]:= -Y 'END';
      DEFLATION; TOTIT:= TOTIT + IT; UP:= START:= IT:= 0
    'END'
  'END';
  'IF' N = 1 'THEN' 'BEGIN' RE[1]:= - D[1] / D[0]; IM[1]:= 0 'END'
  'ELSE'
  'BEGIN' 'REAL' H1, H2;
    H1:= - 0.5 * D[1] / D[0]; H2:= H1 * H1 - D[2] / D[0];
    'IF' H2 >= 0 'THEN'
    'BEGIN' RE[2]:= 'IF' H1 < 0 'THEN' H1 - SQRT(H2)
            'ELSE' H1 + SQRT(H2);
      RE[1]:= D[2] / (D[0] * RE[2]);
      IM[2]:= IM[1]:= 0
    'END' 'ELSE'
    'BEGIN' RE[2]:= RE[1]:= H1;
      IM[2]:= SQRT(-H2); IM[1]:= -IM[2]
    'END'
  'END'; N:= 0;
EXIT:  EM[2]:= FAIL; EM[3]:= START; EM[4]:= TOTIT;
  'FOR' I:= (N-1) 'DIV' 2 'STEP' -1 'UNTIL' 0 'DO'
  'BEGIN' TOL := D[I]; D[I]:= D[N-I]; D[N-I]:= TOL
  'END';
  ZERPOL:= N
'END' OF ZERPOL;
        'EOP'
