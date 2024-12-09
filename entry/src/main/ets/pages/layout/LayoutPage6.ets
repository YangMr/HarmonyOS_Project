@Entry
@Component
struct LayoutPage6 {
  @State
  list: number[] = [0, 1, 2, 3, 4, 5, 6, 7]

  build() {
    Column() {
      Row() {
        List() {
          ForEach(this.list, () => {
            ListItem() {
              Column() {
                Image($r("app.media.startIcon"))
                  .width(48)
                  .height(48)

                Text("app name")
                  .width(64)
                  .height(30)
                  .lineHeight(15)
                  .fontSize(12)
                  .textAlign(TextAlign.Center)
                  .margin({ top: 8 })
                  .padding({ bottom: 15 })
              }
            }
          })
        }
        .listDirection(Axis.Horizontal)
        .width("100%")
        .height(118)

      }
      .width("100%")
      .backgroundColor(Color.White)
      .padding({ left: 30, right: 30 })


      Scroll() {
        Row() {

          ForEach(this.list, () => {
            Column() {
              Image($r("app.media.startIcon"))
                .width(48)
                .height(48)

              Text("app name")
                .width(64)
                .height(30)
                .lineHeight(15)
                .fontSize(12)
                .textAlign(TextAlign.Center)
                .margin({ top: 8 })
                .padding({ bottom: 15 })
            }
          })
        }
        .margin({
          top: 100
        })
        // .width("100%")
        .padding({ left: 30, right: 30 })
        .backgroundColor(Color.White)
      }
      .scrollable(ScrollDirection.Horizontal)
      .width("100%")

    }
    .height('100%')
    .width('100%')
    .backgroundColor("#ccc")
  }
}