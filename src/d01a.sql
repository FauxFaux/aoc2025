create table raw as
    select nr, elem as txt
    from unnest(string_to_array(
            (select content from read_text('d01.txt')), E'\n'))
        with ordinality a(elem, nr);
create table num as
    select nr, (replace(replace(txt, 'R', '+'), 'L', '-')::int) as v
    from raw where txt != '';
create table spin as
    select gn, mod(1000000000050+
                   (select sum(v) from num where nr <= gn), 100) curr
    from generate_series(1, (select count(*) from num)) as gs(gn);
select count(*) from spin where curr = 0;
