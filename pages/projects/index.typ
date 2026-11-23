#import "../../config.typ": *
#show: template-page.with(title: "项目与实践", description: "魔符sigil 的全双工语音对话模型推理优化、C++ 分布式 RPC 项目与后端工程实践。")
#render-page-breadcrumb(items: (("/", "首页"),))

#html.div(class: "page-intro", {
  html.div(class: "eyebrow", "BUILDS / SYSTEMS / EXPERIENCE")
  html.h1("项目与实践")
  html.p("用代码把概念接起来，在实践里理解系统。")
})

#html.elem("section", attrs: (class: "project-detail", id: "graduation-project"), {
  html.div(class: "project-detail-head", {
    html.div({ html.div(class: "eyebrow", "01 / 本科毕业设计"); html.h2("全双工语音对话模型推理优化") })
    html.span(class: "project-period", "进行中")
  })
  html.p("围绕可以同时接收和生成语音的对话模型，研究如何提高推理效率、降低实时交互的响应延迟。")
  tech-labels(("全双工语音", "实时交互", "推理优化"))
})

#html.elem("section", attrs: (class: "project-detail"), {
  html.div(class: "project-detail-head", {
    html.div({ html.div(class: "eyebrow", "02 / PERSONAL PROJECT"); html.h2("C++ 分布式 RPC 系统") })
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

#html.elem("section", attrs: (class: "experience-section", id: "meituan-internship"), {
  html.div(class: "project-detail-head", {
    html.div({ html.div(class: "eyebrow", "03 / ENGINEERING EXPERIENCE"); html.h2("美团 · 后端开发实习") })
    html.span(class: "project-period", "2026.05 — 2026.08")
  })
  html.p("在北京担任后端开发实习生，参与小象超市海外版 Keemart 的商品定价业务。")
  html.div(class: "experience-list", {
    html.div({
      html.span("01")
      html.div({
        html.h3("独立交付定价接口")
        html.p("独立负责商品价格尾数策略接口的方案设计、编码实现、联调和上线，支持海外零售场景下的商品定价。")
      })
    })
    html.div({
      html.span("02")
      html.div({
        html.h3("将定价规则封装为服务")
        html.p("梳理商品定价流程和价格尾数优化规则，明确接口职责、入参和返回结构，将定价规则封装为业务系统可调用的服务。")
      })
    })
    html.div({
      html.span("03")
      html.div({
        html.h3("Java 微服务开发")
        html.p("在既有 Java 微服务架构中实现接口，按内部开发规范完成与业务系统的对接。")
      })
    })
  })
})

#html.div(class: "closing-note", { html.span("继续构建，也继续记录。"); html.a(href: "/page/1/", "阅读更多文字 ↗") })
