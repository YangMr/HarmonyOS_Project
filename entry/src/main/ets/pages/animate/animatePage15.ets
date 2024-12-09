@Entry
@Component
struct AnimatePage15 {
  build() {
    Column() {
      ImageAnimator()
        .images(Array.from(Array(37), (item: string, index: number) => {
          return {
            src: $r(`app.media.loading_${index + 1}`)
          } as ImageFrameInfo
        }))// .images([
          //   { src: $r("app.media.app_refresh_people_0") },
          //   { src: $r("app.media.app_refresh_people_1") },
          //   { src: $r("app.media.app_refresh_people_2") },
          //   { src: $r("app.media.app_refresh_people_3") }
          // ])
        .duration(1000)
        .state(AnimationStatus.Running)
        .fillMode(FillMode.None)
        .iterations(-1)// 必须有宽高
        .width(80)
        .height(120)
    }
    .width("100%")
    .height("100%")
  }
}