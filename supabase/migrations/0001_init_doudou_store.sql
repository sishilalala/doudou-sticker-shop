-- Doudou Rewards Store · initial schema
-- Tables: wallet (single-row), items, wishlist, redemptions
-- RLS: anon all (trust model: shared anon key, family use)

-- ========== wallet (single-row) ==========
create table if not exists wallet (
  id          int primary key default 1,
  balance     int not null default 0,
  pin         text not null default '0000',
  updated_at  timestamptz not null default now()
);
alter table wallet drop constraint if exists wallet_singleton;
alter table wallet add constraint wallet_singleton check (id = 1);
insert into wallet (id, balance, pin) values (1, 128, '0000') on conflict do nothing;

-- ========== items ==========
create table if not exists items (
  id          text primary key,
  name        text not null,
  stickers    int not null check (stickers > 0),
  quantity    int not null default 0 check (quantity >= 0),
  image_url   text not null,
  sort_order  int not null default 0,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists items_sort_idx on items (sort_order, created_at);

-- ========== wishlist ==========
create table if not exists wishlist (
  item_id     text references items(id) on delete cascade,
  position    int not null,
  added_at    timestamptz not null default now(),
  primary key (item_id)
);
create index if not exists wishlist_pos_idx on wishlist (position);

-- ========== redemptions (history snapshots) ==========
create table if not exists redemptions (
  id            uuid primary key default gen_random_uuid(),
  item_id       text,
  name          text not null,
  stickers      int not null,
  redeemed_qty  int not null,
  image_url     text not null,
  redeemed_at   timestamptz not null default now()
);
create index if not exists redemptions_time_idx on redemptions (redeemed_at desc);

-- ========== auto-update updated_at on items ==========
create or replace function touch_updated_at() returns trigger as $$
begin new.updated_at = now(); return new; end;
$$ language plpgsql;
drop trigger if exists items_touch on items;
create trigger items_touch before update on items
  for each row execute function touch_updated_at();

-- ========== RLS ==========
alter table wallet      enable row level security;
alter table items       enable row level security;
alter table wishlist    enable row level security;
alter table redemptions enable row level security;

drop policy if exists "anon all" on wallet;
drop policy if exists "anon all" on items;
drop policy if exists "anon all" on wishlist;
drop policy if exists "anon all" on redemptions;

create policy "anon all" on wallet      for all using (true) with check (true);
create policy "anon all" on items       for all using (true) with check (true);
create policy "anon all" on wishlist    for all using (true) with check (true);
create policy "anon all" on redemptions for all using (true) with check (true);
