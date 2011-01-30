invasion=# insert into station values (666, 'Hell0', 'samsmart');
invasion=# insert into location ( typeid, station, level, x, y) select 0, 666, level, x, y from location where station=0;

