import { MapComponent, mapCommon, map } from '@kit.MapKit';
import { AsyncCallback } from '@kit.BasicServicesKit';
import { geoLocationManager } from '@kit.LocationKit';


@Component
export struct Location {
  mapOptions?: mapCommon.MapOptions
  callback?: AsyncCallback<map.MapComponentController>
  mapController?: map.MapComponentController

  @Link
  currentLocationMessage : string

  async getLocation(){
    // 1. 获取经纬度
    const result = await geoLocationManager.getCurrentLocation()


    // 2. 通过经纬度获取当前街道的位置
    const res = await geoLocationManager.getAddressesFromLocation({
      latitude :result.latitude,
      longitude : result.longitude
    })

    if(res.length){
      this.currentLocationMessage = res[0].placeName as string
    }

    // 3. 设置我在地图上面的位置
    this.mapController?.setMyLocation(result)

    // 4. 准备一个位置所在的相机
    const cameraUpdate : map.CameraUpdate = map.newCameraPosition({
      target : {
        longitude : result.longitude,
        latitude : result.latitude
      },
      zoom : 12
    })

    // 5. 移动相机至地图指定位置
    this.mapController?.moveCamera(cameraUpdate)

    // 6. 位置图层渲染
    this.mapController?.addMarker({
      position : {
        longitude : result.longitude,
        latitude : result.latitude
      },
      title : "当前位置",
      snippet : this.currentLocationMessage,
      clickable : true
    })

    // 7. 根据相机渲染范围图层
    this.mapController?.addCircle({
      radius : 500,
      center : {
        latitude : result.latitude,
        longitude : result.longitude
      },
      fillColor: 0XFFFFC100,
      strokeColor: 0xFFFF0000,
      strokeWidth: 10,
    })

  }

  aboutToAppear(): void {
    this.mapOptions = {
      position: {
        target: {
          latitude: 39.9,
          longitude: 116.4
        },
        zoom: 10,
      },
      mapType : mapCommon.MapType.TERRAIN
    }

    this.callback = async (err, mapController) => {
      if (!err) {
        // 获取地图的控制器类，用来操作地图
        this.mapController = mapController;

        // 获取当前位置的方法
        this.getLocation()

      }
    };
  }

  build() {
    Column() {
      if (canIUse('SystemCapability.Map.Core')) {
        MapComponent({
          mapOptions: this.mapOptions,
          mapCallback: this.callback,
        }).width('100%').height('100%');
      }


    }
    .width("100%")
    .height("100%")
  }
}

