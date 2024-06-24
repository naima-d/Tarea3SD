datos = LOAD '/user/root/tarea3/datasets/17571657100049929577.branch_trace.1006511.csv'
USING PigStorage(',') AS (branch_addr: chararray, branch_type: chararray, taken: int, target: chararray);

cero = FILTER datos BY taken == 0;
uno = FILTER datos BY taken == 1;

contar_ceros = FOREACH (GROUP cero BY branch_type) GENERATE group AS branch_type, COUNT(cero) AS conteo_ceros;
contar_unos = FOREACH (GROUP uno BY branch_type) GENERATE group AS branch_type, COUNT(uno) AS conteo_unos;

unir = JOIN contar_ceros BY branch_type FULL OUTER, contar_unos BY branch_type;
resultado = FOREACH unir GENERATE
            (contar_ceros::branch_type IS NOT NULL ? contar_ceros::branch_type : contar_unos::branch_type) AS branch_type,
            (conteo_ceros IS NOT NULL ? conteo_ceros : 0) AS conteo_ceros,
            (conteo_unos IS NOT NULL ? conteo_unos : 0) AS conteo_unos;

DUMP resultado;