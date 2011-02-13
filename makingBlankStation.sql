invasion=# insert into station values (666, 'Hell0', 'samsmart');
invasion=# insert into location ( typeid, station, level, x, y) select 0, 666, level, x, y from location where station=0;


--adding a new level
invasion=# insert into station values (2228, 'Fomalhaut1', 'CyAdora');
invasion=# insert into location ( typeid, station, level, x, y) select 0, 2228, -1, x, y from location where station=0;

invasion=# update location set typeid=9 where (x,y) in ( select x, y from location where station=2229 and typeid=9) and station = 2228;
invasion=# update location set typeid=10 where (x,y) in ( select x, y from location where station=2229 and typeid=10) and station = 2228;

