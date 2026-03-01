-- Supabase Auth Data Model & User Profiles Setup
-- This script should be run in the Supabase SQL Editor.

-- 1. Create a table for public profiles
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  full_name TEXT,
  avatar_url TEXT,
  role TEXT DEFAULT 'staff' CHECK (role IN ('admin', 'staff', 'manager')),
  cafe_branch TEXT DEFAULT 'Donero-Main',
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()),
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now())
);

-- 2. Enable Row Level Security (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

-- 3. Create RLS Policies
-- Users can view their own profile
CREATE POLICY "Users can view own profile" 
ON public.profiles FOR SELECT 
USING (auth.uid() = id);

-- Users can update their own profile
CREATE POLICY "Users can update own profile" 
ON public.profiles FOR UPDATE 
USING (auth.uid() = id);

-- 4. Create a trigger to automatically insert a profile row on signup
CREATE OR REPLACE FUNCTION public.handle_new_user() 
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, avatar_url)
  VALUES (new.id, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. Attach the trigger to the auth.users table
-- This trigger fires every time a new user is created in the auth schema
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- Optional: Create a view for admin to see all profiles (admin only policy)
-- CREATE POLICY "Admins can view all profiles" 
-- ON public.profiles FOR SELECT 
-- USING ( (SELECT role FROM public.profiles WHERE id = auth.uid()) = 'admin' );
