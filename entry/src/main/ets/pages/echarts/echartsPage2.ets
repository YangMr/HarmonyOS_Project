import { ChartOptions, hmChart, hmChartType } from '@wuyan/hm_chart';


@Entry
@Component
struct EchartsPage2 {
  @State
  myChart: hmChartType | null = null
  @State
  options: ChartOptions = {
    backgroundColor: "#f5f9ff",
    color: ["#78aaf2", "#aed1f7", "#c3dcf8", "#e4f1fc", "#b4c9ef"],
    tooltip: {
      trigger: "axis",
      axisPointer: {
        type: "shadow",
      },
    },
    grid: {
      left: "5%",
      right: "5%",
      bottom: "10%",
      containLabel: true,
    },
    xAxis: {
      type: "category",
      data: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
      axisLine: {
        lineStyle: {
          color: "#d2e0f4",
        },
      },
      axisTick: {
        show: false,
      },
      axisLabel: {
        color: "#7a869a",
      },
    },
    yAxis: {
      type: "value",
      splitLine: {
        lineStyle: {
          color: "#e6effc",
        },
      },
      axisLine: {
        show: false,
      },
      axisLabel: {
        color: "#7a869a",
      },
    },
    series: [
      {
        data: [120, 200, 150, 80, 70, 110, 130],
        type: "bar",
        itemStyle: {
          borderRadius: [4, 4, 0, 0],
        },
      },
    ],
  };

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
      .backgroundColor("#eee")
    }
    .height('100%')
    .width('100%')
  }
}