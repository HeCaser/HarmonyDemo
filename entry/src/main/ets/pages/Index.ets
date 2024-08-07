import { PwdGridView } from './pwd_check/view/PwdGridView';
import { KeyboardView } from './pwd_check/view/KeyboardView';
import { PwdCheckPage } from './pwd_check/PwdCheckPage';
import { PropDemo } from './basic/PropDemo';
import { GesturePwdCheck } from './pwd_check/GestureCheckPage';
import { RouterURLTest } from './basic/RouterURLTest';
import { GesturePwdSketch } from './pwd_check/view/GesturePwdSketch';
import { GestureView } from './pwd_check/view/GestureView';
import { SimpleTitleView } from './pwd_check/view/SimpleTitleView';
import { router } from '@kit.ArkUI';
import { webview } from '@kit.ArkWeb';
import { BusinessError, emitter } from '@kit.BasicServicesKit';
import { textRecognition } from '@kit.CoreVisionKit';
import { ImageTextRecognition } from './api_test/text_recg';
import { DbStore } from './api_test/DbStrore';
import { vibrator } from '@kit.SensorServiceKit';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State pwd: string = '';

  aboutToAppear(): void {
    // console.log("hepan 首页可见")
  }

  aboutToDisappear(): void {
    // console.log("hepan 首页消失")
  }


  test() {
    this.pwd = ""

    router.replaceUrl({
      url: "pages/event/EmitterEvent"
    })
  }

  // onBackPress(): boolean | void {
  //   return true
  // }
  controller: webview.WebviewController = new webview.WebviewController();

  build() {
    Column() {

      SimpleTitleView({
        title: '设置手势密码',
        right_title: "重置",

        onRightTitleClick: () => {
          // this.resetState()
        }
      })

      Button("Test").onClick(() => {
        this.test()
      }).width(100)

      KeyboardView().height(190)
      // RouterURLTest().layoutWeight(1)


    }.width('100%').height('100%')
  }
}

