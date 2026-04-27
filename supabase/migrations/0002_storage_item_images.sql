-- Storage bucket for product images (public read, anon write)
insert into storage.buckets (id, name, public)
  values ('item-images', 'item-images', true)
  on conflict (id) do update set public = true;

drop policy if exists "anon upload item-images" on storage.objects;
drop policy if exists "anon read item-images"   on storage.objects;
drop policy if exists "anon delete item-images" on storage.objects;
drop policy if exists "anon update item-images" on storage.objects;

create policy "anon upload item-images" on storage.objects
  for insert to anon with check (bucket_id = 'item-images');
create policy "anon read item-images" on storage.objects
  for select to anon using (bucket_id = 'item-images');
create policy "anon delete item-images" on storage.objects
  for delete to anon using (bucket_id = 'item-images');
create policy "anon update item-images" on storage.objects
  for update to anon using (bucket_id = 'item-images') with check (bucket_id = 'item-images');
