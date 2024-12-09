@Entry
@Component
struct AnimatePage2 {
  @State
  boxWidth: number = 100
  @State
  boxHeight: number = 100
  @State
  flag: boolean = false
  @State
  bgColor: Color = Color.Red

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {

        }
        .width(this.boxWidth)
        .animation({
          duration: 1000,
          curve: Curve.EaseIn
        })
        .height(this.boxHeight)
        .animation({
          duration: 2000,
          curve: Curve.EaseIn
        })
        .backgroundColor(this.bgColor)
        .animation({
          duration: 3000,
          curve: Curve.EaseIn
        })

      }
      .width("100%")
      .height("100%")
      .padding(20)
      .justifyContent(FlexAlign.Center)

      Button("动画")
        .width(80)
        .height(80)
        .margin({
          right: 10,
          bottom: 10
        })
        .onClick(() => {
          this.flag = !this.flag
          if (this.flag) {
            this.boxWidth = 300
            this.boxHeight = 300
            this.bgColor = Color.Blue
          } else {
            this.boxWidth = 100
            this.boxHeight = 100
            this.bgColor = Color.Red
          }
        })

    }
    .height('100%')
    .width('100%')
  }
}