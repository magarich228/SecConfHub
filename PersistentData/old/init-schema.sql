drop table if exists public.ativity_day_jouriors;

drop table if exists public.activity_day;

drop table if exists public.activity; 

drop table if exists public.event;

drop table if exists public.city;

drop table if exists public.moderator;
drop table if exists public.jury;

drop table if exists public.user;
drop type if exists gender_enum;
drop type if exists role_enum;

drop table if exists public.country;

drop table if exists public.activity_directions;

drop table if exists public.event_types;

create table if not exists public.city
(
    id serial primary key,
    name varchar(100) not null unique,
	photo_path varchar(500)
);

create table if not exists public.country
(
	id serial primary key,
	name varchar(150) not null unique,
	uniform_name varchar(150) not null unique,
	code varchar(2) not null unique,
	num_code int4 not null unique
);

create table if not exists public.activity_directions
(
	id serial primary key,
	name varchar(100) not null unique
);

create table if not exists public.event_types
(
	id serial primary key,
	name varchar(100) not null unique
);

create type gender_enum as enum ('мужской', 'женский');
create type role_enum as enum ('moderator', 'jury', 'organizer', 'member');

create table if not exists public.user
(
	id serial primary key,
	full_name varchar(200) not null,
	gender gender_enum not null,
	birth date not null,
	country_id int,
	phone text not null check (phone ~ '^\+[1-9]\d{1,14}$'),
	pass varchar not null,
	photo_path varchar,
	role_discriminator role_enum,
	
	foreign key (country_id) references public.country (id)
		on delete set default
);

create table if not exists public.moderator
(
	user_id int not null primary key,
	activity_direction_id int references public.activity_directions (id)
		on delete set null,
	event_type_id int references public.event_types (id)
		on delete set null,
	
	foreign key (user_id) references public.user (id)
		on delete cascade
);

create table if not exists public.jury
(
	user_id int not null primary key references public.user (id)
		on delete cascade,
	activity_direction_id int references public.activity_directions (id)
		on delete set null
);

create table if not exists public.event
(
	id serial primary key,
	title text not null,
	start_date date not null,
	days int not null default 1,
	city_id int not null,
	
	constraint days_check check (days > 0),
	foreign key (city_id) references public.city (id)
		on delete cascade
);

create table if not exists public.activity
(
	id serial primary key,
	event_id int not null,
	winner_id int,
	days int not null default 1,
	
	constraint days_check check (days > 0),
	foreign key (event_id) references public.event (id)
		on delete cascade,
	foreign key (winner_id) references public.user (id)
		on delete set null
);

create table if not exists public.activity_day
(
	id serial primary key,
	title varchar(100) not null,
	day_num int not null default 1,
	start_time time not null,
	moderator_id int,
	
	constraint day_num_check check (day_num > 0),
	foreign key (moderator_id) references public.moderator (user_id)
		on delete set null
);

create table if not exists public.ativity_day_jouriors
(
	activity_day_id int not null,
	jury_id int not null,
	
	primary key (activity_day_id, jury_id),
	foreign key (jury_id) references public.jury (user_id)
		on delete cascade
);