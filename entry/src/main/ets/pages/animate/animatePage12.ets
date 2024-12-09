@Entry
@Component
struct AnimatePage12 {
  @State
  toggle: boolean = true

  build() {
    Column({ space: 10 }) {

      Button("click me")
        .margin(50)
        .motionPath({
          path: 'Mstart.x start.y L100 400 L100 200 L400 600 Lend.x end.y',
          from: 0.0,
          to: 1.0,
          rotatable: false
        })
        .onClick(() => {
          animateTo({
            duration: 4000,
            curve: Curve.Linear
          }, () => {
            this.toggle = !this.toggle
          })
        })


      // .width("100%")
      // .height("100%")

    }
    .height('100%')
    .width('100%')
    .alignItems(this.toggle ? HorizontalAlign.Start : HorizontalAlign.Center)
  }
}