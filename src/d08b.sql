create table boxes as
    select a[1]::bigint x, a[2]::bigint y, a[3]::bigint z from (
        select regexp_split_to_array(elem, ',') a
            from unnest(string_to_array(
                (select content from read_text('d08.txt')), E'\n')) a(elem)
                    where elem != '') t;

create macro f(a) as (a.x || ',' || a.y ||','|| a.z);

create macro dist(a, b) as
    (pow(a.x - b.x, 2) + pow(a.y - b.y, 2) + pow(a.z - b.z, 2));

create table edges as
    select row_number() over (order by dist(l, r)) id, f(l) as l, f(r) as r from boxes l, boxes r
         where l < r
         order by dist(l, r);

create table bi as select id,l,r from edges union all select id, r, l from edges;

select * from edges;

select distinct sub, length(sub) from (
    select l, (
        with recursive c(r) as (
            values (l)
        union
            select e.r from (select * from bi where id < 4800) e join c on (c.r = e.l)
        )
    select array_agg(distinct r order by r) from c) sub
        from (select distinct l from bi) dis
) q
order by length(sub) desc limit 3;

select * from bi where l='92049,7915,99919' order by id limit 5;