import { webview } from '@kit.ArkWeb'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct HybirdPage {
  @State
  controller: WebviewController = new webview.WebviewController()
  @State
  flag: boolean = false

  // html 鸿蒙记载html页面 , 并且可以调用html页面的方法
  // 在html页面也可以调用鸿蒙的方法

  showMsg() {
    AlertDialog.show({
      message: "h5端调用了我"
    })
  }

  build() {
    Column() {

      Button("调用(H5端)网页里面的方法")
        .onClick(() => {
          this.controller.runJavaScript("changeText()", (err, success) => {
            if (err) {
              promptAction.showToast({
                message: 'err:' + err.message
              })
            } else {
              promptAction.showToast({
                message: 'success:' + success
              })
            }
          })
        })

      Button("给应用注册脚本")
        .onClick(() => {

          this.controller.registerJavaScriptProxy({
            "objKey": () => {
              this.showMsg()
            },
            "objKey1": () => {
              this.showMsg()
            },
            "objKey2": () => {
              this.showMsg()
            }
          }, "objName", ["objKey", "objKey1"])

          //  网页注入事件必须要refresh一下才能生效
          this.controller.refresh()
        })

      Web({
        src: $rawfile("index.html"),
        controller: this.controller
      })


      // Button("去百度")
      //   .onClick(() => {
      //     this.flag = true
      //   })
      //
      // if (this.flag) {
      //   Web({
      //     //1. 加载在线网页
      //     // src: "https://www.baidu.com/",
      //     // controller: this.controller
      //     // 2. 加载离线网页
      //     // src: $rawfile("index.html"),
      //     src: "https://php.likeadmin.cn/mobile/pages/news_detail/news_detail?id=5",
      //     controller: this.controller
      //   })
      // }

    }
    .height('100%')
    .width('100%')
  }
}