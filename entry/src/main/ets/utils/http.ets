// 1. 导入axios
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'

// 2. 创建axios实例对象
const service = axios.create({
  baseURL: "http://m.mengxuegu.com",
  //baseURL : "https://sqapi2.dishawang.com",
  timeout: 10000
})


interface CacheType {
  url: string
  time: number
  method: string
}


let cache: Map<string, CacheType> = new Map()

// 3. 请求拦截器
service.interceptors.request.use((config: InternalAxiosRequestConfig) => {

  // 1. 获取到请求的地址与方式
  let url = config.url!
  let method = config.method!

  // 3. 判断如果当前的请求的地址和方式和上一次请求的一样
  const cacheUrl: CacheType | undefined = cache.get(url) as CacheType
  if (cacheUrl && cacheUrl.url === url && cacheUrl && cacheUrl.method === method) {
    // 获取当前请求的时候
    const now = Date.now()
    // 获取上一次发送请求的时间
    const lastNow: number = (cacheUrl && cacheUrl.time)
    // 用当前请求的时间 - 上一次发送请求的时间
    const diff = now - lastNow

    // 如果小于3秒,则说明重复请求了, 可以时候,就不在重复请求
    if (diff < 5000) {
      return Promise.reject('重复请求')
    }
  }

  // 2. 将获取到的请求的地址与方式添加到缓存中
  cache.set(url, {
    url,
    method,
    time: Date.now()
  })


  return config;
}, (error: AxiosError) => {

  return Promise.reject(error);
});


// 4. 响应拦截器
service.interceptors.response.use((response: AxiosResponse) => {
  if (response.status === 200) {
    return response.data.data
  }

}, (error: AxiosError) => {
  return Promise.reject(error);
});


// 5. 自定义请求方式
export class Http {
  static get<T>(url: string, params?: object) {
    return service.get<null, T>(url, { params })
  }

  static post<T>(url: string, data?: object) {
    return service.post<null, T>(url, data)
  }

  static put<T>(url: string, data?: object) {
    return service.put<null, T>(url, data)
  }


  static delete<T>(url: string, data?: object) {
    return service.delete<null, T>(url, data)
  }
}

// 6. 导出请求的实例对象
export default service