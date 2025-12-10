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

create table b0 as select * from machines where nr=28;

-- create table max_presses as
--     select nr,bi,
--         reduce(array_filter(target, lambda x,n: (n-1) in button[bi]),
--             lambda a,b: least(a,b)) max_presses
--     from b0,
--         generate_series(1, length(button)) gs(bi) order by nr,bi;

create table by_target as
    select distinct nr,array_agg(bi order by bi) parts,any_value(target)[ti] eq, length(any_value(button)) as btns
    from b0,
         generate_series(1, length(button)) gs(bi),
         generate_series(1, length(target)) gs2(ti)
    where ((ti-1) in button[bi]) group by 1, ti order by 1,2;

-- create unique index by_target_npe on by_target (nr, parts, eq);

select * from by_target;

insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

select * from by_target order by nr, length(parts), parts;


insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
select count(*) from by_target;

-- insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
-- create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
-- select count(*) from by_target;
--
-- insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
-- create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
-- select count(*) from by_target;
--
-- insert into by_target select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) parts, l.eq-r.eq eq, l.btns from by_target l, by_target r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts order by l.nr;
-- create table t as select distinct * from by_target; drop table by_target; alter table t rename to by_target;
-- select count(*) from by_target;

-- select [[nr], parts] from by_target as l,generate_series(1,10) gs(i)
--     where exists (select 1 from by_target r where l.nr=r.nr and parts=[i])
--       and i in l.parts
--     and nr=1;

select * from by_target order by nr, length(parts), parts;

create table uncons as
    select * from by_target l
        where not exists (select 1 from generate_series(1,10) gs(i)
          where exists (select 1 from by_target r where l.nr=r.nr and parts=[i])
            and i in l.parts);

-- delete from by_target l
--     where exists (select 1 from generate_series(1,10) gs(i)
--         where exists (select 1 from by_target r where l.nr=r.nr and parts=[i])
--           and i in l.parts);
--
select 'to do', l.nr,
       array_filter(l.parts, lambda x: not (x in r.parts))[1] p_from,
       array_filter(r.parts, lambda x: not (x in l.parts))[1] p_to,
       l.eq - r.eq rag,
       reduce(l.parts, lambda acc, x: acc + (case when x in r.parts then -1 else 0 end), length(l.parts)) buggy_pos,
from uncons l, uncons r
where l.nr=r.nr
  and l.eq > r.eq
  and (length(l.parts)=length(r.parts))
  and buggy_pos=1
order by l.parts;

-- nr parts eq btns
-- select * from uncons;

-- select 'start state', * from uncons order by nr, length(parts), parts;
--
insert into uncons
select
    u.nr,
    array_sort(apply(parts, lambda x: case x when p_from then p_to else x end)) parts,
    eq - rag eq,
    btns,
from uncons u,(
select l.nr,
       array_filter(l.parts, lambda x: not (x in r.parts))[1] p_from,
       array_filter(r.parts, lambda x: not (x in l.parts))[1] p_to,
       l.eq - r.eq rag,
       reduce(l.parts, lambda acc, x: acc + (case when x in r.parts then -1 else 0 end), length(l.parts)) buggy_pos,
from uncons l, uncons r
where l.nr=r.nr
--   and l.nr=2
  and l.eq > r.eq
  and (length(l.parts)=length(r.parts))
  and buggy_pos=1
order by l.parts) m
where u.nr=m.nr and m.p_from in u.parts and m.p_to not in u.parts;
--
-- select * from uncons where nr=1 order by nr, length(parts), parts;
--

create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;
-- select 'after', * from uncons order by nr, length(parts), parts;

insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;

insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;

insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;

insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;

insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;

insert into uncons
select
    u.nr,
    array_sort(apply(parts, lambda x: case x when p_from then p_to else x end)) parts,
    eq - rag eq,
    btns,
from uncons u,(
    select l.nr,
           array_filter(l.parts, lambda x: not (x in r.parts))[1] p_from,
           array_filter(r.parts, lambda x: not (x in l.parts))[1] p_to,
           l.eq - r.eq rag,
           reduce(l.parts, lambda acc, x: acc + (case when x in r.parts then -1 else 0 end), length(l.parts)) buggy_pos,
    from uncons l, uncons r
    where l.nr=r.nr
--   and l.nr=2
      and l.eq > r.eq
      and (length(l.parts)=length(r.parts))
      and buggy_pos=1
    order by l.parts) m
where u.nr=m.nr and m.p_from in u.parts and m.p_to not in u.parts;


insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;

insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;

insert into uncons select l.nr, filter(l.parts, lambda x,n: not (x in r.parts)) oparts, l.eq-r.eq eq, l.btns from uncons l, uncons r where l.nr=r.nr and l.parts @> r.parts and l.parts != r.parts and length(oparts) != 0 order by l.nr;
create table t as select distinct * from uncons; drop table uncons; alter table t rename to uncons;


select * from uncons order by nr, length(parts), parts;
select nr, count(distinct n) from uncons, unnest(parts) u(n) group by 1 order by 1;

create table max_presses as
    select nr, p, min(eq) mp
    from uncons,
        unnest(parts) u(p)
group by nr, p
order by nr, p;

select * from max_presses;