import { common } from '@kit.AbilityKit';
import { fileIo as fs } from '@kit.CoreFileKit';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct FilePage {
  @State message: string = 'Hello World';

  // 1. 获取文件的属性
  getStat() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName = "aa.txt"
    // 定义文件存储的路径(目录 + 文件名称)
    let filePath = fileDir + "/" + fileName

    // 获取text2文件的属性
    const info = fs.statSync(filePath)
    AlertDialog.show({
      message: info.size.toString()
    })
  }

  // 2. 检查文件是否存在
  checkFile() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName = "aa.txt"
    // 定义文件存储的路径(目录 + 文件名称)
    let filePath = fileDir + "/" + fileName

    const bool = fs.accessSync(filePath)
    AlertDialog.show({
      message: bool + ""
    })
  }

  // 3. 打开创建文件
  createFile() {
    try {
      // 获取上下文对象
      const context = getContext(this) as common.UIAbilityContext
      // 定义存储的目录
      const fileDir = context.tempDir
      // 定义文件名
      const fileName = "text1.txt"
      // 定义文件存储的路径(目录 + 文件名称)
      let filePath = fileDir + "/" + fileName
      // let filePath = getContext().cacheDir + "/text.txt"(也可以)
      // fs.open 打开文件, 如果打开的文件不存在,这个时候就会自定创建文件
      // await fs.open(filePath, fs.OpenMode.CREATE)
      // 创建文件 (file 就是创建的文件)
      const file = fs.openSync(filePath, fs.OpenMode.CREATE)
      promptAction.showToast({
        message: "文件创建成功"
      })
    } catch (e) {
      promptAction.showToast({
        message: "文件创建失败"
      })
      console.log(e)
    }
  }

  // 4. 写入文件
  writeFile() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName = "text2.txt"
    // 定义文件存储的路径(目录 + 文件名称)
    let filePath = fileDir + "/" + fileName
    // 创建文件
    const file = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
    // 文件创建成功的提示
    promptAction.showToast({
      message: "文件创建成功"
    })

    // 给文件写入数据
    fs.writeSync(file.fd, "hello kit")

    // 关闭文件,注意：关闭文件流可以释放系统资源,如果不关闭,系统资源会一直
    // 被占用,
    fs.closeSync(file)

    promptAction.showToast({
      message: "数据写入成功"
    })
  }

  // 5. 读取文件的内容
  readFile() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName = "text2.txt"
    // 定义文件存储的路径(目录 + 文件名称)
    let filePath = fileDir + "/" + fileName
    // 读取文件文本的数据
    const data = fs.readTextSync(filePath)
    AlertDialog.show({
      message: JSON.stringify(data, null, 2)
    })
  }

  // 6. 读取文件,打开文件流
  readFileStream() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName = "text2.txt"
    // 定义文件存储的路径(目录 + 文件名称)
    let filePath = fileDir + "/" + fileName

    // 先以流的方式去读取
    // (创建文件流)
    const stream = fs.createStreamSync(filePath, "r+")

    // 定义流存储的空间(缓存)
    let buf = new ArrayBuffer(4096)

    // 将读取的数据放到buf里面
    stream.read(buf, (err, readLen) => {
      if (err) {
        AlertDialog.show({
          message: "读取失败"
        })
      } else {
        const data = new Uint8Array(buf.slice(0, readLen))

        // 将buf转化为string
        const text = String.fromCharCode(...data)

        AlertDialog.show({
          message: text
        })
      }
    })
  }

  // 7. 复制文件
  copyFile() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName2 = "text2.txt"
    const fileName1 = "text1.txt"
    // 定义文件存储的路径(目录 + 文件名称)
    let filePathText2 = fileDir + "/" + fileName2
    let filePathText1 = fileDir + "/" + fileName1
    // 将filePathText2的内容复制到filePathText1的内容
    fs.copyFileSync(filePathText2, filePathText1)

    promptAction.showToast({
      message: "复制成功"
    })
  }

  copyFile2() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName2 = "text2.txt"

    const fileName1 = "aa.txt"

    let filePathText2 = fileDir + "/" + fileName2

    let filePathText1 = fileDir + "/" + fileName1

    fs.openSync(filePathText1, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)

    fs.copyFileSync(filePathText2, filePathText1)
  }

  // 8. 创建目录
  createMkdir() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileMkdir = "test1"
    // 定义文件存储的路径(沙箱目录 + 自定义目录名称)
    let filePath = fileDir + "/" + fileMkdir
    // 创建目录
    fs.mkdirSync(filePath)

    AlertDialog.show({
      message: "创建目录成功"
    })
  }

  // 9. 删除目录
  deleteMkdir() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileMkdir = "test1"
    // 定义文件存储的路径(沙箱目录 + 自定义目录名称)
    let filePath = fileDir + "/" + fileMkdir
    // 删除目录
    fs.rmdirSync(filePath)

    AlertDialog.show({
      message: "删除目录成功"
    })
  }

  // 10. 删除文件
  deleteFile() {
    // 获取上下文对象
    const context = getContext(this) as common.UIAbilityContext
    // 定义存储的目录
    const fileDir = context.tempDir
    // 定义文件名
    const fileName = "text1.txt"
    // 定义文件存储的路径(目录 + 文件名称)
    let filePath = fileDir + "/" + fileName

    // 删除文件
    fs.unlinkSync(filePath)

    AlertDialog.show({
      message: "删除文件成功"
    })
  }

  build() {
    Column({ space: 20 }) {
      Button("创建文件")
        .onClick(() => {
          this.createFile()
        })

      Button("文件写入数据")
        .onClick(() => {
          this.writeFile()
        })

      Button("读取文件的数据")
        .onClick(() => {
          this.readFile()
        })

      Button("读取文件的数据流")
        .onClick(() => {
          this.readFileStream()
        })

      Button("复制文件")
        .onClick(() => {
          this.copyFile()
        })

      Button("复制文件2")
        .onClick(() => {
          this.copyFile2()
        })


      Button("删除文件")
        .onClick(() => {
          this.deleteFile()
        })

      Button("获取文件的属性")
        .onClick(() => {
          this.getStat()
        })

      Button("检查文件是否存在")
        .onClick(() => {
          this.checkFile()
        })

      Button("创建目录")
        .onClick(() => {
          this.createMkdir()
        })

      Button("删除目录")
        .onClick(() => {
          this.deleteMkdir()
        })
    }
    .height('100%')
    .width('100%')
  }
}