#import "lib/typ2html/typ2html.typ": *
#import "lib/typ2html/sys-input.typ": query-input

// This file and site.config.json contain public information only.
#let site = json("site.config.json")
#let feed-enabled = site.siteUrl != ""

#let footer-content = html-guard(() => {
  html.div(class: "sigil-footer", {
    html.div(class: "footer-signature", {
      html.a(class: "footer-brand", href: "/", site.siteTitle)
      html.p("在代码里探索，在文字里沉淀。")
    })
    html.div(class: "footer-links", {
      html.a(href: "/page/1/", "文字")
      html.a(href: "/projects/", "项目")
      html.a(href: "/about/", "关于")
      if feed-enabled { html.a(href: "/rss.xml", "RSS ↗") }
    })
    html.div(class: "footer-colophon", {
      html.span("© " + datetime.today().display("[year]") + " " + site.author)
      html.span("Built with Typst · Keep exploring.")
    })
  })
})

#let tag-options = (
  "C++": ("preset": "blue", "icon": "/assets/icons/array--strings.svg"),
  "分布式系统": ("preset": "cyan", "icon": "/assets/icons/app-connectivity.svg"),
  "网络编程": ("preset": "blue", "icon": "/assets/icons/flow--modeler--reference.svg"),
  "算法竞赛": ("preset": "cyan", "icon": "/assets/icons/concept.svg"),
  "后端开发": ("preset": "blue", "icon": "/assets/icons/data-bin.svg"),
  "AI 系统": ("preset": "blue", "icon": "/assets/icons/matrix.svg"),
  "随笔": ("preset": "cool-gray", "icon": "/assets/icons/pen.svg"),
)

#let render-tag-link = render-tag-link.with(tag-options: tag-options)
#let render-tag-card = render-tag-card.with(tag-options: tag-options)

#let templates = make-templates(
  site-title: site.siteTitle,
  title: site.siteTitle,
  description: site.description,
  author: site.author,
  lang: "zh",
  header-links: (
    "/": "首页",
    "/page/1/": "文字",
    "/projects/": "项目",
    "/archive/": "归档",
    "/about/": "关于",
  ),
  footer-content: footer-content,
  tag-options: tag-options,
  giscus-config: none,
  feed-enabled: feed-enabled,
  post-scripts: (
    "/assets/core/theme.js",
    "/assets/core/post-nav-switch.js",
    "/assets/code-copy.js",
  ),
  custom-css: ("/assets/custom.css",),
  custom-script: ("/assets/custom.js",),
)

#let template-page = templates.page
#let template-post(..args) = {
  set page(height: auto, width: 30cm)
  set text(16pt, font: ("Noto Sans CJK SC", "DejaVu Sans"), lang: "zh")
  show raw: text.with(font: ("DejaVu Sans Mono", "Noto Sans CJK SC"))
  set table(inset: 8pt)
  (templates.post)(..args)
}

#let section-heading(number, label, title, href: none, action: "查看全部 ↗") = {
  html.div(class: "section-heading", {
    html.div({
      html.div(class: "eyebrow", number + " / " + label)
      html.h2(title)
    })
    if href != none { html.a(class: "text-link", href: href, action) }
  })
}

#let tech-labels(items) = html.div(class: "tech-labels", {
  for item in items { html.span(item) }
})
