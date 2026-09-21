import './globals.css';

export const metadata = {
  title: 'BuyLink',
  description: 'Discover and sell products, TikTok-style.',
};

export default function RootLayout({ children }) {
  return (
    <html lang="en">
      <body className="font-body min-h-screen">
        <nav className="flex items-center justify-between px-6 py-4 border-b border-ink/10">
          <a href="/" className="font-display text-xl">BuyLink</a>
          <div className="flex gap-5 text-sm">
            <a href="/products" className="hover:text-clay">Browse</a>
            <a href="/dashboard" className="hover:text-clay">Sell</a>
            <a href="/login" className="hover:text-clay">Log in</a>
          </div>
        </nav>
        <main>{children}</main>
      </body>
    </html>
  );
}
