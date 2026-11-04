const iconUrl = document.querySelector('link[rel="icon"]')?.getAttribute('href') || '/assets/';
const assetIndex = iconUrl.indexOf('/assets/');
const basePath = assetIndex > 0 ? iconUrl.slice(0, assetIndex) : '';
const localPath = (value) => basePath && value.startsWith(basePath + '/') ? value.slice(basePath.length) : value;
const path = localPath(window.location.pathname);
const section = path.startsWith('/posts/') || path.startsWith('/tags/') || path.startsWith('/categories/')
  ? '/page/1/'
  : path.startsWith('/page/') ? '/page/1/' : path;
for (const link of document.querySelectorAll('header a[href]')) {
  if (localPath(link.getAttribute('href')) === section) link.setAttribute('aria-current', 'page');
}
