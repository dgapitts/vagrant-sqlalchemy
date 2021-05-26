


Note I was initially getting a bunch of errors 

```
psycopg2.OperationalError: FATAL:  Ident authentication failed for user "vagrant"
```

As a quick fix 
* I added a password for vagrant `alter user vagrant password 'vagrant';` but this didn't help
* I tweaked the /var/lib/pgsql/12/data/pg_hba.conf `host    all             all             127.0.0.1/32            trust` and ran `service postgresql-12 reload` (all as root)
* Confirmed that `psql -U vagrant -h 127.0.0.1` (worked as root - didn't promote for password)
* In the create_engine connection string changed `localohst` to `127.0.0.1`

i.e.
```
[root@c7pyth4db vagrant]# cat sqlalchemy-intro-python.py
from sqlalchemy import Column, Integer, String
from sqlalchemy import create_engine
engine = create_engine('postgresql+psycopg2://vagrant:vagrant@127.0.0.1:5432/vagrant', echo = True)
from sqlalchemy.ext.declarative import declarative_base
Base = declarative_base()

class Customers(Base):
   __tablename__ = 'customers'
   id = Column(Integer, primary_key=True)

   name = Column(String)
   address = Column(String)
   email = Column(String)
Base.metadata.create_all(engine)
```
and this eventually worked 
```
[root@c7pyth4db vagrant]# python3 sqlalchemy-intro-python.py 
2021-05-26 20:07:44,421 INFO sqlalchemy.engine.Engine select version()
2021-05-26 20:07:44,422 INFO sqlalchemy.engine.Engine [raw sql] {}
2021-05-26 20:07:44,437 INFO sqlalchemy.engine.Engine select current_schema()
2021-05-26 20:07:44,437 INFO sqlalchemy.engine.Engine [raw sql] {}
2021-05-26 20:07:44,449 INFO sqlalchemy.engine.Engine show standard_conforming_strings
2021-05-26 20:07:44,449 INFO sqlalchemy.engine.Engine [raw sql] {}
2021-05-26 20:07:44,451 INFO sqlalchemy.engine.Engine BEGIN (implicit)
2021-05-26 20:07:44,458 INFO sqlalchemy.engine.Engine select relname from pg_class c join pg_namespace n on n.oid=c.relnamespace where pg_catalog.pg_table_is_visible(c.oid) and relname=%(name)s
2021-05-26 20:07:44,458 INFO sqlalchemy.engine.Engine [generated in 0.00561s] {'name': 'customers'}
2021-05-26 20:07:44,470 INFO sqlalchemy.engine.Engine 
CREATE TABLE customers (
	id SERIAL NOT NULL, 
	name VARCHAR, 
	address VARCHAR, 
	email VARCHAR, 
	PRIMARY KEY (id)
)
2021-05-26 20:07:44,470 INFO sqlalchemy.engine.Engine [no key 0.00028s] {}
2021-05-26 20:07:44,550 INFO sqlalchemy.engine.Engine COMMIT
```

it would be nice to do this more smoothly ;)