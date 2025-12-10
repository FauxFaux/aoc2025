create table machines_nr as
    select nr,
        replace(replace(
                regexp_extract(elem, '\[(.*)\]', 1),
                '.', '0'), '#', '1')::bitstring as target,
        apply(regexp_split_to_array(
            regexp_extract(elem, '\] (.*) \{', 1), ' '),
            lambda x: apply(regexp_split_to_array(
                        regexp_replace(x, '[()]', '', 'g'),
                    ','),
                    lambda y: y::int)) button
        from unnest(string_to_array(
            (select content from read_text('d10t.txt')), E'\n'))
            with ordinality a(elem, nr);

create table machines as
    select nr, target,
        (select
            array_agg(
                -- such bullshit
                (select left(bitstring_agg(v, 0, 9)::varchar, length(target))::bitstring
                    from unnest(b) u(v)))
         from unnest(button) u(b)
        ) buttons from machines_nr;

select i, right(i::bitstring::varchar, 4),
    array_filter(['a', 'b', 'c', 'd'],
        lambda x, n: (i & (1 << (n-1))))
from generate_series(1, (pow(2, 4)-1)::int) gs(i)
order by bit_count(i), i;

create macro combos(arr) as (
    select array_agg(array_filter(arr,
        lambda x, n: (i & (1 << (n-1)))))
    from generate_series(1, (pow(2, length(arr))-1)::int) as gs(i)
    order by bit_count(i), i
);

select combos(buttons) from machines where nr = 1;
