'CODE' 31097;
'PROCEDURE'COMFOUSER2(N,THETA,AR,AI,RR,RI);
'VALUE'N,THETA;'INTEGER'N;'REAL'THETA,RR,RI;'ARRAY'AR,AI;
'BEGIN''REAL'CAR,CAI,SAR,SAI;
   COMFOUSER(N,THETA,AR,CAR,SAR);
   COMFOUSER(N,THETA,AI,CAI,SAI);
   RR:=CAR-SAI;
   RI:=CAI+SAR
'END'COMFOUSER2;
        'EOP'
