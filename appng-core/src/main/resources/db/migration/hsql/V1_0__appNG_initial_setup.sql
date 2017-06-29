create table application (
	id integer generated by default as identity (start with 1),
	appng_version varchar(64),
	application_version varchar(64),
	core_application boolean,
	description LONGVARCHAR,
	displayName varchar(64),
	fileBased boolean not null,
	hidden boolean not null,
	longDescription clob(255),
	name varchar(64) not null,
	snapshot boolean not null,
	time_stamp varchar(64),
	version timestamp,
	primary key (id)
);

create table authgroup (
	id integer generated by default as identity (start with 1),
	description LONGVARCHAR,
	name varchar(64) not null,
	version timestamp,
	primary key (id)
);

create table authgroup_role (
	authgroup_id integer not null,
	role_id integer not null,
	primary key (authgroup_id, role_id)
);

create table database_connection (
	id integer generated by default as identity (start with 1),
	active boolean not null,
	description varchar(255),
	driver_class varchar(255) not null,
	jdbc_url varchar(255) not null,
	managed boolean not null,
	max_connections integer not null,
	min_connections integer not null check (min_connections>=1),
	name varchar(255) not null,
	password blob(255),
	type varchar(255) not null,
	username varchar(255) not null,
	validation_query varchar(255),
	version timestamp,
	site_id integer,
	primary key (id)
);

create table permission (
	id integer generated by default as identity (start with 1),
	description LONGVARCHAR,
	name varchar(255) not null,
	version timestamp,
	application_id integer,
	primary key (id)
);

create table property (
	name varchar(255) not null,
	value varchar(255),
	blobValue blob(255),
	clobValue clob(255),
	defaultValue varchar(255),
	description LONGVARCHAR,
	mandatory boolean not null,
	version timestamp,
	primary key (name)
);

create table repository (
	id integer generated by default as identity (start with 1),
	active boolean not null,
	description LONGVARCHAR,
	name varchar(64) not null,
	published boolean not null,
	remote_repository_name varchar(64),
	mode varchar(255),
	type varchar(255),
	uri varbinary(255),
	version timestamp,
	primary key (id)
);

create table resource (
	id integer generated by default as identity (start with 1),
	bytes blob(255),
	checksum varchar(255),
	description LONGVARCHAR,
	name varchar(255),
	type varchar(255),
	version timestamp,
	application_id integer,
	primary key (id)
);

create table role (
	id integer generated by default as identity (start with 1),
	description LONGVARCHAR,
	name varchar(64) not null,
	version timestamp,
	application_id integer,
	primary key (id)
);

create table role_permission (
	role_id integer not null,
	permissions_id integer not null,
	primary key (role_id, permissions_id)
);

create table site (
	id integer generated by default as identity (start with 1),
	active boolean not null,
	create_repository boolean,
	description LONGVARCHAR,
	domain varchar(255) not null,
	host varchar(255) not null,
	name varchar(64) not null,
	startup_time timestamp,
	version timestamp,
	primary key (id)
);

create table site_application (
	application_id integer not null,
	site_id integer not null,
	active boolean not null,
	deletion_mark boolean,
	reload_required boolean,
	connection_id integer,
	primary key (application_id, site_id)
);

create table sites_granted (
	site_id integer not null,
	application_id integer not null,
	granted_site_id integer not null,
	primary key (site_id, application_id, granted_site_id)
);

create table subject (
	id integer generated by default as identity (start with 1),
	description LONGVARCHAR,
	digest varchar(255),
	email varchar(255),
	language varchar(3) not null,
	name varchar(64) not null,
	realname varchar(64) not null,
	salt varchar(255),
	timezone varchar(255),
	type varchar(255),
	version timestamp,
	primary key (id)
);

create table subject_authgroup (
	subject_Id integer not null,
	group_id integer not null
);

alter table application 
	add constraint UK_lspnba25gpku3nx3oecprrx8c unique (name);

alter table authgroup 
	add constraint UK_hng9ojpn9gcumrchsw1gqwpa3 unique (name);

alter table repository 
	add constraint UK_pbnisjkw01y5ole425crs0ra6 unique (name);

alter table site 
	add constraint UK_qsgk5cjl6wt1xvhdeqymoymqb unique (domain);

alter table site 
	add constraint UK_nnbksm3ee42ted5jwjv82ld8 unique (host);

alter table site 
	add constraint UK_f9iil6uu8d9ohutpr2irlpvio unique (name);

alter table subject 
	add constraint UK_p1jgir6qcpmqnxt4a8105wsot unique (name);

alter table authgroup_role 
	add constraint FK_jovybqkpkc4ne90rc1s5eae0v 
	foreign key (role_id) 
	references role;

alter table authgroup_role 
	add constraint FK_fplucc3y4fcm85mlxvrtcpyvx 
	foreign key (authgroup_id) 
	references authgroup;

alter table database_connection 
	add constraint FK_fif7jaerm0b057auh7a36x2in 
	foreign key (site_id) 
	references site;

alter table permission 
	add constraint FK_3bck4x8dcieqmtiregv8uml9v 
	foreign key (application_id) 
	references application;

alter table resource 
	add constraint FK_qi46qfjlu53f5o3ws58xaj73r 
	foreign key (application_id) 
	references application;

alter table role 
	add constraint FK_e8bn8smcmxf0w0wiu5rkgtp2n 
	foreign key (application_id) 
	references application;

alter table role_permission 
	add constraint FK_bd67q67cmk1xk23k1wagx1h72 
	foreign key (permissions_id) 
	references permission;

alter table role_permission 
	add constraint FK_j89g87bvih4d6jbxjcssrybks 
	foreign key (role_id) 
	references role;

alter table site_application 
	add constraint FK_bnld6s056a2g5epg40tct49vf 
	foreign key (application_id) 
	references application;

alter table site_application 
	add constraint FK_svesomhwjo9kr3ty5h5b6pd80 
	foreign key (connection_id) 
	references database_connection;

alter table site_application 
	add constraint FK_e4tg5ew27rmfkbiccu1cvcxq8 
	foreign key (site_id) 
	references site;

alter table sites_granted 
	add constraint FK_72sitfma549r64la5nl1mnqxg 
	foreign key (granted_site_id) 
	references site;

alter table sites_granted 
	add constraint FK_9ef52f2r713eqqo4w6dduyct7 
	foreign key (site_id, application_id) 
	references site_application;

alter table subject_authgroup 
	add constraint FK_4qwo3qjstp0whaib958xh41vm 
	foreign key (group_id) 
	references authgroup;

alter table subject_authgroup 
	add constraint FK_g93bhgy29ctw7k3y549afgne6 
	foreign key (subject_Id) 
	references subject;