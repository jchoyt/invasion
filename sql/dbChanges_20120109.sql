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

