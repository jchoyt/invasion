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
insert into crittertype values ( 2, 'Gremlin', 'invasion.pets.Gremlin', 75, 20, 15, 15, -1 );
