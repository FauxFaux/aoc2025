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
           row_number() over (partition by n order by bam) perm,
           bam shape
    from (
        select
            distinct n,
            apply(bam, lambda x: x::bitstring) bam
        from raw_shapes, ex(elem) s(bam)
    ) t order by n, perm);

select * from shapes;
select * from puzzles;