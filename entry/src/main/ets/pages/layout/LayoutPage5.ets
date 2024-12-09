@Entry
@Component
struct LayoutPage5 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Column() {
        Column() {
          Image("https://img0.baidu.com/it/u=3222680492,2420356921&fm=253&fmt=auto&app=120&f=JPEG?w=861&h=500")
            .width("100%")
            .height("100%")
        }
        .aspectRatio(1)
      }
      .width("60%")
      .height("60%")
      .backgroundColor("#fff")
      .justifyContent(FlexAlign.Center)
      .alignItems(HorizontalAlign.Center)

    }
    .height('100%')
    .width('100%')
    .backgroundColor("#eee")
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}