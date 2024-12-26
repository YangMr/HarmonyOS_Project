import axios, { AxiosError, AxiosInstance, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios';
import { RequestConfigType } from './types/RequestType';

// /api/banner baidu.com
// /api/list jd.com
export class Http {
  instance: AxiosInstance

  constructor(config: RequestConfigType) {
    this.instance = axios.create(config)
    // 判断有没有设置局部拦截器
    if (config.interceptor?.requestInterceptor) {
      // 局部请求拦截器
      this.instance.interceptors.request.use(config.interceptor?.requestInterceptor,
        config.interceptor?.requestInterceptorError)
    }
    if (config.interceptor?.responseInterceptor) {
      // 局部响应拦截器
      this.instance.interceptors.response.use(config.interceptor?.responseInterceptor,
        config.interceptor?.responseInterceptorError)
    }


    // 全局请求拦截器
    this.instance.interceptors.request.use((config: InternalAxiosRequestConfig) => {
      config.headers.token = "123"
      return config;
    }, (error: AxiosError) => {
      return Promise.reject(error);
    });
    // 全局响应拦截器
    this.instance.interceptors.response.use((response: AxiosResponse) => {
      return response;
    }, (error: AxiosError) => {
      return Promise.reject(error);
    });
  }

  request<T>(config: RequestConfigType) {

    // 单个请求的拦截器
    if (config.interceptor?.requestInterceptor) {
      this.instance.interceptors.request.use(config.interceptor.requestInterceptor,
        config.interceptor.requestInterceptorError)
    }

    // 单个响应的拦截器
    if (config.interceptor?.responseInterceptor) {
      this.instance.interceptors.response.use(config.interceptor.responseInterceptor,
        config.interceptor.responseInterceptorError)
    }

    return this.instance.request<null, T>(config)
  }

  get<T>(url: string, params?: object) {
    return this.instance.get<null, T>(url, { params })
  }

  post<T>(url: string, data ?: object) {
    return this.instance.post<null, T>(url, data)
  }

  put<T>(url: string, data ?: object) {
    return this.instance.put<T>(url, data)
  }


  delete<T>(url: string, data ?: object) {
    return this.instance.delete<T>(url, data)
  }
}