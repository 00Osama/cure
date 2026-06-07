-- ============================================================================
-- CURE — Supabase schema for booking / services / availability
-- Run this in the Supabase SQL editor (Dashboard → SQL → New query).
-- The app reaches these tables over PostgREST via the dio network layer.
-- ============================================================================

-- ---------- services -------------------------------------------------------
-- `key` matches the localized copy keys already in lib/l10n/intl_*.arb
-- (e.g. 'basicCare' -> basicCareTitle / basicCareItems). The DB owns price
-- and availability; the app owns the localized text. No copy is duplicated.
create table if not exists public.services (
  id          uuid primary key default gen_random_uuid(),
  key         text unique not null,
  base_price  numeric(10, 2) not null default 0,
  active      boolean not null default true,
  sort_order  int not null default 0,
  created_at  timestamptz not null default now()
);

-- ---------- nurse availability --------------------------------------------
create table if not exists public.nurse_availability (
  id          uuid primary key default gen_random_uuid(),
  nurse_id    text not null,                 -- Firebase uid
  region      text not null,
  starts_at   timestamptz not null,
  ends_at     timestamptz not null,
  is_booked   boolean not null default false,
  created_at  timestamptz not null default now()
);
create index if not exists idx_avail_region_start
  on public.nurse_availability (region, starts_at)
  where is_booked = false;

-- ---------- bookings -------------------------------------------------------
do $$ begin
  create type booking_status as enum
    ('requested', 'confirmed', 'inProgress', 'completed', 'cancelled');
exception when duplicate_object then null; end $$;

create table if not exists public.bookings (
  id          uuid primary key default gen_random_uuid(),
  patient_id  text not null,                 -- Firebase uid
  nurse_id    text,
  service_id  uuid not null references public.services (id),
  scheduled_at timestamptz not null,
  status      booking_status not null default 'requested',
  remarks     text,
  address     text not null,
  price       numeric(10, 2) not null default 0,
  created_at  timestamptz not null default now(),
  updated_at  timestamptz not null default now()
);
create index if not exists idx_bookings_patient
  on public.bookings (patient_id, created_at desc);

-- keep updated_at fresh
create or replace function public.touch_updated_at()
returns trigger as $$
begin new.updated_at = now(); return new; end;
$$ language plpgsql;

drop trigger if exists trg_bookings_touch on public.bookings;
create trigger trg_bookings_touch
  before update on public.bookings
  for each row execute function public.touch_updated_at();

-- ---------- seed services (prices illustrative) ----------------------------
insert into public.services (key, base_price, sort_order) values
  ('basicCare', 50, 1),
  ('woundCare', 80, 2),
  ('elderlyCare', 120, 3),
  ('chronicCare', 100, 4),
  ('postOpCare', 150, 5),
  ('respiratoryCare', 90, 6),
  ('catheterCare', 110, 7),
  ('psychologicalCare', 70, 8),
  ('emergencyCare', 200, 9)
on conflict (key) do nothing;

-- ---------- Row Level Security --------------------------------------------
alter table public.services           enable row level security;
alter table public.nurse_availability enable row level security;
alter table public.bookings           enable row level security;

drop policy if exists services_read on public.services;
create policy services_read on public.services
  for select to anon, authenticated using (true);

drop policy if exists avail_read on public.nurse_availability;
create policy avail_read on public.nurse_availability
  for select to anon, authenticated using (true);

-- Option A (shipped): the app authenticates PostgREST with the anon key and
-- always filters bookings by patient_id = <firebase uid>. Per-user isolation
-- is enforced app-side because the anon key cannot carry the Firebase
-- identity. Documented limitation — see README "Auth bridge".
drop policy if exists bookings_anon_rw on public.bookings;
create policy bookings_anon_rw on public.bookings
  for all to anon using (true) with check (true);

-- Option B (preferred, when a Supabase session is bridged from Firebase):
-- replace the policy above with these so RLS enforces isolation server-side.
-- create policy bk_select on public.bookings
--   for select to authenticated using (patient_id = auth.uid()::text);
-- create policy bk_insert on public.bookings
--   for insert to authenticated with check (patient_id = auth.uid()::text);
-- create policy bk_update on public.bookings
--   for update to authenticated using (patient_id = auth.uid()::text);

-- ---------- Storage (profile images) --------------------------------------
-- The signup flow uploads avatars to the 'patients_profile_images' /
-- 'nurses_profile_images' buckets. After switching off the service_role key,
-- add a policy allowing anon insert so uploads keep working (demo):
-- create policy avatar_upload on storage.objects
--   for insert to anon with check (bucket_id in
--     ('patients_profile_images','nurses_profile_images'));
