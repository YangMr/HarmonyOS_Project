import { getBannerAPI } from '../api/api';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct RequestPage {
  @State message: string = 'Hello World';

  async handleRequest(){
    try {
      const res = await getBannerAPI("my")
      // AlertDialog.show({
      //   message : JSON.stringify(res)
      // })

      promptAction.showToast({
        message : "res"
      })
    } catch (e) {
      console.log(e)
    }
  }

  build() {
    Column(){
      Button("重复请求")
        .width("100%")
        .height(50)
        .onClick(() => {
          this.handleRequest()
        })
    }
    .height('100%')
    .width('100%')
  }
}