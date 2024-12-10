import { router } from '@kit.ArkUI';

@Entry
@Component
struct CurrentPage2 {
  @State message: string = 'Hello World';

  pageTransition() {
    // 定义页面进入时的效果，从左侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.None, duration: 1200 })
      .slide(SlideEffect.Bottom)
    PageTransitionExit({ type: RouteType.None, duration: 1200 })
      .slide(SlideEffect.Bottom)

  }

  build() {
    RelativeContainer() {
      Text("跳转到页面一")
        .id('CurrentPage2HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          router.pushUrl({
            url: "pages/animate/currentPage1"
          })
        })

    }
    .height('100%')
    .width('100%')
  }
}