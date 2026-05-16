#import "../lib.typ": documentclass
#import "../utils/custom-cuti.typ": show-cn-fakebold, show-fakebold
#import "../utils/style.typ": 字号, 字体

// 你首先应该安装 https://github.com/nju-lug/modern-nju-thesis/tree/main/fonts/FangZheng 里的所有字体，
// 如果是 Web App 上编辑，你应该手动上传这些字体文件，否则不能正常使用「楷体」和「仿宋」，导致显示错误。

#let (
  // 布局函数
  twoside, doc, preface, mainmatter, appendix,
  // 页面函数
  fonts-display-page, cover, decl-page, abstract, abstract-en, bilingual-bibliography,
  outline-page, list-of-figures, list-of-tables, notation, acknowledgement,
) = documentclass(
  // doctype: "bachelor",  // "bachelor" | "master" | "doctor" | "postdoc", 文档类型，默认为本科生 bachelor
  // degree: "academic",  // "academic" | "professional", 学位类型，默认为学术型 academic
  // anonymous: true,  // 盲审模式
  twoside: false,  // 双面模式，会加入空白页，便于打印
  // 你会发现 Typst 有许多警告，这是因为 modern-nju-thesis 加入了很多不必要的 fallback 字体
  // 你可以自定义字体消除警告，先英文字体后中文字体，应传入「宋体」、「黑体」、「楷体」、「仿宋」、「等宽」
  // fonts: (楷体: (name: "Times New Roman", covers: "latin-in-cjk"), "FZKai-Z03S")),
  info: (
    // title: "基于 Typst 的杭州电子科技大学学位论文",
    title: ("基于 Typst 的", "杭州电子科技大学学位论文"),
    title-en: "My Title in English",
    grade: "20XX",
    student-id: "1234567890",
    author: "张三",
    author-en: "Ming Xing",
    department: "某学院",
    department-en: "School of Chemistry and Chemical Engineering",
    major: "某专业",
    major-en: "Chemistry",
    supervisor: ("李四", "教授"),
    supervisor-en: "Professor My Supervisor",
    // supervisor-ii: ("王五", "副教授"),
    // supervisor-ii-en: "Professor My Supervisor",
    submit-date: datetime.today(),
  ),
  // 参考文献源
  bibliography: bibliography.with("ref.bib"),
)

// 文稿设置
#show: doc

// 字体展示测试页
// #fonts-display-page()

// 封面页
#cover()

// 声明页
#decl-page()

// 此后的每一页都有header
#set page(
  header: context{
    [
      #align(center, text(
        size: 字号.五号, 
        font: ("SimSun", "SimSun"), 
        "杭州电子科技大学本科毕业设计（论文）")
      )
      #block(line(length: 100%, stroke: 1pt), above: 0.4em)
      #v(-0.25cm)
    ]
  },
)

// 前言
#show: preface

// 中文摘要
#abstract(
  keywords: ("我", "就是", "测试用", "关键词")
)[
  中文摘要
]

// 英文摘要
#abstract-en(
  keywords: ("Dummy", "Keywords", "Here", "It Is")
)[
  English abstract
]


// 目录
#outline-page()

// 插图目录
// #list-of-figures()

// 表格目录
// #list-of-tables()

// 正文
#show: mainmatter

// 修复中文bold
// #show: show-cn-fakebold
#show: (s, ..params) => show-fakebold(
  reg-exp: "[\p{script=Han}！-･〇-〰—。]",
  base-weight: "regular",
  s,
  ..params
)

// 符号表
// #notation[
//   / DFT: 密度泛函理论 (Density functional theory)
//   / DMRG: 密度矩阵重正化群密度矩阵重正化群密度矩阵重正化群 (Density-Matrix Reformation-Group)
// ]

= 导　论

== 列表

=== 无序列表

- 无序列表项一
- 无序列表项二
  - 无序子列表项一
  - 无序子列表项二

=== 有序列表

+ 有序列表项一
+ 有序列表项二
  + 有序子列表项一
  + 有序子列表项二

=== 术语列表

/ 术语一: 术语解释
/ 术语二: 术语解释

== 图表

引用@tbl:timing，引用@tbl:timing-tlt，以及@fig:nju-logo。引用图表时，表格和图片分别需要加上 `tbl:`和`fig:` 前缀才能正常显示编号。

#align(center, (stack(dir: ltr)[
  #figure(
    table(
      align: center + horizon,
      columns: 4,
      [t], [1], [2], [3],
      [y], [0.3s], [0.4s], [0.8s],
    ),
    caption: [常规表],
  ) <timing>
][
  #h(50pt)
][
  #figure(
    table(
      columns: 4,
      stroke: none,
      table.hline(),
      [t], [1], [2], [3],
      table.hline(stroke: .5pt),
      [y], [0.3s], [0.4s], [0.8s],
      table.hline(),
    ),
    caption: [三线表],
  ) <timing-tlt>
]))

// 续表测试：长表需要允许 table figure 跨页，并用 table.header 重复表头。
// i-figured 会把 table 类型改写为 "i-figured-table"，因此这里两个 kind 都设置为 breakable。
#show figure.where(kind: table): set block(breakable: true)
#show figure.where(kind: "i-figured-table"): set block(breakable: true)

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 2fr),
    align: center + horizon,
    inset: (x: 6pt, y: 8pt),
    stroke: none,

    table.hline(),
    table.header(
      repeat: true,
      [序号], [指标], [结果], [说明],
      table.hline(stroke: .5pt),
    ),

    [1], [alpha], [0.11], [用于测试续表分页和表头重复。],
    [2], [beta], [0.12], [用于测试续表分页和表头重复。],
    [3], [gamma], [0.13], [用于测试续表分页和表头重复。],
    [4], [delta], [0.14], [用于测试续表分页和表头重复。],
    [5], [epsilon], [0.15], [用于测试续表分页和表头重复。],
    [6], [zeta], [0.16], [用于测试续表分页和表头重复。],
    [7], [eta], [0.17], [用于测试续表分页和表头重复。],
    [8], [theta], [0.18], [用于测试续表分页和表头重复。],
    [9], [iota], [0.19], [用于测试续表分页和表头重复。],
    [10], [kappa], [0.20], [用于测试续表分页和表头重复。],
    [11], [lambda], [0.21], [用于测试续表分页和表头重复。],
    [12], [mu], [0.22], [用于测试续表分页和表头重复。],
    [13], [nu], [0.23], [用于测试续表分页和表头重复。],
    [14], [xi], [0.24], [用于测试续表分页和表头重复。],
    [15], [omicron], [0.25], [用于测试续表分页和表头重复。],
    [16], [pi], [0.26], [用于测试续表分页和表头重复。],
    [17], [rho], [0.27], [用于测试续表分页和表头重复。],
    [18], [sigma], [0.28], [用于测试续表分页和表头重复。],
    [19], [tau], [0.29], [用于测试续表分页和表头重复。],
    [20], [upsilon], [0.30], [用于测试续表分页和表头重复。],
    [21], [phi], [0.31], [用于测试续表分页和表头重复。],
    [22], [chi], [0.32], [用于测试续表分页和表头重复。],
    [23], [psi], [0.33], [用于测试续表分页和表头重复。],
    [24], [omega], [0.34], [用于测试续表分页和表头重复。],
    [25], [alpha-2], [0.35], [用于测试续表分页和表头重复。],
    [26], [beta-2], [0.36], [用于测试续表分页和表头重复。],
    [27], [gamma-2], [0.37], [用于测试续表分页和表头重复。],
    [28], [delta-2], [0.38], [用于测试续表分页和表头重复。],
    [29], [epsilon-2], [0.39], [用于测试续表分页和表头重复。],
    [30], [zeta-2], [0.40], [用于测试续表分页和表头重复。],
    [31], [eta-2], [0.41], [用于测试续表分页和表头重复。],
    [32], [theta-2], [0.42], [用于测试续表分页和表头重复。],
    [33], [iota-2], [0.43], [用于测试续表分页和表头重复。],
    [34], [kappa-2], [0.44], [用于测试续表分页和表头重复。],
    [35], [lambda-2], [0.45], [用于测试续表分页和表头重复。],
    [36], [mu-2], [0.46], [用于测试续表分页和表头重复。],
    [37], [nu-2], [0.47], [用于测试续表分页和表头重复。],
    [38], [xi-2], [0.48], [用于测试续表分页和表头重复。],
    [39], [omicron-2], [0.49], [用于测试续表分页和表头重复。],
    [40], [pi-2], [0.50], [用于测试续表分页和表头重复。],
    [41], [rho-2], [0.51], [用于测试续表分页和表头重复。],
    [42], [sigma-2], [0.52], [用于测试续表分页和表头重复。],
    table.hline(),
  ),
  caption: [续表机制测试],
) <continued-table-test>

#figure(
  image("images/hdu-emblem.svg", width: 25%),
  caption: [图片测试],
) <nju-logo>


== 数学公式

可以像 Markdown 一样写行内公式 $x + y$，以及带编号的行间公式：

$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

引用数学公式需要加上 `eqt:` 前缀，则由@eqt:ratio，我们有：

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

我们也可以通过 `<->` 标签来标识该行间公式不需要编号

$ y = integral_1^2 x^2 dif x $ <->

而后续数学公式仍然能正常编号。

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

== 参考文献

可以像这样引用参考文献：图书#[@蒋有绪1998]和会议#[@中国力学学会1990]。

== 代码块

代码块支持语法高亮。引用时需要加上 `lst:` @lst:code

#figure(
  ```py
  def add(x, y):
    return x + y
  ```,
  caption:[代码块],
) <code>


= 正　文

== 正文子标题

=== 正文子子标题

正文内容


// 手动分页
#if twoside {
  pagebreak() + " "
}

// 致谢
#acknowledgement[
  感谢 NJU-LUG，感谢 NJUThesis LaTeX 模板。
]

// 中英双语参考文献
// 默认使用 gb-7714-2015-numeric 样式
#bilingual-bibliography(full: true)


// 手动分页
#if twoside {
  pagebreak() + " "
}


// 附录
#show: appendix

= 附录

== 附录子标题

=== 附录子子标题

附录内容，这里也可以加入图片，例如@fig:appendix-img。

#figure(
  image("images/hdu-emblem.svg", width: 25%),
  caption: [图片测试],
) <appendix-img>
