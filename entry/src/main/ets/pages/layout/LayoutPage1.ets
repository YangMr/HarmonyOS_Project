@Entry
@Component
struct LayoutPage1 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Row() {
        // 100 + 200 = 300
        // flexGrow, 个属性定义了当父容器有剩余空间时，子组件如何扩展以填充这些空间
        // flexShrink这个属性指定了当父容器空间不足时，子组件应该如何缩小来适应空间限制
        Row()
          .width(50)
          .height(400)
          .backgroundColor(Color.White)
          .flexGrow(0)
          .flexShrink(1)

        Image($r("sys.media.ohos_ic_public_translate_c2e"))
          .width(200)
          .height(400)
          .objectFit(ImageFit.Contain)
          .backgroundColor("#66f1ccb8")
          .flexGrow(1)
          .flexShrink(0)

        Row()
          .width(50)
          .height(400)
          .backgroundColor(Color.White)
          .flexGrow(0)
          .flexShrink(1)
      }
      .width("100%")
    }
    .height('100%')
    .width('100%')
    .backgroundColor(Color.Gray)
  }
}