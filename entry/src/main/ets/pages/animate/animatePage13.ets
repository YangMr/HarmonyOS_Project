@Entry
@Component
struct AnimatePage13 {
  @State boxScreenX: number = 300
  @State boxOpacity: number = 0
  @State boxScreenY: number = 80
  @State productList: string[] = ["第一个商品", "第二个商品", "第三个商品", "第四个商品"]

  build() {
    Stack({
      alignContent: Alignment.TopStart
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
                  // AlertDialog.show({
                  //   message: "x:" + e.windowX + "---" + "y:" + e.windowY
                  // })
                  //配置起始位置  不需要动
                  this.boxScreenX = e.windowX - 30
                  this.boxScreenY = e.windowY - 30
                  this.boxOpacity = 1
                  animateTo({
                    duration: 1000
                  }, () => {
                    this.boxScreenX = 10
                    this.boxScreenY = 500
                  })

                  setTimeout(() => {
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
      .translate({
        x: this.boxScreenX,
        y: this.boxScreenY
      })
      .opacity(this.boxOpacity)

    }
  }
}