import { bundleManager, common, Want } from '@kit.AbilityKit';
import axios from '@ohos/axios';
import { notificationManager } from '@kit.NotificationKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { promptAction } from '@kit.ArkUI';

const TAG: string = '[PublishOperation]';
const DOMAIN_NUMBER: number = 0xFF00;

interface DataType {
  data: DataResultType
}

interface DataResultType {
  result: DataResultCodeType
}

interface DataResultCodeType {
  versionCode: string
}

@Entry
@Component
struct AppPage {
  @State
  localVersion: number = 0
  @State
  remoteVersion: number = 0

  aboutToAppear(): void {
    this.checkUpdateApp()
    this.requestPush()
  }

  requestPush() {
    let context = getContext(this) as common.UIAbilityContext;
    notificationManager.isNotificationEnabled().then((data: boolean) => {
      hilog.info(DOMAIN_NUMBER, TAG, "isNotificationEnabled success, data: " + JSON.stringify(data));
      if (!data) {
        notificationManager.requestEnableNotification(context).then(() => {
          hilog.info(DOMAIN_NUMBER, TAG, `[ANS] requestEnableNotification success`);
        }).catch((err: BusinessError) => {
          if (1600004 == err.code) {
            hilog.error(DOMAIN_NUMBER, TAG,
              `[ANS] requestEnableNotification refused, code is ${err.code}, message is ${err.message}`);
          } else {
            hilog.error(DOMAIN_NUMBER, TAG,
              `[ANS] requestEnableNotification failed, code is ${err.code}, message is ${err.message}`);
          }
        });
      }
    }).catch((err: BusinessError) => {
      hilog.error(DOMAIN_NUMBER, TAG, `isNotificationEnabled fail, code is ${err.code}, message is ${err.message}`);
    });
  }

  // 1. 获取本地的版本号
  getAppVersion() {
    const bundleFlags = bundleManager.BundleFlag.GET_BUNDLE_INFO_DEFAULT
    try {
      this.localVersion = bundleManager.getBundleInfoForSelfSync(bundleFlags).versionCode

    } catch (e) {
      console.log(e)
    }
  }

  // 2. 获取远程的版本号
  async getRemoteAppVersion() {
    try {
      const res = await axios.get<null, DataType>("https://xiaomi.itying.com/api/getAppVersion?versionCode=1000005")
      this.remoteVersion = Number(res.data.result.versionCode)
    } catch (e) {
      console.log(e)
    }
  }

  // 3. 检测更新(判断本地版本是否是最新版本)
  async checkUpdateApp() {
    this.getAppVersion()
    await this.getRemoteAppVersion()

    if (this.localVersion < this.remoteVersion) {
      promptAction.showDialog({
        message: "您确定要更新吗?",
        buttons: [
          {
            text: "取消",
            color: "#ff0000"
          },
          {
            text: "确定",
            color: "#0099ff"
          }
        ]
      }).then((result) => {
        if (result.index === 1) {
          // 跳转到应用市场更新
          this.goMarket()
        }
        // AlertDialog.show({
        //   message: JSON.stringify(result, null, 2)
        // })
      })
    } else {
      promptAction.showToast({
        message: "已经是最新版本了, 不需要更新"
      })
    }

  }

  // 4. 跳转到应用市场进行更新
  goMarket() {
    const context = getContext(this) as common.UIAbilityContext
    const bundleName = "com.huawei.hmos.inputmethod"
    let want: Want = {
      action: "ohos.want.action.appdetail",
      uri: "store://appgallery.huawei.com/app/detail?id=" + bundleName
    }
    context.startAbility(want)

  }

  build() {
    Column({ space: 20 }) {
      // Button("获取本地的版本号")
      //   .onClick(() => {
      //     this.getAppVersion()
      //   })
      //
      // Button("获取远程的版本号")
      //   .onClick(() => {
      //     this.getRemoteAppVersion()
      //   })
      //
      //
      // Button("检测是否是最新的版本号")
      //   .onClick(() => {
      //     this.checkUpdateApp()
      //   })
    }
    .height('100%')
    .width('100%')
  }
}