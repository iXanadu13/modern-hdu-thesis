#import "../utils/style.typ": 字号, 字体
#import "../utils/custom-cuti.typ": fakebold, cn-fakebold

// 本科生声明页
#let bachelor-decl-page(
  anonymous: false,
  twoside: false,
  fonts: (:),
  info: (:),
) = {
  // 0. 如果需要匿名则短路返回
  if anonymous {
    return
  }

  // 1.  默认参数
  fonts = 字体 + fonts
  info = (
    title: ("基于 Typst 的", "南京大学学位论文"),
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }


  // 3.  正式渲染
  pagebreak(weak: true, to: if twoside { "odd" })

  v(110pt)

  // align(center, image("../assets/vi/nju-emblem-purple.svg", width: 1.95cm))

  // v(-12pt)

  align(
    center,
    cn-fakebold(
      text(
        font: fonts.黑体,
        size: 18pt,
        weight: "bold",
        "诚 信 承 诺",
      ),
    )
  )

  v(48pt)

  block[
    #set text(font: fonts.宋体, size: 14pt)
    #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 1.8em)

    我谨在此承诺：本人所写的毕业论文《#info.title.sum()》均系本人独立完成，没有抄袭行为，凡涉及其他作者的观点和材料，均作了注释，若有不实，后果由本人承担。
  ]

  v(76pt)

  grid(
    columns: (1fr, 212pt),
    [],
    align(left)[
      #fakebold(text(
        font: fonts.黑体,
        size: 15pt,
        "承诺人（签名）：",
      ))
    ]
  )

  v(10pt)

  grid(
    columns: (1fr, 190pt),
    [],
    align(left)[
      #fakebold(text(
        font: fonts.黑体,
        size: 15pt,
        "2026 年 5 月 12 日",
      ))
    ]
  )
}