create table critterclass (
    id identity,
    class_name varchar(255)
);
insert into critterclass (class_name) values ('invasion.pets.Dalek');
create table broodtype (
    id integer,
    type varchar(32)
);
alter table broodtype add constraint broodtype_pkey primary key (id);
insert into broodtype values (128, 'Player Controlled');
insert into broodtype values (129, 'Feral Psion');
insert into broodtype values (130, 'Feral Mutate');
insert into broodtype values (131, 'Invading');
create table brood (
    id identity,
    char_owner integer,
    pet_owner integer,
    location integer,
    type integer references broodtype (id),
    goal_survive integer,
    goal_protect integer,
    goal_kill_psi integer,
    goal_kill_mutate integer,
    goal_kill_human integer
);
create table critters (
    id identity,
    type integer references critterclass (id),
    name varchar (255),
    brood integer references brood (id),
    ap integer,
    hp integer,
    armor integer,
    shield integer,
    last_injured_by integer
);
alter table brood add constraint critterowner foreign key (pet_owner) references critters (id);
