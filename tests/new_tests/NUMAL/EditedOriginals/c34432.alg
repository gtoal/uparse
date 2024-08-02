'CODE' 34432;
 'PROCEDURE' PRAXIS(N, X, FUNCT, IN, OUT);
 'VALUE' N; 'INTEGER' N;
 'ARRAY' X, IN, OUT;
 'REAL' 'PROCEDURE' FUNCT;
 'BEGIN'
    'COMMENT'THIS PROCEDURE MINIMIZES FUNCT(N,X),WITH THE
    PRINCIPAL AXIS METHOD (SEE BRENT,R.P, 1973, ALGORITHMS
    FOR MINIMIZATION WITHOUT DERIVATIVES,CH.7);

    'PROCEDURE' SORT;
    'BEGIN' 'INTEGER' I, J, K; 'REAL' S;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N - 1 'DO'
        'BEGIN' K:= I; S:= D[I];
            'FOR' J:= I+1 'STEP' 1 'UNTIL' N 'DO' 'IF' D[J]>S 'THEN'
            'BEGIN' K:= J; S:= D[J] 'END';
            'IF' K>I 'THEN'
            'BEGIN' D[K]:= D[I]; D[I]:= S;
                'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
                'BEGIN' S:=V[J,I]; V[J,I]:= V[J,K]; V[J,K]:= S
                'END'
            'END'
        'END'
    'END' SORT;

    'PROCEDURE' MIN(J, NITS, D2, X1, F1, FK); 'VALUE' J, NITS, FK;
    'INTEGER' J, NITS; 'REAL' D2, X1, F1; 'BOOLEAN' FK;
    'BEGIN'
        'REAL' 'PROCEDURE' FLIN(L); 'VALUE' L; 'REAL' L;
        'BEGIN' 'INTEGER' I; 'ARRAY' T[1:N];
            'IF' J > 0 'THEN'
            'BEGIN' 'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                T[I]:= X[I] + L * V[I,J]
            'END' 'ELSE'
            'BEGIN' 'COMMENT' SEARCH ALONG PARABOLIC SPACE CURVE;
                QA:= L * (L - QD1) / (QD0 * (QD0 + QD1));
                QB:= (L + QD0) * (QD1 - L) /(QD0 * QD1);
                QC:= L * (L + QD0) / (QD1 * (QD0 + QD1));
                'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
                T[I]:= QA * Q0[I] +QB * X[I] + QC * Q1[I]
            'END';
            NF:= NF + 1; FLIN:= FUNCT(N, T)
        'END' FLIN;

        'INTEGER' K; 'BOOLEAN' DZ;
        'REAL' X2, XM, F0, F2, FM, D1, T2, S, SF1, SX1;
        SF1:= F1; SX1:= X1;
        K:= 0; XM:= 0; F0:= FM:= FX; DZ:= D2 < RELTOL;
        S:= SQRT(VECVEC(1,N,0,X,X));
        T2:= M4 * SQRT(ABS(FX) / ('IF' DZ 'THEN' DMIN 'ELSE' D2)
        + S * LDT) + M2 * LDT; S:= S * M4 + ABSTOL;
        'IF' DZ 'AND' T2 > S 'THEN' T2:= S;
        'IF'T2<SMALL'THEN'T2:= SMALL;
        'IF'T2>0.01*H 'THEN'T2:= 0.01*H;
        'IF'FK'AND'F1<=FM 'THEN'
        'BEGIN'XM:=X1; FM:= F1 'END';
        'IF' ^ FK'OR'ABS(X1)<T2'THEN'
        'BEGIN'X1:='IF'X1>0 'THEN'T2'ELSE'-T2;
            F1:= FLIN(X1)
        'END';
        'IF'F1<= FM'THEN'
        'BEGIN'XM:= X1; FM:= F1 'END';
    L0: 'IF' DZ 'THEN'
        'BEGIN' 'COMMENT'EVALUATE FLIN AT ANOTHER POINT
            AND ESTIMATE THE SECOND DERIVATIVE;
            X2:= 'IF' F0 < F1 'THEN' -X1 'ELSE' X1 * 2;
            F2:= FLIN(X2); 'IF'F2 <= FM 'THEN'
            'BEGIN' XM:= X2; FM:= F2 'END';
            D2:=(X2*(F1-F0)-X1*(F2-F0))/(X1*X2*(X1-X2))
        'END';
        'COMMENT'ESTIMATE FIRST DERIVATIVE AT 0;
        D1:=(F1-F0)/X1-X1*D2; DZ:='TRUE';
        X2:= 'IF'D2<=SMALL'THEN'
        ('IF'D1<0'THEN'H'ELSE'-H)
        'ELSE'-0.5*D1/D2;
        'IF'ABS(X2)>H'THEN'X2:='IF'X2>0'THEN'H'ELSE'-H;
    L1: F2:=FLIN(X2);
        'IF'K<NITS'AND'F2>F0'THEN'
        'BEGIN'K:=K+1;
            'IF'F0<F1'AND'X1*X2>0'THEN' 'GOTO'L0;
            X2:= 0.5*X2; 'GOTO'L1
        'END';
        NL:= NL+1;
        'IF'F2>FM'THEN'X2:=XM'ELSE'FM:=F2;
        D2:='IF'ABS(X2*(X2-X1))>SMALL'THEN'
        (X2*(F1-F0)-X1*(FM-F0))/(X1*X2*(X1-X2))
        'ELSE' 'IF'K>0'THEN'0'ELSE'D2;
        'IF'D2<=SMALL'THEN'D2:=SMALL;
        X1:=X2; FX:=FM;
        'IF'SF1<FX'THEN'
        'BEGIN' FX:=SF1; X1:=SX1 'END';
        'IF'J>0'THEN'ELMVECCOL(1,N,J,X,V,X1)
    'END' MIN;

    'PROCEDURE'QUAD;
    'BEGIN' 'INTEGER' I; 'REAL' L, S;
        S:= FX; FX:= QF1; QF1:= S; QD1:= 0;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN'S:=X[I]; X[I]:= L:= Q1[I]; Q1[I]:= S;
            QD1:= QD1 + (S - L) ** 2
        'END';
        L:=QD1:=SQRT(QD1); S:= 0;
        'IF'(QD0*QD1>DWARF)'AND'NL>=3*N*N'THEN'
        'BEGIN'MIN(0,2,S,L,QF1,'TRUE');
            QA:= L*(L-QD1)/(QD0*(QD0+QD1));
            QB:=(L+QD0)*(QD1-L)/(QD0*QD1);
            QC:= L*(L+QD0)/(QD1*(QD0+QD1))
        'END' 'ELSE'
        'BEGIN' FX:= QF1; QA:= QB:= 0; QC:= 1 'END';
        QD0:= QD1;'FOR'I:= 1'STEP'1'UNTIL'N'DO'
        'BEGIN'S:=Q0[I]; Q0[I]:=X[I];
            X[I]:= QA*S + QB*X[I]+QC*Q1[I]
        'END'
    'END' QUAD;

    'BOOLEAN' ILLC;
    'INTEGER' I, J, K, K2, NL, MAXF, NF, KL, KT, KTM;
    'REAL' S, SL, DN, DMIN, FX, F1, LDS, LDT, SF, DF, QF1, QD0,
    QD1, QA, QB, QC, M2, M4, SMALL, VSMALL, LARGE, VLARGE, SCBD,
    LDFAC,T2, MACHEPS, RELTOL, ABSTOL, H;
    'ARRAY' V[1:N,1:N], D, Y, Z, Q0, Q1[1:N];

    MACHEPS:= IN[0]; RELTOL:= IN[1]; ABSTOL:= IN[2]; MAXF:= IN[5];
    H:= IN[6]; SCBD:= IN[7]; KTM:= IN[8]; ILLC:= IN[9] < 0;
    SMALL:= MACHEPS ** 2; VSMALL:= SMALL ** 2;
    LARGE:= 1/SMALL; VLARGE:= 1/VSMALL;
    M2:= RELTOL; M4:= SQRT(M2); SETRANDOM(0.5);
    LDFAC:= 'IF' ILLC 'THEN' 0.1 'ELSE' 0.01;
    KT:=NL:=0; NF:=1; OUT[3]:= QF1:=FX:=FUNCT(N,X);
    ABSTOL:=T2:= SMALL+ABS(ABSTOL); DMIN:= SMALL;
    'IF' H<ABSTOL*100'THEN'H:=ABSTOL*100; LDT:=H;
    INIMAT(1,N,1,N,V,0);
    'FOR'I:=1'STEP'1'UNTIL'N'DO'V[I,I]:= 1;
    D[1]:= QD0:= 0; DUPVEC(1,N,0,Q1,X);
    INIVEC(1,N,Q0,0);

    'COMMENT'MAIN LOOP;
L0: SF:=D[1]; D[1]:= S:= 0;
    MIN(1,2,D[1],S,FX,'FALSE');
    'IF' S <= 0 'THEN' MULCOL(1, N, 1, 1, V, V, -1);
    'IF' SF <= 0.9 * D[1] 'OR' 0.9 * SF >= D[1] 'THEN'
    INIVEC(2,N,D,0);
    'FOR' K:= 2'STEP'1'UNTIL'N'DO'
    'BEGIN' DUPVEC(1,N,0,Y,X); SF:=FX;
        ILLC:= ILLC 'OR' KT>0;
    L1: KL:=K; DF:= 0; 'IF' ILLC 'THEN'
        'BEGIN' 'COMMENT'RANDOM STOP TO GET OFF
            RESULTION VALLEY;
            'FOR'I:= 1 'STEP'1'UNTIL'N'DO'
            'BEGIN'S:=Z[I]:=(0.1*LDT+T2*10**KT)
                *(RANDOM-0.5);
                ELMVECCOL(1,N,I,X,V,S)
            'END';
            FX:= FUNCT(N,X); NF:= NF+1
        'END';
        'FOR'K2:= K 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' SL:=FX; S:= 0;
            MIN (K2, 2, D[K2], S, FX, 'FALSE');
            S:='IF' ILLC 'THEN' D[K2] * (S + Z[K2]) ** 2
            'ELSE'SL-FX;'IF'DF<S'THEN'
            'BEGIN'DF:=S;KL:= K2'END';
        'END';
        'IF' ^ILLC 'AND' DF < ABS(100 * MACHEPS * FX) 'THEN'
        'BEGIN' ILLC:= 'TRUE'; 'GOTO' L1 'END';
        'FOR' K2:= 1'STEP' 1'UNTIL'K-1'DO'
        'BEGIN' S:= 0; MIN(K2, 2, D[K2], S, FX, 'FALSE') 'END';
        F1:= FX; FX:= SF; LDS:= 0;
        'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' SL:= X[I]; X[I]:= Y[I]; SL:= Y[I]:= SL - Y[I];
            LDS:= LDS + SL * SL
        'END'; LDS:= SQRT(LDS);
        'IF' LDS > SMALL 'THEN'
        'BEGIN' 'FOR' I:= KL - 1 'STEP' -1 'UNTIL' K 'DO'
            'BEGIN' 'FOR' J:= 1 'STEP' 1 'UNTIL' N 'DO'
                V[J, I + 1]:= V[J,I]; D[I + 1]:= D[I]
            'END';
            D[K]:= 0; DUPCOLVEC(1, N, K, V, Y);
            MULCOL(1, N, K, K, V, V, 1 / LDS);
            MIN(K, 4, D[K], LDS, F1, 'TRUE'); 'IF' LDS <= 0 'THEN'
            'BEGIN' LDS:= LDS; MULCOL(1, N, K, K, V, V, -1) 'END'
        'END';
        LDT:= LDFAC * LDT; 'IF' LDT < LDS 'THEN' LDT:= LDS;
        T2:= M2 * SQRT(VECVEC(1, N, 0, X, X)) + ABSTOL;
        KT:= 'IF' LDT > 0.5 * T2 'THEN' 0 'ELSE' KT + 1;
        'IF' KT > KTM 'THEN' 'BEGIN' OUT[1]:= 0; 'GOTO' L2 'END'
    'END';
    QUAD;
    DN:= 0; 'FOR' I := 1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' D[I] := 1/SQRT(D[I]);
        'IF' DN<D[I] 'THEN' DN:=D[I]
    'END';
    'FOR' J := 1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' S := D[J]/DN; MULCOL(1,N,J,J,V,V,S) 'END';
    'IF' SCBD>1 'THEN'
    'BEGIN' S:=VLARGE; 'FOR' I :=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' SL:= Z[I]:= SQRT(MATTAM(1, N, I, I, V, V));
            'IF' SL<M4 'THEN' Z[I]:= M4;
            'IF' S>SL 'THEN' S:= SL
        'END';
        'FOR' I :=1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' SL := S/Z[I]; Z[I] := 1/SL;
            'IF' Z[I]>SCBD 'THEN'
            'BEGIN' SL:=1/SCBD; Z[I]:= SCBD 'END';
            MULROW(1, N, I, I, V, V, SL)
        'END'
    'END';
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    ICHROWCOL(I + 1, N, I, I, V);
    'BEGIN' 'ARRAY' A[1:N,1:N], EM[0:7];
        EM[0] := EM[2] := MACHEPS;
        EM[4] := 10 * N; EM[6]:= VSMALL;
        DUPMAT(1, N, 1, N, A, V);
        'IF' QRISNGVALDEC(A, N, N, D, V, EM) ^= 0 'THEN'
        'BEGIN' OUT[1]:= 2; 'GOTO' L2 'END';
    'END';
    'IF' SCBD>1 'THEN'
    'BEGIN' 'FOR' I := 1 'STEP' 1 'UNTIL' N 'DO'
        MULROW(1,N,I,I,V,V,Z[I]);
        'FOR' I := 1 'STEP' 1 'UNTIL' N 'DO'
        'BEGIN' S := SQRT(TAMMAT(1,N,I,I,V,V));
            D[I]:= S*D[I]; S:= 1/S;
            MULCOL(1,N,I,I,V,V,S)
        'END'
    'END';
    'FOR' I:= 1 'STEP' 1 'UNTIL' N 'DO'
    'BEGIN' S:= DN * D[I];
        D[I]:= 'IF' S > LARGE 'THEN' VSMALL 'ELSE'
        'IF' S < SMALL 'THEN' VLARGE 'ELSE' S ** (-2)
    'END';
    SORT;
    DMIN:= D[N]; 'IF' DMIN < SMALL 'THEN' DMIN:= SMALL;
    ILLC:= (M2 * D[1]) > DMIN;
    'IF' NF < MAXF 'THEN' 'GOTO' L0 'ELSE' OUT[1]:= 1;
L2: OUT[2]:= FX;
    OUT[4]:= NF; OUT[5]:= NL; OUT[6]:= LDT
'END' PRAXIS;
        'EOP'
