create table raw as
    select l, (
        select array_agg(v)
        from unnest(regexp_split_to_array(trim(elem), '[ :]+')) u(v)
        ) arr
        from unnest(string_to_array(
            (select content from read_text('d11.txt')), E'\n')) with ordinality a(elem, l)
    where elem <> '';

create table edges as
select arr[1] f, t from raw,unnest(arr[2:]) u(t) order by f, t;
--
-- with recursive found(f, t, step, r) as (
--     select *, 1 as step, [row_number() over (order by f, t)] as r from edges where f='svr'
-- union all
--     select e.f, e.t, step + 1, r||[row_number() over (order by e.f, e.t)]
--     from edges e
--     join found fr on fr.t = e.f
-- ) select * from found;

with recursive found(f, t, r) as (
    select *, [t] as r from edges where f='svr'
union all
    select e.f, e.t,  r||[e.t]
    from edges e
    join found fr on fr.t = e.f
) select count(*) from found where t='out' and r @> ['fft'] and r @> ['dac'];
