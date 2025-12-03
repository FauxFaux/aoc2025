create table raw as
    select regexp_split_to_array(elem, '') bank
        from unnest(string_to_array(
            (select content from read_text('d03.txt')), E'\n')) a(elem);

select sum(best::bigint) from (
  select bank,
    (select max(pair)
        from (select
                (bank[n] ||
                 (select max(i)
                    from unnest(bank[n+1:array_length(bank)]) u(i))
                ) as pair
               from generate_series(1, array_length(bank) - 1) gs(n))
            pairs
        ) best
    from raw) by_bank;
