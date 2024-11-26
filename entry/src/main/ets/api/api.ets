import { Http } from '../utils/http'

export const getBannerAPI = (type : string):Promise<null> => {
  return  Http.get<null>(`/api/v1/adsense/${type}`)
}