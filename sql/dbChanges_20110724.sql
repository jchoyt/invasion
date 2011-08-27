create table locker (
    id serial,
    location integer references location(id),
    number integer,
    combination varchar(10),
    owner integer references alt(id),
    lastused timestamp not null default now(),
    open boolean not null default true
);

--change starting sequence to 3M
alter sequence locker_id_seq restart with 3000000;

--new critter for low level guys
insert into crittertype values ( 2, 'Gremlin', 'invasion.pets.Gremlin', 75, 20, 15, 15, -1 );\\

--add statuses
create table effecttype (
    id serial,
    name text
);

insert into effecttype ( name ) values ( 'Drunk' );
insert into effecttype ( name ) values ( 'Blacked Out' );
insert into effecttype ( name ) values ( 'Insane' );
insert into effecttype ( name ) values ( 'Healing' );

create table effects (
    altid integer,
    effectid integer,
    duration integer
);
create index pkey_effects on effects ( altid );

--add drunkenness as a new stat
update statstype set statname='Kills' where statid=9;
update statstype set statname='Deaths' where statid=10;
insert into statstype (statid, statname) values (11,'Drunkenness');
insert into statstype (statid, statname) values (12,'Black outs');

