@Entry
@Component
struct AnimatePage4 {
  @State
  flag: boolean = true

  @Builder
  Body() {
    Row() {
      Row() {

      }
      .width(60)
      .height("100%")

      Row() {
        Text("侧边栏演示")
          .size({ width: "100%", height: "50vp" })
          .textAlign(TextAlign.Center)
      }
      .layoutWeight(1)

      Row() {
        Button("显示")
          .padding(10)
          .onClick(() => {
            // animateTo({
            //   duration: 1000
            // }, () => {
            //   this.flag = !this.flag
            // })
            this.flag = !this.flag
          })
      }
      .width(60)
      .height("100%")

    }
    .height(50)
    .width("100%")
    .backgroundColor("#d81e06")
  }

  @Builder
  Sidebar() {
    Column() {

    }
    .width(200)
    .height("100%")
    .backgroundColor(Color.Red)
    .translate({
      x: this.flag ? -200 : 0
    })
    .animation({
      duration: 1000
    })
  }

  build() {
    Stack({ alignContent: Alignment.Start }) {

      this.Body()

      this.Sidebar()

    }
    .height('100%')
    .width('100%')
  }
}