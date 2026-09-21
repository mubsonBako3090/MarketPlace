'use client';

import { useEffect, useState } from 'react';
import { supabase } from '../../lib/supabaseClient';

export default function ProductsPage() {
  const [products, setProducts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function load() {
      const { data } = await supabase
        .from('products')
        .select('*, stores(name)')
        .order('created_at', { ascending: false });
      setProducts(data || []);
      setLoading(false);
    }
    load();
  }, []);

  if (loading) return <p className="px-6 py-16 text-center">Loading…</p>;

  if (products.length === 0) {
    return (
      <div className="max-w-md mx-auto px-6 py-20 text-center">
        <h1 className="font-display text-2xl mb-2">No products yet</h1>
        <p className="text-ink/60">Be the first to list something.</p>
        <a href="/dashboard" className="underline mt-4 inline-block">Start selling</a>
      </div>
    );
  }

  return (
    <div className="max-w-5xl mx-auto px-6 py-12">
      <h1 className="font-display text-3xl mb-8">Browse products</h1>
      <div className="grid grid-cols-2 md:grid-cols-3 gap-6">
        {products.map((product) => (
          <div key={product.id} className="border border-ink/10 rounded-lg p-4">
            <p className="font-display text-lg">{product.title}</p>
            <p className="text-ink/60 text-sm mb-1">{product.stores?.name}</p>
            <p className="text-clay font-medium">₦{Number(product.price).toLocaleString()}</p>
          </div>
        ))}
      </div>
    </div>
  );
}
