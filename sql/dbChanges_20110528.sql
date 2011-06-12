-- script for database changes to support crafting
-- started 2011-05-27
-- finished 2011-06-XX

create table modType (
    id serial primary key,
    effect text,
    amount float,
    type char(1),
    fault boolean default 'f'
);

--faults
insert into modType (effect, amount, type, fault) values ( 'scale damage', 0.2, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'scale damage', 0.3, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'scale damage', 0.5, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'scale accuracy', 0.2, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'scale accuracy', 0.3, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'scale accuracy', 0.5, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'misfire', 0.1, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'misfire', 0.2, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'misfire', 0.3, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'misfire', 0.5, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'short circuit', 0.05, 'e', true );  --amount is % of remaining charge
insert into modType (effect, amount, type, fault) values ( 'short circuit', 0.1, 'e', true );
insert into modType (effect, amount, type, fault) values ( 'short circuit', 0.25, 'e', true );
insert into modType (effect, amount, type, fault) values ( 'backfire', 0.05, 'e', true );  --amount is % of remaining ammo
insert into modType (effect, amount, type, fault) values ( 'backfire', 0.1, 'e', true );
insert into modType (effect, amount, type, fault) values ( 'backfire', 0.25, 'e', true );



--enhancements
insert into modType (effect, amount, type, fault) values ( 'fire damage', 5, 'e', false );
insert into modType (effect, amount, type, fault) values ( 'acid damage', 5, 'e', false );
insert into modType (effect, amount, type, fault) values ( 'electrical damage', 5, 'e', false );
insert into modType (effect, amount, type, fault) values ( 'decrease weight', 1, 'b', false );


create table itemmod (
    id serial,
    itemid int references item (itemid),
    type int references modtype (id)
);

/*
delete capacitymod from item table

/*
Affects at repair time
	explode
	machinery jams, harming you
*/
