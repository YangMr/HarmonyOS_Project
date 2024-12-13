import { getReadList, ResponseDataItemModel } from '../../api/api'
import storeInstance from '../../utils/store'

interface DataModel {
  readList: ResponseDataItemModel[]
  time: number
  total: number
}

@Entry
@Component
struct ReadPage {
  @State
  readList: ResponseDataItemModel[] = [] as ResponseDataItemModel[]
  @State
  total: number = 0
  @State
  flag: boolean = true

  aboutToAppear(): void {
    this.checkData()
    if (this.flag) {
      this.initReadList()
    }
  }

  async initReadList() {
    try {
      // 如果数据有变化, 这个时候请求接口的数据, 并且进行渲染
      const res = await getReadList({
        current: 1,
        size: 10
      })

      this.readList = res.records
      this.total = res.total

      // 第一次加载的页面, 先存储列表的数据
      const data: DataModel = {
        readList: this.readList,
        time: Date.now(),
        total: this.total
      }
      storeInstance.set("listData", JSON.stringify(data))

      AlertDialog.show({
        message: JSON.stringify(res, null, 2)
      })
    } catch (e) {
      console.log(e)
    }
  }

  checkData() {
    // 每次进入到页面的时候,先尝试获取本地的数据,本地数据如果没有变化,则渲染本地的数据,则不进行请求与重新渲染
    const listData = storeInstance.get("listData")
    if (listData) {
      const localData: DataModel = JSON.parse(listData as string)

      const nowTime = Date.now()
      if (nowTime - localData.time > 10000) {
        this.flag = true
      } else {
        this.flag = false
        this.readList = localData.readList
      }
      // 说明原来本地存储的数据和当前请求的数据没有变化, 则渲染本地的数据
      // if (localData.total === this.total) {
      //   this.readList = localData.readList
      //   this.flag = false
      // } else {
      //   this.flag = true
      // }

      // 存储在首选项的数据会一直存储在本地
      // 第一种情况
      // 时间大于  3000 > 重新请求数据,并进行渲染 3秒内重新进入页面,则不重新发送请求, 直接渲染本地数据
      // 如果大于 3秒, 则重新获取当前页面的数据, 重新渲染

      // 第二种
      // 正常请求接口,然后将本地存储的总条数 和  当前请求接口的总条数 进行对比,
      // 如果一致, 则渲染本地的数据,  如果不一致, 则渲染请求到的数据
    }

  }

  build() {
    Column() {
      ForEach(this.readList, (item: ResponseDataItemModel) => {
        Row() {
          Text(item.title)
            .fontWeight(FontWeight.Bold)
        }
        .width("100%")
        .padding(20)
        .margin({ top: 10 })
        .border({
          width: {
            bottom: 1
          }
        })
      })

    }
    .height('100%')
    .width('100%')
  }
}