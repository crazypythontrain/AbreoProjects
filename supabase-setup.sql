-- Run this entire file in Supabase: Dashboard > SQL Editor > New query > paste > Run

-- Each table stores one JSON blob per row, owned by the logged-in user.
-- This mirrors the simple key/value storage the app already used, so the
-- app code barely changes -- it just talks to Supabase instead.

create table if not exists app_data (
  id text primary key,
  user_id uuid references auth.users(id) not null default auth.uid(),
  data_type text not null,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);

create index if not exists app_data_user_type_idx on app_data (user_id, data_type);

alter table app_data enable row level security;

create policy "Users can read their own data"
  on app_data for select
  using (auth.uid() = user_id);

create policy "Users can insert their own data"
  on app_data for insert
  with check (auth.uid() = user_id);

create policy "Users can update their own data"
  on app_data for update
  using (auth.uid() = user_id);

create policy "Users can delete their own data"
  on app_data for delete
  using (auth.uid() = user_id);
