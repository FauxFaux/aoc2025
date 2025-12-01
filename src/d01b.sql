create table raw as
    select nr, elem as txt
    from unnest(string_to_array(
            (select content from read_text('d01.txt')), E'\n'))
        with ordinality a(elem, nr);
create table num as
    select nr, (replace(replace(txt, 'R', '+'), 'L', '-')::int) as v
    from raw where txt != '';

create table arrs as select nr, v, (select array(select sign(v) from generate_series(1, abs(v)))) arr from num;
create table clicks as select row_number() over (order by nr, click) ln, click from (select nr, unnest(arr) as click from arrs order by nr) a;
create unique index clicks_ln on clicks (ln);
vacuum analyze clicks;

-- 5m45s
-- select count(*) from (
--     select gn, mod(1000000000050+
--                    (select sum(click) from clicks where ln <= gn), 100) curr
--     from generate_series(1, (select count(*) from clicks)) as gs(gn)
--               ) spin where curr=0;

-- instant:
create table run as select ln, sum(click) over (order by ln) as curr from clicks;
select count(*) from run where mod(1000000000050 + curr, 100) = 0;
