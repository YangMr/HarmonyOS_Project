// // 定义加载器组件
// @Component
// struct LoaderComponent {
//   build() {
//     Column({ space: 5, alignment: Alignment.Center }) { // 使用Column布局并居中对齐
//       Stack({ alignment: Alignment.Center }) { // 使用Stack布局来堆叠元素
//         // 创建第一个圆形，并添加动画
//         Circle()
//           .width(64).height(64)
//           .border({ width: 10, color: Color.Green })
//           .startAnimation(
//             Animation().repeatCount(-1).duration(1000).curve(Curve.EaseOut)
//               .keyframes([
//                 Keyframe(0, () => ({
//                   transform: Transform({
//                     translateX: Length('32vp'),
//                     translateY: Length('32vp'),
//                     scaleX: 0,
//                     scaleY: 0,
//                     opacity: 1
//                   })
//                 })),
//                 Keyframe(1, () => ({
//                   transform: Transform({
//                     translateX: Length('0vp'),
//                     translateY: Length('0vp'),
//                     scaleX: 1,
//                     scaleY: 1,
//                     opacity: 0
//                   })
//                 }))
//               ])
//           )
//
//         // 创建第二个圆形，并设置延迟
//         Circle()
//           .width(64).height(64)
//           .border({ width: 10, color: Color.Yellow })
//           .startAnimation(
//             Animation()
//               .repeatCount(-1)
//               .duration(1000)
//               .curve(Curve.EaseOut)
//               .delay(500)// 延迟动画开始的时间
//               .keyframes([
//                 Keyframe(0, () => ({
//                   transform: Transform({
//                     translateX: Length('32vp'),
//                     translateY: Length('32vp'),
//                     scaleX: 0,
//                     scaleY: 0,
//                     opacity: 1
//                   })
//                 })),
//                 Keyframe(1, () => ({
//                   transform: Transform({
//                     translateX: Length('0vp'),
//                     translateY: Length('0vp'),
//                     scaleX: 1,
//                     scaleY: 1,
//                     opacity: 0
//                   })
//                 }))
//               ])
//           )
//       }
//     }
//   }
// }
//
// // 主页面组件
// @Component
// @Entry
// struct MainPage {
//   build() {
//     Column({ space: 5, alignment: Alignment.Center }) { // 使用Column布局并居中对齐
//       LoaderComponent()
//     }
//   }
// }