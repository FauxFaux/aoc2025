create table parts as
    select n, elem
    from unnest(string_to_array(
            (select content from read_text('d05s.txt')), E'\n\n')) with ordinality a(elem, n);

create table ranges as
    select a[1]::bigint as start, a[2]::bigint as stop from (
        select regexp_split_to_array(elem, '-') a
            from unnest(string_to_array((select elem from parts where n=1), E'\n')) a(elem)) t;

select sum(stop-start+1) from ranges;
create view overps as
    select a.start art, a.stop aop, b.start brt, b.stop bop
        from ranges a, ranges b
        where a.start <= b.stop and b.start <= a.stop
            and (a.start != b.start or a.stop != b.stop)
            and a.start <= b.start and a.stop <= b.stop
        order by a.start, a.stop, b.start, b.stop;

select * from overps;

with picked as (select * from overps limit 1),
     cleaned as (delete from ranges where start = picked.start and stop = picked.stop returning *)
select sum(stop-start+1) from cleaned;