import { TextToVoice } from './utils/TextToSpeech';

@Entry
@Component
struct TranslatePage {
  @State message: string =
    '调用方拉起：需要根据不同的意图场景选择不同的参数传递方式，以下以导航场景为例，在其中配置了意图sceneType为2表示导航，并配置了终点经纬度、起点经纬度、出行工具vehicleType等。更多场景与字段说明开发者可以参考';

  // 文件转语音
  read() {
    TextToVoice.start(this.message)
  }

  build() {
    Column({ space: 20 }) {
      Text(this.message)

      Button("阅读这段文本")
        .onClick(() => {
          this.read()
        })
    }
    .height('100%')
    .width('100%')
  }
}