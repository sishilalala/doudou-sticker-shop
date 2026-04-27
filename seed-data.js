/* =========================================================
   Shared seed data for all Doudou Store variants
========================================================= */
const SEED_ITEMS = [
  { id:'s_21277', name:'乐高 21277 旷野矿井', stickers:55, quantity:1, imageUrl:'lego/s_21277.png' },
  { id:'s_60413', name:'乐高 60413 消防救援飞机', stickers:56, quantity:1, imageUrl:'lego/s_60413.png' },
  { id:'s_60505', name:'乐高 60505 飞机·服务车·气垫船三合一', stickers:70, quantity:1, imageUrl:'lego/s_60505.png' },
  { id:'s_60502', name:'乐高 60502 机场与飞机', stickers:100, quantity:1, imageUrl:'lego/s_60502.png' },
  { id:'s_60457', name:'乐高 60457 改装警车修理厂', stickers:50, quantity:1, imageUrl:'lego/s_60457.png' },
  { id:'s_60434', name:'乐高 60434 太空基地与火箭发射台', stickers:130, quantity:1, imageUrl:'lego/s_60434.png' },
  { id:'s_60431', name:'乐高 60431 太空探索车与外星生命', stickers:30, quantity:1, imageUrl:'lego/s_60431.png' },
  { id:'s_60440', name:'乐高 60440 快递货车', stickers:80, quantity:1, imageUrl:'lego/s_60440.png' },
  { id:'s_60500', name:'乐高 60500 乐高面包车', stickers:30, quantity:1, imageUrl:'lego/s_60500.png' },
  { id:'s_60490', name:'乐高 60490 除雪车', stickers:25, quantity:1, imageUrl:'lego/s_60490.png' },
  { id:'s_76320', name:'乐高 76320 钢铁侠与战争机器对抗锤击无人机', stickers:30, quantity:1, imageUrl:'lego/s_76320.png' },
  { id:'s_76319', name:'乐高 76319 美国队长大战灭霸', stickers:32, quantity:1, imageUrl:'lego/s_76319.png' },
  { id:'s_40774', name:'乐高 40774 迪士尼经典动画场景', stickers:24, quantity:1, imageUrl:'lego/s_40774.png' },
  { id:'s_75410', name:'乐高 75410 曼达洛人与格鲁古的N-1星际战机', stickers:26, quantity:1, imageUrl:'lego/s_75410.png' },
  { id:'s_robux', name:'奥特曼罗布水晶', stickers:6, quantity:33, imageUrl:'lego/s_robux.png' },
];

const _now = Date.now();
const _DAY = 86400000;
const SEED_HISTORY = [
  { id:'h1', name:'奥特曼罗布水晶', stickers:6, redeemedQty:2, imageUrl:SEED_ITEMS[14].imageUrl, redeemedAt: _now - 2*_DAY },
  { id:'h2', name:'乐高 60490 除雪车', stickers:25, redeemedQty:1, imageUrl:SEED_ITEMS[9].imageUrl, redeemedAt: _now - 5*_DAY },
  { id:'h3', name:'奥特曼罗布水晶', stickers:6, redeemedQty:3, imageUrl:SEED_ITEMS[14].imageUrl, redeemedAt: _now - 9*_DAY },
  { id:'h4', name:'乐高 40774 迪士尼经典动画场景', stickers:24, redeemedQty:1, imageUrl:SEED_ITEMS[12].imageUrl, redeemedAt: _now - 14*_DAY },
  { id:'h5', name:'乐高 75410 曼达洛人与格鲁古的N-1星际战机', stickers:26, redeemedQty:1, imageUrl:SEED_ITEMS[13].imageUrl, redeemedAt: _now - 22*_DAY },
  { id:'h6', name:'奥特曼罗布水晶', stickers:6, redeemedQty:4, imageUrl:SEED_ITEMS[14].imageUrl, redeemedAt: _now - 35*_DAY },
  { id:'h7', name:'乐高 76319 美国队长大战灭霸', stickers:32, redeemedQty:1, imageUrl:SEED_ITEMS[11].imageUrl, redeemedAt: _now - 48*_DAY },
  { id:'h8', name:'乐高 60431 太空探索车', stickers:30, redeemedQty:1, imageUrl:SEED_ITEMS[6].imageUrl, redeemedAt: _now - 62*_DAY },
];

/* Shared utility: format redeemed time into Chinese */
function fmtAgo(ts){
  const diff = Date.now() - ts;
  const day = diff / _DAY;
  if (day < 1) return '今天';
  if (day < 2) return '昨天';
  if (day < 7) return `${Math.floor(day)}天前`;
  if (day < 30) return `${Math.floor(day/7)}周前`;
  if (day < 365) return `${Math.floor(day/30)}个月前`;
  return `${Math.floor(day/365)}年前`;
}

function escHtml(s){
  const d = document.createElement('div');
  d.textContent = String(s ?? '');
  return d.innerHTML;
}
