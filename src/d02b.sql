create table ranges as
    select a[1]::bigint as start, a[2]::bigint stop from (
        select regexp_split_to_array(elem, '-') a
            from unnest(string_to_array(
                (select content from read_text('d02.txt')), ',')) a(elem)) t;
-- select * from ranges;

select n, (
         select array_agg(substr('38593859', v, n))
  from generate_series(1, length('38593859'),   n) gs(v))
  from generate_series(1, length('38593859')  - 1) gs(n);

-- select n, (
--     select count(distinct substr('123456789', v, n)) = 1
--   from generate_series(1, length('123456789'),   n) gs(v))
--   from generate_series(1, length('123456789')  - 1) gs(n);


select sum(v) from (
    select (
        with d as (select v::varchar v, length(v::varchar) vl
           from generate_series(start, stop) a(v))
        select sum(v::bigint) from d where (
            select bool_or(b) m from (
                select (
                    select count(distinct substr(v, offst, chunk_size)) = 1
                  from generate_series(1, length(v),       chunk_size) gs(offst)) b
                  from generate_series(1, length(v)  - 1) gs(chunk_size)) d
         )
  ) v from ranges) q;
