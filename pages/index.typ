#import "../config.typ": *

#let route-page-raw = query-input("route-page", default: none)
#let is-home = route-page-raw == none
#let posts = query-posts()
#let current-page = if is-home { 1 } else { calc.max(1, int(route-page-raw)) }
#let bounds = query-page-bounds(posts.len(), page: current-page, page-size: query-route-page-size(default: 10))

#show: template-page.with(
  title: if is-home { "代码与思考" } else { "文字" },
  description: if is-home { site.description } else { "魔符sigil 的项目记录、算法笔记与学习随笔。" },
)

#if is-home {
  html.elem("section", attrs: (class: "sigil-hero", "aria-labelledby": "hero-title"), {
    html.div(class: "hero-copy", {
      html.div(class: "eyebrow hero-eyebrow", {
        html.span(class: "status-dot")
        "HELLO, WORLD. I'M SIGIL."
      })
      html.p(class: "hero-greeting", "你好，我是魔符sigil。")
      html.h1(id: "hero-title", {
        "把好奇心，"
        html.br()
        html.span("写进代码。")
      })
      html.p(class: "hero-description", "从算法竞赛到分布式系统，从 C++ 到后端工程。在这里记录每一次拆解问题、动手构建和重新理解的过程。")
      html.div(class: "hero-actions", {
        html.a(class: "button-primary", href: "/page/1/", { "读读我的文字"; html.span("↗") })
        html.a(class: "text-link", href: "/about/", "认识一下我 →")
      })
    })
    html.div(class: "hero-art", {
      html.div(class: "art-topline", { html.span("THE SIGIL / 魔符"); html.span("NO. 001") })
      html.elem("img", attrs: (src: "/assets/sigil-logo.png", alt: "魔符sigil 的头像", width: "750", height: "750"))
      html.div(class: "art-bottomline", { html.span("ALGORITHMS → SYSTEMS → AI"); html.span("持续探索中 ↗") })
    })
  })

  html.div(class: "profile-strip", {
    html.div({ html.span(class: "strip-label", "学习 / STUDY"); html.span("湖南大学 · 计算机科学与技术") })
    html.div({ html.span(class: "strip-label", "实践 / BUILD"); html.span("C++ · 网络编程 · 分布式系统") })
    html.div({ html.span(class: "strip-label", "关注 / EXPLORE"); html.span("后端工程 · AI 系统") })
  })

  html.elem("section", attrs: (class: "home-project", "aria-label": "项目实践"), {
    section-heading("01", "SELECTED BUILD", "让想法跑起来", href: "/projects/", action: "项目与实践 ↗")
    html.a(class: "featured-project", href: "/posts/rpc-system/", {
      html.div(class: "project-visual", {
        html.elem("img", attrs: (src: "/assets/rpc-flow.svg", alt: "C++ RPC 项目：客户端、ZooKeeper 注册中心与服务端之间的调用关系", loading: "lazy", width: "640", height: "360"))
      })
      html.div(class: "project-summary", {
        html.div(class: "eyebrow", "C++ / DISTRIBUTED SYSTEMS")
        html.h3("一套 RPC 系统，\n一次工程探索")
        html.p("从服务注册、网络通信到远程调用，把课本里的概念串成一条真实的请求链路。")
        tech-labels(("Muduo", "Protobuf", "ZooKeeper", "Glog"))
        html.span(class: "project-read", "阅读项目记录 ↗")
      })
    })
  })

  html.elem("section", attrs: (class: "home-notes", "aria-label": "最近的文字"), {
    section-heading("02", "RECENT NOTES", "留下一点思考", href: "/page/1/")
    html.div(class: "note-list", {
      for (i, post) in posts.rev().slice(0, calc.min(4, posts.len())).enumerate() {
        html.a(class: "note-row", href: post.url, {
          html.span(class: "note-number", "0" + str(i + 1))
          html.div(class: "note-content", {
            html.div(class: "note-meta", post.category + " / " + post.date)
            html.h3(post.title)
            html.p(post.description)
          })
          html.span(class: "note-arrow", "↗")
        })
      }
    })
  })

  html.elem("section", attrs: (class: "home-path", "aria-label": "学习与实践方向"), {
    section-heading("03", "A WORK IN PROGRESS", "保持探索的状态")
    html.div(class: "path-grid", {
      html.div(class: "path-intro", {
        html.h3("从一道题，\n到一个系统。")
        html.p("算法训练给了我拆解问题的习惯。工程实践让我开始关心，代码如何在更复杂的环境中可靠运行。")
        html.a(class: "text-link", href: "/about/", "更多关于我 ↗")
      })
      html.div(class: "path-items", {
        html.div(class: "path-item", {
          html.span(class: "path-index", "01")
          html.div({ html.h3("算法与竞赛"); html.p("在 ICPC、CCPC 与校队训练中，练习严谨的推导、实现与团队协作。") })
        })
        html.div(class: "path-item", {
          html.span(class: "path-index", "02")
          html.div({ html.h3("后端与系统"); html.p("从 C++ RPC 项目到美团后端实习，理解网络、并发与服务之间的关系。") })
        })
        html.div(class: "path-item", {
          html.span(class: "path-index", "03")
          html.div({ html.h3("走近 AI 系统"); html.p("带着系统编程的基础，继续学习模型部署、推理效率与工程实现。") })
        })
      })
    })
  })

  html.div(class: "closing-note", {
    html.span(class: "status-dot")
    "把问题想清楚，也把过程留下来。"
    html.a(href: "/archive/", "慢慢积累 ↗")
  })
} else {
  render-page-breadcrumb(items: (("/", "首页"),))
  html.div(class: "page-intro", {
    html.div(class: "eyebrow", "NOTES / THOUGHTS / PRACTICE")
    html.h1("文字")
    html.p("写下做过的事，也记录还在思考的问题。")
    html.div(class: "index-links", { html.a(href: "/categories/", "按分类浏览 ↗"); html.a(href: "/tags/", "按标签浏览 ↗") })
  })
  html.div(class: "posts-grid", {
    for i in range(int(bounds.at("end-index")), int(bounds.at("start-index")) - 1, step: -1) {
      let post = posts.at(i)
      html.elem("div", attrs: (class: "post-card", "data-post-url": post.url), {
        html.div(class: "note-meta", post.category + " / " + post.date)
        html.div(class: "post-title", html.a(class: "post-card-link", href: post.url, post.title))
        html.div(class: "post-description", post.description)
        html.div(class: "post-card-tags", {
          for tag in post.tags { render-tag-link(tag, href: "/tags/" + query-tag-slug-of(tag) + "/") }
        })
      })
    }
  })
  render-pagination-nav("/", current-page, int(bounds.at("total-pages")), aria-label: "文章列表分页", always-paged: true)
}
