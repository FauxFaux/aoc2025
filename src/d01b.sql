create table raw as
    select nr, elem as txt
    from unnest(string_to_array(
            (select content from read_text('d01t.txt')), E'\n'))
        with ordinality a(elem, nr);
create table num as
    select nr, (replace(replace(txt, 'R', '+'), 'L', '-')::int) as v
    from raw where txt != '';
insert into num values (0, 50);
create table spin as
    select gn, mod(100+mod(
                   (select sum(v) from num where nr <= gn), 100), 100) curr
    from generate_series(0, (select count(*) from num) - 1) as gs(gn);

create table passed as
    select spin.*, num.v, curr+v,
            (curr != 0 and (curr+v < 0 or curr+v > 100)) pass
    from spin left join num on spin.gn + 1 = num.nr;

select * from passed where pass or curr = 0;

-- 2385 to low
