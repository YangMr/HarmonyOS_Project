@Entry
@Component
struct LayoutPage2 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      // 搜索栏
      Row() {
      }
      .width("100%")
      .height(70)
      .backgroundColor(Color.Red)


      Row() {
        Row() {
        }
        .width(50)
        .backgroundColor(Color.Yellow)
        .height("100%")
        .flexGrow(0)
        .flexShrink(1)

        Image("http://macro-oss.oss-cn-shenzhen.aliyuncs.com/mall/images/20221108/huawei_banner_01.png")// .objectFit(ImageFit.Contain)
          .flexGrow(1)
          .flexShrink(0)
          .backgroundColor(Color.Pink)
          .width(300)
          .objectFit(ImageFit.Contain)


        Row() {
        }
        .width(50)
        .backgroundColor(Color.Green)
        .height("100%")
        .flexGrow(0)
        .flexShrink(1)

      }
      .width("100%")
      .height(175)

    }
    .height('100%')
    .width('100%')
    .backgroundColor("#eee")
  }
}