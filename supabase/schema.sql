-- ============================================================
-- سوق سوريا الشامل 2026 - مخطط قاعدة البيانات (المرحلة 1)
-- نفّذ هذا الملف في: Supabase Dashboard -> SQL Editor -> New query
-- ============================================================

-- 1) جدول الأقسام الرئيسية -------------------------------------------------
create table if not exists public.categories (
  id text primary key,
  name_ar text not null,
  icon_name text not null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

alter table public.categories enable row level security;

create policy "categories_select_all"
  on public.categories for select
  using (true);

-- تعبئة الأقسام السبعة الافتراضية
insert into public.categories (id, name_ar, icon_name, sort_order) values
  ('cars', 'سيارات', 'car', 1),
  ('real_estate', 'عقارات', 'real_estate', 2),
  ('mobiles', 'موبايلات', 'mobile', 3),
  ('electronics', 'إلكترونيات', 'electronics', 4),
  ('furniture', 'أثاث', 'furniture', 5),
  ('jobs_services', 'وظائف وخدمات', 'jobs', 6),
  ('animals_birds', 'طيور وحيوانات', 'animals', 7)
on conflict (id) do nothing;

-- 2) جدول الملفات الشخصية (يُنشأ تلقائياً عند تسجيل مستخدم جديد) ---------
create table if not exists public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text,
  phone text,
  email text,
  is_admin boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

create policy "profiles_select_own"
  on public.profiles for select
  using (auth.uid() = id);

create policy "profiles_update_own"
  on public.profiles for update
  using (auth.uid() = id);

-- Trigger: إنشاء صف profile تلقائياً عند إنشاء مستخدم جديد، وتحديد
-- صلاحية الأدمن تلقائياً إذا كان البريد مطابقاً للبريد الإداري المعتمد.
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = public
as $$
begin
  insert into public.profiles (id, full_name, phone, email, is_admin)
  values (
    new.id,
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'phone',
    new.email,
    lower(new.email) = lower('sameraoaab@gmail.com')
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- 3) جدول الإعلانات ---------------------------------------------------------
create table if not exists public.ads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  category_id text not null references public.categories (id),
  title text not null,
  description text,
  price numeric(14, 2) not null default 0,
  currency text not null default 'SYP',
  city text not null,
  image_url text,
  is_featured boolean not null default false,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

alter table public.ads enable row level security;

create policy "ads_select_active"
  on public.ads for select
  using (is_active = true);

create policy "ads_insert_own"
  on public.ads for insert
  with check (auth.uid() = user_id);

create policy "ads_update_own"
  on public.ads for update
  using (auth.uid() = user_id);

create policy "ads_delete_own"
  on public.ads for delete
  using (auth.uid() = user_id);

create index if not exists ads_category_idx on public.ads (category_id);
create index if not exists ads_created_at_idx on public.ads (created_at desc);

-- 4) جدول المفضلة ------------------------------------------------------------
create table if not exists public.favorites (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  ad_id uuid not null references public.ads (id) on delete cascade,
  created_at timestamptz not null default now(),
  unique (user_id, ad_id)
);

alter table public.favorites enable row level security;

create policy "favorites_select_own"
  on public.favorites for select
  using (auth.uid() = user_id);

create policy "favorites_insert_own"
  on public.favorites for insert
  with check (auth.uid() = user_id);

create policy "favorites_delete_own"
  on public.favorites for delete
  using (auth.uid() = user_id);

-- 5) مخزن الصور (Storage) -----------------------------------------------
-- ملاحظة: أنشئ الـ Bucket باسم "ads-images" يدوياً من واجهة
-- Supabase Storage (Public bucket)، ثم نفّذ سياسات الوصول التالية:

insert into storage.buckets (id, name, public)
values ('ads-images', 'ads-images', true)
on conflict (id) do nothing;

create policy "ads_images_public_read"
  on storage.objects for select
  using (bucket_id = 'ads-images');

create policy "ads_images_auth_upload"
  on storage.objects for insert
  with check (bucket_id = 'ads-images' and auth.role() = 'authenticated');

create policy "ads_images_owner_delete"
  on storage.objects for delete
  using (bucket_id = 'ads-images' and auth.uid() = owner);
