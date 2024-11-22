// 社区交友的API
import { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { s } from '../utils/service'

// https://sqapi2.dishawang.com/api/v1/adsense/:type

export const getBannerApi = (type : string) : Promise<null> => {
  return s.request<null>({
    url : `/api/v1/adsense/${type}`,
    method : 'GET',
    interceptor: {
      // 请求拦截器成功的函数
      requestInterceptor(config :InternalAxiosRequestConfig){
        config.headers.c = 10
        // AlertDialog.show({
        //   message : JSON.stringify(config, null, 2)
        // })
        return config
      },
      // 请求拦截器失败的函数
      requestInterceptorError(error : AxiosError){
        return error
      },
      // 响应拦截器成功的函数
      responseInterceptor(response : AxiosResponse){
        return response
      },
      // 响应拦截器失败的函数
      responseInterceptorError(error: AxiosError){
        return error
      }
    }
  })
  // return s.get<null>(`/api/v1/adsense/${type}`)
}