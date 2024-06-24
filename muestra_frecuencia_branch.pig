datos = LOAD '/user/root/tarea3/datasets/17571657100049929577.branch_trace.1006511.csv'
    USING PigStorage(',') AS (branch_addr: chararray, branch_type: chararray, taken: int, target: chararray);

-- SE AJUSTA ESTA VARIABLE PARA IR AUMENTANDO O DECRECIENDO LAS POTENCIAS DE 10
muestra = SAMPLE datos 0.00064;

frecuencia_branch = FOREACH (GROUP muestra BY branch_type) GENERATE group AS branch_type, COUNT(muestra) AS frecuencia;

DUMP frecuencia_branch;