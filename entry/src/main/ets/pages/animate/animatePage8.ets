@Entry
@Component
struct AnimatePage8 {
  @State
  show: string = "show"
  @State
  flag: boolean = false

  build() {
    Column() {

      Button(this.show)
        .width(80)
        .height(30)
        .margin(30)
        .onClick(() => {
          if (this.flag) {
            this.show = "hide"
          } else {
            this.show = "show"
          }
          animateTo({ duration: 1000 }, () => {
            this.flag = !this.flag
          })

        })


      if (this.flag) {
        Image("http://gips2.baidu.com/it/u=195724436,3554684702&fm=3028&app=3028&f=JPEG&fmt=auto?w=1280&h=960")
          .width(200)
          .height(200)
          .transition({
            type: TransitionType.Insert,
            translate: {
              x: 0,
              y: 200
            }
          })
          .transition({
            type: TransitionType.Delete,
            translate: {
              x: 0,
              y: 200
            }
          })
      }

    }
    .height('100%')
    .width('100%')
  }
}