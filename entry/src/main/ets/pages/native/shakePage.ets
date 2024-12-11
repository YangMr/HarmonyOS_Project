import { sensor } from '@kit.SensorServiceKit'

@Entry
@Component
struct ShakePage {
  @State top: number = -250
  @State left: number = 0
  @State scaleValue: number = 1

  startSensor() {
    let num: number = 15
    // sensor.on(sensor.SensorId.ACCELEROMETER, (data) => {
    //   if (data.x > num || data.x < -num || data.y > num || data.y < -num || data.z > num || data.z < -num) {
    //     promptAction.showToast({
    //       message: "检测到了摇一摇"
    //     })
    //
    //     this.top = 200
    //   }
    // }, {
    //   interval: 1000000       // 1毫秒
    // })

    sensor.on(sensor.SensorId.GYROSCOPE, (data) => {
      // AlertDialog.show({
      //   message: "aaaa"
      // })
      console.log("data:", JSON.stringify(data))
    })
  }

  aboutToAppear(): void {
    this.startSensor()
  }

  build() {
    Stack({
      alignContent: Alignment.Top
    }) {
      Column() {
        Text("摇一摇看小效果").margin({
          top: 400
        }).fontSize(20)

      }
      .width("100%")
      .height("100%")

      Row() {
        Image($r("app.media.award"))
      }
      .width(200)
      .height(200)
      .scale({
        x: this.scaleValue,
        y: this.scaleValue
      })
      .translate({
        y: this.top,
        x: this.left
      })
      .animation({
        duration: 1000
      })
      .onClick(() => {
        this.top = 300
        this.left = 300
        this.scaleValue = 0
        //需要根据实际的业务需求配置
        setTimeout(() => {
          this.top = -200
          this.left = 0
          this.scaleValue = 0
        }, 1000)
        setTimeout(() => {
          this.scaleValue = 1
        }, 2000)
      })
    }

  }
}