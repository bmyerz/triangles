triangles
=========

## Import some data
```bash
./getdata.sh
./import.sqlite.sh ca-HepTh.txt.clean
```

## Run the queries
```bash
sqlite3 ca-HepTh.txt.clean.db <triangle-simple.sql 
sqlite3 ca-HepTh.txt.clean.db <triangle.sql
```
