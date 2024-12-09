@Entry
@Component
struct LayoutPage4 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Row() {
        Column() {
          Image($r("sys.media.ohos_ic_public_video_off"))
            .width(48)
            .height(48)
        }
        .height(98)
        .layoutWeight(1)
        .backgroundColor(Color.Yellow)
        .justifyContent(FlexAlign.Center)

        Column() {
          Image($r("sys.media.ohos_ic_public_video_off"))
            .width(48)
            .height(48)
        }
        .height(98)
        .layoutWeight(1)
        .backgroundColor(Color.Green)
        .justifyContent(FlexAlign.Center)

        Column() {
          Image($r("sys.media.ohos_ic_public_video_off"))
            .width(48)
            .height(48)
        }
        .height(98)
        .layoutWeight(1)
        .backgroundColor(Color.Pink)
        .justifyContent(FlexAlign.Center)

      }
      .width("100%")
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#eee")
  }
}