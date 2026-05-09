# 🤖 Social Autopilot

> AI-powered social media automation — generate and publish platform-optimized posts from a single event description, via web dashboard or Telegram bot.

![Next.js](https://img.shields.io/badge/Next.js-14-black?style=flat-square&logo=next.js)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-16-blue?style=flat-square&logo=postgresql)
![Docker](https://img.shields.io/badge/Docker-ready-2496ED?style=flat-square&logo=docker)
![Groq](https://img.shields.io/badge/AI-Groq-orange?style=flat-square)

---

## ✨ What it does

1. **Enter** your event topic, dates, and organizer details
2. **AI generates** platform-optimized posts for LinkedIn, Instagram, Facebook, Bluesky, Threads, and Reddit
3. **Review and edit** posts in the dashboard with live character counts
4. **Generate** a branded event banner image
5. **Publish** to all platforms in one click — or via Telegram bot

---

## 📸 Features

| Feature | Description |
|---|---|
| 🧠 AI Content | Groq (llama-3.3-70b) generates platform-specific copy |
| 🎨 Image Banners | SVG banners auto-generated per event |
| 📱 6 Platforms | LinkedIn, Instagram, Facebook, Bluesky, Threads, Reddit |
| 🤖 Telegram Bot | Publish via chat command from anywhere |
| 🗄️ History | All events and posts saved to PostgreSQL |
| ♻️ Regenerate | Per-platform regeneration with custom feedback |
| ✅ Approval flow | Draft → Approved → Published status tracking |

---

## 🚀 Quick Start (Non-Technical)

### Prerequisites

Install these first (click each link):

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) — runs the database
- [Node.js 20+](https://nodejs.org/) — runs the app

### Step 1 — Clone the project

```bash
git clone https://github.com/yourusername/social-autopilot.git
cd social-autopilot
```

### Step 2 — Set up your API keys

Copy the example env file:

```bash
cp .env.example .env.local
```

Open `.env.local` in any text editor (Notepad works) and fill in your keys:

```env
GROQ_API_KEY=          # Get free at console.groq.com
AYRSHARE_API_KEY=      # Get free at app.ayrshare.com
TELEGRAM_BOT_TOKEN=    # Get from @BotFather on Telegram
TELEGRAM_ALLOWED_USER_ID=   # Your Telegram user ID (message @userinfobot)
IMGBB_API_KEY=         # Get free at api.imgbb.com (for image uploads)
```

> See [Getting API Keys](#-getting-api-keys) section below for step-by-step guides.

### Step 3 — Run the setup script

**Windows:**
```bash
setup.bat
```

**Mac/Linux:**
```bash
chmod +x setup.sh && ./setup.sh
```

That's it! The app opens at **http://localhost:3000**

---

## 🔑 Getting API Keys

### Groq (AI text generation) — Free
1. Go to [console.groq.com](https://console.groq.com)
2. Sign up → click **API Keys** → **Create API Key**
3. Copy and paste into `GROQ_API_KEY`

### Ayrshare (Social media publishing) — Free tier
1. Go to [app.ayrshare.com](https://app.ayrshare.com)
2. Sign up → dashboard → copy **API Key**
3. Connect your social accounts (LinkedIn, Instagram, etc.) from the dashboard
4. Copy and paste into `AYRSHARE_API_KEY`

### Telegram Bot — Free
1. Open Telegram → search **@BotFather**
2. Send `/newbot` → follow the steps → copy the token
3. Paste into `TELEGRAM_BOT_TOKEN`
4. Message **@userinfobot** on Telegram → copy your ID
5. Paste into `TELEGRAM_ALLOWED_USER_ID`

### ImgBB (Image hosting) — Free
1. Go to [imgbb.com](https://imgbb.com) → sign up
2. Go to [api.imgbb.com](https://api.imgbb.com) → copy API key
3. Paste into `IMGBB_API_KEY`

---

## 🤖 Telegram Bot Commands

Once the bot is running, open it in Telegram and send:

```
/start          — Show welcome message and usage
/help           — Show all commands

/post AI Summit May 10 by TechCorp → all
/post Web Dev Bootcamp June 5 by CodeSchool → linkedin bluesky
/post Product Launch July 1 by StartupXYZ → instagram threads reddit
```

### Platform shortcuts

| Shortcut | Platforms |
|---|---|
| `all` | linkedin, instagram, facebook, bluesky, threads, reddit |
| `social` | instagram, facebook, bluesky, threads |
| `professional` | linkedin only |

---

## 🏗️ Project Structure

```
social-autopilot/
├── app/
│   ├── page.tsx                    # Event input form
│   ├── dashboard/page.tsx          # Post review & publish
│   ├── history/page.tsx            # Past events
│   └── api/
│       ├── generate/route.ts       # AI post generation (Groq)
│       ├── publish/route.ts        # Platform publishing (Ayrshare)
│       ├── image/route.ts          # Banner generation (SVG)
│       ├── upload/route.ts         # Image upload (ImgBB/Cloudinary)
│       ├── regenerate/route.ts     # Per-platform regeneration
│       └── history/route.ts        # Event history
├── bot/
│   └── index.ts                    # Telegram bot
├── lib/
│   ├── groq.ts                     # Groq client
│   ├── prompts.ts                  # Platform prompt templates
│   ├── db.ts                       # Prisma client
│   └── uploadImage.ts              # ImgBB/Cloudinary uploader
├── prisma/
│   └── schema.prisma               # Database schema
├── docker-compose.yml              # PostgreSQL + Redis
├── setup.bat                       # Windows one-click setup
├── setup.sh                        # Mac/Linux one-click setup
└── .env.example                    # API key template
```

---

## 🛠️ Manual Setup (Developers)

```bash
# Install dependencies
npm install

# Start database
docker compose up -d

# Set up database
npx prisma migrate dev --name init

# Start the web app
npm run dev

# Start Telegram bot (separate terminal)
npm run bot

# Or run both together
npm run dev:all
```

---

## 🌐 Tech Stack

| Layer | Technology |
|---|---|
| Framework | Next.js 14 (App Router) |
| AI — Text | Groq API (llama-3.3-70b-versatile) |
| AI — Images | SVG generation (server-side) |
| Publishing | Ayrshare API |
| Database | PostgreSQL + Prisma ORM |
| Bot | Grammy.js (Telegram) |
| Styling | Tailwind CSS |
| Infrastructure | Docker + Redis |

---

## 📋 Supported Platforms

| Platform | Character Limit | Notes |
|---|---|---|
| LinkedIn | 700 | Professional tone, hashtags, CTA |
| Instagram | 220 | Visual hook, 8-12 hashtags |
| Facebook | 400 | Community-driven, asks question |
| Bluesky | 300 | Casual, authentic, no hashtags |
| Threads | 500 | Conversational, short sentences |
| Reddit | 300 | Title only, community-first |

---

## 🐛 Troubleshooting

### App won't start
```bash
# Make sure Docker Desktop is open, then:
docker compose up -d
npm run dev
```

### Database error
```bash
docker compose down
docker compose up -d
npx prisma migrate dev --name init
```

### Posts not generating
- Check `GROQ_API_KEY` is set in `.env.local`
- Restart the app after changing `.env.local`

### Publishing fails
- Make sure social accounts are connected in Ayrshare dashboard
- Check `AYRSHARE_API_KEY` is correct

### Telegram bot not responding
- Make sure `npm run bot` is running in a separate terminal
- Check `TELEGRAM_BOT_TOKEN` is correct in `.env.local`

---

## ⛏️ Built With

- [Groq](https://groq.com) — Lightning-fast AI inference
- [Ayrshare](https://ayrshare.com) — Social media API
- [Grammy](https://grammy.dev) — Telegram bot framework
- [Prisma](https://prisma.io) — Database ORM
- [Next.js](https://nextjs.org) — React framework
