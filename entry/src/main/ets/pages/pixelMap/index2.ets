import { photoAccessHelper } from '@kit.MediaLibraryKit'
import { fileIo as fs } from '@kit.CoreFileKit'
import { image } from '@kit.ImageKit'
import { promptAction } from '@kit.ArkUI'

@Entry
@Component
struct Index2 {
  // 对图片进行压缩
  async getPixelMap() {
    // 获取文件的fd
    const fd = await this.openCamera()

    // 创建图片资源的实例对象
    const imageSourceApi = image.createImageSource(fd)

    // 判断图片资源的实例对象是否存在
    if (!imageSourceApi) {
      return
    }
    // 创建pixelMap对象
    let pixelMap = await imageSourceApi.createPixelMap({
      editable: true
    })

    // 对图像进行缩放
    pixelMap.scaleSync(0.1, 0.1)

    // 对图片进行压缩
    const imagePickerApi = image.createImagePacker()
    let packOpts: image.PackingOption = { format: "image/png", quality: 50 };
    const data = await imagePickerApi.packing(pixelMap, packOpts)

    const filePath = getContext().cacheDir + "/" + Date.now() + ".png"
    let file = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
    fs.writeSync(file.fd, data)
    fs.closeSync(file.fd)
    promptAction.showToast({
      message: "图片压缩成功"
    })
    // 实现文件上传
  }

  // 实现文件上传
  upload() {
    this.getPixelMap()
  }

  // 打开相机或者相册
  async openCamera() {
    // 参数
    const PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions
    PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE
    PhotoSelectOptions.maxSelectNumber = 1
    // 创建选择器
    let photoPicker = new photoAccessHelper.PhotoViewPicker()
    // 打开相册
    const result = await photoPicker.select(PhotoSelectOptions)
    // 获取选择的图片地址
    const url = result.photoUris[0]
    // 读取所选择的文件数据
    const data = fs.openSync(url, fs.OpenMode.READ_ONLY)

    // 将图片存储到沙箱
    const filePath = getContext().cacheDir + "/" + `t${Date.now()}.png`
    const file = fs.openSync(filePath, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE)
    fs.copyFileSync(data.fd, file.fd)

    return file.fd
  }

  build() {
    Column() {
      Button("文件上传")
        .onClick(() => {
          this.upload();
        })
    }
    .height('100%')
    .width('100%')
  }
}