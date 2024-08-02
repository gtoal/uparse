'CODE' 32020;
'REAL' 'PROCEDURE' SUMPOSSERIES(AI, I, MAXADDUP, MAXZERO,MAXRECURS,
                                MACHEXP, TIM);
'VALUE' MAXADDUP, MAXZERO, MAXRECURS, MACHEXP, TIM;
'REAL' AI, I, MAXZERO; 'INTEGER' MAXADDUP, MAXRECURS, MACHEXP, TIM;
'BEGIN' 'INTEGER' RECURS, VL, VL2, VL4;

       'REAL' 'PROCEDURE' SUMUP(AI, I); 'REAL' AI, I;
       'BEGIN' 'INTEGER' J; 'REAL' SUM, NEXTTERM;
          I:= MAXADDUP + 1; J:= 1;
       CHECK ADD: 'IF' AI <= MAXZERO 'THEN'
          'BEGIN''IF' J < TIM 'THEN'
             'BEGIN' J:= J + 1; I:= I + 1; 'GOTO' CHECK ADD 'END'
          'END''ELSE'
          'IF' RECURS ^= MAXRECURS 'THEN''GOTO' TRANSFORMSERIES;
          SUM:= 0; I:= 0; J:= 0;
       ADD LOOP: I:= I + 1; NEXTTERM:= AI;
          J:= 'IF' NEXTTERM <= MAXZERO 'THEN' J + 1 'ELSE' 0;
          SUM:= SUM + NEXTTERM;
          'IF' J < TIM 'THEN''GOTO' ADD LOOP;
          SUMUP:= SUM; 'GOTO' GOTSUM;
       TRANSFORMSERIES:
          'BEGIN''BOOLEAN' JODD; 'INTEGER' J2; 'ARRAY' V[1:VL];

             'REAL''PROCEDURE' BJK(J, K); 'VALUE' J, K; 'REAL' K;
             'INTEGER' J;
             'BEGIN''REAL' COEFF;
                'IF' K > MACHEXP 'THEN' BJK:= 0 'ELSE'
                'BEGIN' COEFF:= 2 ** (K - 1); I:= J * COEFF;
                   BJK:= COEFF * AI
                'END'
             'END' BJK;
             'REAL''PROCEDURE' VJ(J); 'VALUE' J; 'INTEGER' J;
             'BEGIN''REAL' TEMP, K;
                'IF' JODD 'THEN'
                'BEGIN' JODD:= 'FALSE'; RECURS:= RECURS + 1;
                   TEMP:= VJ:= SUMUP(BJK(J, K), K);
                   RECURS:= RECURS - 1;
                   'IF' J <= VL 'THEN' V[J]:= TEMP 'ELSE'
                   'IF' J <= VL2 'THEN' V[J - VL]:= TEMP
                'END''ELSE'
                'BEGIN' JODD:= 'TRUE'; 'IF' J > VL4 'THEN'
                   'BEGIN' RECURS:= RECURS + 1;
                      VJ:= - SUMUP(BJK(J, K), K); RECURS:= RECURS - 1
                   'END''ELSE'
                   'BEGIN' J2:= J2 + 1; I:= J2;
                      'IF' J > VL2 'THEN' VJ:= - (V[J2 - VL] - AI) / 2
                      'ELSE'
                      'BEGIN' TEMP:= V['IF' J <= VL 'THEN' J 'ELSE'
                         J - VL]:= (V[J2] - AI) / 2; VJ:= - TEMP
                      'END'
                   'END'
                'END'
             'END' VJ;

             J2:= 0;
             JODD:= 'TRUE'; SUMUP:= EULER(VJ(J + 1), J, MAXZERO, TIM)
          'END' TRANSFORMSERIES;
       GOTSUM:
       'END' SUMUP;

       RECURS:= 0; VL:= 1000; VL2:= 2 * VL; VL4:= 2 * VL2;
       SUMPOSSERIES:= SUMUP(AI, I)
    'END' SUMPOSSERIES;
        'EOP'
