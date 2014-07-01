create table ranks as select src as vid, 1.0 as rank from edges group by src;
create table sizes as select src as vid, count(dst) as len from edges group by src;
create table contribs as select E.dst as vid, R.rank/S.len as contribution from edges E, sizes S, ranks R
where 
R.vid = E.src 
and R.vid = S.vid;

create table newranks as select vid, sum(contribution)*0.85+0.15 as rank from contribs group by vid;
