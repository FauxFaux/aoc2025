create table file as
    select n, elem
    from unnest(string_to_array(
        (select content from read_text('d12t.txt')), E'\n\n'))
            with ordinality a(elem, n);

create table raw_shapes as
    select n-1 n,
           apply(string_to_array(regexp_replace(elem, '^\d+:\n', ''), E'\n'),
                 lambda x: replace(replace(x, '#', '1'), '.', '0')
           ) elem
        from file where n < (select max(n) from file);

create table puzzles as
    select n,
        apply(string_to_array(split_part(elem, ': ', 1), 'x'), lambda x: x::int64) dims,
        apply(string_to_array(split_part(elem, ': ', 2), ' '), lambda x: x::int64) list
        from unnest(string_to_array(
            (select elem from file where n = (select max(n) from file)),
            E'\n')) with ordinality a(elem, n);

-- vibed indexes
create macro ex(x) as table
    select x
    union
    -- vertical flip
    select array[x[3], x[2], x[1]]
    union
    -- horizontal flip
    select array[x[1][3] || x[1][2] || x[1][1],
                 x[2][3] || x[2][2] || x[2][1],
                 x[3][3] || x[3][2] || x[3][1]]
    union
    -- rotate right
    select array[
        x[3][1] || x[2][1] || x[1][1],
        x[3][2] || x[2][2] || x[1][2],
        x[3][3] || x[2][3] || x[1][3]]
    union
    -- rotate 180
    select array[
        x[3][3] || x[3][2] || x[3][1],
        x[2][3] || x[2][2] || x[2][1],
        x[1][3] || x[1][2] || x[1][1]]
    union
    -- rotate left
    select array[
        x[1][3] || x[2][3] || x[3][3],
        x[1][2] || x[2][2] || x[3][2],
        x[1][1] || x[2][1] || x[3][1]]
;

create table shapes as (
    select n,
           array_agg(bam) shapes
    from (
        select
            distinct n,
            apply(bam, lambda x: x::bitstring) bam
        from raw_shapes, ex(elem) s(bam)
    ) t group by n order by n);

select * from shapes;
select *, pow(6, list_sum(list))::int64 p from puzzles;

-- horrific? generate_series outputting either (empty set) or (lots of zeros and ones) is quite annoying
create macro lv_series(lv, i) as table
    select filter(split(
        case n when -1 then ''
            else to_base(n, (select length(shapes) from shapes where n=i-1)::int, lv[i]) end,
        ''), lambda x: x <> '')::int64[] as arr
    from generate_series(
        case lv[i] when 0 then -1 else 0 end,
        case lv[i] when 0 then -1 else pow((select length(shapes) from shapes where n=i-1), lv[i])::int64 - 1 end
    ) g(n);

create macro ls(lv) as table
    select a,b,c,d,e,f from
         lv_series(lv, 1) g(a),
         lv_series(lv, 2) g(b),
         lv_series(lv, 3) g(c),
         lv_series(lv, 4) g(d),
         lv_series(lv, 5) g(e),
         lv_series(lv, 6) g(f),
    ;

select * from shapes;

create macro exs(v, i) as (select array_agg(shapes[vi+1]) from unnest(v) u(vi) join shapes on (n=i));

select list_concat(
    exs(a, 0),
    exs(b, 1),
    exs(c, 2),
    exs(d, 3),
    exs(e, 4),
    exs(f, 5))
from ls(array[0,0,0,0,2,0]);
