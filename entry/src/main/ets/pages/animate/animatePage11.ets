import { curves } from '@kit.ArkUI'

@Entry
@Component
struct AnimatePage11 {
  @State
  translatex: number = 0

  jumpWithSpeed(speed: number) {
    this.translatex = -20
    animateTo({
      duration: 2000,
      // 速度  质量  刚度  阻尼
      curve: curves.springCurve(speed, 1, 1, 1)
    }, () => {
      this.translatex = 0
    })
  }

  build() {
    Column({ space: 10 }) {
      Column() {
        Text("登录框")
          .fontColor(Color.White)
      }
      .width(100)
      .height(100)
      .backgroundColor(Color.Gray)
      .translate({
        x: this.translatex
      })

      Row() {
        Button("jump 10")
          .fontSize(14)
          .onClick(() => {
            this.jumpWithSpeed(10)
          })

        Button("jump 200")
          .fontSize(14)
          .onClick(() => {
            this.jumpWithSpeed(200)
          })
      }
      .margin(30)
    }
    .height('100%')
    .width('100%')
  }
}