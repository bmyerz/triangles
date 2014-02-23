echo "
create table edges(src int, dst int);
.mode csv
.separator \t
.import $1 edges
" > import.sql

sqlite3 -init import.sql $1.db
