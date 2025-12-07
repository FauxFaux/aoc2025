create table splits as
    select l, (
        select array_agg(case v when '.' then 0::bigint else 1 end)
        from unnest(regexp_split_to_array(trim(elem), '')) u(v)
        ) arr
        from unnest(string_to_array(
            (select content from read_text('d07.txt')), E'\n')) with ordinality a(elem, l)
    where elem <> '';

create macro r(a) as (select arr from splits s where s.l=a);

update splits set arr = r(1) where l=2;
create macro s(i, v) as coalesce((select r(i-1)[v]), 0);

create macro c(i) as (
       select array_agg((1-s(i,v))*(r(i-2)[v]
           +coalesce(s(i, v-1)*r(i-2)[v-1], 0)
           +coalesce(s(i, v+1)*r(i-2)[v+1], 0)))
       from generate_series(1, 142) g(v));

update splits set arr=c(4) where l=4;
update splits set arr=c(6) where l=6;
update splits set arr=c(8) where l=8;
update splits set arr=c(10) where l=10;
update splits set arr=c(12) where l=12;
update splits set arr=c(14) where l=14;
update splits set arr=c(16) where l=16;
update splits set arr=c(18) where l=18;
update splits set arr=c(20) where l=20;
update splits set arr=c(22) where l=22;
update splits set arr=c(24) where l=24;
update splits set arr=c(26) where l=26;
update splits set arr=c(28) where l=28;
update splits set arr=c(30) where l=30;
update splits set arr=c(32) where l=32;
update splits set arr=c(34) where l=34;
update splits set arr=c(36) where l=36;
update splits set arr=c(38) where l=38;
update splits set arr=c(40) where l=40;
update splits set arr=c(42) where l=42;
update splits set arr=c(44) where l=44;
update splits set arr=c(46) where l=46;
update splits set arr=c(48) where l=48;
update splits set arr=c(50) where l=50;
update splits set arr=c(52) where l=52;
update splits set arr=c(54) where l=54;
update splits set arr=c(56) where l=56;
update splits set arr=c(58) where l=58;
update splits set arr=c(60) where l=60;
update splits set arr=c(62) where l=62;
update splits set arr=c(64) where l=64;
update splits set arr=c(66) where l=66;
update splits set arr=c(68) where l=68;
update splits set arr=c(70) where l=70;
update splits set arr=c(72) where l=72;
update splits set arr=c(74) where l=74;
update splits set arr=c(76) where l=76;
update splits set arr=c(78) where l=78;
update splits set arr=c(80) where l=80;
update splits set arr=c(82) where l=82;
update splits set arr=c(84) where l=84;
update splits set arr=c(86) where l=86;
update splits set arr=c(88) where l=88;
update splits set arr=c(90) where l=90;
update splits set arr=c(92) where l=92;
update splits set arr=c(94) where l=94;
update splits set arr=c(96) where l=96;
update splits set arr=c(98) where l=98;
update splits set arr=c(100) where l=100;
update splits set arr=c(102) where l=102;
update splits set arr=c(104) where l=104;
update splits set arr=c(106) where l=106;
update splits set arr=c(108) where l=108;
update splits set arr=c(110) where l=110;
update splits set arr=c(112) where l=112;
update splits set arr=c(114) where l=114;
update splits set arr=c(116) where l=116;
update splits set arr=c(118) where l=118;
update splits set arr=c(120) where l=120;
update splits set arr=c(122) where l=122;
update splits set arr=c(124) where l=124;
update splits set arr=c(126) where l=126;
update splits set arr=c(128) where l=128;
update splits set arr=c(130) where l=130;
update splits set arr=c(132) where l=132;
update splits set arr=c(134) where l=134;
update splits set arr=c(136) where l=136;
update splits set arr=c(138) where l=138;
update splits set arr=c(140) where l=140;
update splits set arr=c(142) where l=142;

.maxrows 1000
.maxwidth 10000
-- select * from splits order by l;

select array_reduce(r(142), lambda x, y: coalesce(x,0)+coalesce(y,0)) as ans;
