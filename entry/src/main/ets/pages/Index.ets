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
import { BusinessError } from '@kit.BasicServicesKit';
@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State pwd: string = '048';

  test() {
    if (this.pwd.length >= 8) {
      this.pwd = ""

    } else {
     this.pwd =  this.pwd + `${this.pwd.length}`
    }
  }

  // onBackPress(): boolean | void {
  //   return true
  // }
  controller: webview.WebviewController = new webview.WebviewController();
  build() {
    Column() {
      SimpleTitleView({
        title:'设置手势密码',
        right_title:"重置",
        onBackClick:()=>{
          router.back()
        },
        onRightTitleClick:()=>{
          // this.resetState()
        }
      })
      Button("Test").onClick(() => {
        this.test()
      }).width(100)

    // GestureView({
    //   gesture_pwd:this.pwd
    // }).layoutWeight(1)
    //   RouterURLTest().layoutWeight(1)

      Button('loadUrl')
        .onClick(() => {
          try {
            // 通过$rawfile加载本地资源文件。
            this.controller.loadUrl($rawfile('index2.html'));
          } catch (error) {
            console.error(`ErrorCode: ${(error as BusinessError).code},  Message: ${(error as BusinessError).message}`);
          }
        })
      Web({ src: 'www.example.com', controller: this.controller }).javaScriptAccess(true)


    }.width('100%').height('100%')
  }
}

