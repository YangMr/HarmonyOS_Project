@Entry
@Component
struct AnimatePage9 {
  @State
  numbers: string[] = ["1", "2", "3", "4", "5", "6", "7"]
  @State
  startNumber: number = 8

  build() {
    Column({ space: 10 }) {

      Column() {
        ForEach(this.numbers, (item: string) => {
          Text(item)
            .width(240)
            .height(60)
            .backgroundColor(Color.Orange)
            .textAlign(TextAlign.Center)
            .borderWidth(1)
            .fontSize(18)
            .transition({
              type: TransitionType.All,
              translate: {
                x: 200
              },
              scale: {
                x: 0,
                y: 0
              }
            })
        }, (item: string) => {
          return item + Date.now()
        })
      }
      .width("90%")
      .height("70%")
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin(10)


      Button("向头部添加元素")
        .fontSize(16)
        .width(160)
        .onClick(() => {
          animateTo({
            duration: 1000
          }, () => {
            this.numbers.unshift(this.startNumber.toString())
            this.startNumber++
          })

        })

      Button("向尾部添加元素")
        .fontSize(16)
        .width(160)
        .onClick(() => {
          animateTo({
            duration: 1000
          }, () => {
            this.numbers.push(this.startNumber.toString())
            this.startNumber++
          })
        })

      Button("删除头部添加元素")
        .fontSize(16)
        .width(160)
        .onClick(() => {
          animateTo({
            duration: 1000
          }, () => {
            this.numbers.shift()
            this.startNumber--
          })
        })

      Button("删除尾部添加元素")
        .fontSize(16)
        .width(160)
        .onClick(() => {
          animateTo({
            duration: 1000
          }, () => {
            this.numbers.shift()
            this.startNumber--
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}