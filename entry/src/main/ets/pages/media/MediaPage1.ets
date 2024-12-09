@Entry
@Component
struct MediaPage1 {
  // 获取断点 (xs / sm(手机) / md(折叠屏) / lg(平板))
  @StorageProp("currentBreakpoint") curBp: string = ""

  build() {
    Column() {


      // 媒体查询 / 断点

      GridRow({
        columns: { sm: 12, md: 12, lg: 12 },
        gutter: { x: "10vp" }
      }) {
        GridCol({
          span: { sm: 4, md: 8 },
          offset: { sm: 0, md: 1 }
        }) {
          Row() {
            TextInput({ placeholder: "请输入内容" })
              .border({
                width: 1
              })

          }
          .width("100%")
          .height(60)

        }
      }
      .padding({
        left: 10,
        right: 10
      })

      // 手机上面 --- 手机
      // if (this.curBp === "sm") {
      //   Text("手机")
      // } else if (this.curBp === "md") {
      //   Text("折叠屏")
      // }
      //
      // // 折叠品 --- 折叠屏
      //
      // // 平板 --- 平板
      // Text("hello")
    }
    .height('100%')
    .width('100%')
  }
}