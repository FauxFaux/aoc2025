create table raw as
    select l, c, v from (
    select l, regexp_split_to_array(elem, '') arr
        from unnest(array_reverse(string_to_array(
            (select content from read_text('d06.txt')), E'\n'))) with ordinality a(elem, l)
    where elem <> '') t, unnest(arr) with ordinality u(v, c);

create table colns as
    select c, ('0' || trim(string_agg(v,'' order by l desc)))::bigint v
    from raw where l > 1 group by c;

create table endcs as
    select row_number() over (order by c) id, c from (
        select (c-1) c
            from raw where l=1 and v != ' '
            except (select 1) union all (select 99999999999)
        ) g
        order by c;

create table ranges as
    select o.c as start, (select c from endcs i where i.id = o.id+1) stop
    from endcs o where stop;

create table debug as
    select start,array_agg(v) arr, (select v from raw where c=start+1 and l=1) as op
    from
       ranges, colns where c > start and c<stop group by start order by start;

select sum(result) from (
    select case op
        when '+' then (select sum(v) from unnest(arr) u(v))
        else          (select product(v)::bigint from unnest(arr) u(v))
        end as result
    from debug) by_row;
