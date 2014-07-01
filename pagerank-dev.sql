--initialization
create table edges(src int, dst int);
insert into edges values (4,1);
insert into edges values (4,2);
insert into edges values (2,3);
insert into edges values (3,2);
insert into edges values (6,2);
insert into edges values (6,5);
insert into edges values (5,4);
insert into edges values (5,2);
insert into edges values (5,6);
insert into edges values (7,2);
insert into edges values (7,5);
insert into edges values (8,2);
insert into edges values (8,5);
insert into edges values (9,2);
insert into edges values (9,5);
insert into edges values (10,5);
insert into edges values (11,5);



create table ranks as select src as vid, 1.0 as rank from edges group by src;

create table sizes as select src as vid, count(dst) as len from edges group by src;

-- ALSO: create clustered index on edges.src, thus creating an edgelist that can be reused through all iterations
-- In Myrial with loop hoisting we can do this 


-- one pagerank iteration
create table contribs as select E.dst as vid, R.rank/S.len as contribution from edges E, sizes S, ranks R
where 
R.vid = E.src 
and R.vid = S.vid;

-- will only contain vertices that have incoming edges.
-- SparkPagerank.scala does the same (is this okay? Won't we miss contributions later?)
create table newranks as select vid, sum(contribution)*0.85+0.15 as rank from contribs group by vid;


-- check result
select * from newranks;
