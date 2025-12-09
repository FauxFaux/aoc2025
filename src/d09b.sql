create table coords as
    select id, a[1]::bigint x, a[2]::bigint y from (
        select id, regexp_split_to_array(elem, ',') a
            from unnest(string_to_array(
                (select content from read_text('d09.txt')), E'\n')) with ordinality a(elem, id)
                    where elem != '') t;

insert into coords select (select max(id) from coords)+1, x, y from coords where id=1;

create table vert as
select x,y
    from
       (select l.x,
               least(l.y,r.y) as start,
               greatest(l.y,r.y) as stop
        from coords l
            inner join coords r
                on (l.id = r.id-1 and l.x=r.x)) u,
   generate_series(start+1,stop-1) gs(y)
order by x,y;

create table hor as
select x,y
    from
       (select l.y,
               least(l.x,r.x) as start,
               greatest(l.x,r.x) as stop
        from coords l
            inner join coords r
                on (l.id = r.id-1 and l.y=r.y)) u,
   generate_series(start+1,stop-1) gs(x)
order by x,y;

create table edge as
    select * from hor
    union all
    select * from vert;

-- create index idx_edge_x on edge(x);
-- create index idx_edge_y on edge(y);
-- vacuum analyze edge;

select count(*) from edge;


select max((1+abs(l.x-r.x))*(1+abs(l.y-r.y))) as area
from coords l,coords r
where
    r.x >= l.x and r.y >= l.y
    and not exists (
        select 1 from edge c
          where
                (c.x between least(l.x, r.x)+1 and greatest(l.x, r.x)-1)
            and (c.y between least(l.y, r.y)+1 and greatest(l.y, r.y)-1));
