for (const pre of document.querySelectorAll('pre')) {
  const code = pre.querySelector('code');
  if (!code) continue;
  const button = document.createElement('button');
  button.className = 'sigil-copy';
  button.type = 'button';
  button.textContent = '复制';
  button.setAttribute('aria-label', '复制代码');
  button.addEventListener('click', async () => {
    try {
      await navigator.clipboard.writeText(code.textContent);
      button.textContent = '已复制';
    } catch {
      button.textContent = '请选中文本复制';
    }
    setTimeout(() => { button.textContent = '复制'; }, 1800);
  });
  pre.append(button);
}
