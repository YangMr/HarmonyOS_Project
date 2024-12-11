import { display, window } from '@kit.ArkUI';
import { batteryInfo } from '@kit.BasicServicesKit';
import { sensor } from '@kit.SensorServiceKit';

@Entry
@Component
struct NativePage {
  @State message: string = 'Hello World';
  @State screenWidth: number = 0
  @State screenHeight: number = 0
  @State sHeight: number = 0

  // 获取加速度传感器的数据
  startSensor() {
    sensor.on(sensor.SensorId.ACCELEROMETER, (data) => {
      console.info('X-coordinate component: ' + data.x);
      console.info('Y-coordinate component: ' + data.y);
      console.info('Z-coordinate component: ' + data.z);

      this.message = `X:${data.x}--Y:${data.y}--Z:${data.y}`
    })


  }

  aboutToAppear(): void {
    this.v()
    this.startSensor()
    // this.start()
  }

  // 获取设备的尺寸
  getDevice() {
    const size = display.getDefaultDisplaySync()
    this.screenWidth = size.width
    this.screenHeight = size.height
    this.message = JSON.stringify(size, null, 2)
  }

  // 获取状态栏的高度
  async getStatusHeight() {
    // 获取窗口的对象
    const win = await window.getLastWindow(getContext(this))
    // 窗口的区域
    const avoidArea = win.getWindowAvoidArea(window.AvoidAreaType.TYPE_SYSTEM)
    // 获取状态栏的高度
    this.sHeight = avoidArea.topRect.height
  }

  // 切换为横屏
  async h() {
    // 获取窗口的对象
    const win = await window.getLastWindow(getContext(this))
    // 切换为横屏
    win.setPreferredOrientation(window.Orientation.LANDSCAPE)
  }

  // 切换为竖屏
  async v() {
    // 获取窗口的对象
    const win = await window.getLastWindow(getContext(this))
    // 切换为横屏
    win.setPreferredOrientation(window.Orientation.PORTRAIT)
  }

  build() {
    Column({ space: 20 }) {
      Button("切换为竖屏")
        .onClick(() => {
          this.v()
        })

      Text(this.message)
      Text(this.screenWidth.toString())
      Text(this.screenHeight.toString())
      Text(this.sHeight.toString())

      Button("获取设备的尺寸")
        .onClick(() => {
          this.getDevice()
        })

      Button("获取状态栏的高度")
        .onClick(() => {
          this.getStatusHeight()
        })

      Text(`剩余电量: ${batteryInfo.batterySOC}%`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Text(`表示当前设备电池的充电状态: ${batteryInfo.chargingStatus}`)
        .fontSize(20)
        .fontWeight(FontWeight.Bold)

      Button("切换为横屏")
        .onClick(() => {
          this.h()
        })


    }
    .height('100%')
    .width('100%')
  }
}