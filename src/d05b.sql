create table parts as
    select n, elem
    from unnest(string_to_array(
            (select content from read_text('d05s.txt')), E'\n\n')) with ordinality a(elem, n);

create table ranges as
    select id, a[1]::bigint as start, a[2]::bigint as stop from (
        select id, regexp_split_to_array(elem, '-') a
            from unnest(string_to_array((select elem from parts where n=1), E'\n')) with ordinality a(elem, id)) t;

create sequence pri;
-- no setval() in duckdb and alter sequence is a troll
select nextval('pri') from generate_series(1, 10000);

alter table ranges add primary key (id);
alter table ranges alter column id set default nextval('pri');
alter table ranges add column live boolean default true;

create view overps as
    select a.start art, a.stop aop, b.start brt, b.stop bop
        from ranges a, ranges b
        where a.start <= b.stop and b.start <= a.stop
            and (a.start != b.start or a.stop != b.stop)
            and a.start <= b.start and a.stop <= b.stop
        order by a.start, a.stop, b.start, b.stop, (a.stop-a.start+b.stop-b.start);

select * from overps;
select * from ranges;

-- insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1;
update ranges set live = false where id=(select id from overps limit 1);

select * from ranges;
