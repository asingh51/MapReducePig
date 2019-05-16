matrix1 = LOAD '$M' USING PigStorage(',') AS (row:int,col:int,value:float);
matrix2 = LOAD '$N' USING PigStorage(',') AS (row:int,col:int,value:float);
A = JOIN matrix1 BY column FULL OUTER, matrix2 BY row;
B = FOREACH A GENERATE matrix1.row AS m1r, matrix2.column AS m2c,(matrix1.value)*(matrix2.value) AS value;
C = GROUP B BY (m1r, m2c);
multiplied_matrices = FOREACH C GENERATE group.$0 as row, group.$1 as column, SUM(B.value) AS val;
STORE multiplied_matrices INTO '$O' USING PigStorage (',');
