import { textToSpeech } from '@kit.CoreSpeechKit';
import { util } from '@kit.ArkTS';

// 定义一个类方法
export class TextToVoice {
  // 这个变量保存文字转语音的实例对象
  static ttsEngine: textToSpeech.TextToSpeechEngine;
  // 创建引擎实例相关参数
  static initParamsInfo: textToSpeech.CreateEngineParams = {
    language: 'zh-CN',
    person: 0,
    online: 1,
    extraParams: {}
  };
  // 合成播报音频的相关参数
  static speakParams: textToSpeech.SpeakParams = {
    requestId: util.generateRandomUUID(), // requestId在同一实例内仅能用一次，请勿重复设置
    extraParams: {
      "speed": 1,
      "volume": 2,
      "pitch": 1,
      "languageContext": 'zh-CN',
      "audioType": "pcm",
    }
  }

  // 1. 初始化文字转语音的实例对象(初始化引擎)
  static async init() {
    if (!TextToVoice.ttsEngine) {
      TextToVoice.ttsEngine = await textToSpeech.createEngine(TextToVoice.initParamsInfo)
    }

  }


  // 3. 监听语音播报(必须要有)
  static speakListener: textToSpeech.SpeakListener = {
    // 开始播报回调
    onStart(requestId: string, response: textToSpeech.StartResponse) {
      console.info(`onStart, requestId: ${requestId} response: ${JSON.stringify(response)}`);
    },
    // 合成完成及播报完成回调
    onComplete(requestId: string, response: textToSpeech.CompleteResponse) {
      console.info(`onComplete, requestId: ${requestId} response: ${JSON.stringify(response)}`);
    },
    // 停止播报回调
    onStop(requestId: string, response: textToSpeech.StopResponse) {
      console.info(`onStop, requestId: ${requestId} response: ${JSON.stringify(response)}`);
    },
    // 返回音频流
    onData(requestId: string, audio: ArrayBuffer, response: textToSpeech.SynthesisResponse) {
      console.info(`onData, requestId: ${requestId} sequence: ${JSON.stringify(response)} audio: ${JSON.stringify(audio)}`);
    },
    // 错误回调
    onError(requestId: string, errorCode: number, errorMessage: string) {
      console.error(`onError, requestId: ${requestId} errorCode: ${errorCode} errorMessage: ${errorMessage}`);
    }
  };

  // 2. 开始播放
  static async start(text: string) {
    // 调用初始化文字转语音的实例对象(初始化引擎)方法
    if (!TextToVoice.ttsEngine) {
      TextToVoice.ttsEngine = await textToSpeech.createEngine(TextToVoice.initParamsInfo)
    }
    TextToVoice.ttsEngine.setListener(TextToVoice.speakListener)


    // 开始播放(开始转换 文字转语音)
    TextToVoice.ttsEngine.speak(text, TextToVoice.speakParams)
  }
}