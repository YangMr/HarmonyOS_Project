@Entry
@Component
struct LayoutPage7 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Row({ space: 24 }) {
        Image($r("sys.media.ohos_ic_public_sound_off"))
          .width(48)// .width("20%")
          .height(48)
          .objectFit(ImageFit.Contain)
          .displayPriority(1)


        Image($r("sys.media.ohos_ic_public_scan"))// .width("20%")
          .height(48)
          .objectFit(ImageFit.Contain)
          .displayPriority(2)


        Image($r("sys.media.ohos_ic_public_phone"))
          .width("20%")
          .height(48)
          .objectFit(ImageFit.Contain)
          .displayPriority(3)


        Image($r("sys.media.ohos_ic_public_share"))
          .width("20%")
          .height(48)
          .objectFit(ImageFit.Contain)
          .displayPriority(2)


        Image($r("sys.media.ohos_ic_public_more"))
          .width("20%")
          .height(48)
          .objectFit(ImageFit.Contain)
          .displayPriority(1)


      }
      .width('100%')
      .height(96)
      .borderRadius(16)
      .backgroundColor("#fff")
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }
}