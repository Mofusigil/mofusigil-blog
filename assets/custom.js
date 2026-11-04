const path = window.location.pathname;
const section = path.startsWith('/posts/') || path.startsWith('/tags/') || path.startsWith('/categories/')
  ? '/page/1/'
  : path.startsWith('/page/') ? '/page/1/' : path;
for (const link of document.querySelectorAll('header a[href]')) {
  if (link.getAttribute('href') === section) link.setAttribute('aria-current', 'page');
}
