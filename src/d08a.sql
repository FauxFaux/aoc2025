create table boxes as
    select a[1]::bigint x, a[2]::bigint y, a[3]::bigint z from (
        select regexp_split_to_array(elem, ',') a
            from unnest(string_to_array(
                (select content from read_text('d08.txt')), E'\n')) a(elem)
                    where elem != '') t;

create macro f(a) as (a.x || ',' || a.y ||','|| a.z);

create table edges as select f(l) as l, f(r) as r from boxes l, boxes r
         where l < r
         order by pow(l.x - r.x, 2) + pow(l.y - r.y, 2) + pow(l.z - r.z, 2)
    limit 1000;

create table bi as select l,r from edges union all select r, l from edges;


select distinct sub, length(sub) from (
    select l, (
        with recursive c(r) as (
            values (l)
        union
            select e.r from bi e join c on (c.r = e.l)
        )
    select array_agg(distinct r order by r) from c) sub
        from (select distinct l from bi) dis
) q
order by length(sub) desc limit 3;
