import { existsSync, readFileSync, readdirSync, statSync } from 'node:fs';
import { dirname, extname, join, resolve, sep } from 'node:path';
import { fileURLToPath } from 'node:url';

const repo = resolve(dirname(fileURLToPath(import.meta.url)), '../..');
const root = resolve(repo, process.argv[2] || '_site');
const config = JSON.parse(readFileSync(join(repo, 'site.config.json'), 'utf8'));
const basePath = root.endsWith('_site-pages') && config.siteUrl ? new URL(config.siteUrl).pathname.replace(/\/+$/, '') : '';
const errors = [];
if (!existsSync(join(root, 'index.html'))) throw new Error('Build the site before running the checks.');
const walk = (directory) => readdirSync(directory, { withFileTypes: true }).flatMap((entry) => {
  const target = join(directory, entry.name);
  return entry.isDirectory() ? walk(target) : [target];
});
const files = walk(root);
const pages = files.filter((file) => extname(file) === '.html');
const decode = (text) => text.replace(/&amp;/g, '&').replace(/&quot;/g, '"').replace(/&#39;/g, "'");
const ids = new Map(pages.map((file) => [file, new Set([...readFileSync(file, 'utf8').matchAll(/\bid="([^"]+)"/g)].map((match) => match[1]))]));
let links = 0;
const checkLink = (raw, from, checkHash = true) => {
  const value = decode(raw);
  if (!value || /^(https?:|mailto:|tel:|data:|blob:|javascript:|\/\/)/i.test(value)) return;
  let url;
  try { url = new URL(value, `https://local.invalid${basePath}/${from.slice(root.length + 1)}`); }
  catch { errors.push(`Invalid link in ${from.slice(root.length + 1)}`); return; }
  let pathname = decodeURIComponent(url.pathname);
  if (basePath) {
    if (!pathname.startsWith(basePath + '/') && pathname !== basePath) {
      errors.push(`Missing project path in ${from.slice(root.length + 1)}: ${pathname}`);
      return;
    }
    pathname = pathname.slice(basePath.length) || '/';
  }
  let target = resolve(root, '.' + pathname);
  if (target !== root && !target.startsWith(root + sep)) { errors.push('Link escapes output directory'); return; }
  if (existsSync(target) && statSync(target).isDirectory()) target = join(target, 'index.html');
  if (!existsSync(target)) {
    errors.push(`Missing target ${pathname} in ${from.slice(root.length + 1)}`);
    return;
  }
  if (checkHash && url.hash && ids.has(target) && !ids.get(target).has(decodeURIComponent(url.hash.slice(1)))) {
    errors.push(`Missing anchor ${url.hash} in ${target.slice(root.length + 1)}`);
  }
  links++;
};

for (const file of files) {
  const extension = extname(file).toLowerCase();
  if (['.pdf', '.docx', '.doc', '.xlsx'].includes(extension)) errors.push('Private document found in build output');
  if (!['.html', '.css', '.js', '.svg', '.xml', '.json', '.txt'].includes(extension)) continue;
  const content = readFileSync(file, 'utf8');
  if (/tiger2005|vercount\.one|giscus\.app|350620554/i.test(content)) errors.push(`Template account or tracker remains in ${file.slice(root.length + 1)}`);
  // Generic checks avoid placing any private name or number into this repository.
  if (/(?<!\d)[1-9]\d{5}(?:19|20)\d{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[12]\d|3[01])\d{3}[\dXx](?!\d)/.test(content)) errors.push(`Possible identity number in ${file.slice(root.length + 1)}`);
  if (/(?:\+86[ -]?)?(?<!\d)1[3-9]\d{9}(?!\d)/.test(content)) errors.push(`Possible personal phone number in ${file.slice(root.length + 1)}`);
  if (/[\w.+-]+@[\w.-]+\.[a-z]{2,}/i.test(content)) errors.push(`Possible personal email in ${file.slice(root.length + 1)}`);
  if (extension === '.html') {
    const author = content.match(/<meta\s+name="author"\s+content="([^"]+)"/);
    if (author?.[1] !== config.author) errors.push(`Unexpected author metadata in ${file.slice(root.length + 1)}`);
    if (!content.includes(config.siteTitle)) errors.push(`Missing site identity in ${file.slice(root.length + 1)}`);
    for (const match of content.matchAll(/\b(?:href|src|data-post-url)="([^"]*)"/g)) checkLink(match[1], file);
    for (const style of content.matchAll(/\bstyle="([^"]*)"/g)) {
      for (const match of decode(style[1]).matchAll(/url\(\s*["']?([^"')\s]+)["']?\s*\)/g)) checkLink(match[1], file, false);
    }
  }
  if (extension === '.css') {
    for (const match of content.matchAll(/url\(\s*["']?([^"')\s]+)["']?\s*\)/g)) checkLink(match[1], file, false);
  }
}
if (config.siteUrl && !existsSync(join(root, 'rss.xml'))) errors.push('Configured domain should produce RSS');
if (!config.siteUrl && existsSync(join(root, 'rss.xml'))) errors.push('RSS should wait for a configured domain');
if (errors.length) {
  console.error([...new Set(errors)].join('\n'));
  process.exit(1);
}
console.log(`Passed: ${pages.length} pages, ${links} local links/assets; public author verified; no template accounts, trackers, private documents or contact details.`);
