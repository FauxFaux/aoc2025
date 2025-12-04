create table raw as
    select l, regexp_split_to_array(elem, '') bank
        from unnest(string_to_array(
            (select content from read_text('d04t.txt')), E'\n')) with ordinality a(elem, l)
        where elem <> '';

create table papers as
select l, c from raw, unnest(bank) with ordinality u(v, c) where v='@' order by l,c ;

create macro e(tl, tc) as coalesce((select 1 from papers p where p.l = tl and p.c = tc limit 1), 0);
create macro ea(tl, tc, a) as coalesce((select 1 from papers p where not row(tl, tc) = any(a) and p.l = tl and p.c = tc limit 1), 0);
create macro grid(tl, tc, a) as (
      ea(tl  , tc+1, a) + ea(tl  , tc-1, a)
    + ea(tl+1, tc  , a) + ea(tl-1, tc  , a)
    + ea(tl+1, tc+1, a) + ea(tl+1, tc-1, a)
    + ea(tl-1, tc+1, a) + ea(tl-1, tc-1, a)
);

-- select array_agg(row(l,c)) from papers;

-- select ea(3,3, (select array_agg(row(l,r)) from values (1,1) v(l,r)));

create table t as select l,c
    from papers where (e(l  , c+1) + e(l  , c-1)
    + e(l+1, c  ) + e(l-1, c  )
    + e(l+1, c+1) + e(l+1, c-1)
    + e(l-1, c+1) + e(l-1, c-1))
       < 4;

select * from t;



-- select array_agg(row(l,c)) from t;

-- select l,c
--     from papers
--     where grid(l, c, (select array_agg(row(l,c)) from t)) < 4;

        --
-- WITH RECURSIVE t(l, c) AS (
--     select l,c
--         from papers where
--           e(l  , c+1) + e(l  , c-1)
--         + e(l+1, c  ) + e(l-1, c  )
--         + e(l+1, c+1) + e(l+1, c-1)
--         + e(l-1, c+1) + e(l-1, c-1) < 4
--     UNION ALL
--         select l,c
--         from papers
--         where grid(l, c, (select array_agg(row(l,c)) from t)) < 4
-- )
-- SELECT l,c FROM t;
