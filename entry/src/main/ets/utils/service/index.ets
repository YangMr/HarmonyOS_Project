import { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import { Http } from "./request"

export const s = new Http({
  baseURL : "https://sqapi2.dishawang.com",
  timeout : 10000,
  interceptor: {
    // 请求拦截器成功的函数
    requestInterceptor(config :InternalAxiosRequestConfig){
      config.headers.a = 1

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

export const n = new Http({
  baseURL : "https://php.likeadmin.cn",
  timeout : 10000,
  interceptor: {
    // 请求拦截器成功的函数
    requestInterceptor(config :InternalAxiosRequestConfig){
      config.headers.b = 2
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
