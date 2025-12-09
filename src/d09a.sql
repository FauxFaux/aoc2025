create table coords as
    select a[1]::bigint x, a[2]::bigint y from (
        select regexp_split_to_array(elem, ',') a
            from unnest(string_to_array(
                (select content from read_text('d09.txt')), E'\n')) a(elem)
                    where elem != '') t;

select *,(1+abs(l.x-r.x))*(1+abs(l.y-r.y)) area
from coords l,coords r order by area desc;
