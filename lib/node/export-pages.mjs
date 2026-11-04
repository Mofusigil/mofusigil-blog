import { cpSync, existsSync, mkdirSync, readFileSync, readdirSync, rmSync, writeFileSync } from 'node:fs';
import { dirname, extname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';
import { prefixCssUrls, prefixHtmlUrls } from './pages-paths.mjs';

const repo = resolve(dirname(fileURLToPath(import.meta.url)), '../..');
const source = join(repo, '_site');
const output = join(repo, '_site-pages');
const config = JSON.parse(readFileSync(join(repo, 'site.config.json'), 'utf8'));
if (!config.siteUrl) throw new Error('Set the public GitHub Pages URL in site.config.json first.');
const basePath = new URL(config.siteUrl).pathname.replace(/\/+$/, '');
if (!existsSync(join(source, 'index.html'))) throw new Error('Build the site before exporting GitHub Pages.');

rmSync(output, { recursive: true, force: true });
mkdirSync(output, { recursive: true });
cpSync(source, output, { recursive: true });
const visit = (directory) => {
  for (const entry of readdirSync(directory, { withFileTypes: true })) {
    const path = join(directory, entry.name);
    if (entry.isDirectory()) { visit(path); continue; }
    const extension = extname(path);
    if (extension !== '.html' && extension !== '.css') continue;
    const text = readFileSync(path, 'utf8');
    writeFileSync(path, extension === '.html' ? prefixHtmlUrls(text, basePath) : prefixCssUrls(text, basePath));
  }
};
visit(output);
// Branch publishing should serve these compiled files directly, without Jekyll.
writeFileSync(join(output, '.nojekyll'), '');
rmSync(join(output, '_headers'), { force: true });
console.log(`GitHub Pages files: ${output}\nProject path: ${basePath || '/'}\nPublic URL: ${config.siteUrl}/`);
