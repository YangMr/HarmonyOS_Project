import { webSocket } from '@kit.NetworkKit';
import { promptAction } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry
@Component
struct WebsocketIndex {
  // 连接状态 true 已连接 false 断开连接
  @State
  isConnect: boolean = false
  @State
  websocketInstance?: webSocket.WebSocket | null = null
  @State
  inputText: string = ""

  aboutToAppear(): void {
    this.connectWebsocket()
  }

  // 连接服务端websocket
  connectWebsocket() {
    // 如果websocket已经连接了, 我们则不在进行连接
    if (this.isConnect) {
      return
    }

    // 1. 创建websocket实例对象
    const ws = webSocket.createWebSocket()
    this.websocketInstance = ws

    // 2. 建立连接
    ws.connect("ws://101.42.151.51:3434", (err: BusinessError, value: boolean) => {
      if (!err) {
        promptAction.showToast({ message: "连接成功" })
        console.log("Connected successfully");

        // 设置连接成功
        this.isConnect = true
      } else {
        promptAction.showToast({ message: "连接失败" })
        console.log("Connection failed. Err:" + JSON.stringify(err));
      }
    })


    // 3. 监听客户端打开连接
    ws.on("open", (err: BusinessError, value: Object) => {
      if (!err) {
        AlertDialog.show({ message: "打开连接" })

        // 打开连接之后, 客户端给服务端发送消息
        // ws.send(JSON.stringify({ name: "jack" }))
      } else {
        console.log("openErr:" + JSON.stringify(err))
      }
    })

    // 4. 监听是否关闭连接
    ws.on("close", (err: BusinessError, value: webSocket.CloseResult) => {
      if (!err) {
        promptAction.showToast({ message: "关闭连接" })
        // 设置连接断开
        this.isConnect = false
      } else {
        console.log("close err:" + JSON.stringify(err));
      }
    })

    // 5. 监听是否连接失败
    ws.on("error", (err: BusinessError) => {
      if (!err) {
        promptAction.showToast({ message: "连接发生错误" })
        // 设置连接断开
        this.isConnect = false
      } else {
        console.log("close err:" + JSON.stringify(err));
      }
    })

    // 6. 监听服务端发送过来的消息
    ws.on("message", (err: BusinessError, value: string | ArrayBuffer) => {
      if (!err) {
        AlertDialog.show({
          message: value.toString()
        })
      } else {
        console.log("message err :" + JSON.stringify(err))
      }
    })

  }

  // 给服务端websocket发送消息
  sendMessage() {
    this.websocketInstance?.send(JSON.stringify({ id: 1, user: "jack", text: this.inputText }))
  }

  build() {
    Column({ space: 20 }) {
      Row() {
        TextInput({ placeholder: "请输入内容", text: $$this.inputText })
      }
      .width("100%")
      .padding({ left: 20, right: 20 })

      Button("连接服务端websocket")
        .onClick(() => {
          this.connectWebsocket()
        })

      Button("给服务端发送消息")
        .onClick(() => {
          this.sendMessage()
        })
    }
    .height('100%')
    .width('100%')
  }
}