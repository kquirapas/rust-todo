-- Add up migration script here
create table accounts (
	id uuid not null default gen_random_uuid(),
	email varchar(150) not null unique,
	password bytea not null,
	salt bytea not null,
	username varchar(16) not null unique,
	about varchar(255),
	primary key (id)
);

create table tasks (
	id uuid default gen_random_uuid(),
	description text,
	created_by uuid,
	created_at timestamp not null default current_timestamp,
	primary key (id),
	foreign key (created_by) references accounts(id)
);

create table roles (
	id uuid not null default gen_random_uuid() unique,
	name varchar(16) not null unique,
	description varchar(255) not null
);

create table permissions (
	id uuid not null default gen_random_uuid() unique,
	name varchar(16) not null unique,
	description varchar(255) not null
);

create table accounts_roles (
	account_id uuid,
	role_id uuid,
	primary key (account_id, role_id),
	foreign key (account_id) references accounts(id),
	foreign key (role_id) references roles(id)
);

create table roles_permissions (
	role_id uuid,
	permissions_id uuid,
	primary key (role_id, permissions_id),
	foreign key (role_id) references roles(id),
	foreign key (permissions_id) references permissions(id)
);

