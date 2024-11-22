// 1. 导入axios
import axios, { AxiosError, AxiosResponse, InternalAxiosRequestConfig } from "@ohos/axios"
// 2. 创建axios实例对象
const service = axios.create({
  // baseURL : "http://www.baidu.com",
  timeout : 10000
})

// 3. 请求拦截器
service.interceptors.request.use((config:InternalAxiosRequestConfig) => {
  return config;
}, (error:AxiosError) => {
  return Promise.reject(error);
});


// 4. 响应拦截器
service.interceptors.response.use((response:AxiosResponse)=> {
  return response;
}, (error:AxiosError)=> {
  return Promise.reject(error);
});



// 5. 自定义请求方式
export class Http{
  static get<T>(url : string, params?: object){
    return service.get<null, T>(url , {params})
  }

  static post<T>(url : string, data? : object){
    return service.post<null, T>(url, data)
  }

  static put<T>(url : string, data? : object){
    return service.put<null, T>(url, data)
  }


  static delete<T>(url : string, data? : object){
    return service.delete<null, T>(url, data)
  }

}

// 6. 导出请求的实例对象
export default service