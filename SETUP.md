# One More Studio — setup guide

This app is a single static HTML file (`index.html`). No build step, no
framework, no npm install. That makes Vercel deployment as simple as
pointing it at the repo.

## 1. Create your Supabase project (free)

1. Go to https://supabase.com and sign up / log in.
2. Click "New project". Pick any name and region, set a database password
   (save it somewhere safe — you won't need it day-to-day, Supabase manages
   the connection for you).
3. Wait ~2 minutes for the project to finish setting up.

## 2. Create the database table

1. In your Supabase project, open the **SQL Editor** (left sidebar).
2. Click **New query**.
3. Open `supabase-setup.sql` from this folder, copy all of it, paste it in.
4. Click **Run**. You should see "Success. No rows returned."

This creates one table (`app_data`) that stores all your projects, app
builds, courses, and social posts as JSON, with row-level security so only
you can ever read or write your own rows — even though Supabase's anon key
is public-facing, the security policies block anyone else's access.

## 3. Get your API keys

1. In Supabase, go to **Project Settings** (gear icon) → **API**.
2. Copy the **Project URL** (looks like `https://xxxxx.supabase.co`).
3. Copy the **anon public** key (a long string starting with `eyJ...`).

## 4. Add your keys to the app

1. Open `index.html` in any text editor.
2. Find this near the top of the `<script>` section:
   ```js
   const SUPABASE_URL = 'YOUR_SUPABASE_URL';
   const SUPABASE_ANON_KEY = 'YOUR_SUPABASE_ANON_KEY';
   ```
3. Replace both placeholder strings with the values you copied. Keep the
   quotes. Save the file.

This anon key is safe to expose in frontend code — that's how Supabase is
designed to work. Your actual data stays protected by the row-level
security policies from step 2, not by hiding this key.

## 5. Create your account in the app (once it's live, or even locally)

You can test this locally first: just open `index.html` directly in your
browser (double-click it). Click **Create account**, enter an email and
password. Supabase will likely ask you to confirm your email — check your
inbox and click the confirmation link. Then come back and **Sign in**.

This is your one personal login. There's no separate admin step — whoever
creates the first (and only) account is the only person who can ever see
this data, because of the row-level security policy.

## 6. Push to GitHub

```bash
cd one-more-studio
git init
git add .
git commit -m "Initial commit"
```

Then create a new repository on https://github.com/new (don't initialize
it with a README), and follow the push instructions GitHub shows you,
something like:

```bash
git remote add origin https://github.com/YOUR_USERNAME/one-more-studio.git
git branch -M main
git push -u origin main
```

## 7. Deploy on Vercel (free)

1. Go to https://vercel.com and sign up / log in (you can use your GitHub
   account to sign in, which makes this step faster).
2. Click **Add New** → **Project**.
3. Import the `one-more-studio` repo you just pushed.
4. Leave all settings as default (no framework, no build command needed —
   it's a static file). Click **Deploy**.
5. After a minute, you'll get a live URL like
   `one-more-studio.vercel.app`. That's it — open it from any device.

## Updating the app later

Whenever you want to change something:
1. Edit `index.html` locally (or ask Claude for an updated version).
2. `git add . && git commit -m "update" && git push`
3. Vercel redeploys automatically within a minute or two.

## A note on the password

Supabase requires passwords of at least 6 characters by default. Use a
proper password manager — this is your only login, so make it a strong
one, since the whole point of this setup is that it isn't tied to one
laptop or one browser anymore.
