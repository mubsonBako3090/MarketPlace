# BuyLink — Phase 1

Auth + store creation + product listing, built with Next.js and Supabase.

## Setup

1. **Create a Supabase project** at supabase.com (free tier is fine).
2. In the Supabase SQL editor, run `supabase/schema.sql` to create the
   `profiles`, `stores`, and `products` tables with row-level security.
3. Copy `.env.local.example` to `.env.local` and fill in your project's
   URL and anon key (Project Settings → API in Supabase).
4. Install dependencies and run:
   ```
   npm install
   npm run dev
   ```
5. Open http://localhost:3000

## What's built (Phase 1)

- `/signup` — create an account as buyer, seller, or both
- `/login` — log in
- `/dashboard` — sellers create their store here
- `/dashboard/products/new` — add a product to your store
- `/products` — buyers browse all listed products

## Not yet built (later phases)

- Photo/video upload for products (Phase 2/4 — needs Supabase Storage or Cloudinary)
- Search and category filters (Phase 2)
- Buyer–seller messaging (Phase 3)
- Social feed / vertical swipe view (Phase 4)

## Notes

- Auth and RLS are wired so a seller can only edit their own store/products,
  but anyone can view stores and products (public marketplace).
- Styling uses Tailwind with a small custom palette in `tailwind.config.js` —
  change `clay`/`ink`/`sand`/`moss` there to rebrand.
