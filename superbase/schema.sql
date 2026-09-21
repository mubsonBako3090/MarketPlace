-- BuyLink core schema (Phase 1: auth, stores, products)
-- Run this in the Supabase SQL editor.

-- Profiles (extends Supabase's built-in auth.users)
create table profiles (
  id uuid references auth.users on delete cascade primary key,
  full_name text,
  role text check (role in ('buyer', 'seller', 'both')) default 'buyer',
  avatar_url text,
  location text,
  created_at timestamptz default now()
);

-- Stores (a seller can own one or more stores)
create table stores (
  id uuid primary key default gen_random_uuid(),
  owner_id uuid references profiles(id) on delete cascade not null,
  name text not null,
  description text,
  category text,
  logo_url text,
  verified boolean default false,
  created_at timestamptz default now()
);

-- Products
create table products (
  id uuid primary key default gen_random_uuid(),
  store_id uuid references stores(id) on delete cascade not null,
  title text not null,
  description text,
  price numeric(12, 2) not null,
  category text,
  stock_qty integer default 1,
  photo_urls text[] default '{}',
  created_at timestamptz default now()
);

-- Row Level Security
alter table profiles enable row level security;
alter table stores enable row level security;
alter table products enable row level security;

-- Profiles: a user can read any profile, but only edit their own
create policy "Profiles are viewable by everyone"
  on profiles for select using (true);
create policy "Users can update their own profile"
  on profiles for update using (auth.uid() = id);
create policy "Users can insert their own profile"
  on profiles for insert with check (auth.uid() = id);

-- Stores: anyone can view, only the owner can create/edit
create policy "Stores are viewable by everyone"
  on stores for select using (true);
create policy "Owners can insert their own store"
  on stores for insert with check (auth.uid() = owner_id);
create policy "Owners can update their own store"
  on stores for update using (auth.uid() = owner_id);
create policy "Owners can delete their own store"
  on stores for delete using (auth.uid() = owner_id);

-- Products: anyone can view, only the store owner can create/edit
create policy "Products are viewable by everyone"
  on products for select using (true);
create policy "Store owners can insert products"
  on products for insert with check (
    auth.uid() = (select owner_id from stores where id = store_id)
  );
create policy "Store owners can update their products"
  on products for update using (
    auth.uid() = (select owner_id from stores where id = store_id)
  );
create policy "Store owners can delete their products"
  on products for delete using (
    auth.uid() = (select owner_id from stores where id = store_id)
  );
