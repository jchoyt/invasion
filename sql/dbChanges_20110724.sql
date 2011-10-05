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

update effecttype set id=id-1;

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

alter table effects add constraint altid_fkey foreign key (altid) references alt(id);
alter table effecttype add constraint effecttype_pkey primary key (id);
alter table effects add constraint effectid_fkey foreign key (effectid) references effecttype(id);

insert into skills (name, value, race, prerequisite, cost) values ( 'Melee 1', 131072, 'human', null, 10);
insert into skills (name, value, race, prerequisite, cost) values ( 'Melee 2', 262144, 'human', 18, 20);
insert into skills (name, value, race, prerequisite, cost) values ( 'Melee 3', 524288, 'human', 19, 40);
insert into skills (name, value, race, prerequisite, cost) values ( 'Melee 4', 1048576, 'human', 20, 80);
insert into skills (name, value, race, prerequisite, cost) values ( 'Melee 5', 2097152, 'human', 21, 160);



/* CREATE OR REPLACE FUNCTION update_modified_column()
	RETURNS TRIGGER AS $$
	BEGIN
	   NEW.modified = now();
	   RETURN NEW;
	END;
	$$ language 'plpgsql';

CREATE TRIGGER update_customer_modtime BEFORE UPDATE
    ON customer FOR EACH ROW EXECUTE PROCEDURE
    update_modified_column(); */



