'CODE' 34355;
    'BOOLEAN' 'PROCEDURE' HSHCOMCOL(L, U, J, AR, AI, TOL, K, C, S, T);
    'VALUE' L, U, J, TOL; 'INTEGER' L, U, J; 'REAL' TOL, K, C, S, T;
    'ARRAY' AR, AI;
    'BEGIN' 'REAL' VR, DEL, MOD, H, ARLJ, AILJ;
        VR:= TAMMAT(L + 1, U, J, J, AR, AR) + TAMMAT(L + 1, U,
        J, J, AI, AI); ARLJ:= AR[L,J]; AILJ:= AI[L,J];
        CARPOL(ARLJ, AILJ, MOD, C, S); 'IF' VR > TOL 'THEN'
        'BEGIN' VR:= VR + ARLJ ** 2 + AILJ ** 2; H:= K:= SQRT(VR);
            T:= VR + MOD * H;
            'IF' ARLJ = 0 'AND' AILJ = 0 'THEN' AR[L,J]:= H 'ELSE'
            'BEGIN' AR[L,J]:= ARLJ + C * K; AI[L,J]:= AILJ + S * K;
                S:= - S
            'END';
            C:= - C; HSHCOMCOL:= 'TRUE'
        'END'
        'ELSE'
        'BEGIN' HSHCOMCOL:= 'FALSE'; K:= MOD; T:= - 1 'END'
    'END' HSHCOMCOL;
        'EOP'
