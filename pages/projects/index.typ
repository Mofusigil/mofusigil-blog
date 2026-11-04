#import "../../config.typ": *
#show: template-page.with(title: "项目与实践", description: "魔符sigil 的 C++ 分布式 RPC 项目与后端工程实践。")
#render-page-breadcrumb(items: (("/", "首页"),))

#html.div(class: "page-intro", {
  html.div(class: "eyebrow", "BUILDS / SYSTEMS / EXPERIENCE")
  html.h1("项目与实践")
  html.p("用代码把概念接起来，在实践里理解系统。")
})

#html.elem("section", attrs: (class: "project-detail"), {
  html.div(class: "project-detail-head", {
    html.div({ html.div(class: "eyebrow", "01 / PERSONAL PROJECT"); html.h2("C++ 分布式 RPC 系统") })
    html.span(class: "project-period", "2026.02 — 2026.03")
  })
  html.p("独立实现本地服务在 RPC 节点上的注册、发布与远程调用，围绕网络通信、消息协议、服务发现和日志组织完整链路。")
  tech-labels(("C++", "Muduo", "Reactor", "Protobuf", "ZooKeeper", "Glog"))
  html.elem("img", attrs: (class: "project-detail-image", src: "/assets/rpc-flow.svg", alt: "客户端通过 TCP 与服务端通信，ZooKeeper 提供服务注册与发现", width: "640", height: "360"))
  html.div(class: "project-modules", {
    html.div({ html.h3("网络与协议"); html.p("基于 Muduo 的 Reactor 模型解耦网络 I/O 与业务逻辑，以自定义协议和 Protobuf 处理消息边界与序列化。") })
    html.div({ html.h3("注册与发现"); html.p("引入 ZooKeeper 及 Watcher 机制，支持服务的动态注册与发现。") })
    html.div({ html.h3("日志与排查"); html.p("使用 Glog 记录系统运行信息，辅助定位跨模块调用中的问题。") })
  })
  html.a(class: "button-primary", href: "/posts/rpc-system/", { "阅读完整项目记录"; html.span("↗") })
})

#html.elem("section", attrs: (class: "experience-section"), {
  html.div(class: "project-detail-head", {
    html.div({ html.div(class: "eyebrow", "02 / ENGINEERING EXPERIENCE"); html.h2("美团 · 软件开发实习") })
    html.span(class: "project-period", "2026.05 — 2026.07")
  })
  html.p("在真实后端业务中，学习从单个功能到完整服务的工程思路。")
  html.div(class: "experience-list", {
    html.div({ html.span("01"); html.div({ html.h3("理解企业级架构"); html.p("学习后端开发规范、Java 微服务与分布式中间件，理解模块边界与协作方式。") }) })
    html.div({ html.span("02"); html.div({ html.h3("梳理业务链路"); html.p("围绕商品价格业务阅读代码、梳理流程，学习业务规则如何转化为接口和数据模型。") }) })
    html.div({ html.span("03"); html.div({ html.h3("关注可靠性问题"); html.p("结合高并发业务，学习数据一致性、系统可用性与接口维护中的工程取舍。") }) })
  })
})

#html.div(class: "closing-note", { html.span("继续构建，也继续记录。"); html.a(href: "/page/1/", "阅读更多文字 ↗") })
