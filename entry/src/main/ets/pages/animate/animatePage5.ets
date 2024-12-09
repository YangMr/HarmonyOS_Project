@Entry
@Component
struct AnimatePage5 {
  @State
  flag: boolean = true

  @Builder
  ActionSheet() {
    Column() {
      List({ space: 44 }) {
        ListItem() {
          Text("相册选择")
            .fontSize(18)
            .fontColor("#666")
            .width("100%")
            .textAlign(TextAlign.Center)
        }

        ListItem() {
          Text("相机选择")
            .fontSize(18)
            .fontColor("#666")
            .width("100%")
            .textAlign(TextAlign.Center)
        }

        ListItem() {
          Text("取消")
            .fontSize(18)
            .fontColor("#666")
            .width("100%")
            .textAlign(TextAlign.Center)
            .onClick(() => {
              this.flag = true
            })
        }
      }
      .divider({
        strokeWidth: 1,
        color: Color.Gray
      })
    }
    .width("100%")
    .height(200)
    .backgroundColor("#ccc")
    .padding({ top: 20 })
    .translate({
      y: this.flag ? 225 : 0
    })
    .animation({
      duration: 1000,
      curve: Curve.Ease
    })
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        Button() {
          Text("Show action sheet")
            .fontSize(20)
            .fontColor(Color.White)
            .onClick(() => {
              this.flag = false
            })
        }
        .width("80%")
        .height(80)

      }
      .width("100%")
      .height("100%")
      .padding(20)
      .onClick(() => {
        this.flag = true
      })
      .justifyContent(FlexAlign.Center)

      this.ActionSheet()
    }
    .height('100%')
    .width('100%')
  }
}