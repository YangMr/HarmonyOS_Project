import { AxiosError, AxiosRequestConfig, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';

export interface  RequestConfigType extends AxiosRequestConfig{
  interceptor? :RequestInterceptorConfigType
}

interface RequestInterceptorConfigType{
  // 请求拦截器成功的函数
  requestInterceptor? : (config : InternalAxiosRequestConfig) =>InternalAxiosRequestConfig | Promise<InternalAxiosRequestConfig>,
  // 请求拦截器失败的函数
  requestInterceptorError? : (error : AxiosError) =>AxiosError | Promise<AxiosError>,
  // 响应拦截器成功的函数
  responseInterceptor? : (response : AxiosResponse) =>AxiosResponse | Promise<AxiosResponse>,
  // 响应拦截器失败的函数
  responseInterceptorError? : (error : AxiosError) => AxiosError | Promise<AxiosError>,
}