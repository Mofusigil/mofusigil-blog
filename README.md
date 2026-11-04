# 魔符sigil 的个人博客

基于 Typst 的匿名个人博客，记录算法竞赛、C++ 网络编程、分布式系统与 AI 系统的学习和实践。

## 本地运行

需要 Node.js 24 和 Typst 0.15.1（启用 HTML 导出）。当前工作区已在被 Git 忽略的 `.tools/` 中准备本地 Typst；新环境可安装 `typst`，或通过 `TYPST_BIN` 指定可执行文件。Typst 包缓存保存在 `.tools/typst-packages/`。

```sh
npm ci
npm run build
npm run check
npm run preview
```

预览地址是 `http://127.0.0.1:4173`，可用 `PORT` 修改端口。修改源码后重新运行构建并刷新浏览器即可。

## 内容维护

- `site.config.json`：站点名、公开作者名、介绍和正式域名。只放准备公开的信息。
- `config.typ`：导航、页脚、主题配置与标签样式。
- `pages/index.typ`：首页；`pages/about/index.typ`：匿名介绍和竞赛足迹。
- `pages/projects/index.typ`：项目和工程实践。
- `posts/<slug>/index.typ`：文章，包含标题、摘要、日期、标签、分类与正文。
- `assets/custom.css`：浅色 / 深色主题及响应式布局。
- `assets/sigil-logo.png`：你提供的原图，用于导航 Logo、首页、关于页头像与浏览器图标。
- 主题采用天空蓝、白色与浅冰蓝；深色主题使用深蓝背景。

原模板文章已替换为四篇根据个人经历整理的初稿，分别介绍博客、RPC 项目、算法竞赛与 AI 系统学习方向。文章日期为整理日期，项目和实习时间在正文中单独标注。

新增文章时，可参照现有 `posts/` 下的 Typst 文件。重新构建后，分类、标签、归档与前后篇导航会自动更新。

## 公开信息与隐私

全站公开身份为“魔符sigil”。申请材料原件、真名、手机号、邮箱、证件信息、成绩单、推荐信和签名图片均未复制到项目或站点中。未配置未经确认的个人社交链接。

`npm run check` 检查构建后的作者元数据、本地链接、原模板账号与追踪器残留，以及私密文档、手机号、邮箱和证件号码。它不能代替发布前对新增文字的人工检查。

## GitHub Pages 发布

本站的目标网址为 `https://mofusigil.github.io/mofusigil-blog/`。源码保存在 `main` 分支，编译后的网页保存在 `gh-pages` 分支。

首次发布前运行：

```sh
npm run publish:pages
```

此命令编译 Typst，生成 `_site-pages/`，适配 `/mofusigil-blog/` 下的页面、图片、CSS、标签图标和导航，检查所有本地链接，再将静态产物推送到 `origin` 的 `gh-pages` 分支。它不会修改 `main` 工作区，也不会强制覆盖远程历史；发布提交使用公开昵称与 GitHub noreply 邮箱。

首次启用：

1. 打开仓库 **Settings → Pages**。
2. 在 **Build and deployment → Source** 选择 **Deploy from a branch**。
3. 选择 **gh-pages** 分支和 **/(root)**，点击 **Save**。
4. 部署完成后，打开 `https://mofusigil.github.io/mofusigil-blog/`。

以后修改文章或页面后，再运行 `npm run publish:pages` 即可更新。只上传 `main` 源码不会更新网页。

如果只想生成静态文件而不推送，运行 `npm run build:pages`。`_site/` 仍用于普通本地预览，`_site-pages/` 用于 GitHub 项目网站。后者包含 `.nojekyll`，避免 GitHub 再用 Jekyll 处理已经编译好的文件。

`site.config.json` 中的 `siteUrl` 控制 canonical 链接、RSS 与 GitHub Pages 项目路径；更换域名或仓库名后需要更新并重新发布。自动构建配置仍保存在 `ci/github-actions-build.example.yml`，是未启用的模板。当前的静态分支发布方式无需凭据拥有修改 Actions 工作流的权限。

## 来源

使用 [Carbon Typst Blog](https://github.com/tiger2005/carbon-typst-blog) 的 Typst HTML 生成框架，保留通用排版和路由能力。原作者的个人文章与身份内容不属于本站作者。
