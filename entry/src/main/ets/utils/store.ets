import { preferences } from '@kit.ArkData'

export class Store {
  // 设置(获取)store
  getStore() {
    return preferences.getPreferencesSync(getContext(), {
      name: "store"
    })
  }

  // 存储
  set(name: string, value: string) {
    const store = this.getStore()
    store.putSync(name, value)
    store.flush()
  }
  
  // 获取
  get(name: string) {
    const store = this.getStore()
    return store.getSync(name, "")
  }

  // 删除
  delete(name: string) {
    const store = this.getStore()
    store.deleteSync(name)
  }

  // 清空
  clear() {
    const store = this.getStore()
    store.clearSync()
  }
}

const storeInstance = new Store()

export default storeInstance