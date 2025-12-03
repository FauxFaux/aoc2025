-- noinspection SqlDerivedTableAliasForFile

create table raw as
select regexp_split_to_array(elem, '') bank
from unnest(string_to_array(
        (select content from read_text('d03.txt')), E'\n')) a(elem);

create macro un(bank) as table select nr from unnest(bank) with ordinality u(i, nr) order by i desc, nr limit 1;

select sum((bank[a] || bank[b] || bank[c] || bank[d] || bank[e] || bank[f] || bank[g] || bank[h] || bank[i] || bank[j] || bank[k] || bank[l])::bigint) as best from (
select *, (select k+nr from un(bank[k+1 : -1])) l from (
select *, (select j+nr from un(bank[j+1 : -2])) k from (
select *, (select i+nr from un(bank[i+1 : -3])) j from (
select *, (select h+nr from un(bank[h+1 : -4])) i from (
select *, (select g+nr from un(bank[g+1 : -5])) h from (
select *, (select f+nr from un(bank[f+1 : -6])) g from (
select *, (select e+nr from un(bank[e+1 : -7])) f from (
select *, (select d+nr from un(bank[d+1 : -8])) e from (
select *, (select c+nr from un(bank[c+1 : -9])) d from (
select *, (select b+nr from un(bank[b+1 :-10])) c from (
select *, (select a+nr from un(bank[a+1 :-11])) b from (
select *, (select   nr from un(bank[    :-12])) a from raw
))))))))))));
