@Entry
@Component
struct AnimatePage14 {
  @State flag: boolean = true
  @State boxScreenX: number = 0
  @State boxOpacity: number = 0
  @State boxScreenY: number = 0
  @State productList: string[] = ["第一个商品", "第二个商品", "第三个商品", "第四个商品"]

  build() {
    Stack({
      alignContent: this.flag ? Alignment.TopEnd : Alignment.BottomStart
    }) {
      Column() {
        List({
          space: 20
        }) {
          ForEach(this.productList, (item: string) => {
            ListItem() {
              Row() {
                Text(item)
                Button() {
                  Text("+").fontSize(18).fontColor(Color.White)
                }.width(30)
                .height(30)
                .onClick((e) => {
                  //获取点击的位置 距离屏幕左侧和顶部的距离
                  //Api11以后也可以使用e.windowX   e.windowY获取点击的位置距离屏幕左侧和顶部的距离
                  console.log(e.windowX + "")
                  console.log(e.windowY + "")
                  //配置起始位置  不需要动画
                  this.boxScreenX = e.windowX - 30
                  this.boxScreenY = e.windowY - 30
                  this.boxOpacity = 1

                  animateTo({
                    duration: 1000,
                  }, () => {
                    this.flag = false
                  })
                  setTimeout(() => {
                    this.flag = true
                    this.boxOpacity = 0
                  }, 1000)

                })
              }.justifyContent(FlexAlign.SpaceBetween)
              .width('100%')
            }
          })

        }
        .padding(20)
        .divider({
          strokeWidth: 1,
          color: "#eee"
        })
      }
      .width('100%')
      .height('100%')

      Row() {
      }
      .backgroundColor(Color.Red)
      .width(60)
      .height(60)
      .margin({
        top: this.boxScreenY
      })
      .motionPath({
        path: `Mstart.x start.y L${this.boxScreenX * 2} ${this.boxScreenY} Lend.x end.y`,
        from: 0.0,
        to: 1.0,
        rotatable: true
      })
      .opacity(this.boxOpacity)

    }
  }
}