'CODE' 34611;
    'PROCEDURE'CHSH2(A1R,A1I,A2R,A2I,C,SR,SI);
    'VALUE'A1R,A1I,A2R,A2I;'REAL'A1R,A1I,A2R,A2I,C,SR,SI;
    'BEGIN' 'REAL' R;
    'IF' A2R^=0 'OR' A2I^=0 'THEN'
    'BEGIN' 'IF' A1R^=0 'OR' A1I^=0 'THEN'
        'BEGIN' R:=SQRT(A1R*A1R+A1I*A1I);C:=R;
            SR:=(A1R*A2R+A1I*A2I)/R;SI:=(A1R*A2I-A1I*A2R)/R;
            R:=SQRT(C*C+SR*SR+SI*SI);C:=C/R;SR:=SR/R;SI:=SI/R
        'END' 'ELSE'
        'BEGIN' SI:=C:=0;SR:=1 'END'
    'END' 'ELSE' 'BEGIN' C:=1;SR:=SI:=0 'END'
    'END' CHSH2;
         'EOP'
