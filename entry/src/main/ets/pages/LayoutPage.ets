@Entry
@Component
struct LayoutPage {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Column() {

      }
      // .width("100%")
      .width("1080lpx")
      .height("477lpx")
      .backgroundColor(Color.Red)
      .margin({ top: "100lpx" })
    }
    .height('100%')
    .width('100%')
  }
}