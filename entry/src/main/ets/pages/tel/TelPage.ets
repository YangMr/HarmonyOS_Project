import { call } from '@kit.TelephonyKit'
import { common, Want } from '@kit.AbilityKit'
import { BusinessError } from '@kit.BasicServicesKit'

@Entry
@Component
struct TelPage {
  // 拨打电话
  doTel() {
    call.makeCall(getContext(), "15910732068")
  }

  // 打开浏览器
  openBrows() {
    //
    // const context = getContext(this) as common.UIAbilityContext
    //
    // let want: Want = {
    //   action: 'ohos.want.action.viewData',
    //   entities: ['entity.system.browsable'],
    //   uri: 'https://www.huawei.com/'
    // };
    // context.startAbility(want)
    //   .then(() => {
    //     console.error('Start browsableAbility successfully.');
    //   })
    //   .catch((err: BusinessError) => {
    //     console.error(`Failed to startAbility. Code: ${err.code}, message: ${err.message}`);
    //   });
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      action: "ohos.want.action.viewData",
      entities: ["entity.system.browsable"],
      uri: "https://www.baidu.com/"
    }
    context.startAbility(want)
      .then(() => {
        AlertDialog.show({
          message: "成功"
        })
      })
      .catch((error: BusinessError) => {
        AlertDialog.show({
          message: "失败"
        })
      })
  }

  // 跳转到应用市场
  goMark() {
    const context = getContext() as common.UIAbilityContext

    // let bundleName = "com.kanyun.hos.solar"
    let bundleName = ""

    context.startAbility({
      action: "ohos.want.action.appdetail",
      // uri: "store://appgallery.huawei.com/app/detail?id=" + bundleName
      uri: "store://appgallery.huawei.com/app"
    })
      .then(() => {
        AlertDialog.show({
          message: "成功"
        })
      })
      .catch((error: BusinessError) => {
        AlertDialog.show({
          message: "失败"
        })
      })
  }

  // 打开高德地图
  openMap() {
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      uri: 'amapuri://route/plan?sid=BGVIS1&dlat=39.98848272&dname=北大&slat=39.92848272&dlon=116.47560823&did=BGVIS2&slon=116.39560823&sname=清华&t=0&sourceApplication=applicationName'
    }
    context.startAbility(want)

  }

  // 打开第三方应用淘宝
  openTaoBao() {
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      uri: "taobao://"
    }
    context.startAbility(want)
  }

  // 打开第三方应用支付宝
  openAliPay() {
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      uri: "alipays://"
    }
    context.startAbility(want)
  }

  // 打开支付宝的扫码
  openAliPayScan() {
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      uri: "alipays://platformapi/startapp?saId=10000007"
    }
    context.startAbility(want)
  }

  // 打开支付宝传入url
  openAliPayUrl() {
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      uri: "alipays://platformapi/startapp?appId=20000067&url=http://www.baidu.com"
    }
    context.startAbility(want)
  }

  // 打开微信
  openWeChat() {
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      uri: "weixin://"
    }
    context.startAbility(want)
  }

  // 打开京东
  openJD() {
    const context = getContext(this) as common.UIAbilityContext
    let want: Want = {
      uri: "openApp.jdMobile://"
    }
    context.startAbility(want)
  }

  openPermission() {
    const context = getContext(this) as common.UIAbilityContext

    let want: Want = {
      bundleName: 'com.huawei.hmos.settings',
      abilityName: 'com.huawei.hmos.settings.MainAbility',
      uri: 'application_info_entry',
      parameters: {
        pushParams: "com.example.harmonyos_device"
      }
      // bundleName: "com.huawei.hmos.settings",
      // abilityName: "com.huawei.hmos.settings.MainAbility",
      // uri: "application_info_entry",
      // parameters: {
      //   pushParams: "com.example.harmonyos_device"
      // }
    }
    context.startAbility(want)
  }

  build() {
    Column({ space: 20 }) {
      Button("拨打电话")
        .onClick(() => {
          this.doTel()
        })

      Button("打开浏览器")
        .onClick(() => {
          this.openBrows()
        })

      Button("跳转到应用市场")
        .onClick(() => {
          this.goMark()
        })

      Button("打开高德地图")
        .onClick(() => {
          this.openMap()
        })

      Button("打开淘宝")
        .onClick(() => {
          this.openTaoBao()
        })

      Button("打开支付宝")
        .onClick(() => {
          this.openAliPay()
        })

      Button("打开支付宝扫码")
        .onClick(() => {
          this.openAliPayScan()
        })

      Button("打开微信")
        .onClick(() => {
          this.openWeChat()
        })

      Button("打开京东")
        .onClick(() => {
          this.openJD()
        })

      Button("打开鸿蒙设置权限")
        .onClick(() => {
          this.openPermission()
        })
    }
    .height('100%')
    .width('100%')
  }
}