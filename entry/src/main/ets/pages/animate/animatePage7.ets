@Entry
@Component
struct AnimatePage7 {
  @State
  flag: boolean = true
  @State
  boxScale: number = 1

  build() {
    Column() {
      Row() {
        Image("http://gips0.baidu.com/it/u=1690853528,2506870245&fm=3028&app=3028&f=JPEG&fmt=auto?w=1024&h=1024")
          .width(260)
          .height(260)
          .borderRadius(130)
      }
      .width(260)
      .height(260)
      .margin({ top: 200 })
      .scale({
        x: this.boxScale,
        y: this.boxScale
      })
      .onClick(() => {
        animateTo({
          duration: 2000,
          curve: Curve.Linear,
          iterations: -1
        }, () => {
          this.flag = !this.flag
          this.flag ? this.boxScale = 1.3 : this.boxScale = 1
          // if (this.flag) {
          //   this.boxRotate = 360
          // } else {
          //   this.boxRotate = 0
          // }
          // this.flag = !this.flag
        })

      })
    }
    .height('100%')
    .width('100%')
  }
}