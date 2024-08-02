'CODE' 34353;
    'PROCEDURE' COMROWCST(L, U, I, AR, AI, XR, XI);
    'VALUE' L, U, I, XR, XI; 'INTEGER' L, U, I; 'REAL' XR, XI;
    'ARRAY' AR, AI;
    'BEGIN'
    'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO' COMMUL(AR[I,L], AI[I,L], XR,
    XI, AR[I,L], AI[I,L]);
    'END' COMROWCST;
        'EOP'
