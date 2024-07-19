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

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State pwd: string = '048';

  aboutToAppear(): void {

  }

  test() {
    let a = 2
    let b = 2
    let a1 = `${a}`
    let b1 = `${b}`
    AlertDialog.show({
      message: `${a1 === b1 ? '相等' : '不等'}`
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

      GestureView({
        gesture_pwd: this.pwd
      }).layoutWeight(1)
      RouterURLTest().layoutWeight(1)


    }.width('100%').height('100%')
  }
}

