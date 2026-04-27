-- Doudou's seed data (15 items + 8 redemption history records)
-- For forkers: skip this file or replace with your own items.
-- Image URLs assume the 15 PNGs in lego/ have been uploaded to the item-images bucket
-- with the same filenames (s_21277.png, s_60413.png, ...).
-- Replace <YOUR_PROJECT_REF> with your Supabase project ref before running.

-- Items
insert into items (id, name, stickers, quantity, image_url, sort_order) values
  ('s_21277', '乐高 21277 旷野矿井',                      55,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_21277.png', 1),
  ('s_60413', '乐高 60413 消防救援飞机',                   56,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60413.png', 2),
  ('s_60505', '乐高 60505 飞机·服务车·气垫船三合一',      70,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60505.png', 3),
  ('s_60502', '乐高 60502 机场与飞机',                     100, 1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60502.png', 4),
  ('s_60457', '乐高 60457 改装警车修理厂',                 50,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60457.png', 5),
  ('s_60434', '乐高 60434 太空基地与火箭发射台',           130, 1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60434.png', 6),
  ('s_60431', '乐高 60431 太空探索车与外星生命',           30,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60431.png', 7),
  ('s_60440', '乐高 60440 快递货车',                       80,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60440.png', 8),
  ('s_60500', '乐高 60500 乐高面包车',                     30,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60500.png', 9),
  ('s_60490', '乐高 60490 除雪车',                         25,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60490.png', 10),
  ('s_76320', '乐高 76320 钢铁侠与战争机器对抗锤击无人机', 30,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_76320.png', 11),
  ('s_76319', '乐高 76319 美国队长大战灭霸',               32,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_76319.png', 12),
  ('s_40774', '乐高 40774 迪士尼经典动画场景',             24,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_40774.png', 13),
  ('s_75410', '乐高 75410 曼达洛人与格鲁古的N-1星际战机',  26,  1,  'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_75410.png', 14),
  ('s_robux', '奥特曼罗布水晶',                            6,   33, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_robux.png', 15)
on conflict (id) do nothing;

-- Redemption history (relative timestamps so seeded history always looks recent)
insert into redemptions (item_id, name, stickers, redeemed_qty, image_url, redeemed_at) values
  ('s_robux', '奥特曼罗布水晶',                          6,  2, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_robux.png', now() - interval '2 days'),
  ('s_60490', '乐高 60490 除雪车',                        25, 1, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60490.png', now() - interval '5 days'),
  ('s_robux', '奥特曼罗布水晶',                          6,  3, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_robux.png', now() - interval '9 days'),
  ('s_40774', '乐高 40774 迪士尼经典动画场景',            24, 1, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_40774.png', now() - interval '14 days'),
  ('s_75410', '乐高 75410 曼达洛人与格鲁古的N-1星际战机', 26, 1, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_75410.png', now() - interval '22 days'),
  ('s_robux', '奥特曼罗布水晶',                          6,  4, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_robux.png', now() - interval '35 days'),
  ('s_76319', '乐高 76319 美国队长大战灭霸',              32, 1, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_76319.png', now() - interval '48 days'),
  ('s_60431', '乐高 60431 太空探索车',                    30, 1, 'https://<YOUR_PROJECT_REF>.supabase.co/storage/v1/object/public/item-images/s_60431.png', now() - interval '62 days');
