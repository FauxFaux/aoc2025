create table raw as
    select regexp_split_to_array(elem, '') bank
        from unnest(string_to_array(
            (select content from read_text('d03t.txt')), E'\n')) a(elem);
select array(
    select elem from (select elem, nr from unnest(bank) with ordinality a(elem, nr) order by elem desc limit 2) t order by nr
) from raw;