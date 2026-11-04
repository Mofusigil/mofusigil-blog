#import "../../config.typ": *

#show: template-page.with(title: "关于", description: "认识魔符sigil：算法竞赛、C++、后端工程与 AI 系统。")
#render-page-breadcrumb(items: (("/", "首页"),))

#html.div(class: "page-intro about-intro", {
  html.div(class: "eyebrow", "A LITTLE ABOUT ME")
  html.h1({ "你好，我是"; html.span(class: "keep-together", "魔符sigil"); "。" })
  html.p("喜欢拆解问题，也喜欢亲手把想法搭起来。")
})

#html.div(class: "about-layout", {
  html.aside(class: "profile-card", {
    html.elem("img", attrs: (src: "/assets/sigil-logo.png", alt: "魔符sigil 的头像", width: "80", height: "80"))
    html.h2("魔符sigil")
    html.p("算法 · 系统 · 持续学习")
    html.div(class: "profile-facts", {
      html.div({ html.span("教育"); html.strong("湖南大学") })
      html.div({ html.span("专业"); html.strong("计算机科学与技术") })
      html.div({ html.span("阶段"); html.strong("本科 · 2023—2027（预计）") })
      html.div({ html.span("方向"); html.strong("C++ / 后端 / AI 系统") })
    })
    html.a(class: "text-link", href: "/projects/", "看看我的项目 ↗")
  })
  html.div(class: "about-prose", [
    = 从算法竞赛开始

    我在湖南大学学习计算机科学与技术，也是 ACM 校队的一员。长期的算法训练让我习惯先梳理问题、推导边界，再把思路落实为可以验证的代码。

    ICPC、CCPC 和省赛的经历，让我持续练习算法实现与团队协作。相比只保留结果，我也希望在这里写下对解题方法、代码细节和学习过程的理解。

    = 向工程实践延伸

    我主要使用 C/C++，关注 Linux 下的网络编程、I/O 多路复用、Reactor 模型与并发编程。Git、CMake 和 GDB 是我学习和开发时使用的工具。

    我独立实现过一套 C++ 分布式 RPC 服务注册与调用系统，使用 Muduo、Protobuf、ZooKeeper 和 Glog，把网络通信、序列化、服务发现与日志串在一起。项目的收获，在于开始从完整的调用链路理解一个系统。

    2026 年 5 月至 7 月，我在美团进行软件开发实习，接触后端开发规范、Java 微服务架构和商品价格业务，学习高并发业务中的数据一致性与系统可用性问题。

    = 接下来想探索什么

    我希望把已有的算法与系统基础，逐步连接到 AI 的工程实现。模型部署、推理效率，以及强化学习、多模态模型在复杂系统中的应用，都是我想继续学习的方向。

    这些是正在探索的兴趣。我会把有结论的实践和仍在推敲的问题都记下来，让学习有迹可循。

    = 这里会写什么

    - *项目记录*：整理做过的设计、模块之间的关系和需要继续验证的问题。
    - *算法笔记*：沉淀训练中的推导方法、实现细节与复盘思路。
    - *学习随笔*：记录从系统编程走向后端工程、再走近 AI 系统的过程。
  ])
})

#html.div(class: "about-awards", {
  section-heading("/", "COMPETITIVE PROGRAMMING", "竞赛足迹")
  html.p(class: "section-description", "一些阶段性的记录，也是继续练习的起点。")
  html.div(class: "achievement-list", {
    for award in (
      ("GOLD", "2024 CCPC 全国邀请赛（山东）", "金奖"),
      ("GOLD", "第 21 届湖南省大学生计算机程序设计竞赛", "金奖"),
      ("BRONZE", "第 49 届 ICPC 亚洲区域赛（沈阳）", "铜奖"),
      ("BRONZE", "第 50 届 ICPC 亚洲区域赛（上海）", "铜奖"),
      ("BRONZE", "第 50 届 ICPC 亚洲区域赛（成都）", "铜奖"),
      ("BRONZE", "第 10 届 CCPC 中国大学生程序设计竞赛（哈尔滨）", "铜奖"),
      ("BRONZE", "2025 CCF 大学生计算机系统与程序设计竞赛决赛（CCSP）", "铜奖"),
    ) {
      html.div(class: "achievement-row", {
        html.span(class: "medal-label " + lower(award.at(0)), award.at(0))
        html.span(award.at(1))
        html.strong(award.at(2))
      })
    }
  })
})
