/**
 * 1. 引入worker模块
 * 2. 获取work的实例对象
 * 3. 给宿主线程发送消息
 * 4. 接收宿主线程发送给子线程消息
 * 5. 监听接收宿主线程发送给子线程消息错误信息
 */


function test(a: number, b: number) {
  return a + b
}

// 目的: 使用worker创建一个线程
import { worker } from '@kit.ArkTS';

// 获取对应的 ThreadWorkerGlobalScope 实例
const workerPort = worker.workerPort;
let TAG = "WORKER_SUB_THREAD";

// 给ThreadWorkerGlobalScope的onmessage赋值，监听宿主线程发送过来的消息
workerPort.onmessage = function (data) {
  console.log(`${TAG}, workerPort.onMessage: ` + JSON.stringify(data));
  // 模拟一个耗时任务
  setTimeout(() => {
    const result = test(10, 10)
    // 给宿主线程发送数据
    // 耗时结束后，向宿主线程发送消息
    workerPort.postMessage(result);
  }, 3000);
}

// 给ThreadWorkerGlobalScope的onmessageerror赋值，监听异常情况
workerPort.onmessageerror = function (error) {
  console.log(`${TAG}, workerPort.onmessageerror: ` + JSON.stringify(error));
}
