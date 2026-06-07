-- Demo availability so the booking flow has slots to pick.
-- Generates slots for today..+4 days, at 09:00/11:00/14:00/16:00,
-- for three regions. Safe to skip in production. Re-running adds duplicates.
insert into public.nurse_availability (nurse_id, region, starts_at, ends_at)
select
  'demo-nurse',
  r.region,
  date_trunc('day', now()) + make_interval(days => d) + t.t,
  date_trunc('day', now()) + make_interval(days => d) + t.t + interval '1 hour'
from (values ('fayoumCity'), ('itsa'), ('tamiya')) as r(region),
     generate_series(0, 4) as d,
     (values (interval '9 hour'), (interval '11 hour'),
             (interval '14 hour'), (interval '16 hour')) as t(t);
