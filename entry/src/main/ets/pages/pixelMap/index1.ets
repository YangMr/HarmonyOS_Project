import { fileIo as fs } from '@kit.CoreFileKit';
import { image } from '@kit.ImageKit';

@Entry
@Component
struct Index1 {
  @State message: string = 'Hello World';
  @State PixelMap: image.PixelMap | undefined = undefined;
  @State flag: boolean = true

  aboutToAppear(): void {
    this.getPixelMap()
  }

  // 获取资源的fd (获取图片的fd) (获取到本地的图片数据, 将本地的图片存储到沙箱)
  async getResourceFd() {
    // 获取上下文对象
    const context = getContext()
    // 获取资源管理器
    const resourceMgr = context.resourceManager
    // 资源管理器读取文件的数据
    const imageBuffer = await resourceMgr.getMediaContent($r("app.media.startIcon"))

    // 将读取到的图片数据存储到沙箱
    const filePath = context.cacheDir + "/" + "c.png"
    const file = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)

    fs.writeSync(file.fd, imageBuffer.buffer)

    return file.fd
  }

  // 获取PixelMap
  async getPixelMap() {
    // 获取文件的fd
    const fd = await this.getResourceFd()


    // 创建图片源的实例
    const imageSourceApi = image.createImageSource(fd)


    // 如果没有图片源的实例,则不继续往下执行
    if (!imageSourceApi) {
      return
    }

    // 创建PixelMap
    const pixelMap = await imageSourceApi.createPixelMap({
      editable: true
    })


    this.PixelMap = pixelMap

  }

  // 获取图片的信息
  getImageInfo() {
    this.PixelMap?.getImageInfo().then((info: image.ImageInfo) => {
      this.message = JSON.stringify(info, null, 2)
    })
  }

  // 对选择的图片进行裁剪
  cutImg() {
    this.flag = false

    this.PixelMap?.cropSync({
      x: 0,
      y: 0,
      size: {
        width: 150,
        height: 150
      }
    })


    this.message = "裁剪成功"

    this.flag = true

  }

  // 缩放图片 改变图片尺寸
  scaleImg() {
    this.flag = false
    this.PixelMap?.scaleSync(0.5, 0.5)

    this.message = "缩放成功"
    this.flag = true
  }

  // 让图片位移
  translateImg() {
    this.flag = false
    this.PixelMap?.translateSync(100, 100)

    this.message = "图片位移成功"
    this.flag = true
  }

  // 改变图片透明度
  opacityImg() {
    this.flag = false
    this.PixelMap?.opacitySync(0.5)

    this.message = "改变图片透明度"
    this.flag = true
  }

  // 旋转图片
  rotateImg() {
    this.flag = false
    this.PixelMap?.rotateSync(90)
    this.message = "旋转图片"
    this.flag = true
  }

  // 翻转图片
  flipImg() {
    this.flag = false
    this.PixelMap?.flipSync(false, true)

    this.message = "翻转图片"
    this.flag = true
  }

  //pixelMap 先压缩图片, 然后保存到本地

  saveLocal() {
    // 先将图片进行缩放
    this.PixelMap?.scale(0.3, 0.3).then(() => {
      // 保存到本地的图片的路径
      let context = getContext()
      let fileName = Date.now()
      let newDir = context.cacheDir + "/" + fileName + ".png"

      // 压缩图片
      const ImagePackerApi = image.createImagePacker()
      let packOpts: image.PackingOption = { format: "image/png", quality: 98 };
      ImagePackerApi.packing(this.PixelMap, packOpts).then((data: ArrayBuffer) => {
        // data就是压缩之后的图片数据流
        let file = fs.openSync(newDir, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
        fs.writeSync(file.fd, data)
      })

    })
  }

  build() {
    Scroll() {
      Column({ space: 20 }) {
        Text(this.message)

        Button("获取图片的fd")
          .onClick(() => {
            this.getResourceFd()
          })

        Button("创建piexmap对象")
          .onClick(() => {
            this.getPixelMap()
          })

        Button("获取图片信息")
          .onClick(() => {
            this.getImageInfo()
          })

        Button("对图片进行裁剪")
          .onClick(() => {
            this.cutImg()
          })

        Button("对图片进行缩放")
          .onClick(() => {
            this.scaleImg()
          })

        Button("对图片发生位移")
          .onClick(() => {
            this.translateImg()
          })

        Button("改变图片的透明度")
          .onClick(() => {
            this.opacityImg()
          })

        Button("旋转图片")
          .onClick(() => {
            this.rotateImg()
          })

        Button("翻转图片")
          .onClick(() => {
            this.flipImg()
          })

        Button("将pixelMap资源保存到本地")
          .onClick(() => {
            this.saveLocal()
          })


        if (this.flag) {
          Image(this.PixelMap ? this.PixelMap : "")
          // .width(300)
          // .objectFit(ImageFit.Contain)
        }


      }
      .width('100%')
    }.width('100%')
    .height('100%')
  }
}