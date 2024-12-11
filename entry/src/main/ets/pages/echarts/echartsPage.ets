import { ChartOptions, hmChart, hmChartType } from '@wuyan/hm_chart';

@Entry
@Component
struct EchartsPage {
  @State
  myChart: hmChartType | null = null
  @State
  options: ChartOptions = {
    xAxis: {
      type: 'category',
      data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
    },
    yAxis: {
      type: 'value'
    },
    tooltip: {
      trigger: 'axis'
    },
    series: [
      {
        data: [820, 932, 901, 934, 1290, 1330, 1320],
        type: 'line',
        smooth: true
      }
    ]
  }

  // 鸿蒙中要使用图表
  // 1. 安装echarts
  // 2. 使用hmChart渲染图标
  // 3. 定义mychart
  // 4. 定义options

  build() {
    Column() {
      Row() {
        hmChart({
          Options: this.options,
          myChart: this.myChart
        })
      }
      .width("100%")
      .height(300)
      .backgroundColor("#ccc")
    }
    .height('100%')
    .width('100%')
  }
}