'CODE' 34035;
    'PROCEDURE' ICHSEQ(L, U, IL, SHIFT, A); 'VALUE' L,U,IL,SHIFT;
    'INTEGER' L,U,IL,SHIFT; 'ARRAY' A;
    'BEGIN' 'REAL' R;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' R:= A[IL]; A[IL]:= A[IL + SHIFT]; A[IL + SHIFT]:= R;
            IL:= IL + L
        'END'
    'END' ICHSEQ;
        'EOP'
