.timer on

-- make it undirected
drop table udedges;

create table udedges as
select src, dst from edges where src <= dst;

select count(*) from 
    (select E1.src, E2.src, E3.src from udedges E1, udedges E2, udedges E3
    where E1.dst=E2.src and
          E2.dst=E3.src and
          E3.dst=E1.src and
          ((E1.src < E1.dst and    -- just picks some ordering
          E2.src < E2.dst) or (E1.src > E1.dst and E2.src > E2.dst)));

select count(*) from 
    (select E1.src, E2.src, E3.src from edges E1, edges E2, edges E3
    where E1.dst=E2.src and
          E2.dst=E3.src and
          E3.dst=E1.src and
          E1.src < E1.dst and    -- just picks some ordering
          E2.src < E2.dst);
