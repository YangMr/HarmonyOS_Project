import { MyDataSource } from './utils/MyDataSource'

interface ListModel {
  id: number,
  name: string
}

@Entry
@Component
struct RanderPage {
  @State
  list: ListModel[] = [
    {
      id: 1,
      name: "jack1"
    },
    {
      id: 1,
      name: "jack2"
    },
    {
      id: 1,
      name: "jack3"
    },
    {
      id: 1,
      name: "jack4"
    },
    {
      id: 1,
      name: "jack5"
    }
  ]
  @State
  arrayList: string[] = []
  @State
  data: MyDataSource<string> = new MyDataSource()
  @State
  data1: MyDataSource<number> = new MyDataSource()
  @State
  data2: MyDataSource<ListModel> = new MyDataSource()

  aboutToAppear(): void {
    this.initData()
  }

  initData() {
    for (let i = 0; i < 10000; i++) {
      this.arrayList.push(i + "")
    }

    this.data.pushAllData(this.arrayList)

    for (let i = 0; i < 10000; i++) {
      this.data1.pushData(i)
    }

    // for (let i = 0; i < this.list.length; i++) {
    //
    // }
    this.data2.pushAllData(this.list)

  }

  build() {
    Row() {
      List() {
        // LazyForEach  渲染的数据需要用户自己构建数据约束
        LazyForEach(this.data, (item: number) => {
          ListItem() {
            Row() {
              Text(item.toString())
            }
            .padding(20)
            .border({
              width: {
                bottom: 1
              }
            })
          }

        })
      }
      .width(100)
      .height("100%")


      List() {
        // LazyForEach  渲染的数据需要用户自己构建数据约束
        LazyForEach(this.data2, (item: ListModel) => {
          ListItem() {
            Row() {
              Text(item.name)
            }
            .padding(20)
            .border({
              width: {
                bottom: 1
              }
            })
          }

        })
      }
      .width(200)
      .height("100%")
    }
    .height('100%')
    .width(500)
  }
}