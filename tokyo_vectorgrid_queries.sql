--These are the queries used on our vector grid exported from QGIS
--Mainly to add the numstore variable in order to show the total stores in each grid square

select * from tokyo_grid_1km

alter table tokyo_grid_1km drop column if exists numstore;
alter table tokyo_grid_1km add column numstore integer default 0.0;

select count(*) from tokyo_grid_1km

begin;

delete from tokyo_grid_1km
where id not in (
	select tg.ogc_fid 
	from tokyo_districts as td, tokyo_grid_1km as tg
	where st_intersects(st_transform(td.wkb_geometry,3095), tg.wkb_geometry)
)

commit;
rollback;

begin;

with storequery as (
	select tg.ogc_fid, count(*) as numstore
	from tokyo_konbini as tb, tokyo_grid_1km as tg
	where st_contains(tg.wkb_geometry,tb.wkb_geometry)
	group by tg.ogc_fid
)
update tokyo_grid_1km
set numstore = storequery.numstore
from storequery
where tokyo_grid_1km.ogc_fid = storequery.ogc_fid;

select * from tokyo_grid_1km
order by numstore desc;

commit;
rollback;