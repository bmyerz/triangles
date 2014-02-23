triangles
=========

## Import some data
```bash
./getdata.sh
./import.sh ca-HepTh.txt.clean
```

## Run the queries
```bash
sqlite3 -init triangle-simple.sql ca-HepTh.txt.clean.db
sqlite3 -init triangle.sql ca-HepTh.txt.clean.db
```
