create table ranges as
    select a[1]::bigint as start, a[2]::bigint stop from (
        select regexp_split_to_array(elem, '-') a
            from unnest(string_to_array(
                (select content from read_text('d02.txt')), ',')) a(elem)) t;
-- select * from ranges;

-- select regexp_matches(v::varchar, '(.)\1')v from generate_series(11, 22) a(v);

-- select substr('1010', v, 2) from generate_series(1, length('1010') - 1) gs(v);

-- oh right, it's the full id (so far)


select sum(v) from (
    select (
        with d as (select v::varchar v, length(v::varchar) vl, (length(v::varchar) / 2)::bigint half
           from generate_series(start, stop) a(v) where length(v::varchar) % 2 = 0)
        select sum(v::bigint) from d where substr(v, 1, half) = substr(v, half + 1)
  ) v from ranges) q;
