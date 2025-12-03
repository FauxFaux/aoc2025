create table ranges as
    select a[1]::bigint as start, a[2]::bigint stop from (
        select regexp_split_to_array(elem, '-') a
            from unnest(string_to_array(
                (select content from read_text('d02.txt')), ',')) a(elem)) t;

create macro specials(len, i) as table
    select repeat(n::varchar, (len/i)::int)::bigint
    from generate_series((10^(i-1))::int, (10^i)::int-1) a(n)
    where i < len and len % i = 0;

create macro special_ids(len) as table
    select * from specials(len, 1)
    union all
    select * from specials(len, 2)
    union all
    select * from specials(len, 3)
    union all
    select * from specials(len, 4)
    union all
    select * from specials(len, 5)
    union all
    select * from specials(len, 6)
    union all
    select * from specials(len, 7)
    union all
    select * from specials(len, 8)
    union all
    select * from specials(len, 9)
;


select * from special_ids(10);

-- select * from specials(2, 2);