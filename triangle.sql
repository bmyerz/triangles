.timer on

-- make it undirected
drop table udedges;

create table udedges as
select src, dst from edges where src <= dst;


-- vertex table with attributes(degree) from undirected edge table
drop view vertex;

create view vertex as
select vid, count(*) as deg from
        -- get all udedges in directed representation
        (select src as vid from udedges
         union all 
         select dst as vid from udedges) 
group by vid;


-- table of udedges in such a direction that src degree > dst degree
-- TODO: is there a way to avoid union overlap / will databse do a binary sort instead?
drop view triswap;

create view triswap as
select E.src as vbig, E.dst as vsmall from udedges E, vertex Ds, vertex Dd where E.src=Ds.vid and E.dst=Dd.vid and Ds.deg >= Dd.deg
union all
select E.dst as vbig, E.src as vsmall from udedges E, vertex Ds, vertex Dd where E.src=Ds.vid and E.dst=Dd.vid and Ds.deg < Dd.deg;

-- triangles enumeration
--        *
-- TS3  /   \ TS1
--    /       \
--   v         v
--   * <------ *
--       TS2
select count(*) from (select TS3.vsmall as v, TS1.vsmall as u, TS1.vbig as w from triswap TS1, triswap TS2, triswap TS3
where TS1.vbig = TS3.vbig and
      TS1.vsmall = TS2.vbig and
      TS3.vsmall = TS2.vsmall);

      
      
    
