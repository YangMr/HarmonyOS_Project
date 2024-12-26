import { BasicDataSource } from './BasicDataSource';

export class MyDataSource<T> extends BasicDataSource<T> {
  private dataArray: T[] = [];

  public totalCount(): number {
    return this.dataArray.length;
  }

  public getData(index: number): T {
    return this.dataArray[index];
  }

  //给数组添加数据，指定位置
  public addData(index: number, data: T): void {
    this.dataArray.splice(index, 0, data);
    this.notifyDataAdd(index);
  }

  //给数组添加数据，默认放在最后
  public pushData(data: T): void {
    this.dataArray.push(data);
    this.notifyDataAdd(this.dataArray.length - 1);
  }

  //你给我一共一个数组，我负责放入到代码中
  public pushAllData(data: T[]): void {
    for (let index = 0; index < data.length; index++) {
      this.pushData(data[index])
    }
  }
}
