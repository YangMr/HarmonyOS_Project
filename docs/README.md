// 项目 一个公共接口地址 https://slwl-api.itheima.net

// 1. 多baseURL问题 --- 

便民平台APP --- 自己服务器的接口  ---  其他的公司的接口 --- 多baseURL问题

// 2. 解决方案 --- 通过动态传参设置baseURL --- 根据不同baseURL的实例对象 --- 进行对应请求

// 3. 多个baseURL相同参数

// 4. 解决方案: 封装了全局请求拦截器以及全局响应拦截器

// 5. 多个baseURL情况下, 不同baseURL传递不同参数的问题

// 6. 解决方案: 封装了局部请求拦截器以及局部响应拦截器


// 7. 相同baseURL情况下, 单个接口传递不同参数

// 8. 解决方案: 封装了单个请求拦截器以及单个响应拦截器

// 优化: 
1. 全局loading
2. 局部loading
3. 单个loading


---- 内置http
---- axios  
