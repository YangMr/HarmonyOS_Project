import { map, mapCommon, MapComponent, navi, site } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { geoLocationManager } from '@kit.LocationKit';

interface ListModel {
  name: string
  distance: number
}

@Entry
@Component
struct LinePage {
  mapOptions?: mapCommon.MapOptions;
  callback?: AsyncCallback<map.MapComponentController>;
  mapController?: map.MapComponentController;
  @State
  list: ListModel[] = []
  @State
  locationMessage: string = ""
  @State
  locationResult: geoLocationManager.Location = {} as geoLocationManager.Location

  async testDrivingRoutes() {
    let params: navi.DrivingRouteParams = {
      // 起点的经纬度
      origins: [{
        "latitude": 31.982129213545843,
        "longitude": 120.27745557768591
      }],
      // 终点的经纬度
      destination: {
        "latitude": 31.967236140819114,
        "longitude": 120.27142088866847
      },
      // 路径的途经点
      // waypoints: [{ "latitude": 31.967236140819114, "longitude": 120.27142088866847 },
      //   { "latitude": 31.972868002238872, "longitude": 120.2943211817165 },
      //   { "latitude": 31.98469327973332, "longitude": 120.29101107384068 }],
      language: "zh_CN"
    };
    const result = await navi.getDrivingRoutes(params);
    AlertDialog.show({
      message: JSON.stringify(result, null, 2)
    })

    this.mapController?.addMarker({
      position: {
        latitude: result.routes[0].steps[0].roads[0].startLocation.latitude,
        longitude: result.routes[0].steps[0].roads[0].startLocation.longitude,
      },
      title: "当前位置",
      clickable: true
    })

    this.mapController?.addMarker({
      position: {
        latitude: result.routes[0].steps[0].roads[0].endLocation.latitude,
        longitude: result.routes[0].steps[0].roads[0].endLocation.longitude,
      },
      title: "当前位置",
      clickable: true
    })

    // polyline初始化参数
    let polylineOption: mapCommon.MapPolylineOptions = {
      points: result.routes[0].steps[0].roads[0].polyline,
      clickable: true,
      startCap: mapCommon.CapStyle.BUTT,
      endCap: mapCommon.CapStyle.BUTT,
      geodesic: false,
      jointType: mapCommon.JointType.BEVEL,
      visible: true,
      width: 10,
      zIndex: 10,
      gradient: false
    }
    // 创建polyline
    this.mapController?.addPolyline(polylineOption);
    // console.info("Succeeded in getting driving routes.");
  }

  async getLocationSearch(result: geoLocationManager.Location) {
    try {

      const res = await site.nearbySearch({
        location: {
          latitude: result.latitude,
          longitude: result.longitude
        },
        pageSize: 4,
        pageIndex: 1,
        radius: 1000
      })


      this.list = res.sites?.slice(0, 4) as ListModel[]
    } catch (e) {

      console.log(e)
    }
  }

  aboutToAppear(): void {
    // 地图初始化参数，设置地图中心点坐标及层级
    this.mapOptions = {
      position: {
        target: {
          latitude: 39.9,
          longitude: 116.4
        },
        zoom: 10
      }
    };

    // 地图初始化的回调
    this.callback = async (err, mapController) => {
      if (!err) {
        // 获取地图的控制器类，用来操作地图
        this.mapController = mapController;

        this.mapController.setZoomGesturesEnabled(true);
        this.mapController.setScrollGesturesEnabled(true);
        this.mapController.setRotateGesturesEnabled(true);
        this.mapController.setTiltGesturesEnabled(true);
        this.getLocation()
      }
    };
  }

  async getLocation() {
    // 1. 获取当前经纬度
    const result = await geoLocationManager.getCurrentLocation();

    this.locationResult = result

    // 2. 街道信息
    const res = await geoLocationManager.getAddressesFromLocation({
      latitude: result.latitude,
      longitude: result.longitude
    })

    if (res.length) {
      this.locationMessage = res[0].placeName as string
    }


    // 2. 设置用户的位置
    this.mapController?.setMyLocation(result)

    // 3. 准备一个位置所在的相机
    const cameraUpdate: map.CameraUpdate = map.newCameraPosition({
      target: {
        latitude: result.latitude,
        longitude: result.longitude
      },
      zoom: 12
    })

    // 4. 移动相机至地图指定位置
    this.mapController?.moveCamera(cameraUpdate)

    // 5. 获取坐标单周围的信息
    this.getLocationSearch(result)
  }

  build() {
    Stack({ alignContent: Alignment.Top }) {


      MapComponent({ mapOptions: this.mapOptions, mapCallback: this.callback }).width('100%').height('100%');


      // RelativeContainer() {
      Column() {
        Row() {
          TextInput({ placeholder: "请输入起点", text: $$this.locationMessage })
        }
        .width("100%")
        .height(60)
        .backgroundColor(Color.White)
        .padding(10)

        Row() {
          TextInput({ placeholder: "请输入终点" })
        }
        .width("100%")
        .height(60)
        .backgroundColor(Color.White)
        .padding(10)

        Row() {
          Button("查询")
            .width("100%")
            .onClick(() => {
              this.testDrivingRoutes()
            })
        }
        .width("100%")
        .height(60)
        .backgroundColor(Color.White)
        .padding(10)
      }
      .padding(20)
      .margin({
        top: 40
      })


      // Column() {
      //   ForEach(this.list, (item: ListModel) => {
      //     Row() {
      //       Text(item.name)
      //
      //       Text(item.distance + "m")
      //     }
      //     .width("100%")
      //     .padding({ left: 20, right: 20 })
      //     .height(60)
      //     .border({
      //       width: {
      //         bottom: 1
      //       },
      //       color: "#eee"
      //     })
      //     .backgroundColor("#fff")
      //     .justifyContent(FlexAlign.SpaceBetween)
      //   })
      //
      //
      // }
      // .width("100%")
      // .padding(20)
      // .alignRules({
      //   bottom: {
      //     anchor: "__container__",
      //     align: VerticalAlign.Bottom
      //   }
      // })

      // .offset({
      //   y: -70
      // })
      // }
      // .backgroundColor(Color.Red)

      Row() {
        Stack({ alignContent: Alignment.Start }) {
          Row() {
            Text("当前位置")
          }
          .width("100%")
          .height("100%")
          .justifyContent(FlexAlign.Center)

          Image($r("sys.media.ohos_ic_public_arrow_left"))
            .width(30)
            .aspectRatio(1)
            .fillColor(Color.Black)
        }
        .height(50)
        .backgroundColor(Color.White)
      }
    }
    .height('100%')
    .width('100%')
    .backgroundColor("#eee")
  }
}