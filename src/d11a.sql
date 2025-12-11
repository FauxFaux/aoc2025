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

with recursive found(f, t, step) as (
    select *, 1 as step from edges where f='you'
union all
    select e.f, e.t, step + 1
    from edges e
    join found fr on fr.t = e.f
) select count(*) from found where t='out';
