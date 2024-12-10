import { router } from '@kit.ArkUI';

@Entry
@Component
struct AnimateIndex {
  @State message: string = 'Hello World';

  build() {
    Column() {
      // 共享元素转场
      Image("https://emoji.bj.bcebos.com/yige-aigc/index_aigc/final/toolspics/1.png")
        .width(100)
        .height(100)
        .sharedTransition("shared1", {
          duration: 1000,
          // type: SharedTransitionEffectType.Static
        })
        .onClick(() => {
          router.pushUrl({
            url: "pages/animate/animateIndex2"
          })
        })
    }
    .height('100%')
    .width('100%')
    .justifyContent(FlexAlign.Center)
  }
}