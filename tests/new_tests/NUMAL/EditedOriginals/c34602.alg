'CODE' 34602;
'PROCEDURE' HSHDECMUL(N,A,B,DWARF);'VALUE'N,DWARF;'INTEGER'N;
'REAL' DWARF;'ARRAY' A,B;
'BEGIN'  'ARRAY' V[1:N];'INTEGER' J,K,K1,N1;'REAL' R,T,C;
    K:=1;N1:=N+1;
    'FOR' K1:=2 'STEP' 1 'UNTIL' N1 'DO'
    'BEGIN' R:=TAMMAT(K1,N,K,K,B,B);
        'IF' R>DWARF 'THEN'
        'BEGIN' R:='IF' B[K,K]<0 'THEN' -SQRT(R+B[K,K]*B[K,K])
            'ELSE' SQRT(R+B[K,K]*B[K,K]);T:=B[K,K]+R;C:=-T/R;
            B[K,K]:=-R;V[K]:=1;
            'FOR' J:=K1 'STEP' 1 'UNTIL' N 'DO' V[J]:=B[J,K]/T;
            HSHVECMAT(K,N,K1,N,C,V,B);HSHVECMAT(K,N,1,N,C,V,A)
        'END';K:=K1
    'END'
'END' HSHDECMUL;
        'EOP'
