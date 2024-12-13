// import { webSocket } from '@kit.NetworkKit';
// import { BusinessError } from '@kit.BasicServicesKit';
//
// @Entry
// @Component
// struct WebsocketPage {
//   @State message: string = 'Hello World';
//   // http  只有当客户端给服务端发送了请求之后, 服务端才可以进行响应
//   // 如果客户端没有对服务端发送请求 , 那么服务无法主动给客户发送数据
//   // 单向
//
//   // http / https
//
//   // ws / wss
//
//   // 服务端 - 客户端
//
//   // websocket  双工通信    客户端可以主动给服务端发消息  服务端也可以主动给客户端发消息 客户端可以主动或者被动接受
//   // 服务端的消息, 服务端也可以主动或者被动接受客户端发送的消息
//
//   // 数据实时的, 实时给客户端
//
//   // 使用websocket的前提: 先连接服务端的websocket
//
//   @State
//   websocketInstance: webSocket.WebSocket | null = null
//
//   // 连接服务端的websocket
//   connectWebsocket() {
//     // 1. 创建websocket的实例对象
//     this.websocketInstance = webSocket.createWebSocket();
//
//     this.websocketInstance.on('open', (err: BusinessError, value: Object) => {
//       console.log("on open, status:" + JSON.stringify(value));
//       // 当收到on('open')事件时，可以通过send()方法与服务器进行通信
//       AlertDialog.show({
//         message: "open"
//       })
//     });
//
//     // 接收服务端发送的消息
//     this.websocketInstance.on("message", (err: BusinessError<void>, value: string | ArrayBuffer) => {
//       if (!err) {
//         AlertDialog.show({
//           message: value.toString()
//         })
//       } else {
//         AlertDialog.show({
//           message: "接收消息失败"
//         })
//       }
//     })
//
//     // 2. 连接服务端的websocket
//     this.websocketInstance.connect("ws://localhost:7777", (err: BusinessError, value: boolean) => {
//       if (!err) {
//         AlertDialog.show({
//           message: "连接成功"
//         })
//
//
//       } else {
//         AlertDialog.show({
//           message: "websocket连接失败"
//         })
//         console.log("connect fail, err:" + JSON.stringify(err));
//       }
//     })
//
//
//   }
//
//   build() {
//     Column() {
//       Button("连接服务端的websocket")
//         .onClick(() => {
//           this.connectWebsocket();
//         })
//     }
//     .height('100%')
//     .width('100%')
//   }
// }

import { webSocket } from '@kit.NetworkKit'
import { promptAction } from '@kit.ArkUI'
import { BusinessError } from '@kit.BasicServicesKit'

interface messageInfo {
  //用户id，我这里的设置：客户端的id为1001,服务端id为1002
  id: string
  msg: string
}

@Entry
@Component
struct WebsocketPage {
  @State data: messageInfo[] = [] //消息数组
  @State myMsg: string = ''
  //这是websocket在线测试url，客户端发送什么，服务器就会返回什么
  @State url: string = 'ws://localhost:4445'
  // @State url: string = 'ws://sqapi2.dishawang.com/ws'
  // @State url: string = 'ws://124.222.224.186:8801'
  ws: webSocket.WebSocket | null = null

  async aboutToAppear() {
    this.connect2Server(this.url)
    this.receiveMsg()
  }

  //连接服务端
  connect2Server(defaultIpAddress: string) {
    this.ws = webSocket.createWebSocket();
    //根据URL地址，建立一个WebSocket连接
    this.ws.connect(defaultIpAddress, (err: BusinessError, value: boolean) => {
      if (!err) {
        //连接成功
        promptAction.showToast({ message: 'connect success ' })
      } else {
        AlertDialog.show({ message: 'connect fail ' + err.message })
      }
    })

    this.ws.on('open', (err: BusinessError, value: object) => {
      //打开webSocket失败
      if (err) {
        AlertDialog.show({ message: JSON.stringify(err) })
      }
    })

    this.ws.on('error', (err: BusinessError) => {
      console.log("on error, error:" + JSON.stringify(err));
    });
  }

  //接收到服务器消息
  receiveMsg() {
    if (this.ws) {
      this.ws.on('message', (err, value) => {
        this.data.push({ id: '1002', msg: JSON.stringify(value) })
      })
    }
  }

  //发送消息到服务端
  sendMsg2Server(msg: string) {
    if (this.ws) {
      this.ws.send(msg)
        .catch((e: Error) => {
          console.log("error", JSON.stringify(e))
          AlertDialog.show({ message: '发送失败' + e.message })
        })
    }


  }

  build() {
    Navigation() {
      Column() {
        List() {
          ForEach(this.data, (Item: messageInfo) => {
            ListItem() {
              Row() {
                //网络图片需要打开网络权限
                Image(Item.id === '1001' ?
                  "https://tse3-mm.cn.bing.net/th/id/OIP-C.JRIYJ3EqtcLF1LwK3oxjgAHaGg?w=201&h=181&c=7&r=0&o=5&dpr=1.3&pid=1.7" :
                  "https://tse3-mm.cn.bing.net/th/id/OIP-C.7Z068v6GRuOJVYYUSHsBDgHaNK?w=115&h=182&c=7&r=0&o=5&dpr=1.3&pid=1.7")
                  .height(40)
                  .width(40)
                  .borderRadius(6)
                Row() {
                  Text(Item.msg)
                    .backgroundColor(Item.id === '1001' ? Color.Orange : Color.Yellow)
                    .padding(10)
                    .lineHeight(24)
                    .margin({
                      left: 10,
                      right: 10
                    })
                    .borderRadius(5)
                }
                .layoutWeight(6)
                .justifyContent(Item.id === '1001' ? FlexAlign.End : FlexAlign.Start)

                Text().layoutWeight(1)
              }
              .alignItems(VerticalAlign.Top)
              .direction(Item.id === '1001' ? Direction.Rtl : Direction.Ltr)
            }
            .margin({ bottom: 10 })
          })
        }
        .padding(10)
        .backgroundColor(Color.Pink)
        .layoutWeight(1)

        TextInput({ placeholder: '请输入', text: $$this.myMsg })
          .onSubmit(() => {
            this.sendMsg2Server(this.myMsg)
            this.data.push({ id: '1001', msg: this.myMsg } as messageInfo)
            //清空输入框内容
            this.myMsg = ''
          })
      }
      .height('100%')
      .width('100%')
    }
    .title('webSocket通信')
    .titleMode(NavigationTitleMode.Mini)
  }
}
