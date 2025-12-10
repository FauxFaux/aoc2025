create table machines as
    select nr,
        apply(regexp_split_to_array(
            regexp_extract(elem, '\] (.*) \{', 1), ' '),
            lambda x: apply(regexp_split_to_array(
                        regexp_replace(x, '[()]', '', 'g'),
                    ','),
                    lambda y: y::int)) button,
        apply(regexp_split_to_array(
                regexp_extract(elem, '\{(.*)\}', 1), ','),
            lambda x: x::int) as target
        from unnest(string_to_array(
            (select content from read_text('d10.txt')), E'\n'))
            with ordinality a(elem, nr);

-- select *, (select b from unnest(button) u(b) order by length(b) desc, b limit 1) long from machines o;
-- select count(*),length(target) from machines group by 2 order by 1;

create table b0 as select * from machines where nr=3;

create table max_presses as
    select nr,bi,
        reduce(array_filter(target, lambda x,n: (n-1) in button[bi]),
            lambda a,b: least(a,b)) max_presses
    from b0,
        generate_series(1, length(button)) gs(bi) order by nr,bi;

create table by_target as
    select nr,ti,array_agg(bi) parts,any_value(target)[ti] eq, length(any_value(button)) as btns
    from b0,
         generate_series(1, length(button)) gs(bi),
         generate_series(1, length(target)) gs2(ti)
    where ((ti-1) in button[bi]) group by 1,2 order by 1,2;

select * from max_presses;
select * from by_target;

select min(lenc) from (
select *,reduce(guess,lambda a,b: a+b) lenc from (
select count(distinct ti) c, guess, any_value(btns) btns from (
select ti,[x1,x2,x3,x4,x5,x6] guess, btns,
       reduce(parts, lambda acc, i: acc+[x1,x2,x3,x4,x5,x6][i], 0) summed, eq
from
    by_target,
    generate_series(0, (select max_presses from max_presses where bi=1)) gs(x1),
    generate_series(0, coalesce((select max_presses from max_presses where bi=2), 0)) gs(x2),
    generate_series(0, coalesce((select max_presses from max_presses where bi=3), 0)) gs(x3),
    generate_series(0, coalesce((select max_presses from max_presses where bi=4), 0)) gs(x4),
    generate_series(0, coalesce((select max_presses from max_presses where bi=5), 0)) gs(x5),
    generate_series(0, coalesce((select max_presses from max_presses where bi=6), 0)) gs(x6),
where summed=eq) q group by guess) where c=(select count(*) from by_target)
    );
