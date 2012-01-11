-- create the actionlog table
create table actionlog (
    actor integer,
    action integer,
    subject integer,
    ts bigint
);

alter table actionlog add constraint actionlog_pkey primary key (ts);

grant all on table actionlog to webuser;

-- TODO add some way of truncating this to only 5 days of data


-- add help link to skills
alter table skills add column helplink text;

update skills set helplink='http://soulcubes.com/PlayerGuide.html#Firearms' where id=1;
update skills set helplink='http://soulcubes.com/PlayerGuide.html#Melee' where id=18;
update skills set helplink='http://soulcubes.com/PlayerGuide.html#Tinkerer' where id=6;
