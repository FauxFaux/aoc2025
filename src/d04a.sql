create table raw as
    select l, regexp_split_to_array(elem, '') bank
        from unnest(string_to_array(
            (select content from read_text('d04t.txt')), E'\n')) with ordinality a(elem, l)
        where elem <> '';

create table papers as
select l, c from raw, unnest(bank) with ordinality u(v, c) where v='@' order by l,c ;

create macro e(tl, tc) as coalesce((select 1 from papers where l = tl and c = tc limit 1), 0);

-- select e(1,3);

select *,
      e(l  , c+1) + e(l  , c-1)
    + e(l+1, c  ) + e(l+1, c  )
    + e(l+1, c+1) + e(l+1, c-1)
    + e(l-1, c+1) + e(l-1, c-1)
    as cnt,
    e(l, c+1) as right,
    c+1,
    (c+1) = 4,
    e(l, 4) as hack,
from papers where l=1;
