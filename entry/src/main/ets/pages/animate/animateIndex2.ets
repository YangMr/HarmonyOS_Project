@Entry
@Component
struct AnimateIndex2 {
  @State message: string = 'Hello World';

  build() {
    Column() {
      Image("https://emoji.bj.bcebos.com/yige-aigc/index_aigc/final/toolspics/1.png")
        .width(300)
        .height(300)
        .sharedTransition("shared1", {
          duration: 1000,
          type: SharedTransitionEffectType.Static
        })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}