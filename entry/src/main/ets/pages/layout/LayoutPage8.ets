@Entry
@Component
struct WrapCapabilitySample {
  @State rate: number = 1
  readonly imageList: ResourceStr [] = [
    "https://img1.baidu.com/it/u=2763984098,151158424&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=889",
    "https://img1.baidu.com/it/u=1453356183,2473705747&fm=253&fmt=auto&app=138&f=JPEG?w=751&h=500",
    "https://img0.baidu.com/it/u=2944726738,1310666541&fm=253&fmt=auto&app=138&f=JPEG?w=667&h=500",
    "https://img0.baidu.com/it/u=2650685357,1926171164&fm=253&fmt=auto&app=138&f=JPEG?w=750&h=500",
    "https://img0.baidu.com/it/u=3910844331,492615673&fm=253&fmt=auto&app=138&f=JPEG?w=774&h=500",
    "https://img0.baidu.com/it/u=3098873129,230506230&fm=253&fmt=auto&app=120&f=JPEG?w=627&h=376"
  ]

  // 底部滑块，可以通过拖拽滑块改变容器尺寸
  @Builder
  slider() {
    Slider({
      value: this.rate * 100,
      min: 50,
      max: 70,
      style: SliderStyle.OutSet
    })
      .blockColor(Color.White)
      .width('60%')
      .onChange((value: number) => {
        this.rate = value / 100
      })
      .position({ x: '20%', y: '87%' })
  }

  build() {
    Flex({ justifyContent: FlexAlign.Center, direction: FlexDirection.Column }) {
      Column() {
        // 通过Flex组件warp参数实现自适应折行
        Flex({
          direction: FlexDirection.Row,
          alignItems: ItemAlign.Center,
          justifyContent: FlexAlign.Center,
          wrap: FlexWrap.Wrap
        }) {
          ForEach(this.imageList, (item: Resource) => {
            Image(item).width(53).height(58).padding(10)
          })
        }
        .backgroundColor("#fff")
        .padding(20)
        .width(this.rate * 100 + '%')
        .borderRadius(16)
      }
      .width('100%')

      this.slider()
    }.width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}