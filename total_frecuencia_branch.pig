datos = LOAD '/user/root/tarea3/datasets/17571657100049929577.branch_trace.1006511.csv'
    USING PigStorage(',') AS (branch_addr: chararray, branch_type: chararray, taken: int, target: chararray);

frecuencia_branch = FOREACH (GROUP datos BY branch_type) GENERATE group AS branch_type, COUNT(datos) AS frecuencia;

DUMP frecuencia_branch;