import { router } from '@kit.ArkUI';

@Entry
@Component
struct CachePage {
  @State message: string = 'Hello World';

  // 本地数据缓存预加载方案：
  // 用户在进入页面的时候先展示之前看到的数据，等到接口请求到数据的时候会
  // 将之前的缓存的数据替换，主要是使用了localStorage和时间戳，首次进入页面的时候使用getItem查
  // 找对应的数据，如果没找到就正常请求接口渲染页面，如果查找到了就先渲染缓存数据等待新的数据接口
  // 请求后替换，因为localstorage缓存是长久保存数据不会被自动清除的，所以需要加上时间戳让缓存的数
  // 据在一定时间内去除掉，主要方法就是在存储数据的时候加上时间，在获取数据的时候判断现在的时间减去当
  // 时存储时的时间如果小于自己设置的时间，就证明数据没有过期，就正常展示缓存的数据，如果大于设置的时
  // 间就清除缓存的数据


  build() {
    Column() {
      Button("跳转到阅读页面")
        .onClick(() => {
          router.pushUrl({
            url: "pages/cache/readPage"
          })
        })
    }
    .height('100%')
    .width('100%')
  }
}