import { router } from '@kit.ArkUI';

@Entry
@Component
struct CurrentPage1 {
  @State message: string = 'Hello World';

  pageTransition() {
    // 定义页面进入时的效果，从左侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: 1200 })
      .slide(SlideEffect.Bottom)
    PageTransitionExit({ type: RouteType.None, duration: 1200 })
      .slide(SlideEffect.Bottom)

  }

  build() {
    Column() {
      Button("跳转到页面二")
        .onClick(() => {
          router.pushUrl({
            url: "pages/animate/currentPage2"
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}