import { worker } from '@kit.ArkTS';

let TAG = "WORKER_MAIN_THREAD";
let URL = "entry/ets/worker/worker.ts";

@Entry
@Component
struct WorkPage {
  @State
  workerInstance?: worker.ThreadWorker | null = null
  @State
  message: string = ""

  // 通过宿主线程 让 work 创建子线程
  aboutToAppear(): void {
    this.initWorker()
    this.monitorMessage()
  }

  aboutToDisappear(): void {
    this.destroyWorker()
  }

  // 初始化Worker
  initWorker() {
    // 执行worker/worker.ts文件的内容, 这个文件的内容就是创建一个子线程
    this.workerInstance = new worker.ThreadWorker(URL, {
      name: "WORKER_THREAD"
    })
  }

  // 给子线程发送消息
  sendMessage() {
    this.workerInstance!.postMessage("jack");
  }

  build() {
    Column() {
      Text(this.message)

      Button("给子线程发送消息")
        .onClick(() => {
          this.sendMessage()
        })
    }
    .height('100%')
    .width('100%')
  }

  // 销毁子线程
  private destroyWorker() {
    try {
      this.workerInstance!.terminate();
    } catch (err) {
      console.log(err)
    }
  }

  // 监听子线程给宿主线程发送消息
  private monitorMessage() {
    this.workerInstance!.onmessage = (data) => {
      console.log(`${TAG}, workerInstance.onMessage: ` + JSON.stringify(data));
      this.message = `${TAG}, workerInstance.onMessage: ` + JSON.stringify(data)
    }
  }
}