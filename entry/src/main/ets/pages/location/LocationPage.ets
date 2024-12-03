import { router } from '@kit.ArkUI';

@Entry
@Component
struct LocationPage {
  @State message: string = 'Hello World';

  build() {
    Column(){
      Button("路线规划")
        .onClick(() => {
          router.pushUrl({
            url : "pages/Line/LinePage"
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}