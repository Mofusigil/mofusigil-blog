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

## 域名与发布

构建产物位于 `_site/`，可部署到任意静态网站托管平台。当前仅完成本地定制。

`site.config.json` 中的 `siteUrl` 为空，因此不会生成指向他人域名或示例域名的 canonical 链接，也暂不生成 RSS。填入自己的正式 HTTPS 域名后，重新构建即可自动生成 RSS 并显示订阅入口。

自动构建配置保存在 `ci/github-actions-build.example.yml`，作为未启用的 GitHub Actions 模板。需要自动构建时，可将它复制到 `.github/workflows/build.yml` 后提交；该模板只构建、检查并上传静态产物。原作者的 Cloudflare 部署、评论仓库和访问统计均已移除。

## 来源

使用 [Carbon Typst Blog](https://github.com/tiger2005/carbon-typst-blog) 的 Typst HTML 生成框架，保留通用排版和路由能力。原作者的个人文章与身份内容不属于本站作者。
