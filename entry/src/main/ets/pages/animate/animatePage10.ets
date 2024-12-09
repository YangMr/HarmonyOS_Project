@Entry
@Component
struct AnimatePage10 {
  @State
  numbers: number[] = [1, 2, 3, 4]

  build() {
    Column({ space: 10 }) {

      Column() {
        ForEach(this.numbers, (item: number, index: number) => {
          Text(item.toString())
            .width(240)
            .height(60)
            .backgroundColor(Color.Orange)
            .textAlign(TextAlign.Center)
            .borderWidth(1)
            .fontSize(18)
            .transition({
              type: TransitionType.All,
              translate: {
                x: 300
              },
              scale: {
                x: 0,
                y: 0
              }
            })
            .onClick(() => {
              animateTo({
                duration: 1000
              }, () => {
                const index = this.numbers.indexOf(item)
                this.numbers.splice(index, 1)
              })

            })

        }, (item: number) => {
          return item.toString()
        })
      }
      .width("90%")
      .height("70%")
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)
      .margin(10)


      Button("+")
        .onClick(() => {
          animateTo({
            duration: 1000
          }, () => {
            this.numbers.push(this.numbers[this.numbers.length -1] + 1)
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}