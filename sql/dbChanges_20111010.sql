-- Load language
CREATE LANGUAGE plpgsql;

-- Create function to delete effects when a char dies
CREATE FUNCTION clearEffectsOnDeath() RETURNS trigger AS '
BEGIN
IF NEW.location=-57005 THEN
    DELETE FROM effects WHERE altid=NEW.id;
END IF;
RETURN NEW;
END;
' LANGUAGE plpgsql;

-- Create trigger
CREATE TRIGGER clearEffectsOnDeath AFTER UPDATE ON alt
  FOR EACH ROW EXECUTE PROCEDURE clearEffectsOnDeath();

insert into location (id, station, message, messagetype) values (-1337, -57005, 'You see bits of your flesh floating around you', 'chalk');

-- ~~~~above here done on prod already ~~~~~~

drop table playermessages;

-- fill out the faction table
alter table faction rename to factions;
alter table factions add column shloc integer default -1;
alter table factions add column level integer default 0;
alter table factions add column type integer default 1;
alter table factions add column prestige integer default 0;
alter table factions add column ammenities bigint default 0;
alter table factions add column open boolean default true;
alter table factions add column station integer not null;
alter table factions add column cansetsh bigint default 0;

ALTER TABLE ONLY factions ADD CONSTRAINT factions_shloc_fkey FOREIGN KEY (shloc) REFERENCES location(id);

SELECT pg_catalog.setval('faction_id_seq', 2000001, true);

-- MOD ALT
alter table alt add column factionrank integer default -1;

-- fill out location for hacking
alter table location add column hackamount integer default 0;
alter table location add column hackedby integer default 0;  --note this can be a faction or a character

-- captured flags
create table flagscaptured (
    holder integer,
    owner integer
);

alter table only flagscaptured add constraint captured_holder_fkey foreign key (holder) references factions(id);
alter table only flagscaptured add constraint captured_owner_fkey foreign key (owner) references factions(id);

-- faction politics
create table politics (
    setter int,
    target int,
    setting int
);

alter table only politics add constraint politics_target_fkey foreign key (target) references factions(id);
alter table only politics add constraint politics_setter_fkey foreign key (setter) references factions(id);

-- faction invites
create table factioninvites (
    inviter int,
    invitee int,
    faction int,
    message text,
    issued timestamp not null default now()
);

alter table only factioninvites add constraint invites_inviter_fkey foreign key (inviter) references alt(id);
alter table only factioninvites add constraint invites_invitee_fkey foreign key (invitee) references alt(id);
alter table only factioninvites add constraint invites_faction_fkey foreign key (faction) references factions(id);


-- Prevent issues with unregistered locations
alter table alt add constraint location_fkey foreign key (location) references location (id);

-- add faction descriptions and creator
alter table factions add column description text;
alter table factions add column createdby integer;

--add location for "no stronghold"
insert into location (id, message) values (-1, 'No stronghold here!');

-- Set faction id -1 to mean no faction - need this to make code for quitting a faction easier
alter table alt alter factionid set default -1;
insert into factions (id,name, station) values (-1,'Unfactioned',-1);
update alt set factionid=-1 where factionid is null;

-- add create date for factions and characters
alter table factions add column createdate timestamp not null default now();
alter table alt add column createdate timestamp not null default now();

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



