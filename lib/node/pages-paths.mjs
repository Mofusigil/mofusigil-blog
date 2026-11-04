// Apply a GitHub project path to actual resource attributes, leaving prose alone.
export const prefixRootUrl = (url, basePath) => {
  if (!basePath || !url.startsWith('/') || url.startsWith('//')) return url;
  if (url === basePath || url.startsWith(basePath + '/')) return url;
  return basePath + url;
};

export const prefixCssUrls = (content, basePath) => content.replace(
  /url\(\s*(["']|&quot;|&apos;|&#34;|&#39;)?(\/(?!\/)[^)]*?)\1\s*\)/g,
  (_match, quote = '', url) => `url(${quote}${prefixRootUrl(url.trim(), basePath)}${quote})`,
);

export const prefixHtmlUrls = (content, basePath) => content
  .replace(/(\b(?:href|src|data-post-url|poster|action)\s*=\s*)(["'])([^"']*)\2/g,
    (_match, attribute, quote, url) => `${attribute}${quote}${prefixRootUrl(url, basePath)}${quote}`)
  .replace(/(\bstyle\s*=\s*)(["'])(.*?)\2/g,
    (_match, attribute, quote, style) => `${attribute}${quote}${prefixCssUrls(style, basePath)}${quote}`);
