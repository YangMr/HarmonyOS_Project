import { Http } from '../utils/http'

export const getBannerAPI = (type: string): Promise<null> => {
  return Http.get<null>(`/api/v1/adsense/${type}`)
}


interface DataModel {
  current: number
  size: number
}

export interface ResponseDataModel {
  "total": number,
  "records": ResponseDataItemModel[]

}

export interface ResponseDataItemModel {
  "id": number,
  "userId": number,
  "nickName": string,
  "title": string
  "summary": string
  "imageUrl": string
  "viewCount": number,
  "thumhup": number,
  "updateDate": string
}


export const getReadList = (data: DataModel): Promise<ResponseDataModel> => {
  return Http.post<ResponseDataModel>("/api/article/api/article/search", data)
}