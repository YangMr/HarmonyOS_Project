@Entry
@Component
struct AnimatePage {
  @State
  boxWidth: number = 100
  @State
  boxHeight: number = 100
  @State
  flag: boolean = false

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column() {
        Row() {

        }
        .width(this.boxWidth)
        .height(this.boxHeight)
        .backgroundColor(Color.Red)

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
          animateTo({
            // 动画的持续时间为1秒
            duration: 1000,
            // delay: 1000,
            playMode: PlayMode.AlternateReverse
          }, () => {
            this.flag = !this.flag
            if (this.flag) {
              this.boxWidth = 300
              this.boxHeight = 300
            } else {
              this.boxWidth = 100
              this.boxHeight = 100
            }
          })
        })

    }
    .height('100%')
    .width('100%')
  }
}