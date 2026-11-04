const key = 'sigil-theme';
const button = document.querySelector('.nav-theme-switch');
const media = window.matchMedia('(prefers-color-scheme: dark)');
const stored = () => {
  try { return localStorage.getItem(key); } catch { return null; }
};
const apply = (theme) => {
  const dark = theme === 'gray-90';
  document.documentElement.setAttribute('data-theme', dark ? 'gray-90' : 'gray-10');
  button?.setAttribute('aria-label', dark ? '切换到浅色主题' : '切换到深色主题');
  button?.setAttribute('aria-pressed', String(dark));
};
apply(stored() || (media.matches ? 'gray-90' : 'gray-10'));
button?.addEventListener('click', () => {
  const theme = document.documentElement.getAttribute('data-theme') === 'gray-90' ? 'gray-10' : 'gray-90';
  apply(theme);
  try { localStorage.setItem(key, theme); } catch { /* Private browsing may block storage. */ }
});
media.addEventListener('change', () => { if (!stored()) apply(media.matches ? 'gray-90' : 'gray-10'); });
