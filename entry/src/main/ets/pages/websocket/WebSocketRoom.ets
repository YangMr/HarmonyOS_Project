import { webSocket } from '@kit.NetworkKit'
import { BusinessError } from '@kit.BasicServicesKit'
import { promptAction } from '@kit.ArkUI'

interface ChatListModel {
  userId: number,
  nickName: string
  text: string,
}

@Entry
@Component
struct WebSocketRoom {
  @State
  nickName: string = ""
  @State
  text: string = ""
  @State
  ws: webSocket.WebSocket | null = null
  @State
  roomList: string[] = []
  @State
  chatList: ChatListModel[] = []

  // 连接websocket
  connectWebsocket() {
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
    this.ws.on("open", (err: BusinessError, value: object) => {
      if (!err) {
        promptAction.showToast({ message: "打开连接" })
        this.sendMessage()
      } else {
        console.log("connect error" + JSON.stringify(err))
      }
    })

    // 5. 监听服务端发送过来的数据
    this.ws.on("message", (err: BusinessError, value: string | ArrayBuffer | ChatListModel) => {
      if (!err) {


        const data = JSON.parse(JSON.stringify(value)) as ChatListModel
        const newData: ChatListModel = JSON.parse(data.toString())
        if (newData.text) {
          this.chatList.push(newData)
        } else {
          this.roomList.push(value as string)
        }
      } else {
        console.log("message error" + JSON.stringify(err))
      }
    })
  }

  // 4. 给服务端发送数据
  sendMessage() {
    this.ws?.send(JSON.stringify({ userId: 1, nickName: this.nickName, text: this.text }))
  }

  // 7. 渲染数据
  // 8. 监听websocket关闭
  // 9. 监听websocket发送错误
  // 10. 断线重连


  build() {
    Column() {
      Row() {
        TextInput({ placeholder: "请输入用户名", text: $$this.nickName })
          .layoutWeight(1)
          .backgroundColor(Color.White)
        Button("加入聊天室")
          .onClick(() => {
            // 点击加入聊天室按钮进行连接websocket服务
            if (!this.nickName) {
              return
            }

            // 连接websocket
            this.connectWebsocket()

          })
      }
      .width("100%")

      Scroll() {
        Column({ space: 20 }) {
          ForEach(this.roomList, (item: string) => {
            Text(item)
          })
        }
        .width("100%")

      }
      .width("100%")
      .height(200)
      .margin({ top: 40 })
      .padding(20)
      .backgroundColor(Color.White)

      Scroll() {
        Column({ space: 20 }) {
          ForEach(this.chatList, (item: ChatListModel) => {
            Text(item.text)
          })


        }
        .width("100%")

      }
      .width("100%")
      .height(200)
      .margin({ top: 40 })
      .padding(20)
      .backgroundColor(Color.White)

      Row() {
        TextInput({ placeholder: "请输入您要说的内容", text: $$this.text })
          .layoutWeight(1)
          .backgroundColor(Color.White)
        Button("发送")
          .onClick(() => {
            if (!this.text) {
              return
            }

            // 发送消息
            this.sendMessage()
          })
      }
      .width("100%")
      .margin({ top: 30 })

    }
    .height('100%')
    .width('100%')
    .padding(20)
    .backgroundColor("#ccc")
  }
}