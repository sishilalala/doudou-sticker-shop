# 🏷️ 豆豆兑换商店 · Doudou Rewards Store

一个给小朋友用贴纸兑换奖励的迷你商店。Bento 色块布局、心愿单、兑换记录、家长后台、实时多设备同步。

> 单文件 HTML + Supabase（Postgres + Storage + Realtime），**零构建**，部署后两个设备同时打开会自动同步。

线上 demo：[doudou-rewards-store.netlify.app](https://doudou-rewards-store.netlify.app/)

---

## 功能

- 🛒 **商店**：Bento 色块布局，库存可视化，售完置灰
- 💝 **心愿单**：抽屉式面板，可排序，售完自动移除
- 🎉 **兑换流程**：数量选择、彩纸动效、Toast 提示
- 📜 **兑换记录**：按月份分组，统计累计兑换/花费/最爱
- 🔐 **家长模式**：4 位 PIN（默认 `0000`），可改
  - 调整贴纸余额
  - 上下架商品（图片自动抠白底）
  - 改 PIN
- 🔄 **实时同步**：A 设备改了，B 设备自动更新（Supabase Realtime）
- 🟢 **同步指示灯**：左下角，实时显示连接状态

---

## 技术栈

- 前端：单个 `index.html`，原生 HTML/CSS/JS，无框架无构建
- 后端：[Supabase](https://supabase.com)
  - Postgres（4 张表 + RLS）
  - Storage（商品图片 bucket）
  - Realtime（postgres_changes 订阅）
- 部署：[Netlify](https://netlify.com) 静态托管

**为什么是单文件？** 这是个家用工具，强求工程化反而是坏品味。整个前端 ~1500 行，复制粘贴就能改。

---

## 自己 fork 一份只需要 5 分钟

任何人都可以 fork 这个 repo，连上自己的 Supabase 项目，部署一个属于自己的版本。

### 1. Fork + Clone

```bash
# 在 GitHub 上点 Fork
git clone https://github.com/<你的用户名>/Doudou_rewards_store.git
cd Doudou_rewards_store
```

### 2. 创建 Supabase 项目

1. 去 [supabase.com](https://supabase.com) → New project（免费版够用）
2. 项目创建后，从 **Project Settings → API** 拿两个值：
   - `Project URL`，形如 `https://xxxxx.supabase.co`
   - `anon public` key（很长一串 JWT）

### 3. 建表 + Storage

在 Supabase 控制台 → **SQL Editor**，依次粘贴并执行：

1. `supabase/migrations/0001_init_doudou_store.sql` — 建 4 张表 + RLS
2. `supabase/migrations/0002_storage_item_images.sql` — 建 `item-images` bucket

### 4. 接上你自己的 Supabase（本地）

```bash
cp config.example.js config.js
```

打开 `config.js`，把两个值替换成步骤 2 拿到的 Project URL 和 anon key：

```js
window.CONFIG = {
  SUPABASE_URL:      'https://你的-project-ref.supabase.co',
  SUPABASE_ANON_KEY: 'eyJhbGc...',  // 你的 anon JWT
};
```

> `config.js` 已经在 `.gitignore` 里，**不会被提交**。这样你 fork 的 repo 就不会泄露自己的 key。

### 5. 添加你自己的商品

本地起一个静态服务器（SDK 走 WebSocket，需要 http:// 而不是 file://）：

```bash
python3 -m http.server 8000
# 访问 http://localhost:8000
```

打开页面 → 点右上角齿轮 ⚙️ → 输入 PIN `0000` → 进家长模式 → 上架商品。

> 不需要 import 任何种子数据，从空商店开始就好。
> 如果你想看到一个有数据的演示状态，可以参考 `supabase/seed.sql`（不过那是豆豆的乐高清单，未必适合你）。

### 6. 部署到 Netlify

因为 `config.js` 不在 git 里，Netlify 需要在每次构建时**根据环境变量生成它**。`netlify.toml` 已经配好了构建命令，你只需要在 Netlify 后台加两个环境变量：

1. Push 到 GitHub
2. 去 [app.netlify.com](https://app.netlify.com) → **Add new site → Import from Git**，选你的 repo
3. **重要**：还没点 Deploy 之前先去 **Site settings → Environment variables**，添加两个：
   - `SUPABASE_URL`        = 你的 Project URL
   - `SUPABASE_ANON_KEY`   = 你的 anon public key
4. 回到 Deploys 页面 → **Trigger deploy**
5. 30 秒后你会拿到一个 `xxx.netlify.app` 链接

之后每次 push 到 GitHub 都会自动重新部署，构建时会用环境变量重新生成 `config.js`。

> ⚠️ 如果你 deploy 后页面显示「⚙️ 配置缺失」——说明 Netlify 环境变量没设好。检查 Site settings → Environment variables。

---

## 自己定制（可选）

| 想改什么 | 改哪里 |
|---|---|
| 主题色（黄/红/蓝/绿…） | `index.html` 顶部 CSS 变量 `--c1`..`--c8` |
| "豆豆"两个字 | `index.html` 内搜 "豆豆" 替换 |
| 默认 PIN | `supabase/migrations/0001_init_doudou_store.sql` 里 wallet 初始 `'0000'` |
| 默认贴纸余额 | 同上，wallet 初始 `128` |
| Bento 网格布局（哪一格是大格子） | `index.html` 内搜 `const LAYOUT` |
| 字体 | `index.html` `<link rel="preconnect">` 附近的 Google Fonts |

---

## 数据模型

四张表，全部启用 RLS（policy: `anon all` —— 拿到 anon key 就能读写）：

```
wallet      (id=1 单例)  ─┬─ balance, pin
items                    ─┬─ id, name, stickers, quantity, image_url, sort_order
wishlist                 ─┬─ item_id (FK→items, ON DELETE CASCADE), position
redemptions              ─┬─ id, item_id, name, stickers, redeemed_qty, image_url, redeemed_at
                          (历史快照，商品下架后记录仍保留)
```

详情见 `supabase/migrations/0001_init_doudou_store.sql`。

---

## 安全说明

**当前的信任模型**：所有家长共享 anon key，PIN 明文存数据库。

适用场景：家用、3-5 人以内的小范围使用。

**不适用**：

- 多家庭共用一个部署（每家应该自己 fork + 自己建 Supabase）
- 把 anon key 当作秘密（anon key 本来就是要发到浏览器里的；任何打开你网站的人都能拿到，并且因为 RLS 是 `anon all`，他们也能改数据）

> ⚠️ 建议：fork 之后，把你自己的 anon key 替换进去，**不要**把豆豆默认的 demo key 留在你的部署里。

如果以后要做更安全的版本（多用户隔离、PIN 哈希、Supabase Auth + magic link）：参考仓库内的 `HANDOFF.md` 第 8 节。

---

## 项目结构

```
.
├── index.html                 # 主页面（Bento v2 设计 + Supabase 集成）
├── index-v1.html              # 旧版备份（橙红渐变主题）
├── config.example.js          # 配置模板（fork 后复制为 config.js）
├── config.js                  # 你的本地配置（gitignored；Netlify 构建时从 env vars 生成）
├── seed-data.js               # fmtAgo / escHtml 工具函数（SEED_* 已不再使用）
├── lego/                      # 15 张透明 PNG 商品图（已上传到 Supabase Storage）
├── supabase/
│   ├── migrations/
│   │   ├── 0001_init_doudou_store.sql      # 表 + RLS
│   │   └── 0002_storage_item_images.sql    # Storage bucket + policies
│   └── seed.sql               # 豆豆专属种子数据（forker 可忽略）
├── netlify.toml               # Netlify 部署配置
└── README.md
```

---

## License

MIT
