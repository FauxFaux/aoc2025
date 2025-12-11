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
select count(*) total_edges from edges;

-- assumption: there's only paths from fft -> dac, none from dac -> fft (as that'd cycle)


-- create table until_fft as
--     select * from edges where not (f = 'fft' or t = 'out' or f = 'dac' or t = 'dac');
--
-- create table until_dac as
--     select * from edges where not (f = 'dac' or t = 'out' or t = 'fft');
--
-- with recursive found(f, t, r) as (
--     select * from until_fft where f='svr'
-- union
--     select e.f, e.t
--     from until_fft e
--     join found fr on fr.t = e.f
-- ) select * from found where t='fft';
--
-- with recursive found(f, t, r) as (
--     select * from until_dac where f='fft'
-- union
--     select e.f, e.t
--     from until_dac e
--     join found fr on fr.t = e.f
-- ) select * from found where t='dac';

create table reachable_from_fft as
    with recursive found(f, t, r) as (
        select * from edges where f='fft'
    union
        select e.f, e.t
        from edges e
        join found fr on fr.t = e.f
    ) select * from found;

create table reachable_from_dac as
    with recursive found(f, t, r) as (
        select * from edges where f='dac'
    union
        select e.f, e.t
        from edges e
        join found fr on fr.t = e.f
    ) select * from found;

create table svr_to_fft as
    select * from edges
        except select * from reachable_from_fft;

create table fft_to_dac as
    select * from reachable_from_fft
        except select * from reachable_from_dac;

select count(*) fft_able from reachable_from_fft;
select count(*) dac_able from reachable_from_dac;

---

select count(*) s2f from svr_to_fft;
select count(*) f2d from fft_to_dac;
select count(*) d2o from reachable_from_dac;

---

with recursive found(f, t, r) as (
    select * from svr_to_fft where f='svr'
union all
    select e.f, e.t
    from svr_to_fft e
    join found fr on fr.t = e.f
) select count(*) as s2ff from found where t='fft';

with recursive found(f, t, r) as (
    select * from reachable_from_dac where f='dac'
union all
    select e.f, e.t
    from reachable_from_dac e
    join found fr on fr.t = e.f
) select count(*) as d2of from found where t='out';

create table fd as select * from fft_to_dac;
-- select * from fd o where not exists (select 1 from fd i where i.f = o.t and i.t != 'dac');
delete from fd o where t != 'dac' and not exists (select 1 from fd i where i.f = o.t);
delete from fd o where t != 'dac' and not exists (select 1 from fd i where i.f = o.t);
delete from fd o where t != 'dac' and not exists (select 1 from fd i where i.f = o.t);
delete from fd o where t != 'dac' and not exists (select 1 from fd i where i.f = o.t);
delete from fd o where t != 'dac' and not exists (select 1 from fd i where i.f = o.t);
delete from fd o where t != 'dac' and not exists (select 1 from fd i where i.f = o.t);

with recursive found(f, t, r) as (
    select * from fd where f='fft'
    union all
    select e.f, e.t
    from fd e
             join found fr on fr.t = e.f
) select count(*) f2df from found where t='dac';

-- s2ff*f2df*d2of
