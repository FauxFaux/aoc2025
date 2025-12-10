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
            (select content from read_text('d10t.txt')), E'\n'))
            with ordinality a(elem, nr);

-- select *, (select b from unnest(button) u(b) order by length(b) desc, b limit 1) long from machines o;

-- create table b1 as (
--     with with_max as (select nr, button, target,
--            reduce(array_filter(target, lambda x,n: n in button[1]),
--                   lambda a,b: least(a,b)) max_presses
--     from machines)
--     select nr, i as pushes, button[2:] button, apply(target,
--              lambda x,n: x+case n in button[1]
--                      when true then -i else 0 end
--            ) as target
--     from with_max, generate_series(0, max_presses) gs(i)
--     order by nr, i
-- );
create table b1 as ( with with_max as (select nr, button, target, reduce(array_filter(target, lambda x,n: n in button[1]), lambda a,b: least(a,b)) max_presses
from machines where nr=1) select nr, i as pushes, button[2:] button, apply(target, lambda x,n: x+case n in button[1] when true then -i else 0 end ) as target from with_max, generate_series(0, max_presses) gs(i) order by nr, i );

select * from b1;

create table b2 as ( with with_max as (select nr, button, target, reduce(array_filter(target, lambda x,n: n in button[1]), lambda a,b: least(a,b)) max_presses
from b1) select nr, i as pushes, button[2:] button, apply(target, lambda x,n: x+case n in button[1] when true then -i else 0 end ) as target from with_max, generate_series(0, max_presses) gs(i) order by nr, i );

select * from b2;

create table b3 as ( with with_max as (select nr, button, target, reduce(array_filter(target, lambda x,n: n in button[1]), lambda a,b: least(a,b)) max_presses
from b2) select nr, i as pushes, button[2:] button, apply(target, lambda x,n: x+case n in button[1] when true then -i else 0 end ) as target from with_max, generate_series(0, max_presses) gs(i) order by nr, i );

create table b4 as ( with with_max as (select nr, button, target, reduce(array_filter(target, lambda x,n: n in button[1]), lambda a,b: least(a,b)) max_presses
from b3) select nr, i as pushes, button[2:] button, apply(target, lambda x,n: x+case n in button[1] when true then -i else 0 end ) as target from with_max, generate_series(0, max_presses) gs(i) order by nr, i );

create table b5 as ( with with_max as (select nr, button, target, reduce(array_filter(target, lambda x,n: n in button[1]), lambda a,b: least(a,b)) max_presses
from b4) select nr, i as pushes, button[2:] button, apply(target, lambda x,n: x+case n in button[1] when true then -i else 0 end ) as target from with_max, generate_series(0, max_presses) gs(i) order by nr, i );

create table b6 as ( with with_max as (select nr, button, target, reduce(array_filter(target, lambda x,n: n in button[1]), lambda a,b: least(a,b)) max_presses
from b5) select nr, i as pushes, button[2:] button, apply(target, lambda x,n: x+case n in button[1] when true then -i else 0 end ) as target from with_max, generate_series(0, max_presses) gs(i) order by nr, i );



-- select * from b6 order by reduce(target, lambda a,b: a+b) limit 100;
