'CODE' 36404;
'PROCEDURE' VECPERM(PERM,LOW,UPP,VECTOR);'VALUE' LOW,UPP;
'INTEGER' LOW,UPP;'INTEGER' 'ARRAY' PERM;'REAL' 'ARRAY' VECTOR;
'BEGIN' 'INTEGER' T,J,K;'REAL' A;'BOOLEAN' 'ARRAY' TODO[LOW:UPP];
    'FOR' T:=LOW 'STEP' 1 'UNTIL' UPP 'DO' TODO[T]:='TRUE';
    'FOR' T:=LOW 'STEP' 1 'UNTIL' UPP 'DO'
    'BEGIN' 'IF' TODO[T] 'THEN'
        'BEGIN' K:=T;A:=VECTOR[K];
            'FOR' J:=PERM[K] 'WHILE' J^=T 'DO'
            'BEGIN' VECTOR[K]:=VECTOR[J];TODO[K]:='FALSE';K:=J
            'END';VECTOR[K]:=A;TODO[K]:='FALSE'
        'END' CYCLE;
    'END' FOR T;
'END' VECPERM;

        'EOP'
