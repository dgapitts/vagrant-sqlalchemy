# vagrant-sqlalchemy

## Intro

This project is to explore and demo the python sqlalchemy ORM 

SQLAlchemy is the Python SQL toolkit and Object Relational Mapper that gives application developers the full power and flexibility of SQL. It provides a full suite of well known enterprise-level persistence patterns, designed for efficient and high-performing database access, adapted into a simple and Pythonic domain language...
SQLAlchemy is most famous for its object-relational mapper (ORM), an optional component that provides the data mapper pattern, where classes can be mapped to the database in open ended, multiple ways - allowing the object model and database schema to develop in a cleanly decoupled way from the beginning.
https://www.sqlalchemy.org/

I'm going working with a few DB engines:  postgres, sqlite, cockroachdb and mysql.

## Vagrant scp

As per [docs/vagrant-scp.md](docs/vagrant-scp.md) I've made some notes on setting up scp with vagrant, as the initial datasets are created in pgbench/postgres, then dumped to flat files and tweaked for the other db engines. 

The tweaking will be largely scriptted plus a few quicklu manual edits, I'm using vagrant-scp to save these datasets.