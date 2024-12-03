import { Location } from './components/Location';

@Entry
@Component
struct MapPage {
  @State message: string = 'Hello World';

  // 控制模态框的显示与隐藏
  @State
  isShow: boolean = false

  @State
  currentLocationMessage: string = ""

  // 展示的模态框的内容build
  @Builder
  getLocationContext(){
    Stack({alignContent : Alignment.Top}){
      // 地图
      Location({currentLocationMessage : this.currentLocationMessage})
      // 取消与确定按钮
      Row(){
        Text("取消")
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .onClick(() => {
            this.isShow = false
            this.currentLocationMessage = ""
          })

        Button("发送")
          .type(ButtonType.Normal)
          .borderRadius(4)
          .backgroundColor(Color.Green)
          .height(30)
          .width(60)
          .onClick(() => {
            this.isShow = false
          })
      }
      .width("100%")
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({left: 20, right : 20})
      .margin({top : 50})
      .height(60)
    }
    .width("100%")
    .height("100%")
    .backgroundColor(Color.White)
  }


  build() {
    Column(){
      Button("发送位置")
        .onClick(() => {
          this.isShow = true
        })
        .bindContentCover($$this.isShow,this.getLocationContext(), {
          modalTransition : ModalTransition.NONE
        })

      Row(){
        if(this.currentLocationMessage){
          Row(){
            Location({
              currentLocationMessage : this.currentLocationMessage
            })
          }
          .width("60%")
          .height("100%")
        }

      }
      .width("100%")
      .height(200)
      .margin({
        top : 60
      })
      .justifyContent(FlexAlign.End)
    }
    .height('100%')
    .width('100%')

  }
}