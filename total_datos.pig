datos = LOAD '/user/root/tarea3/datasets/17571657100049929577.branch_trace.1006511.csv'
USING PigStorage(',') AS (branch_addr, branch_type, taken, target);

total = FOREACH (GROUP datos ALL) GENERATE COUNT(datos) AS total;

DUMP total;