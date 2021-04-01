select * from tokyo_districts;

alter table tokyo_districts drop column if exists id_0;
alter table tokyo_districts drop column if exists name_0;
alter table tokyo_districts drop column if exists id_1;
alter table tokyo_districts drop column if exists varname_2;

alter table tokyo_districts rename name_1 to prefecture;
alter table tokyo_districts rename name_2 to name;
alter table tokyo_districts rename id_2 to id;
alter table tokyo_districts rename name_1 to prefecture;
alter table tokyo_districts rename type_2 to type_ja;
alter table tokyo_districts rename engtype_2 to type_en;
alter table tokyo_districts rename nl_name_2 to name_ja;





