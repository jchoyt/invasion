-- script for database changes to support crafting
-- started 2011-05-27
-- finished 2011-07-18

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
insert into modType (effect, amount, type, fault) values ( 'backfire', 0.05, 'p', true );  --amount is % of remaining ammo
insert into modType (effect, amount, type, fault) values ( 'backfire', 0.1, 'p', true );
insert into modType (effect, amount, type, fault) values ( 'backfire', 0.25, 'p', true );
insert into modType (effect, amount, type, fault) values ( 'weight change', 1, 'b', true );
insert into modType (effect, amount, type, fault) values ( 'weight change', 2, 'b', true );


--enhancements
insert into modType (effect, amount, type, fault) values ( 'fire damage', 5, 'e', false );
insert into modType (effect, amount, type, fault) values ( 'acid damage', 5, 'e', false );
insert into modType (effect, amount, type, fault) values ( 'electrical damage', 5, 'e', false );
insert into modType (effect, amount, type, fault) values ( 'weight change', 1, 'b', false );


create table itemmod (
    id serial,
    itemid int references item (itemid),
    type int references modtype (id)
);


alter table item drop column capacitymod;

/*

add items for repairs remove crafting?

regular

typa A circuit boards
type A processing unit
typa B circuit boards
type B processing unit
typa C circuit boards
type C processing unit
wire
chunk of steel
carbon nanotube XXXXXXXXXXXXx
carbon-based lubricant
a roll of pleather
a sheet of plastic
bulk plastic
metal pipe
chunk of brass
chunk of titanium
crystal array
memory crystal


exotic

bioXXXXXXXXXXx
small bottle of acid
small bottle of poison <- use something else
small general purpose medicine pack  <- heals poison
sleeping pills
LSD
small canister of nerve toxin
pack of hypodermic darts

*/

/*
Effects at repair time
	explode
	machinery jams, harming you
*/
