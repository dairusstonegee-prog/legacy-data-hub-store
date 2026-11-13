create extension if not exists pgcrypto;
create table users(id uuid primary key default gen_random_uuid(), name text not null, email text unique not null, password_hash text, created_at timestamptz default now());
create table bundles(id serial primary key, network text not null, size text not null, price numeric(8,2), reseller_price numeric(8,2), in_stock boolean default true, sort int default 0);
create table orders(id uuid primary key default gen_random_uuid(), reference text unique not null, bundle_id int references bundles(id) on delete set null, network text, size text, amount numeric(8,2), phone text not null, email text not null, tier text default 'customer', status text default 'Processing', created_at timestamptz default now(), delivered_at timestamptz);
create index on orders(phone); create index on orders(email);
alter table users enable row level security; alter table bundles enable row level security; alter table orders enable row level security; -- server uses the service key
-- reseller_price null = falls back to retail price.
insert into bundles(network,size,price,in_stock,sort) values
('MTN','1GB',4.8,true,0),
('MTN','2GB',9.8,true,1),
('MTN','3GB',14.3,true,2),
('MTN','4GB',22,true,3),
('MTN','5GB',26,true,4),
('MTN','6GB',29,true,5),
('MTN','8GB',37,true,6),
('MTN','10GB',46,true,7),
('MTN','15GB',64,true,8),
('MTN','20GB',84,true,9),
('MTN','25GB',104,true,10),
('MTN','30GB',126,true,11),
('MTN','40GB',163,true,12),
('MTN','50GB',205,true,13),
('TELECEL','10GB',41,true,0),
('TELECEL','15GB',57.85,true,1),
('TELECEL','20GB',76.8,true,2),
('TELECEL','25GB',93.75,true,3),
('TELECEL','40GB',146.6,true,4),
('TELECEL','50GB',181.50,true,5),
('AIRTELTIGO','1GB',4.75,true,0),
('AIRTELTIGO','2GB',9.25,true,1),
('AIRTELTIGO','3GB',14.25,true,2),
('AIRTELTIGO','4GB',17.5,true,3),
('AIRTELTIGO','5GB',20.5,true,4),
('AIRTELTIGO','6GB',24.5,true,5),
('AIRTELTIGO','8GB',32,true,6),
('AIRTELTIGO','10GB',40,true,7),
('AIRTELTIGO','12GB',47,true,8),
('AIRTELTIGO','15GB',60.5,true,9);
