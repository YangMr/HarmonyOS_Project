import { webSocket } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct WebsocketChart {
  @State
  ws: webSocket.WebSocket | null = null
  @State
  isConnect: boolean = false
  @State
  list: ListModel[] = []

  // 进入当前页面就建立websocket连接
  aboutToAppear(): void {
    this.connectWebsocket()
  }

  // 连接websocket的方法
  connectWebsocket() {
    // 4. 处理websocket重复打开
    if (this.isConnect) {
      return
    }
    // 1. 创建websocket实例对象
    this.ws = webSocket.createWebSocket()
    // 2. 建立连接
    this.ws.connect("ws://101.42.151.51:3434", (err: BusinessError, value: boolean) => {
      if (!err) {
        promptAction.showToast({ message: "建立连接" })
      } else {
        console.log("connect error" + JSON.stringify(err))
      }
    })
    // 3. 监听打开连接
    this.ws.on("open", (err, value: Object) => {
      if (!err) {
        promptAction.showToast({ message: "连接成功" })
        this.isConnect = true
      } else {
        console.log("open error" + JSON.stringify(err))
      }
    })

    // 5. 接收服务端发送数据
    this.ws.on("message", (err: BusinessError, value: string | ArrayBuffer) => {
      if (!err) {


        // 6. 保存服务端的数据
        this.list = JSON.parse(value as string)

      } else {
        console.log("message error" + JSON.stringify(err))
      }
    })
  }

  build() {
    Column() {
      // 7. 渲染数据
      ForEach(this.list, (item: ListModel) => {
        Column() {
          Text(item.count + "万")
            .fontSize(30)
          Text(item.tag)
            .fontSize(20)
        }
      })
    }
    .height('100%')
    .width('100%')
  }
}

interface ListModel {
  count: number
  tag: string
}