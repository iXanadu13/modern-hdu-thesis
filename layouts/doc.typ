// 文稿设置，可以进行一些像页面边距这类的全局设置
#let doc(
  // documentclass 传入参数
  info: (:),
  // 其他参数
  fallback: false,  // 字体缺失时使用 fallback，不显示豆腐块
  lang: "zh",
  // 页边距：上3cm，下2cm，左3cm，右2cm；装订线1cm（加到左边距）
  // 上边距多加了1cm乃刻意为之，用于正确设置header的高度
  margin: (top: 4cm, bottom: 2cm, left: 4cm, right: 2cm),
  it,
) = {
  // 1.  默认参数
  info = (
    title: ("基于 Typst 的", "南京大学学位论文"),
    author: "张三",
  ) + info

  // 2.  对参数进行处理
  // 2.1 如果是字符串，则使用换行符将标题分隔为列表
  if type(info.title) == str {
    info.title = info.title.split("\n")
  }

  // 3.  基本的样式设置
  set text(fallback: fallback, lang: lang)
  set page(margin: margin)

  // 4.  PDF 元信息
  set document(
    title: (("",)+ info.title).sum(),
    author: info.author,
  )

  it
}