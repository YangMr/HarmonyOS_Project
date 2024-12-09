@Entry
@Component
struct LayoutPage3 {
  @State
  list: number[] = [0, 1, 2, 3]

  build() {
    Column() {
      Row() {
        ForEach(this.list, () => {
          Column() {
            Image($r("app.media.startIcon"))
              .width(48)
              .height(48)
              .margin({ top: 10 })
            Text("App name")
              .width(64)
              .height(30)
              .fontSize(12)
              .margin({ top: 8 })
              .padding({ bottom: 15 })
              .textAlign(TextAlign.Center)
          }
          .width(80)
          .height(102)
          .flexShrink(1)
        })
      }
      .width("100%")

      .justifyContent(FlexAlign.SpaceEvenly)


      Row() {
        ForEach(this.list, () => {
          Column() {
            Image($r("app.media.startIcon"))
              .width(48)
              .height(48)
              .margin({ top: 10 })
            Text("App name")
              .width(64)
              .height(30)
              .fontSize(12)
              .margin({ top: 8 })
              .padding({ bottom: 15 })
              .textAlign(TextAlign.Center)

          }
          .width(80)
          .height(102)
          .flexShrink(1)
        })
      }
      .width("100%")

      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .height('100%')
    .width('100%')
  }
}