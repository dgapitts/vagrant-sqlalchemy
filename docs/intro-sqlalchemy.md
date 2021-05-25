Introducing sqlalchemy ORM with sqlite3

Following a simple [tutorial](https://www.tutorialspoint.com/sqlalchemy/sqlalchemy_orm_declaring_mapping.htm)

```
[vagrant@c7pyth4db vagrant]$ cat sqlalchemy-intro.py
from sqlalchemy import Column, Integer, String
from sqlalchemy import create_engine
engine = create_engine('sqlite:///sales.db', echo = True)
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

to running this, I also need 
```
pip3 install sqlalchemy
```

now we can use python to create the cutomers table based on the sqlachemy ORM 
```
[vagrant@c7pyth4db vagrant]$ python3 sqlalchemy-intro.py
2021-05-25 19:20:11,990 INFO sqlalchemy.engine.Engine BEGIN (implicit)
2021-05-25 19:20:11,990 INFO sqlalchemy.engine.Engine PRAGMA main.table_info("customers")
2021-05-25 19:20:11,990 INFO sqlalchemy.engine.Engine [raw sql] ()
2021-05-25 19:20:11,991 INFO sqlalchemy.engine.Engine PRAGMA temp.table_info("customers")
2021-05-25 19:20:11,991 INFO sqlalchemy.engine.Engine [raw sql] ()
2021-05-25 19:20:11,992 INFO sqlalchemy.engine.Engine 
CREATE TABLE customers (
	id INTEGER NOT NULL, 
	name VARCHAR, 
	address VARCHAR, 
	email VARCHAR, 
	PRIMARY KEY (id)
)


2021-05-25 19:20:11,992 INFO sqlalchemy.engine.Engine [no key 0.00019s] ()
2021-05-25 19:20:11,997 INFO sqlalchemy.engine.Engine COMMIT
```