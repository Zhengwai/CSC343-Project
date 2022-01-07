drop table if exists all_data CASCADE;
create table all_data (id varchar(255),
name varchar(255),
englishName varchar(255),
isPlanet varchar(255),
semimajorAxis varchar(255),
perihelion varchar(255),
aphelion varchar(255),
eccentricity varchar(255),
inclination varchar(255),
massValue varchar(255),
massExponent varchar(255),
volValue varchar(255),
volExponent varchar(255),
density varchar(255),
gravity varchar(255),
escape varchar(255),
meanRadius varchar(255),
equaRadius varchar(255),
polarRadius varchar(255),
flattening varchar(255),
dimension varchar(255),
sideralOrbit varchar(255),
sideralRotation varchar(255),
aroundPlanet varchar(255),
discoveredBy varchar(255),
discoveryDate varchar(255),
alternativeName varchar(255),
axialTilt varchar(255),
avgTemp varchar(255),
mainAnomaly varchar(255),
argPeriapsis varchar(255),
longAscNode varchar(255));
\copy all_data from alldata.csv with csv
delete from all_data where name='name';
drop table if exists tempast cascade;
create table tempast(aid serial, name text);
insert into tempast(name)
select distinct discoveredby from all_data where discoveredby!='';
insert into astronomer
select aid, name, null as nationality from tempast;
drop table if exists nicedata cascade;
create table nicedata(bid text, name text, mass float, volume float, escape_speed float, gravity float,perihelion float, aphelion float, eccentricity float, isplanet text, aroundplanet text);
insert into nicedata
select id, englishname, cast(massvalue as float)*power(10, cast(massexponent as int)), cast(volvalue as float)*power(10, cast(volexponent as int)), cast(escape as float), cast(gravity as float), cast(perihelion as float), cast(aphelion as float), cast(eccentricity as float), isplanet, aroundplanet
from all_data;
insert into planet
select bid, name, 'dwarf', mass, volume, escape_speed, gravity
from nicedata
where isplanet='TRUE' and mass<power(10,23);
insert into planet
select bid, name, 'full', mass, volume, escape_speed, gravity
from nicedata
where isplanet='TRUE' and mass>power(10,23);
insert into smallermoon
select bid, name
from nicedata
where isplanet='FALSE' and aroundplanet!='null' and mass=0 and volume=0;
insert into smallmoon
select bid, name, mass
from nicedata
where isplanet='FALSE' and aroundplanet!='null' and mass!=0 and volume=0;
insert into largemoon
select bid, name, mass, volume, escape_speed, gravity
from nicedata
where isplanet='FALSE' and aroundplanet!='null' and mass!=0 and volume!=0;
insert into asteroid
select bid, name, mass
from nicedata
where isplanet='FALSE' and aroundplanet='null';
insert into orbit
select bid, 'sun', perihelion, aphelion, eccentricity
from nicedata
where isplanet='TRUE';
insert into orbit
select bid, aroundplanet, perihelion, aphelion, eccentricity
from nicedata
where isplanet='FALSE' and aroundplanet!='null';
insert into discovered
select id, aid, to_date(discoverydate, 'dd/mm/yyyy')
from astronomer join all_data on astronomer.name=all_data.discoveredby
where discoverydate!='' and discoverydate!='2003' and discoverydate!='2004' and substring(discoverydate,1,2)!='??';
insert into discovered
select id, aid, to_date(substring(discoverydate,4,7), 'mm/yyyy')
from astronomer join all_data on astronomer.name=all_data.discoveredby
where substring(discoverydate,1,2)='??';
insert into discovered
select id, aid, to_date(discoverydate, 'yyyy')
from astronomer join all_data on astronomer.name=all_data.discoveredby
where discoverydate='2003' or discoverydate='2004';
drop table nicedata cascade;
drop table tempast cascade;
drop table all_data cascade;
