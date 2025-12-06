create table raw as
    select l, c, v from (
    select l, regexp_split_to_array(trim(elem), ' +') arr
        from unnest(array_reverse(string_to_array(
            (select content from read_text('d06.txt')), E'\n'))) with ordinality a(elem, l)
    where elem <> '') t, unnest(arr) with ordinality u(v, c);

select sum(acc) from (
    select c, case (select v from raw i where l=1 and i.c = o.c)
        when '+' then sum(v::bigint)
        else product(v::bigint)::bigint
        end as acc
    from raw o where l > 1 group by c
 ) debug;
