'CODE' 34030;
    'PROCEDURE' ICHVEC(L, U, SHIFT, A); 'VALUE' L,U,SHIFT;
    'INTEGER' L,U,SHIFT; 'ARRAY' A;
    'BEGIN' 'REAL' R;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'BEGIN' R:= A[L]; A[L]:= A[L + SHIFT]; A[L + SHIFT]:= R 'END'
    'END' ICHVEC;
       'EOP'
