--This file contains the queries used to add the NumStores and Density variables to our tokyo_districts table
--These variables list the total number of stores in each district and the density per km/sq

select ogc_fid, name, numstores 
from tokyo_districts
order by numstores desc;

--here we want to 
alter table tokyo_districts add column numstores integer default 0;

--we write a spatial join aggeragate query to count the total stores in each ward
select td.ogc_fid, count(*) as NumStores
from tokyo_districts as td, tokyo_konbini as tc
where (	st_contains(td.wkb_geometry, tc.wkb_geometry))
group by td.ogc_fid
order by ogc_fid asc;

begin;
with storequery as (
	select td.ogc_fid, count(*) as NumStores
	from tokyo_districts as td, tokyo_konbini as tc
	where (	st_contains(td.wkb_geometry, tc.wkb_geometry))
	group by td.ogc_fid
)
update tokyo_districts
set numstores = storequery.numstores
from storequery
where tokyo_districts.ogc_fid = storequery.ogc_fid;

commit;
rollback;

--We do something similar to calculate the store density
alter table tokyo_districts add column density integer default 0;
select * from tokyo_districts;

begin;

with densityquery as (
	select ogc_fid, st_area(st_transform(wkb_geometry,3095))/1000000 as area, 
	numstores, numstores/(st_area(st_transform(wkb_geometry,3095))/1000000) as density
	from tokyo_districts
	order by density desc
)
update tokyo_districts
set density = densityquery.density
from densityquery
where tokyo_districts.ogc_fid = densityquery.ogc_fid;

commit;
rollback;