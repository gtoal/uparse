'CODE' 34270;
'INTEGER' 'PROCEDURE' QRISNGVALBID(D, B, N, EM);
'VALUE' N; 'INTEGER' N; 'ARRAY' D, B, EM;
'BEGIN' 'INTEGER' N1, K, K1, I, I1, COUNT, MAX, RNK;
    'REAL' TOL, BMAX, Z, X, Y, G, H, F, C, S, MIN;
    TOL:= EM[2] * EM[1]; COUNT:= 0; BMAX:= 0; MAX:= EM[4]; MIN:= EM[6];
    RNK:= N;
IN: K:= N; N1:= N - 1;
NEXT: K:= K - 1; 'IF' K > 0 'THEN'
    'BEGIN' 'IF' ABS(B[K]) >= TOL 'THEN'
        'BEGIN' 'IF' ABS(D[K]) >= TOL 'THEN' 'GOTO' NEXT;
            C:= 0; S:= 1;
            'FOR' I:= K 'STEP' 1 'UNTIL' N1 'DO'
            'BEGIN' F:= S * B[I]; B[I]:= C * B[I]; I1:= I + 1;
                'IF' ABS(F) < TOL 'THEN' 'GOTO' NEGLECT;
                G:= D[I1]; D[I1]:= H:= SQRT(F * F + G * G);
                C:= G / H; S:= - F / H
            'END'
        NEGLECT:
        'END'
        'ELSE' 'IF' ABS(B[K]) > BMAX 'THEN' BMAX:= ABS(B[K])
    'END';
    'IF' K = N1 'THEN'
    'BEGIN' 'IF' D[N] < 0 'THEN' D[N]:= - D[N];
        'IF' D[N] <= MIN 'THEN' RNK:= RNK - 1; N:= N1
    'END'
    'ELSE'
    'BEGIN' COUNT:= COUNT + 1; 'IF' COUNT > MAX 'THEN' 'GOTO' END;
        K1:= K + 1; Z:= D[N]; X:= D[K1]; Y:= D[N1];
        G:= 'IF' N1 = 1 'THEN' 0 'ELSE' B[N1 - 1]; H:= B[N1];
        F:= ((Y - Z) * (Y + Z) + (G - H) * (G + H)) / (2 * H * Y);
        G:= SQRT(F * F + 1);
        F:= ((X - Z) * (X + Z) + H * (Y / ('IF' F < 0 'THEN' F - G
        'ELSE' F + G) - H)) / X; C:= S:= 1;
        'FOR' I:= K1 + 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' I1:= I - 1; G:= B[I1]; Y:= D[I]; H:= S * G; G:= C * G;
            Z:= SQRT(F * F + H * H); C:= F / Z; S:= H / Z;
            'IF' I1 ^= K1 'THEN' B[I1 - 1]:= Z; F:= X * C + G * S;
            G:= G * C - X * S; H:= Y * S; Y:= Y * C;
            D[I1]:= Z:= SQRT(F * F + H * H); C:= F / Z; S:= H / Z;
            F:= C * G + S * Y; X:= C * Y - S * G
        'END';
        B[N1]:= F; D[N]:= X
    'END';
    'IF' N > 0 'THEN' 'GOTO' IN;
END: EM[3]:= BMAX; EM[5]:= COUNT; EM[7]:= RNK; QRISNGVALBID:= N
'END' QRISNGVALBID;
        'EOP'
