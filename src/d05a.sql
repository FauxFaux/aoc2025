create table parts as
    select n, elem
    from unnest(string_to_array(
            (select content from read_text('d05.txt')), E'\n\n')) with ordinality a(elem, n);

create table ranges as
    select a[1]::bigint as start, a[2]::bigint as stop from (
        select regexp_split_to_array(elem, '-') a
            from unnest(string_to_array((select elem from parts where n=1), E'\n')) a(elem)) t;

create table available as
    select elem::bigint as id
            from unnest(string_to_array((select elem from parts where n=2), E'\n')) a(elem);

create table fresh as select id, exists (select 1 from ranges where id >= start and id <= stop) as fresh from available;

select count(*) from fresh where fresh = true;
