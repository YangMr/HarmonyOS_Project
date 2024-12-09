import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct AnimatePage3 {
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
        .height(this.boxHeight)
        .backgroundColor(this.bgColor)
        .animation({
          // 动画持续时间(过度时间)
          duration: 3000,
          // 插值曲线 (动画的运动曲线效果)
          curve: Curve.EaseIn,
          // 动画播放速度，值越大动画播放越快，值越小播放越慢，为0时无动画效果
          tempo: 1,
          // 动画延迟播放时间，单位为ms(毫秒)，默认不延时播放。
          delay: 0,
          // 动画播放次数。默认播放一次，设置为-1时表示无限次播放。设置为0时表示无动画效果。
          iterations: 2,
          // 动画播放完成回调
          onFinish: () => {
            promptAction.showToast({
              message: "动画播放完成"
            })
          },
          // 在动画中定义onFinish回调的类型。
          finishCallbackType: FinishCallbackType.LOGICALLY
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