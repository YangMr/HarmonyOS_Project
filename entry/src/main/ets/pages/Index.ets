import { getBannerApi } from '../api/baidu'
import { getHomeApi } from '../api/jd'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct Index {

  @Builder
  loading(){
    LoadingProgress()
      .width(30)
      .height(30)
  }

  async initGetBanner(){
    try {

      const res = await getBannerApi("my")
      AlertDialog.show({
        message : JSON.stringify(res, null, 2)
      })


    } catch (e) {
      console.log(e)
    }
  }


  async initGetHome(){
    try {
      const res = await getHomeApi()
      // AlertDialog.show({
      //   message : JSON.stringify(res, null,2)
      // })
    } catch (e) {
      console.log(e)
    }
  }


  build() {
    Column(){


      Button("请求社区交友项目的接口")
        .onClick(() => {
          this.initGetBanner()
        })

      Button("请求资讯项目的接口")
        .onClick(() => {
          this.initGetHome()
        })
    }
    .height('100%')
    .width('100%')
  }
}