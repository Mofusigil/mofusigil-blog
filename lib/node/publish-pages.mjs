import { cpSync, existsSync, mkdtempSync, readFileSync, readdirSync, rmSync } from 'node:fs';
import { tmpdir } from 'node:os';
import { dirname, join, resolve } from 'node:path';
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';

const repo = resolve(dirname(fileURLToPath(import.meta.url)), '../..');
const output = join(repo, '_site-pages');
const config = JSON.parse(readFileSync(join(repo, 'site.config.json'), 'utf8'));
if (!existsSync(join(output, 'index.html')) || !existsSync(join(output, '.nojekyll'))) {
  throw new Error('Run npm run build:pages before publishing.');
}
const git = (args, cwd = repo, quiet = false, env = process.env) => {
  const result = spawnSync('git', args, { cwd, env: { ...env, GIT_TERMINAL_PROMPT: '0' }, encoding: 'utf8', stdio: quiet ? 'pipe' : 'inherit' });
  if (result.error) throw result.error;
  if (result.status !== 0) throw new Error(`Git ${args[0]} failed${quiet ? ': ' + (result.stderr || '').trim() : ''}`);
  return (result.stdout || '').trim();
};
const remote = git(['remote', 'get-url', 'origin'], repo, true);
const match = remote.match(/^(?:https:\/\/github\.com\/|git@github\.com:)([A-Za-z0-9-]+)\/([A-Za-z0-9_.-]+?)(?:\.git)?$/);
if (!match) throw new Error('origin must point to the intended GitHub repository without embedded credentials.');
const [, owner, repository] = match;
const identity = {
  ...process.env,
  GIT_AUTHOR_NAME: config.author,
  GIT_AUTHOR_EMAIL: `${owner}@users.noreply.github.com`,
  GIT_COMMITTER_NAME: config.author,
  GIT_COMMITTER_EMAIL: `${owner}@users.noreply.github.com`,
};
const existing = git(['ls-remote', '--heads', remote, 'refs/heads/gh-pages'], repo, true);
const temporary = mkdtempSync(join(tmpdir(), 'mofusigil-pages-'));
try {
  git(['init', '--initial-branch=codex/pages-publish'], temporary);
  git(['remote', 'add', 'origin', remote], temporary);
  if (existing) {
    git(['fetch', '--depth=1', 'origin', 'gh-pages'], temporary);
    git(['checkout', '-B', 'codex/pages-publish', 'FETCH_HEAD'], temporary);
  }
  for (const entry of readdirSync(temporary)) {
    if (entry !== '.git') rmSync(join(temporary, entry), { recursive: true, force: true });
  }
  cpSync(output, temporary, { recursive: true });
  git(['add', '--all'], temporary);
  const changed = spawnSync('git', ['diff', '--cached', '--quiet'], { cwd: temporary });
  if (changed.status === 1) git(['commit', '-m', 'Publish compiled Mofusigil blog for GitHub Pages'], temporary, false, identity);
  else if (changed.status !== 0) throw new Error('Unable to inspect the publishing commit.');
  git(['push', 'origin', 'HEAD:gh-pages'], temporary);
  const expected = git(['rev-parse', 'HEAD'], temporary, true);
  const actual = git(['ls-remote', 'origin', 'refs/heads/gh-pages'], temporary, true).split(/\s+/)[0];
  if (actual !== expected) throw new Error('The publishing branch did not match the compiled commit.');
  console.log(`Verified static branch: https://github.com/${owner}/${repository}/tree/gh-pages`);
  console.log('First publication: Settings → Pages → Deploy from a branch → gh-pages → /(root) → Save.');
} finally {
  rmSync(temporary, { recursive: true, force: true });
}
