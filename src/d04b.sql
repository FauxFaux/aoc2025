create table raw as
    select l, regexp_split_to_array(elem, '') bank
        from unnest(string_to_array(
            (select content from read_text('d04.txt')), E'\n')) with ordinality a(elem, l)
        where elem <> '';

create table papers as
select l, c from raw, unnest(bank) with ordinality u(v, c) where v='@' order by l,c ;

create macro e(tl, tc) as coalesce((select 1 from papers p where p.l = tl and p.c = tc limit 1), 0);

create table rm as     select l,c
                       from (
                                select l,c,
                                       e(l  , c+1) + e(l  , c-1)
                                           + e(l+1, c  ) + e(l-1, c  )
                                           + e(l+1, c+1) + e(l+1, c-1)
                                           + e(l-1, c+1) + e(l-1, c-1) as cnt
                                from papers
                                where cnt < 4
                            ) buggy_nesting;

.changes on
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);

select * from rm;


insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);

select * from rm;

insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
insert into rm select l,c from (
                                   with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
                                   select l,c, (
                                       + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
                                           + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
                                       ) cnt
                                   from curr f
                                   where cnt < 4) f
where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c);
select * from rm;

-- WITH RECURSIVE rm(l, c) AS (
--     select l,c
--     from (
--         select l,c,
--                e(l  , c+1) + e(l  , c-1)
--              + e(l+1, c  ) + e(l-1, c  )
--              + e(l+1, c+1) + e(l+1, c-1)
--              + e(l-1, c+1) + e(l-1, c-1) as cnt
--         from papers
--         where cnt < 4
--     ) buggy_nesting
--     UNION
--     select l,c from (
--         with curr as (select * from papers c where not exists (select 1 from rm where rm.l=c.l and rm.c=c.c))
--         select l,c, (
--             + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c   limit 1), 0)
--             + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c   limit 1), 0)
--             + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c+1 limit 1), 0)
--             + coalesce((select 1 from curr c where c.l=f.l   and c.c=f.c-1 limit 1), 0)
--             + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c-1 limit 1), 0)
--             + coalesce((select 1 from curr c where c.l=f.l-1 and c.c=f.c+1 limit 1), 0)
--             + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c-1 limit 1), 0)
--             + coalesce((select 1 from curr c where c.l=f.l+1 and c.c=f.c+1 limit 1), 0)
--         ) cnt
--         from curr f
--         where cnt < 4 order by l,c) f
--     where not exists (select 1 from rm where f.l=rm.l and f.c=rm.c))
-- SELECT l,c FROM rm;
