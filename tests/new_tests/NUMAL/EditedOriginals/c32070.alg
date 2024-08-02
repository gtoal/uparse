'CODE' 32070;
   'REAL' 'PROCEDURE' QADRAT(X, A, B, FX, E);
   'VALUE' A, B; 'REAL' X, A, B, FX; 'ARRAY' E;
   'BEGIN' 'REAL' F0, F2, F3, F5, F6, F7, F9,
        F14, V, W, HMIN, HMAX, RE, AE;

      'REAL' 'PROCEDURE' LINT(X0, XN, F0, F2, F3, F5, F6, F7, F9, F14);
      'REAL' X0, XN, F0, F2, F3, F5, F6, F7, F9, F14;
      'BEGIN' 'REAL' H, XM, F1, F4, F8, F10, F11, F12, F13;
         XM:= (X0 + XN) / 2; H:= (XN - X0) / 32; X:= XM + 4 * H;
         F8:= FX; X:= XN - 4 * H; F11:= FX; X:= XN - 2 * H; F12:= FX;
         V:= 0.330580178199226 * F7 + 0.173485115707338 * (F6 + F8) +
         0.321105426559972*(F5 + F9) + 0.135007708341042 * (F3 + F11)
         + 0.165714514228223*(F2 + F12) + 0.393971460638127@- 1 * (F0
         + F14); X:= X0 + H; F1:= FX; X:= XN - H; F13:= FX;
         W:= 0.260652434656970 * F7 + 0.239063286684765 * (F6 + F8) +
         0.263062635477467*(F5 + F9) + 0.218681931383057 * (F3 + F11)
         + 0.275789764664284@- 1 * (F2 + F12) + 0.105575010053846* (F1
         + F13) + 0.157119426059518@- 1 * (F0 + F14);
         'IF' ABS(H) < HMIN 'THEN' E[3]:= E[3] + 1;
         'IF' ABS(V - W) < ABS(W) * RE + AE 'OR' ABS(H) < HMIN
         'THEN' LINT:= H * W 'ELSE'
         'BEGIN' X:= X0 + 6 * H; F4:= FX; X:= XN - 6 * H; F10:= FX;
            V:= 0.245673430093324* F7 + 0.255786258286921* (F6 + F8) +
            0.228526063690406*(F5 + F9) + 0.500557131525460@- 1*(F4 +
            F10) + 0.177946487736780*(F3 + F11)+0.584014599347449@- 1
            * (F2 + F12) + 0.874830942871331@- 1 * (F1 + F13) +
            0.189642078648079@- 1 * (F0 + F14);
            LINT:= 'IF' ABS(V - W) < ABS(V) * RE + AE 'THEN' H * V
                                                      'ELSE'
            LINT(X0, XM, F0, F1, F2, F3, F4, F5, F6, F7) - LINT(XN,
            XM, F14, F13, F12, F11, F10, F9, F8, F7)
         'END'
      'END' LINT;

      HMAX:= (B - A) / 16; 'IF' HMAX=0 'THEN'
      'BEGIN' QADRAT:= 0; 'GOTO' RETURN 'END';
      RE:= E[1]; AE:= 2 * E[2] / ABS(B - A); E[3]:= 0;
      HMIN:= ABS(B - A) * RE; X:= A; F0:= FX;
      X:= A + HMAX; F2:= FX; X:= A + 2 * HMAX; F3:= FX;
      X:= A + 4 * HMAX; F5:= FX; X:= A + 6 * HMAX; F6:= FX;
      X:= A + 8 * HMAX; F7:= FX; X:= B - 4 * HMAX; F9:= FX; X:= B;
      F14:= FX;
      QADRAT:= LINT(A, B, F0, F2, F3, F5, F6, F7, F9, F14) * 16;
      RETURN:
   'END' QADRAT;
        'EOP'
