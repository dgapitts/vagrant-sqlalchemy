
During the provision provisioning (i.e. provision.sh) we loaded the default pgbench scheman and data with scale factor of 3

```
  su -c "/usr/pgsql-12/bin/pgbench -i -s 3" -s /bin/sh vagrant
```


First I dump the DDL / schema and clean this file with a bit of grep and sed [(see How to escape single quote in sed?)](
https://stackoverflow.com/questions/24509214/how-to-escape-single-quote-in-sed)

```
pg_dump --schema-only vagrant > pg_bench_s3_schema.sql
sed 's/public.//g' pg_bench_s3_schema.sql | grep -v '^SET' | grep -v 'SELECT' | grep -v 'ALTER TABLE\|ADD CONSTRAINT' | sed 's/WITH (fillfactor=\x27100\x27)//g' > sqlite3_schema.sql
time cat sqlite3_schema.sql | sqlite3 bench.db
...
real	0m0.018s
user	0m0.005s
sys	0m0.007s
```


Next we use pg_dump [(with inserts)](
https://stackoverflow.com/questions/54666946/postgres-dump-with-inserts-but-without-copy-actions)



```
pg_dump --inserts --data-only vagrant > pg_bench_s3_data.sql
sed 's/public.//g' pg_bench_s3_data.sql | grep -v '^SET' | grep -v 'SELECT\|--' > sqlite3_data.sql
time cat sqlite3_data.sql | sqlite3 bench.db
...
real	11m1.262s
user	0m16.361s
sys	5m0.968
```

