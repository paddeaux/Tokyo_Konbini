--Since out selection of points was not exact we use a simple SQL query to remove any stores outside
--Tokyos borders

delete from tokyo_konbini
where ogc_fid in (
select tk.ogc_fid 
from tokyo_konbini as tk, tokyo_prefecture as tp
where not(st_contains(tp.wkb_geometry, tk.wkb_geometry))
);

select * 
from tokyo_konbini as tk, tokyo_prefecture as tp
where not(st_contains(tp.wkb_geometry, tk.wkb_geometry));


--Our goal is to alter the "brand" column and remove all null values. They will be replaced by the relevant
--brand name (in english) taken from and of the other brand or name columns

--select statement first to check our conditions
select * from tokyo_konbini
where (
	name like '%ローソン%' or
	upper(name) like upper('%Lawson%') or
	upper(name_en) like upper('%Lawson%') or
	name_ja like '%ローソン%'		
);

update tokyo_konbini
set brand = 'Lawson'
where (
	brand ~* '^.*lawson.*$' or
	brand  ~* '^.*ロ.*ソン.*$' or
	name ~* '^.*ロ.*ソン.*$' or
	name ~* '^.*lawson.*$' or
	name_ja ~* '^.*ロ.*ソン.*$'
);

--SevenEleven

--select statement first to check our conditions
select * from tokyo_konbini
where (
	(brand is NULL) and (
		name ~* '^.*セブン.*イレブン.*$' or
		name_ja like '%セブン-イレブン%' or
		upper(name_en) like upper('%Eleven%') or
		upper(name) like upper('%Eleven%')		
	)
);

update tokyo_konbini
set brand = '7-Eleven'
where (
	brand ~* '^.*セブン.*イレブン.*$' or
	brand ~* '^.*eleven.*$' or
	name ~* '^.*セブン.*イレブン.*$' or
	name_ja ~* '^.*セブン.*イレブン.*$' or
	name ~* '^.*eleven.*$' or
	name_en ~* '^.*eleven.*$' or
	name_en ~* '^.*7-11.*$'
);

--Family Mart

select * from tokyo_konbini
where (
	brand is null and (
		name like '%ファミリーマート%' or
		name_ja like '%サンクス%' or
		name ~* '^.*Family.*Mart.*$' or
		name_en ~* '^.*Family.*Mart.*$'
	)
)

update tokyo_konbini
set brand = 'FamilyMart'
where (
	brand ~* '^.*ファミマ.*$' or
	brand ~* '^.*Family.*Mart.*$' or
	brand ~* '^.*ファミリ.*マ.*ト.*$' or
	name ~* '^.*ファミリ.*マ.*ト.*$' or
	name_ja ~* '^.*ファミリ.*マ.*ト$' or
	name ~* '^.*Family.*Mart.*$' or
	name_en ~* '^.*Family.*Mart.*$' or
	name_en ~* '^.*Familly.*Markt.*$'
);

--Mini Stop

select * from tokyo_konbini
where (
	brand is null and (
		name ~* '^.*Mini(\s){0,}Stop.*$' or
		name_en ~* '^.*Mini(\s){0,}Stop.*$' or
		name like '%ミニストップ%' or
		name_ja like '%ミニストップ%'
	)
);

update tokyo_konbini
set brand = 'MiniStop'
where (
	brand ~* '^.*Mini.*Stop.*$' or
	brand ~* '^.*ミニストップ.*$' or
	name ~* '^.*Mini.*Stop.*$' or
	name_en ~* '^.*Mini.*Stop.*$' or
	name ~* '^.*ミニストップ.*$' or
	name_ja ~* '^.*ミニストップ.*$'
);

--Yamazaki

select * from tokyo_konbini
where (
	brand is null and (
		name like '%ヤマザキショップ%' or
		name like '%デイリーヤマザキ%' or
		name_ja like '%ヤマザキショップ%' or
		name_ja like '%デイリーヤマザキ%' or --"Daily Yamazaki"
		name ~* '^.*yamazaki.*$' or
		name_en ~* '^.*yamazaki.*$'
	)
)

update tokyo_konbini
set brand = 'Yamazaki'
where (
	brand ~* '^.*yamazaki.*$' or
	brand ~* '^.*ヤマザキ.*$' or
	name ~* '^.*ヤマザキショップ.*$' or
	name ~* '^.*ヤマザキデイリ.*$' or
	name_ja ~* '^.*デイリ.*ヤマザキ.*$' or
	name ~* '^.*ヤマザキショップ.*$' or
	name_ja ~* '^.*デイリ.*ヤマザキ.*$' or
	name ~* '^.*yamazaki.*$' or
	name_en ~* '^.*yamazaki.*$'
);

--Sunkus

select * from tokyo_konbini
where (
	brand is NULL and (
		name ~* '^.*sunkus.*$' or
		name ~* '^.*サンクス.*$' or
		name_en ~* '^.*sunkus.*$' or
		name_ja ~* '^.*サンクス.*$'
	)
)
order by name_en desc;

update tokyo_konbini
set brand = 'Sunkus'
where (
	name ~* '^.*sunkus.*$' or
	name ~* '^.*サンクス.*$' or
	name_en ~* '^.*sunkus.*$' or
	name_ja ~* '^.*サンクス.*$'
);

--Three F

select ogc_fid, brand, name, name_en, name_ja from tokyo_konbini
where (
	brand is null and (
		name ~* '^.*Three.*F.*$' or
		name ~* '^.*スリ.*エフ.*$' or
		name_ja ~* '^.*スリ.*エフ.*$' or
		name_en ~* '^.*Three.*F.*$'
	)
);

update tokyo_konbini
set brand = 'Three-F'
where (
	name ~* '^.*Three.*F.*$' or
	name ~* '^.*スリ.*エフ.*$' or
	name_ja ~* '^.*スリ.*エフ.*$' or
	name_en ~* '^.*Three.*F.*$'
);

--Circle k
select ogc_fid, brand, name, name_en, name_ja from tokyo_konbini
where (
	brand is null and (
		name ~* '^.*サ.*クルK.*$' or
		name ~* '^.*Circle.*K.*$' or
		name_en ~* '^.*Circle.*K.*$' or
		name_ja ~* '^.*サ.*クルK.*'
	)
);

update tokyo_konbini
set brand = 'Circle K'
where (
	name ~* '^.*サ.*クルK.*$' or
	name ~* '^.*Circle.*K.*$' or
	name_en ~* '^.*Circle.*K.*$' or
	name_ja ~* '^.*サ.*クルK.*'
);

--Poplar
select * from tokyo_konbini
where (
	brand ~* '^.*ポプラ.*$' or
	name ~* '^.*ポプラ.*$' or
	name_ja ~* '^.*ポプラ.*$' or
	name_en ~* '^.*poplar.*$' or
	name ~* '^.*poplar.*$'
);

update tokyo_konbini
set brand = 'Poplar'
where (
	brand ~* '^.*ポプラ.*$' or
	name ~* '^.*ポプラ.*$' or
	name_ja ~* '^.*ポプラ.*$' or
	name_en ~* '^.*poplar.*$' or
	name ~* '^.*poplar.*$'
)

--Mini Piago
select * from tokyo_konbini
where (
	brand ~* '^.*ピアゴ.*$' or
	brand ~* '^.*piago.*$' or
	name ~* '^.*ピアゴ.*$' or
	name_ja ~* '^.*ピアゴ.*$' or
	name ~* '^.*piago.*$' or
	name_en ~* '^.*piago.*$'
);

update tokyo_konbini
set brand = 'Mini Piago'
where (
	brand ~* '^.*ピアゴ.*$' or
	brand ~* '^.*piago.*$' or
	name ~* '^.*ピアゴ.*$' or
	name_ja ~* '^.*ピアゴ.*$' or
	name ~* '^.*piago.*$' or
	name_en ~* '^.*piago.*$'
);

update tokyo_konbini
set brand = 'Community Store'
where (
	brand ~* '^.*コミュニティ.*ストア.*$' or
	brand ~* '^.*Community.*Store.*$' or
	name ~* '^.*Community.*Store.*$' or
	name ~* '^.*コミュニティ.*ストア.*$' or
	name_en ~* '^.*Community.*Store.*$' or
	name_ja ~* '^.*コミュニティ.*ストア.*$'
)

--Set brand to name where everything else is null
update tokyo_konbini
set brand = name
where (
	brand is null and 
	name is not null and
	name_en is null and
	name_ja is null
)

update tokyo_konbini
set brand = 'Not Defined'
where (
	brand is null and
	name is null and
	name_en is null and
	name_ja is null
);

--My Basket
update tokyo_konbini
set brand = 'My Basket'
where (
	name ~* '^.*まいばすけっと.*$' or
	name_en ~* '^.*my(\s){0,}basket.*$'
)

--Times
update tokyo_konbini
set brand = 'Times'
where (
	name ~* '^.*タイムズマート.*$'
)

--Remaining brands
update tokyo_konbini
set brand = name_en
where (
	brand is null and
	name_en is not null
)

--Last remaining null brands
update tokyo_konbini
set brand = name
where (
	brand is null
	and name is not null
)

