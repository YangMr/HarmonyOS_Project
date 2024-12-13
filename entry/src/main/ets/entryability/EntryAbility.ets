import { abilityAccessCtrl, AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { display, window } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';
import { pushService } from '@kit.PushKit';

export default class EntryAbility extends UIAbility {
  windowObj?: window.Window
  private curBp: string = ''

  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam) {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');


    // 创建程序控制管理器
    const manager = abilityAccessCtrl.createAtManager()
    await manager.requestPermissionsFromUser(this.context, [
      "ohos.permission.LOCATION",
      "ohos.permission.APPROXIMATELY_LOCATION"
    ])

    // 获取Push Token
    try {
      const pushToken: string = await pushService.getToken();
      console.log("ttt", pushToken)
    } catch (err) {
      let e: BusinessError = err as BusinessError;
      hilog.error(0x0000, 'testTag', 'Failed to get push token: %{public}d %{public}s', e.code, e.message);
    }

  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {


    windowStage.getMainWindow().then((windowObj) => {
      this.windowObj = windowObj
      // 获取应用启动时的窗口尺寸
      this.updateBreakpoint(windowObj.getWindowProperties().windowRect.width)
      // 注册回调函数，监听窗口尺寸变化
      windowObj.on('windowSizeChange', (windowSize) => {
        this.updateBreakpoint(windowSize.width)
      })
    });


    windowStage.loadContent('pages/websocket/WebSocketRoom', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }

  // 根据当前窗口尺寸更新断点
  private updateBreakpoint(windowWidth: number): void {

    // 拿到当前窗口对象获取当前所在displayId
    let displayId = this.windowObj?.getWindowProperties().displayId
    try {
      // 将长度的单位由px换算为vp
      let windowWidthVp = windowWidth / display.getDisplayByIdSync(displayId).densityPixels

      console.log("currentBreakpoint", windowWidthVp)

      let newBp: string = ''
      if (windowWidthVp < 320) {
        newBp = 'xs'
      } else if (windowWidthVp < 600) {
        newBp = 'sm'
      } else if (windowWidthVp < 840) {
        newBp = 'md'
      } else {
        newBp = 'lg'
      }

      if (this.curBp !== newBp) {
        this.curBp = newBp
        console.log("currentBreakpoint", this.curBp)
        // 使用状态变量记录当前断点值
        AppStorage.setOrCreate('currentBreakpoint', this.curBp)
      }
    } catch (err) {
      console.log("getDisplayByIdSync failed err" + err.code)
    }
  }
}
