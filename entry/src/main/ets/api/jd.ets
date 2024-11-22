// 资讯的API
import { n } from '../utils/service'
// https://php.likeadmin.cn/api/index/index
export const getHomeApi = ():Promise<null> => {
  return n.get<null>("/api/index/index")
}