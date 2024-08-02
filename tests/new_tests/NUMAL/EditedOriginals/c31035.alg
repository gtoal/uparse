'CODE' 31035;
    'PROCEDURE' DUPMAT(L, U, I, J, A, B); 'VALUE' L,U,I,J;
    'INTEGER' L,U,I,J; 'ARRAY' A,B;
    'BEGIN' 'INTEGER' K;
        'FOR' L:= L 'STEP' 1 'UNTIL' U 'DO'
        'FOR' K:= I 'STEP' 1 'UNTIL' J 'DO' A[L,K]:= B[L,K]
    'END' DUPMAT;
        'EOP'
