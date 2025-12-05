create table parts as
    select n, elem
    from unnest(string_to_array(
            (select content from read_text('d05u.txt')), E'\n\n')) with ordinality a(elem, n);

create table ranges as
    select id, a[1]::bigint as start, a[2]::bigint as stop from (
        select id, regexp_split_to_array(elem, '-') a
            from unnest(string_to_array((select elem from parts where n=1), E'\n')) with ordinality a(elem, id)) t;

create sequence pri;
-- no setval() in duckdb and alter sequence is a troll
select sum(nextval('pri')) from generate_series(1, 10000);

alter table ranges add primary key (id);
alter table ranges alter column id set default nextval('pri');
alter table ranges add column live boolean default true;

create unique index rafull on ranges (start, stop);

create view overps as
    select a.start art, a.stop aop, b.start brt, b.stop bop,
        (case when a.stop-a.start < b.stop-b.start then a.id else b.id end) as sid
        from ranges a, ranges b
        where a.start <= b.stop and b.start <= a.stop
            and (a.start != b.start or a.stop != b.stop)
            and a.start <= b.start and a.stop <= b.stop
            and a.live and b.live
        order by a.start, a.stop, b.start, b.stop, (a.stop-a.start+b.stop-b.start);

-- select * from overps;
-- select * from ranges;

.changes on

insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);

insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);
insert into ranges (start, stop) select least(art, brt) as start, greatest(aop, bop) as stop from overps a limit 1 on conflict (start, stop) do update set live=true; update ranges set live = false where id=(select sid from overps limit 1);

-- 366663619277599 too high

-- no idea why it doesn't catch these olol
delete from ranges o where live and exists (select 1 from ranges i where live and o.start > i.start and o.stop < i.stop);

select sum(stop-start+1) from ranges where live;


-- .maxrows 100
-- select start||'..='||stop||',' from ranges where live order by start;
-- select * from overps;
-- select count(distinct start) from ranges where live;
-- select * from ranges where start=424358604270 and stop=7668845009584;
-- update ranges set live = false where id=(select sid from overps limit 1);

