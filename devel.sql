update alt set ap = ap + 1 where ap < apmax;
update alt set ip = ip -1 where ip > 0 AND id!=4;

insert into messages (message, type, altid) select 'Your wounds are so grevious even breathing causes more damage', 4, id from alt where hp < 11 and hp > 0; update alt set hp = hp - 1 where hp < 11 and hp > 0 

--if just died, put body at a random cloning facility
update alt a set location = (select id from location l where typeid=31 and a.station=l.station order by random() limit 1), ticksalive=-1*level where ticksalive=-2147483648;  
update alt set ticksalive = ticksalive + 1 where ticksalive != 0;

update alt set ticksalive= -1 where id=8;

alter table alt add column ticksalive int default 1;

update alt set ticksalive= -2147483648, location=-1 where id=8;
update alt set hp=10 where id=2;

delete from location where station=1337;

select * from location limit 5;

select distinct station from location;

select max(x), max(y) from location where station=0;

insert into messages (message, type, altid) select 'There will be random smitings as I start to work out attacking, death, respawn, etc.  Don''t take it personally.  I hate you all evenly.  <3  Invasion', 4, id from alt;


CREATE RULE alt_clear_injurer AS ON UPDATE TO alt
    WHERE NEW.hp <> OLD.hp and NEW.hp = NEW.hpmax
    DO INSTEAD update alt set 
        hp = new.hp,
        lasthurtby = null
    WHERE id = OLD.id;

drop rule alt_clear_injurer on alt;

select * from stats limit 10;

update stats set count = count + 1 where statid = 4 and altid in (select id from alt where hp < 11 and hp > 0); 

select * from alt;

select * from stats where statid=4;


--join is screwing somethin up

select
    a.id,
    a.name as alt,
    a.level,
    ap || '/' || apmax as apset,
    ip,
    hp || '/' || hpmax as hpset,
    'L' || l.level || ' (' || x || ',' || y || ')' as loc,
    ticksalive
from alt a join location l on
(
   a.location=l.id
)
join station s on (s.id=l.station)
    where username='Purveyor'
    order by a.name

select * from station where id < 0;

select * from location where id < 0;

select * from alt;

update alt set location = -57005 where location is null;

update alt set station=0 where station is null;