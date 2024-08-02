'CODE' 35178;
    'PROCEDURE' NONEXP BESS K01(X, K0, K1);'VALUE' X;'REAL' X, K0, K1;
    'IF' X <= 1.5 'THEN'
    'BEGIN' 'REAL' EXPX;
        EXPX:= EXP(X); BESS K01(X, K0, K1); K0:= K0 * EXPX;
        K1:= EXPX * K1
    'END' 'ELSE' 'IF' X <= 5 'THEN'
    'BEGIN' 'INTEGER' R; 'REAL' T2, FAC, S1, S2, TERM1, TERM2,
        SQRTEXPR, EXPH2, X2;
        S1:= .5; S2:=0; R:= 0; X2:= X + X;
        EXPH2:= 1 / SQRT(5 * X);
        'FOR' FAC:= .90483741803596,
        .67032004603564,     .40656965974060,     .20189651799466,
        .82084998623899@-1,  .27323722447293@-1,  .74465830709243@-2,
        .16615572731739@-2,  .30353913807887@-3,  .45399929762485@-4,
        .55595132416500@-5,  .55739036926944@-6,  .45753387694459@-7,
        .307487987958650@-8, .16918979226151@-9,  .76218651945127@-11,
        .28111852987891@-12, .84890440338729@-14, .2098791048793@-15,
        .42483542552916@-17 'DO'
        'BEGIN' R:= R + 1; T2:= R * R / 10;
            SQRTEXPR:= SQRT(T2 / X2 + 1);
            TERM1:= FAC / SQRTEXPR; TERM2:= FAC * SQRTEXPR * T2;
            S1:= S1 + TERM1; S2:= S2 + TERM2
        'END';
        K0:= EXPH2 * S1; K1:= EXPH2 * S2 * 2
    'END' 'ELSE'
    'BEGIN' 'INTEGER' R;
        'REAL' BR, BR1, BR2, CR, CR1, CR2, DR, ERMIN1, ERPLUS1, ER,
        F0, F1, EXPX, Y, Y2;
        Y:= 10 / X - 1; Y2:= Y + Y; R:= 30;
        BR1:= BR2:= CR1:= CR2:= ERPLUS1:= ER:= 0;
        'FOR' DR:= .27545@ - 15, -.172697@ - 14, .1136042 @ - 13,
        -.7883236       @ -13, .58081063       @ -12,
        -.457993622     @ -11, .3904375576     @ -10,
        -.36454717921   @ - 9, .379299645568   @ - 8,
        -.450473376411  @ - 7, .63257510850049 @ - 6,
        -.11106685196665@ - 4, .26953261276272 @ - 3,
        -.11310504646928@ - 1 'DO'
        'BEGIN' R:= R - 2; BR:= Y2 * BR1 - BR2 + DR;
            CR:= CR1 * Y2 - CR2 + ER;
            ERMIN1:= R * DR + ERPLUS1; ERPLUS1:= ER; ER:= ERMIN1;
            BR2:= BR1; BR1:= BR; CR2:= CR1; CR1:= CR
        'END';
        F0:= Y * BR1 - BR2 + .9884081742308258;
        F1:= Y * CR1 - CR2 + ER / 2;
        EXPX:= SQRT(1.5707963267949 / X); K0:= F0:= F0 * EXPX;
        K1:= (1 + .5 / X) * F0 + (10 / X / X) * EXPX * F1
      'END'   K0;
        'EOP'
