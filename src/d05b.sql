create table parts as
    select n, elem
    from unnest(string_to_array(
            (select content from read_text('d05.txt')), E'\n\n')) with ordinality a(elem, n);

create table ranges as
    select a[1]::bigint as start, a[2]::bigint as stop from (
        select regexp_split_to_array(elem, '-') a
            from unnest(string_to_array((select elem from parts where n=1), E'\n')) a(elem)) t;

select sum(stop-start+1) from ranges;

create table overps as
select a.start art, a.stop aop, b.start brt, b.stop bop, a.stop-b.start+1 width from ranges a, ranges b
    where a.start <= b.stop and b.start <= a.stop
        and (a.start != b.start or a.stop != b.stop)
        and a.start <= b.start
    order by a.start, b.start;

select sum(width) from overps;

-- 308368198594539 too low
select (select sum(stop-start+1) from ranges)-(select sum(width) from overps);